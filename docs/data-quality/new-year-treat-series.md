# New Year Treat Series

## Table of Contents

- [Observation](#observation)
- [Modeling Decision](#modeling-decision)
- [Impact and Limitation](#impact-and-limitation)
- [Revisiting the Decision](#revisiting-the-decision)

## Observation

During exploration of the source scoring data, New Year Treat records appeared to repeat contestant, episode, and task information across series names.

This behavior raised questions about how these records should be represented in the current analytical model.

## Modeling Decision

The current models exclude series whose names begin with `New Year Treat`, using the `is_excluded_series` macro in `macros/series_filter.sql`.

This is a deliberate inclusion rule for the current analysis. It should not be interpreted as proof that the source records are invalid.

## Impact and Limitation

The current analytical models do not include New Year Treat specials. Analyses using these models therefore focus on the included series and should not be described as covering all Taskmaster episodes.

## Revisiting the Decision

Revisit this rule if the source data is updated or if the project expands to analyze specials separately. Before including these records, establish how contestants, episodes, tasks, and scores should be uniquely represented across series.