/****
While exploring the data, I noticed the "New Year Treat" series type did not have the correct data. 
Even though the series name changed, the contestants, episode, and task description were always the same. 
Therefore, I am creating a macro to filter out any series that starts with "New Year Treat" so that the data is not included in the marts.
****/

{% macro is_excluded_series(column_name) %}
    {{ column_name }} ilike 'new year treat%'
{% endmacro %}
