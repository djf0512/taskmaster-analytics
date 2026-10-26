{% macro episode_key(series_name, episode_number) %}
    md5( lower(trim({{ series_name }})) || '_' || cast({{ episode_number }} as varchar) )
{% endmacro %}