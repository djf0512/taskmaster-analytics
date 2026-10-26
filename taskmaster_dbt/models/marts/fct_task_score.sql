select
    {{ contestant_key('contestant_name') }} as contestant_key,
    task_id,
    {{ series_key('series_name') }} as series_key,
    {{  episode_key('series_name', 'episode_number') }} as episode_key,
    case when not is_tiebreak then points end as points,
    case when is_tiebreak then points end as tiebreak_results  -- 1 they won, 0 they lost, null if not a tiebreak
from {{ ref('int_task_scores_included') }}
where contestant_name is not null