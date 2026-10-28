select
    task_id,
    series            as series_name,
    episode_num       as episode_number,
    episode_title,
    task_num          as task_label,
    cast(is_prize as boolean)    as is_prize,
    cast(is_live as boolean)     as is_live,
    cast(is_tiebreak as boolean) as is_tiebreak,
    contestant        as contestant_name,
    score             as task_points
from {{ source('raw', 'scores_long') }}
