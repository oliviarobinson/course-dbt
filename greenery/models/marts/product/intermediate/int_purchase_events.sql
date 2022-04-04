with events as (

  select *
  from {{ ref('int_events') }}
  where event_type = 'checkout'
)

, order_items as (
  
  select *
  from {{ ref('int_order_items') }}

)

select distinct
  events.session_id
  , events.order_id
  , order_items.product_id
  , order_items.product_name
from events 
left join order_items 
  on events.order_id = order_items.order_id