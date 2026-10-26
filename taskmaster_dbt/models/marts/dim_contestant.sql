select
    md5(lower(trim(contestant_name))) as contestant_key,
    min(contestant_name) as contestant_name,
    min(split_part(contestant_name, ' ', 1)) as contestant_first_name,
    min(split_part(contestant_name, ' ', 2)) as contestant_last_name
from {{ ref('int_task_scores_included') }}
where contestant_name is not null
group by md5(lower(trim(contestant_name)))
