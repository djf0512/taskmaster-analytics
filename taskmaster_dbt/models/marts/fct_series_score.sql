with totals as (

    select
        contestant_key,
        series_key,
        sum(points) as total_points,
        sum(tiebreak_results) as tiebreaks_won, --if null, they didn't have a tiebreak, if 0 they lost, if 1 they won
        count(tiebreak_results) as tiebreaks_played
    from {{ ref('fct_task_score') }}
    group by contestant_key, series_key

)
, ranked as (

    select
        *,
        rank() over (partition by series_key order by total_points desc, tiebreaks_won desc) as final_rank
    from totals

)
select
    *
    , final_rank = 1 as is_winner
from ranked