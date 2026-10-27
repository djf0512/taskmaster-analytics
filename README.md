# Taskmaster Analytics

An independent analytics engineering project exploring Taskmaster UK scoring data and, eventually, public attention and engagement data from external APIs.

The project uses Python, DuckDB, and dbt Core to ingest raw data, transform it through staging and intermediate models, and build a dimensional model for analysis.

**Status:** Work in progress. Currently focused on data quality, dimensional modeling, and validating the core scoring data pipeline.

## Project Goals

- Build a reproducible data pipeline from raw source data to analytical models.
- Design fact and dimension tables that support analysis of contestant performance across tasks, episodes, and series.
- Investigate source-data quality issues and document modeling decisions.
- Integrate public data from the Wikipedia and YouTube APIs to explore audience attention and engagement.

## Tech Stack

- **Python:** Load source CSV data into DuckDB.
- **DuckDB:** Local analytical database and warehouse.
- **dbt Core:** SQL transformations, dimensional modeling, documentation, and data tests.
- **Git/GitHub:** Version control and project documentation.

## Data Pipeline

1. **Ingestion:** Load source CSV files into the raw schema in DuckDB.
2. **Staging:** Standardize and prepare source data.
3. **Intermediate:** Apply inclusion rules and prepare data for the analytical models.
4. **Marts:** Build fact and dimension tables for analysis.
5. **Planned:** Integrate API data and develop additional analytical models.

## Dimensional Model

The current model includes:

- `fct_task_score`: Task-level scores for each contestant.
- `dim_contestant`: Contestant attributes.
- `dim_task`: Task attributes.
- `dim_episodes`: Episode attributes.
- `dim_series`: Series attributes.

The fact table stores scoring measures and keys to the dimensions, while descriptive attributes are maintained in the dimension tables.

## Data Quality

During source-data exploration, I identified inconsistencies in the New Year Treat records. These records are currently excluded from the analytical models because the source repeats contestant, episode, and task information across the New Year Treat series types.

See [Data Quality Decisions](docs/data-quality.md) for details.

## Planned Work

- Complete validation of the dimensional model and its relationships.
- Improve reproducibility and document the local setup process.
- Integrate Wikipedia and YouTube API data.
- Develop analytical models exploring contestant performance and public attention.

## Data Sources and Attribution

Per-task scores are sourced from [silverdavi/taskmaster-uk-scores](https://github.com/silverdavi/taskmaster-uk-scores), licensed under CC BY-SA 4.0 and compiled from the Taskmaster fan wiki. Source data is not redistributed in this repository.

Taskmaster is a trademark of its owners. This is an independent fan project and is not affiliated with or endorsed by the show.