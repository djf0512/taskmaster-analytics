select *
from {{ ref('stg_series') }}
where not {{ is_excluded_series('series_name') }}