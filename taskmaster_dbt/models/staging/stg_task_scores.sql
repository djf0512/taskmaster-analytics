select
    task_id,
    series,
    episode_num as episode_number,
    episode_title,
    task_num as task_number,
    is_prize,
    is_live,
    is_tiebreak,
    contestant as contestant_name,
    score as points
from {{ source('raw', 'scores_long') }}
