# New Year Treat Series

## Finding

The source lists six series named New Year Treat 1 to 6. They contain exactly the same data under six names:

| Series | Rows | Tasks | Contestants | Total points |
|---|---|---|---|---|
| New Year Treat 1 | 55 | 11 | 5 | 144 |
| New Year Treat 2 | 55 | 11 | 5 | 144 |
| New Year Treat 3 | 55 | 11 | 5 | 144 |
| New Year Treat 4 | 55 | 11 | 5 | 144 |
| New Year Treat 5 | 55 | 11 | 5 | 144 |
| New Year Treat 6 | 55 | 11 | 5 | 144 |

- There is one distinct cast across all six series.
- Across the six series there are only 11 distinct task descriptions for 66 tasks.
- Every series has the same two episode titles.

None of the 24 included series shares a cast with another, so this is specific to the New Year Treat rows. These are six separate specials, so identical rows in all six point to a source error: one set of rows has been copied under six names.

Reproduce:

```sql
select series, count(*) as rows, count(distinct task_id) as tasks,
       count(distinct contestant) as contestants, sum(score) as points
from raw.scores_long
where series ilike 'new year treat%'
group by series order by series;
```

## Decision

All series whose name starts with `New Year Treat` are removed in the intermediate layer by the `is_excluded_series` macro (`taskmaster_dbt/macros/series_filter.sql`). Marts never repeat the rule, and a test checks that no excluded series reaches `dim_series`.

## Limitation

The models cover 24 series (20 regular and 4 Champion of Champions) and should not be described as covering every Taskmaster episode.

## Revisiting

Revisit if the source is corrected. Before including the specials, decide how contestants, episodes, and tasks are uniquely identified across the six series. The cleanest fix is upstream: report the duplication to the source repository.