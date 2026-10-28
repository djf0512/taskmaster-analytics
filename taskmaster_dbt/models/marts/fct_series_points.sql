-- Grain: one row per contestant per series.
-- Rank: series points, then the result of the finale tiebreak. Only a tiebreak in the last
-- episode of a series decides a tie for the series win; tiebreaks earlier in the series
-- do not count (see docs/model-design.md).
with finale as (

    select series_key, max(episode_number) as finale_episode_number
    from {{ ref('dim_episode') }}
    group by series_key

)
, finale_tiebreak as (

    select
        e.series_key,
        e.contestant_key,
        coalesce(e.tiebreak_won, 0) as finale_tiebreak_won
    from {{ ref('fct_episode_points') }} e
    join {{ ref('dim_episode') }} d on d.episode_key = e.episode_key
    join finale f
        on  f.series_key = d.series_key
        and f.finale_episode_number = d.episode_number

)
, totals as (

    select
        series_key,
        contestant_key,
        contestant_seat_position,
        sum(episode_points) as series_points,
        sum(episode_task_points) as series_task_points,
        sum(episode_adjustment_points) as series_adjustment_points,
        sum(tiebreak_won) as tiebreaks_won,
        sum(tiebreak_played) as tiebreaks_played
    from {{ ref('fct_episode_points') }}
    group by series_key, contestant_key, contestant_seat_position

)
, ranked as (

    select
        t.*,
        coalesce(f.finale_tiebreak_won, 0) as finale_tiebreak_won,
        rank() over (
            partition by t.series_key
            order by t.series_points desc, coalesce(f.finale_tiebreak_won, 0) desc
        ) as final_rank
    from totals t
    left join finale_tiebreak f using (series_key, contestant_key)

)
select
    *,
    final_rank = 1 as is_winner
from ranked