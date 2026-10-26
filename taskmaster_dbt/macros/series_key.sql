{% macro series_key(series_name) %}
    md5(lower(trim({{ series_name }})))
{% endmacro %}