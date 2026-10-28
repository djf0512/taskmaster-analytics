# dbt Project

Transformations, tests, and documentation for Taskmaster Analytics, running on a local DuckDB file. Run every dbt command from this folder (`profiles.yml` is here and points to `../warehouse/taskmaster.duckdb`).

## Layers

| Folder | Schema | Contents |
|---|---|---|
| `models/staging/` | `staging` | `stg_*`: one model per raw table, renamed and typed |
| `models/intermediate/` | `intermediate` | `int_*`: excluded series removed, official episode totals unpacked |
| `models/marts/` | `marts` | `dim_*` and `fct_*`: the star schema |
| `macros/` | | key macros (`contestant_key`, `series_key`, `episode_key`), the series exclusion rule, and the schema-name override |
| `tests/` | | singular tests; each file returns the bad rows, so zero rows means pass |

Model list, grains, and keys: [data dictionary](../docs/data-dictionary.md). Design decisions: [model design](../docs/model-design.md).

## Commands

```bash
dbt debug                                  # check the connection
dbt build                                  # build models and run all tests
dbt test --select test_type:singular       # custom tests only
dbt source freshness                       # how old is the raw load?
dbt docs generate && dbt docs serve        # browsable docs and lineage graph
```

Before building, load the raw tables from the repository root with `python ingestion/load_scores.py` (see [setup](../docs/setup.md)). Close any DuckDB shell or UI first: only one process can hold the database file.

## Testing approach

- Generic tests on keys and relationships are declared in the `_*_models.yml` file next to each layer.
- Singular tests in `tests/` cover grain, business rules, and reconciliation between the three fact tables.
- Findings behind the tests are documented in [docs/data-quality](../docs/data-quality/README.md).
