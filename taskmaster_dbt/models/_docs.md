{% docs excluded_series %}
Rows from the New Year Treat series are removed. The source dataset assigns the same cast,
episodes and tasks to all six of them (identical rows and points in every series), so the data
is not usable for analysis. The rule lives in the `is_excluded_series` macro. See
`docs/data-quality/new-year-treat-series.md` for the evidence.
{% enddocs %}

{% docs adjustment_points %}
Official episode points minus the sum of that contestant's task points in the episode.
Most rows are 0. Positive values are consistent with bonus points awarded outside individual tasks,
and negative values with deductions; the source does not label either, so treat the column as an
unexplained difference rather than a confirmed category. Tiebreak tasks are excluded from the task sum.
{% enddocs %}

{% docs tiebreak_result %}
Result of a tiebreak task: 1 = won, 0 = lost, null = not a tiebreak task or the contestant did not take part.
It is a result, not a score, so it is kept out of task points and never added to them.
{% enddocs %}