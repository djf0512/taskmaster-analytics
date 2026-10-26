select *
from {{ ref('stg_episodes') }}
where not {{ is_excluded_series('series_name') }}