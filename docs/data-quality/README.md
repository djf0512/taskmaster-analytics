# Data Quality

This directory documents source-data findings, modeling decisions, and limitations that affect how the Taskmaster Analytics models should be interpreted.

## Table of Contents

- [Findings](#findings)
- [Documentation Guidelines](#documentation-guidelines)

## Findings

| Finding | Modeling decision | Details |
|---|---|---|
| New Year Treat records | Excluded from current analytical models | [Read investigation](new-year-treat-series.md) |
| Episode totals differ from summed task scores | Treat episode totals and task scores as separate measures | [Read investigation](episode-vs-task-scores.md) |

## Documentation Guidelines

- Record small implementation details directly in SQL comments or model YAML.
- Describe measure definitions and interpretation in the data dictionary.
- Use a separate investigation document when a finding needs evidence, examples, reasoning, or an explanation of tradeoffs.
- Update this index when adding a new investigation.

These documents describe observed source-data behavior and project modeling decisions. An observed difference does not automatically mean the source data is incorrect.