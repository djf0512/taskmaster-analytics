-- Grain: one row per contestant per episode.
-- Spine is the official episode totals; task points are summed from fct_task_points and compared.
with episode_task_totals as (

    select
        contestant_key,
        episode_key,
        series_key,
        sum(task_points) as episode_task_points,
        sum(tiebreak_results) as tiebreak_won,  -- null: no tiebreak; 0: lost; 1: won
        count(tiebreak_results) as tiebreak_played
    from {{ ref('fct_task_points') }}
    group by contestant_key, episode_key, series_key

)
, episode_contestant_points as (

select
    {{ series_key('series_name') }} as series_key,
    {{ episode_key('series_name', 'episode_number') }} as episode_key,
    {{ contestant_key('contestant_name') }} as contestant_key,
    contestant_seat_position,
    episode_points
from {{ ref('int_episode_contestant_points') }}

)
, combined as (

select
    e.series_key,
    e.episode_key,
    e.contestant_key,
    e.contestant_seat_position,
    e.episode_points,
    t.episode_task_points,
    e.episode_points - t.episode_task_points as episode_adjustment_points,
    t.tiebreak_won,
    t.tiebreak_played
from episode_contestant_points e
left join episode_task_totals t
    on e.series_key = t.series_key
        and e.episode_key = t.episode_key
        and e.contestant_key = t.contestant_key

)
select
    *
from combined
