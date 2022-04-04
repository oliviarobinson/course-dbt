with users as (

  select *
  from {{ ref('stg_users') }}

) 

select 
  user_id
  , first_name
  , last_name
  , email
  , phone_number
  , created_at_utc
  , updated_at_utc
from users