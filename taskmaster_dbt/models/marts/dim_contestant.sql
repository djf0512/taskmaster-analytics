select
    {{ contestant_key('contestant_name') }} as contestant_key,
    min(contestant_name) as contestant_name
from {{ ref('int_task_points_included') }}
where contestant_name is not null
group by {{ contestant_key('contestant_name') }}