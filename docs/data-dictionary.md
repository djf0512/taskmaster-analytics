# Data Dictionary

This document describes the key analytical concepts and model grains used in Taskmaster Analytics. Model and column descriptions are maintained in the dbt YAML files and are available through the generated dbt documentation.

## Table of Contents

- [Model Overview](#model-overview)
- [Key Analytical Concepts](#key-analytical-concepts)
- [Measure Definitions](#measure-definitions)
- [Known Limitations](#known-limitations)

## Model Overview

| Model | Grain | Purpose |
|---|---|---|
| `fct_task_score` | One row per contestant per task | Analyzes points awarded for individual tasks. |
| `fct_episode_score` | One row per contestant per episode | Compares task-level points with final episode scores. |
| `fct_series_score` | One row per contestant per series | Supports analysis of overall series performance. |
| `dim_contestant` | One row per contestant | Provides contestant-level context. |
| `dim_task` | One row per task | Provides task-level context. |
| `dim_episodes` | One row per episode | Provides episode-level context. |
| `dim_series` | One row per series | Provides series-level context. |

*Update this table as models change. The model names and grains should match the actual dbt project.*

## Key Analytical Concepts

### Task-level scoring

Task scores represent points attributed to individual tasks. They can be aggregated by contestant, episode, or series, provided the relevant relationships and scoring rules are respected.

### Episode-level scoring

Episode totals represent the final scores recorded for contestants in an episode. These totals may include points that are not attributed to individual tasks.

### Series-level performance

Series-level performance summarizes contestant results across a series. The totals and rankings depend on which scoring measure is used and how the source data represents final scores.

## Measure Definitions

| Measure | Definition | Important consideration |
|---|---|---|
| Task points | Points awarded to a contestant for an individual task. | May not equal the final episode score. |
| Episode points | Final score recorded for a contestant in an episode. | Includes task points and any additional points awarded outside individual tasks. |
| Episode bonus points | The difference between episode points and the sum of task points for that contestant in that episode. |  |
| Series points | The sum of episode points for a contestant across a series (called a season in the US). | Includes episode bonus points. |

## Known Limitations

- New Year Treat specials are excluded from the current analytical models.
- Task-score sums may differ from final episode totals.
- The meaning of any difference between task scores and episode totals should be validated before interpreting it as bonus points.

See the [data quality documentation](data-quality/README.md) for the investigations and modeling decisions behind these limitations.