with events as (

  select *
  from {{ ref('stg_events') }}
)

, products as (

  select *
  from {{ ref('stg_products') }}
)

select 
  event_id
  , session_id
  , user_id
  , page_url
  , created_at_utc
  , event_type
  , order_id
  , events.product_id
  , products.product_name
from events 
left join products 
  on events.product_id = products.product_id