select
    {{ episode_key('series_name', 'episode_number') }} as episode_key,
    {{ series_key('series_name') }} as series_key,
    series_name,
    episode_number,
    episode_title,
    air_date
from {{ ref('int_episodes_included') }}