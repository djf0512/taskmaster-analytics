select
    {{ contestant_key('contestant_name') }} as contestant_key,
    task_id,
    {{ series_key('series_name') }} as series_key,
    episode_number,
    points
from {{ ref('int_task_scores_included') }}
where contestant_name is not null