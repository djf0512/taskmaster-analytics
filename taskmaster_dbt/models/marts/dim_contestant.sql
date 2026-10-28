-- No contestant ID exists in the source, so the key is a hash of the normalized name.
-- Assumption: one name = one person (see docs/model-design.md).
select
    {{ contestant_key('contestant_name') }} as contestant_key,
    min(trim(contestant_name))              as contestant_name
from {{ ref('int_task_points_included') }}
where contestant_name is not null
group by {{ contestant_key('contestant_name') }}