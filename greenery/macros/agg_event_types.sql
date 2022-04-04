/* 
In this case we know what columns values should be allowed, 
and we want to make sure we always use those column values, so I'm hardcoding them in here. 
Also adding a test to alert if column values change
*/

{% macro agg_event_types() %}

{% set event_types = ["page_view", "add_to_cart", "checkout", "package_shipped"] %}

{% for event_type in event_types %}

    max(
      case when event_type = '{{event_type}}' 
      then 1 else 0 end
    ) as has_{{ dbt_utils.slugify(event_type) }}

{%- if not loop.last %},{% endif %}

{% endfor %}

{% endmacro %}