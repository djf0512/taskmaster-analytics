# Model Design

Why the models look the way they do. Definitions and grains are in the [data dictionary](data-dictionary.md).

## Layers

| Layer | Schema | Job | Naming |
|---|---|---|---|
| Staging | `staging` | One model per raw table. Renames, type casts, passes through `loaded_at` and `source_commit`. No joins, no rules. | `stg_*` |
| Intermediate | `intermediate` | Business rules shared by several models: removing excluded series, unpacking official episode totals. | `int_*` |
| Marts | `marts` | Star schema for analysis. Marts never read staging; they read intermediate models (and, for roll-up facts, other marts). | `dim_*`, `fct_*` |

Rule: a business rule lives in exactly one place. The series exclusion is one macro (`is_excluded_series`) used only in the intermediate layer, so no mart repeats it.

## Decisions

### Contestant identity

The source has no contestant ID, so `contestant_key` hashes the normalized name. The source has 105 distinct names and still 105 after trimming and lower-casing, so there are no spelling variants. 20 contestants appear in more than one included series (the Champion of Champions specials), which is why contestants, not appearances, are the dimension. The assumption is that one name is one person. If two people ever share a name, the keys will merge them.

### Excluded series

All six New Year Treat series are removed in the intermediate layer. Evidence: [New Year Treat series](data-quality/new-year-treat-series.md).

### What counts toward points

Every task counts except tiebreak tasks. The prize task counts. Tiebreak rows hold a result (1 won, 0 lost, NULL not a participant), so `fct_task_points` splits the source column into `task_points` (normal tasks) and `tiebreak_results` (tiebreak tasks). That keeps `task_points` safe to sum.

### Official totals versus task sums

Official episode points come from the episodes file (names and totals are both in seat order, unpacked in `int_episode_contestant_points`). Task points are summed from the task facts. The difference is stored as `episode_adjustment_points`. Evidence: [episode totals vs. task scores](data-quality/episode-vs-task-scores.md).

### Ranking a series

Final rank sorts by series points, then by the result of the finale tiebreak. Only a tiebreak in a series' last episode decides a tie for the series win. Summing tiebreak wins across the whole series gave two winners in Series 20: three contestants finished on 151 points, and one of them had also won an unrelated tiebreak in episode 4. With the finale-only rule, the Series 20 finale tiebreak results (Maisie Adam 1, Ania Magliano 0, Phil Ellis 0) give a single winner. Contestants still tied after the finale tiebreak share a rank, which is why a test requires exactly one winner per series.

### Seat position

Each contestant keeps the same seat within a series (checked: no contestant changes seat). `fct_series_points` groups by seat as well as contestant, and a test checks that the grain stays unique.

### Fact tables built on facts

`fct_episode_points` is built on `fct_task_points`, and `fct_series_points` on `fct_episode_points`. Each is a roll-up to a coarser grain, so the rules stay in one place and the totals reconcile (a test checks that task points add up the same at all three grains). Three levels is the limit. If another fact needs the same inputs, move the shared logic into an intermediate model.

## Tests

- Keys: `unique` and `not_null` on every dimension key, `relationships` from each fact key to its dimension.
- Grain: one singular test per fact table.
- Rules: one winner per series, derived series type agrees with the source's own label, unpacked contestants match the source's contestant count, every task has one row per contestant, task points reconcile across the three fact tables.
- Source freshness is checked against the load timestamp (`dbt source freshness`).