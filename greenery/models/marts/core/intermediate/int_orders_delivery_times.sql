with orders as (

  select *
  from {{ ref('stg_orders') }}
) 

, time_calcs as (

  select 
    orders.*

    -- calculations for delivery timing 
    , {{ dbt_utils.datediff('created_at_utc', 'delivered_at_utc', 'day') }} 
        as delivery_time_actual_days
    , {{ dbt_utils.datediff('created_at_utc', 'estimated_delivery_at_utc', 'day') }} 
        as delivery_time_estimated_days
    , {{ dbt_utils.datediff('delivered_at_utc', 'estimated_delivery_at_utc', 'day') }} 
        as delivery_estimate_diff_days
  from orders 
) 

select 
  time_calcs.*
  , case when delivery_estimate_diff_days < 0 
      then 1 else 0 
    end as delivery_was_late
from time_calcs 