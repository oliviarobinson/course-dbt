with orders as (
 
  select *
  from {{ ref('int_orders') }}
)

select 
  address_id
  , address
  , zipcode
  , statecode
  , country
  , count(distinct user_id) as num_users_associated
  , count(distinct order_id) as num_orders_associated
  , min(created_at_utc) as first_order_date
  , max(created_at_utc) as latest_order_date
  , sum(
      case when order_status = 'preparing' 
      then 1 else 0 end 
    ) as num_orders_in_prep
  , sum(
      case when order_status = 'shipped' 
      then 1 else 0 
      end 
    ) as num_orders_in_flight
  , round(
      avg(delivery_time_actual_days), 2
    ) as avg_time_to_delivery_days
  , sum(delivery_was_late) as num_orders_delivered_late
  , round(
      avg(delivery_was_late), 2
    ) as perc_orders_delivered_late
from orders 
group by 1, 2, 3, 4, 5

