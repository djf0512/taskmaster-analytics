-- returns a row if task points do not add up the same way at task, episode and series grain
select 
    task_total, 
    episode_total, 
    series_total
from (
    select
        (select sum(task_points)         from {{ ref('fct_task_points') }})    as task_total,
        (select sum(episode_task_points) from {{ ref('fct_episode_points') }}) as episode_total,
        (select sum(series_task_points)  from {{ ref('fct_series_points') }})  as series_total
)
where task_total <> episode_total
   or task_total <> series_total
