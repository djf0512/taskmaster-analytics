# Data Dictionary

This document describes the purpose and intended grain of the analytical models in Taskmaster Analytics.

## Table of Contents

- [Overview](#overview)
- [Fact Table](#fact-table)
- [Dimension Tables](#dimension-tables)
- [Measures and Interpretation](#measures-and-interpretation)
- [Known Limitations](#known-limitations)

## Overview

The data model separates task-level scoring records from descriptive dimensions. This structure supports analysis of scores by contestant, task, episode, and series.

## Fact Table

### `fct_task_score`

**Intended grain:** One row per contestant per task.

This table contains task-level scores associated with contestants and tasks. It is designed to support comparisons of performance at the task level.

Document the actual columns from the current model here, including their meanings, data types, and whether they can contain nulls.

## Dimension Tables

| Model | Purpose |
|---|---|
| `dim_contestant` | Identifies contestants represented in the analytical data. |
| `dim_task` | Describes individual tasks. |
| `dim_episodes` | Describes episodes associated with tasks. |
| `dim_series` | Describes the series associated with the analytical records. |

Add each model's actual columns and key definitions after confirming them against the current SQL and YAML files.

## Measures and Interpretation

Task scores and episode totals represent different measures.

- **Task scores** are scores attributed to individual tasks.
- **Episode totals** represent final scores recorded for an episode and may include bonus points not attributed to individual tasks.

Consequently, summing task scores does not necessarily reproduce an episode's final score. These measures should not be treated as interchangeable.

See [Episode Totals vs. Task Scores](data-quality/episode-vs-task-scores.md) for the investigation and modeling implications.

## Known Limitations

- New Year Treat records are excluded from the current analytical models under the project's series-inclusion rule.
- Episode-level final scores are not interchangeable with task-level scores.
- Model definitions and column-level descriptions should be kept synchronized with the actual dbt models.