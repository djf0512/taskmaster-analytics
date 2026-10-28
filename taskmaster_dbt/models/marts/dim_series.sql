-- series_type is derived from the series name
select 
    {{ series_key('series_name') }} as series_key,
    series_name,
    case
        when series_name ilike 'series %' then 'regular'
        when series_name ilike 'champion of champions%' then 'champion_of_champions'
        when series_name ilike 'new year treat%' then 'new_year_treat'  -- this one shouldn't appear as it's excluded in the intermediate step
        else 'unknown'
    end as series_type,
    try_cast(regexp_extract(series_name, '(\d+)\s*$', 1) as int) as series_number,
    series_air_date_range,
    number_of_episodes
from {{ ref('int_series_included') }}