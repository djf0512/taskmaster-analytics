select
    task_id,
    {{ series_key('series_name') }} as series_key,
    {{ episode_key('series_name', 'episode_number') }} as episode_key,
    task_label,
    is_prize,
    is_live,
    is_tiebreak,
    task_description
from {{ ref('int_tasks_included') }}