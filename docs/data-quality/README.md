# Data Quality

Findings about the source data and the modeling decisions they led to. Each finding has its own page with the evidence, so the decision can be checked.

| Finding | Decision | Details |
|---|---|---|
| New Year Treat series repeat one cast and one set of tasks six times | Excluded from the models | [New Year Treat series](new-year-treat-series.md) |
| Official episode totals differ from summed task scores | Both kept; difference modeled as adjustment points | [Episode totals vs. task scores](episode-vs-task-scores.md) |

## How findings are documented

- Small implementation details go in SQL comments or model YAML.
- Definitions go in the [data dictionary](../data-dictionary.md).
- A finding that needs evidence, examples, or a tradeoff gets its own page here, with the query that reproduces it and the source commit it was checked against.
- Add new pages to the table above.

An observed difference between two measures is not automatically an error in the source. Pages say which it is, and how sure the conclusion is.