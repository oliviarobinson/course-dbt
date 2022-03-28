select 
    address_id
    , address
    , zipcode
    , state as statecode
    , country
from {{ source('postgres', 'addresses') }}
