{% 
  set event_types = 
    dbt_utils.get_column_values(
      table=ref('fact_events'),
      column='event_type'
    ) 
%}

with events as (

  select *
  from {{ ref('fact_events') }}
)

select 
  session_id
  , user_id
  , min(created_at_utc) as first_action_time
  , max(created_at_utc) as latest_action_time
  , count(distinct event_id) as events

  {% for event_type in event_types %}

  , sum(
      case when event_type = '{{ event_type }}' 
      then 1 else 0 end
    ) as {{ dbt_utils.slugify(event_type) }}_event

  {% endfor %}

from events 
group by 1, 2