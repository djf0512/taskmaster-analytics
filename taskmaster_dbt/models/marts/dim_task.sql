select
    task_id,
    series_name,
    episode_number,
    episode_title,
    task_label,
    is_prize,
    is_live,
    is_tiebreak,
    task_description
from {{ ref('int_tasks_included') }}