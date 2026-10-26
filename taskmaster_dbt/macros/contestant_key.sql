{% macro contestant_key(contestant_name) %}
    md5(lower(trim({{ contestant_name }})))
{% endmacro %}