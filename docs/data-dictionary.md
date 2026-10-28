# Data Dictionary

Definitions of the models, keys, and measures. Column-level descriptions live in the dbt YAML files and in the generated dbt docs (`dbt docs generate`). This page is the single list of models; other documents link here instead of repeating it.

## Contents

- [Models](#models)
- [Keys](#keys)
- [Measures](#measures)
- [Known Limitations](#known-limitations)

## Models

| Model | Type | Grain | Key |
|---|---|---|---|
| `dim_contestant` | dimension | one row per contestant | `contestant_key` |
| `dim_episode` | dimension | one row per episode | `episode_key` |
| `dim_series` | dimension | one row per series | `series_key` |
| `dim_task` | dimension | one row per task | `task_id` (from the source) |
| `fct_task_points` | fact | one row per contestant per task | `contestant_key` + `task_id` |
| `fct_episode_points` | fact | one row per contestant per episode | `contestant_key` + `episode_key` |
| `fct_series_points` | fact | one row per contestant per series | `contestant_key` + `series_key` |

Series are called seasons in the US. Only the 24 included series are modeled: 20 regular series and 4 Champion of Champions.

## Keys

| Key | Definition |
|---|---|
| `contestant_key` | md5 of the lower-cased, trimmed contestant name (the source has no contestant ID) |
| `series_key` | md5 of the lower-cased, trimmed series name |
| `episode_key` | md5 of the lower-cased, trimmed series name, an underscore, and the episode number |
| `task_id` | used as-is from the source |

Each key is built by one macro in `taskmaster_dbt/macros/`, so dimensions and facts always agree.

## Measures

| Measure | Definition | Note |
|---|---|---|
| Task points (`task_points`) | Points awarded to a contestant for one normal task | If not a tiebreaker task and value is Null means the contestant was disqualified / DNF |
| Tiebreak result (`tiebreak_results`) | 1 if the contestant won a tiebreak task, 0 if they lost, null otherwise | A result, not a score. Never added to points. |
| Episode points (`episode_points`) | Official points for a contestant in an episode, as printed in the broadcast tables | Comes from the episodes file, not from summing tasks. |
| Episode task points (`episode_task_points`) | Sum of the contestant's task points in the episode | Excludes tiebreak tasks. Includes the prize task. |
| Adjustment points (`episode_adjustment_points`) | Episode points minus episode task points | Positive values are consistent with bonus points and negative values with deductions. |
| Series points (`series_points`) | Sum of a contestant's episode points across the series | Includes adjustment points. |
| Final rank (`final_rank`) | Rank within a series by series points, then by the finale tiebreak | See [model design](model-design.md). |
| Winner (`is_winner`) | True for rank 1 | A test requires exactly one winner per series. |

## Known limitations

- New Year Treat specials are excluded. Analyses cover the included series only and should not be described as covering every episode.
- A contestant is identified by name. Two different people with the same name would be merged.

Evidence and reasoning for each limitation: [data quality findings](data-quality/README.md).