with totals as (

    select
        series_key,
        contestant_key,
        contestant_seat_position,
        sum(episode_points) as series_points,
        sum(episode_task_points) as series_task_points,
        sum(episode_bonus_points) as series_bonus_points,
        sum(tiebreak_won) as tiebreaks_won,
        sum(tiebreak_played) as tiebreaks_played
    from {{ ref('fct_episode_points') }}
    group by series_key, contestant_key, contestant_seat_position

)
, ranked as (

    select
        *,
        rank() over (partition by series_key order by series_points desc, tiebreaks_won desc) as final_rank
    from totals

)
select
    *
    , final_rank = 1 as is_winner
from ranked