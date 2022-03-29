with products as (

  select *
  from {{ ref('stg_products') }}

) 

select 
  product_id
  , product_name
  , price_usd
  , inventory
from products