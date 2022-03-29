select 
    product_id
    , name as product_name
    , price as price_usd
    , inventory
from {{ source('postgres', 'products') }}
