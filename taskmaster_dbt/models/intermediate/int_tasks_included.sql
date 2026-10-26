select *
from {{ ref('stg_tasks') }}
where not {{ is_excluded_series('series_name') }}