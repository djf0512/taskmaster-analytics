select
    series                                           as series_name,
    episode_num                                      as episode_number,
    episode_title,
    air_date                                         as air_date_raw,
    try_strptime(air_date, '%d %B %Y')               as air_date,
    n_contestants,
    contestants                                      as contestants_raw,
    total_1, total_2, total_3, total_4, total_5,
    _loaded_at                                       as loaded_at,
    _source_commit                                   as source_commit
from {{ source('raw', 'episodes') }}
