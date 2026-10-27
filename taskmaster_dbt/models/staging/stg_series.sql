select
    series            as series_name,
    kind              as series_kind,
    air               as series_air_date_range,
    episodes          as number_of_episodes
from {{ source('raw', 'series') }}
