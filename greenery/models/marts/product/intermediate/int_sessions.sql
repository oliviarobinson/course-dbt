with events as (

  select *
  from {{ ref('int_events') }}
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

    -- macro to aggregate event types
    , {{ agg_event_types() }} 

  from events 
  group by 1, 2
)

, funnel_stages as (

  select 
    sessions.*
    , greatest(has_page_view, has_add_to_cart, has_checkout) as funnel_s1
    , greatest(has_add_to_cart, has_checkout) as funnel_s2
    , has_checkout as funnel_s3
  from sessions 

)

select * 
from funnel_stages 
