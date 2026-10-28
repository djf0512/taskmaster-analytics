select *
from {{ ref('stg_task_points') }}
where not {{ is_excluded_series('series_name') }}