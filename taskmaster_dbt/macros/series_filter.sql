{#
  Returns true for series that are excluded from the analytical models.
  Today that is every "New Year Treat" series: the source assigns the same cast,
  episodes and tasks to all six, so the rows carry no independent information.
  Evidence: docs/data-quality/new-year-treat-series.md

  Used only in the intermediate layer, so marts never need to repeat the rule.
#}
{% macro is_excluded_series(column_name) %}
    {{ column_name }} ilike 'new year treat%'
{% endmacro %}
