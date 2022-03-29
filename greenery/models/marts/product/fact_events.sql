with events as (

  select *
  from {{ ref('stg_events') }}
)

select 
  event_id
  , session_id
  , user_id
  , page_url
  , created_at_utc
  , event_type
  , order_id
  , product_id
  , case when order_id is not null then 1 else 0 end as is_order
from events 