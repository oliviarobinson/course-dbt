with promos as (
  
  select *
  from {{ ref('stg_promos') }}

)

, orders as (

  select *
  from {{ ref('int_orders') }}
  where promo_id is not null 

) 


select 
  promos.promo_id
  , promos.promo_discount_raw_usd
  , promos.promo_status
  , count(distinct order_id) as num_times_used
  , count(distinct user_id) as num_users_used
  , avg(promo_discount_perc_of_total) as avg_discount_perc
  , min(created_at_utc) as first_used
  , max(created_at_utc) as latest_used
from promos 
full join orders 
  on promos.promo_id = orders.promo_id
group by 1, 2, 3