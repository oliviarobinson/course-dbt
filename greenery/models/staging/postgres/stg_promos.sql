select 
    promo_id
    , discount as promo_discount_raw_usd
    , status as promo_status
from {{ source('postgres', 'promos') }}
