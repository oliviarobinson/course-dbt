with sessions as (

  select *
  from {{ ref('int_sessions') }}
)

, date_info as (

  select 
    sessions.*
    , {{ dbt_date.month_name("first_action_time") }} as month_short_name
    , {{ dbt_date.day_name("first_action_time") }} as day_of_week_short_name
    , {{ dbt_date.week_start("first_action_time") }} as week_start
  from sessions
)

select * 
from date_info