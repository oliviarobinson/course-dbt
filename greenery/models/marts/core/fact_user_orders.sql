with orders as (

  select *
  from {{ ref('int_orders') }}
) 

, order_agg as (

  select 
    user_id 
    , first_name 
    , last_name 
    , email
    , phone_number  
    , count(distinct order_id) as n_orders
    , case when count(distinct order_id) > 1 
      then 1 else 0 
      end as is_repeat_customer
    , min(created_at_utc) as first_order_date 
    , max(created_at_utc) as latest_order_date
    , sum(used_promo) as n_promos_used
  from orders
  {{ dbt_utils.group_by(n=5) }}
)

select * 
from order_agg