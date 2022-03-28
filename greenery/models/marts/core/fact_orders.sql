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
    , promos.promo_discount
    , case when orders.promo_id is not null then 1 else 0 end as used_promo

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
)

select *
from add_info 