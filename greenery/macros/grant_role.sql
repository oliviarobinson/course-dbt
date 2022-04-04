{% macro grant_role(role) %}

    {% set sql %}
      GRANT SELECT ON {{ this }} TO {{ role }};
    {% endset %}

    {% set table = run_query(sql) %}

{% endmacro %}