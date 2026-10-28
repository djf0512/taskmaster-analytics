-- returns series that do not have exactly one winner
select 
    series_key, 
    count(*) as winners
from {{ ref('fct_series_points') }}
where is_winner
group by series_key
having count(*) <> 1
