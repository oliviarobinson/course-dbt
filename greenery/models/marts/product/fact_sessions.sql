{% 
  set event_types = 
    dbt_utils.get_column_values(
      table=ref('stg_events'),
      column='event_type'
    ) 
%}

with events as (

  select *
  from {{ ref('stg_events') }}
)

, sessions as (

  select 
    session_id
    , user_id
    , min(created_at_utc) as first_action_time
    , max(created_at_utc) as latest_action_time

    -- if there was an order, include the order id
    -- we have a test to check that no sessions include multiple orders
    , max(order_id) as order_id 

    , count(distinct event_id) as n_events

    {% for event_type in event_types %}

    , sum(
        case when event_type = '{{ event_type }}' 
        then 1 else 0 end
      ) as n_{{ dbt_utils.slugify(event_type) }}

    {% endfor %}

  from events 
  group by 1, 2
)

select * 
  , {{ dbt_utils.datediff('first_action_time', 'latest_action_time', 'minute') }} 
      as session_length_mins

from sessions 
