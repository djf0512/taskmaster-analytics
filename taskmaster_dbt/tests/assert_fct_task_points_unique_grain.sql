-- returns contestants that appear more than once for the same task
select
    contestant_key,
    task_id,
    count(*) as count
from {{ ref('fct_task_points') }}
group by contestant_key, task_id
having count(*) > 1