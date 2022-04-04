with orders as (

  select * 
  from {{ ref('int_orders') }}
)

, order_items as (

  select *
  from {{ ref('int_order_items') }}
)

, order_items_agg as (

   {{ agg_order_items() }}

)

select 
  orders.*
  , order_items_agg.total_items 
  , order_items_agg.unique_items
  , order_items_agg.avg_cost_per_item
  , order_items_agg.product_names_list 
from orders
left join order_items_agg
  on orders.order_id = order_items_agg.order_id