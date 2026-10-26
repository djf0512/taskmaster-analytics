select
    contestant_key,
    task_id,
    count(*) as count
from {{ ref('fct_task_score') }}
group by contestant_key, task_id
having count(*) > 1