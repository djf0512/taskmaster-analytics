# Taskmaster Analytics

An analytics engineering project exploring contestant performance and task scoring in the UK television series *Taskmaster*. The project transforms publicly available scoring data into tested, documented analytical models using Python, DuckDB, and dbt.

## Table of Contents

- [Project Goals](#project-goals)
- [Tech Stack](#tech-stack)
- [Data Pipeline](#data-pipeline)
- [Data Models](#data-models)
- [Data Quality](#data-quality)
- [Repository Structure](#repository-structure)
- [Current Status](#current-status)
- [Future Work](#future-work)
- [Data Sources](#data-sources)

## Project Goals

- Build a reproducible data pipeline from raw source data to analytical models.
- Apply analytics engineering practices, including modular SQL transformations, testing, and documentation.
- Explore contestant performance and scoring patterns across tasks, episodes, and series.
- Establish a foundation for combining scoring data with public audience engagement data.

## Tech Stack

- **Python:** Data ingestion and pipeline support
- **DuckDB:** Local analytical database
- **dbt Core:** SQL transformations, testing, and documentation
- **SQL:** Data modeling and analysis
- **Git/GitHub:** Version control and project documentation

## Data Pipeline

The pipeline follows a layered approach:

1. **Raw data:** Obtain the source scoring data.
2. **Staging:** Standardize and prepare source records for transformation.
3. **Intermediate models:** Apply inclusion rules and prepare data for analysis.
4. **Marts:** Build fact and dimension tables for analytical use.

## Data Models

The analytical layer includes:

- **`fct_task_score`:** Task-level scoring records, with one row per contestant per task.
- **`fct_series_score`:** Series-level scoring records, with one row per contestant per series.
- **`dim_contestant`:** Contestant dimension.
- **`dim_task`:** Task dimension.
- **`dim_episodes`:** Episode dimension.
- **`dim_series`:** Series dimension.

See the [dbt project documentation](taskmaster_dbt/README.md) for model organization and setup, and the [data dictionary](docs/data-dictionary.md) for definitions and grain.

## Data Quality

Source data requires some modeling decisions before it can be used consistently for analysis.

- [New Year Treat series](docs/data-quality/new-year-treat-series.md): documents the decision to exclude these records from the current analytical models.
- [Episode totals vs. task scores](docs/data-quality/episode-vs-task-scores.md): explains why episode totals and the sum of individual task scores can differ.

See the [data quality index](docs/data-quality/README.md) for an overview.

## Repository Structure

- `data/`: Local source data
- `ingestion/`: Python ingestion code
- `taskmaster_dbt/`: dbt models, tests, and macros
- `docs/`: Project documentation and data-quality investigations
- `warehouse/`: Local DuckDB database

Exact directory names should match the current repository.

## Current Status

The initial pipeline and analytical models are under development. The current focus is on data modeling, data quality, reproducibility, and documentation.

## Future Work

- Expand analysis of contestant and task performance.
- Incorporate public audience engagement data from sources such as Wikipedia and YouTube, subject to API availability and data limitations.
- Develop analytical outputs that connect task-level performance with broader audience interest.

## Data Sources

Scoring data is sourced from [silver­davi/taskmaster-uk-scores](https://github.com/silverdavi/taskmaster-uk-scores).

Source data remains subject to its original attribution and licensing terms. Refer to the source repository for details.