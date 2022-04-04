with events as (

  select *
  from {{ ref('int_events') }}
)

, purchase_events as (

  select *
  from {{ ref('int_purchase_events') }}
)

, sessions as (

    select 
      session_id
      , user_id
      , product_id
      , product_name
      , max(order_id) as order_id
      , {{ agg_event_types() }} 
    from events
    where product_id is not null
    {{ dbt_utils.group_by(n=4) }}
)

, session_orders as (

  select 
    sessions.session_id
    , sessions.user_id
    , sessions.product_id
    , sessions.product_name
    , purchase_events.order_id
    , sessions.has_page_view
    , sessions.has_add_to_cart
    , case when purchase_events.order_id is not null 
      then 1 else 0 
      end as has_checkout
  from sessions
  left join purchase_events
    on sessions.session_id = purchase_events.session_id
    and sessions.product_id = purchase_events.product_id
)

select * 
from session_orders


