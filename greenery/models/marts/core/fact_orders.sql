with orders as (

  select *
  from {{ ref('int_orders_delivery_times') }}
) 

, users as (

  select *
  from {{ ref('stg_users') }}
)

, promos as (

  select *
  from {{ ref('stg_promos') }}
)

, addresses as (

  select *
  from {{ ref('stg_addresses') }}
)

, order_items as (

  select *
  from {{ ref('int_order_items') }}
)

, order_items_agg as (

  select 
    orders.order_id
    -- items ordered 
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
)


, add_info as (

  select 
    orders.order_id

    -- user info 
    , orders.user_id
    , users.first_name 
    , users.last_name
    , users.email
    , users.phone_number

    -- promo id and raw discount 
    , orders.promo_id
    , promos.promo_discount_raw_usd
    , case when orders.promo_id is not null then 1 else 0 end as used_promo
    , promos.promo_discount_raw_usd::decimal / 
        orders.total_cost_usd as promo_discount_perc_of_total

    -- address info 
    , orders.address_id 
    , addresses.address
    , addresses.zipcode
    , addresses.statecode 
    , addresses.country

    -- timing and cost info 
    , orders.created_at_utc
    , order_cost_usd
    , shipping_cost_usd
    , total_cost_usd
    , shipping_cost_usd / total_cost_usd as shipping_cost_perc_of_total

    -- stats on items ordered
    , order_items_agg.total_items
    , order_items_agg.unique_items
    , order_items_agg.avg_cost_per_item
    , order_items_agg.product_names_list

    -- shipping info 
    , tracking_id
    , shipping_service
    , estimated_delivery_at_utc
    , delivered_at_utc
    , order_status 
    , delivery_time_actual_days
    , delivery_time_estimated_days
    , delivery_estimate_diff_days
    , delivery_was_late

  from orders 

  left join users 
    on orders.user_id = users.user_id 
  left join promos 
    on orders.promo_id = promos.promo_id 
  left join addresses 
    on orders.address_id = addresses.address_id
  left join order_items_agg 
    on orders.order_id = order_items_agg.order_id
)

select *
from add_info 