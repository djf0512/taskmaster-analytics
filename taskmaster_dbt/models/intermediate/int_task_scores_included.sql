select *
from {{ ref('stg_task_scores') }}
where not {{ is_excluded_series('series_name') }}