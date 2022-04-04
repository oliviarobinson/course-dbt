/* 
We want to be able to aggregate info about items ordered from the order_items table, and we want to do the same aggregations at the order level and the user level. 

Return the SQL to embed in the model.
*/

{%- macro agg_order_items() -%}

select  

  orders.order_id
  , sum(order_items.quantity) as total_items 
  , count(distinct order_items.order_item_id) as unique_items
  , max(orders.total_cost_usd::decimal) / 
      sum(order_items.quantity) as avg_cost_per_item
  , string_agg(product_name, ', ' order by product_name asc) 
      as product_names_list

from orders
left join order_items
  on orders.order_id = order_items.order_id

group by 1

{%- endmacro -%}