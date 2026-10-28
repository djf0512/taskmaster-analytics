select
    series            as series_name,
    kind              as series_kind,
    air               as series_air_date_range,
    episodes          as number_of_episodes,
    _loaded_at        as loaded_at,
    _source_commit    as source_commit
from {{ source('raw', 'series') }}
