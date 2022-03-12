select 
    product_id
    , name
    , price as price_usd
    , inventory
from {{ source('postgres', 'products') }}
