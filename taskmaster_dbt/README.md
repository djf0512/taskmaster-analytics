# dbt Project

This directory contains the dbt transformations, tests, and documentation for the Taskmaster Analytics project. DuckDB is used as the local analytical database.

## Table of Contents

- [Project Structure](#project-structure)
- [Model Layers](#model-layers)
- [Data Quality and Testing](#data-quality-and-testing)
- [Setup](#setup)
- [Running the Project](#running-the-project)
- [Related Documentation](#related-documentation)

## Project Structure

- `models/staging/`: Source-specific cleaning and standardization.
- `models/intermediate/`: Intermediate transformations and inclusion rules.
- `models/marts/`: Analytical fact and dimension models.
- `macros/`: Reusable SQL logic.
- `tests/`: Custom data-quality tests.
- `dbt_project.yml`: dbt project configuration.
- `profiles.yml`: Local DuckDB connection configuration, if maintained in this directory.

## Model Layers

### Staging

Staging models prepare source data for downstream transformations. They should generally stay close to the source structure while applying consistent naming, types, and basic cleanup.

### Intermediate

Intermediate models apply reusable transformations and business rules, including the inclusion criteria used to determine which records are available to the analytical models.

### Marts

The mart layer provides tables intended for analysis:

- `fct_task_score`: Task-level scoring fact table.
- `dim_contestant`: Contestant dimension.
- `dim_task`: Task dimension.
- `dim_episodes`: Episode dimension.
- `dim_series`: Series dimension.

See the model SQL and YAML files for the current definitions and tests.

## Data Quality and Testing

The project uses dbt tests and custom SQL tests to check assumptions about the analytical data.

Examples include checking model relationships, required values, and the expected grain of the task-score fact table.

Documented source-data findings and their modeling implications are maintained in [`docs/data-quality/`](../docs/data-quality/README.md).

## Setup

1. Clone this project repository.
2. From the project root, clone the [taskmaster-uk-scores repository](https://github.com/silverdavi/taskmaster-uk-scores) into the expected raw-data directory:

   ```bash
   git clone https://github.com/silverdavi/taskmaster-uk-scores.git data/raw/taskmaster-uk-scores
   ```
   
   The data is CC BY-SA 4.0 (compiled from the Taskmaster fan wiki). Credit it in the README and don't commit it.
3. Place the source files in the location expected by the ingestion script.
4. Install the Python and dbt dependencies listed by the project.
5. Confirm that the DuckDB database path in `profiles.yml` matches the intended local setup.

The expected source-data path and database path should be verified against the current ingestion script and profile configuration before using these instructions.

## Running the Project

From the `taskmaster_dbt/` directory, a typical dbt workflow is:

```bash
dbt debug
dbt deps
dbt build
```

Run the ingestion script before building the models if the source data has not yet been loaded or prepared.

The exact working directory and ingestion command depend on the current project configuration.

## Related Documentation

- [Root project README](../README.md)
- [Data dictionary](../docs/data-dictionary.md)
- [Data quality index](../docs/data-quality/README.md)

## Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
