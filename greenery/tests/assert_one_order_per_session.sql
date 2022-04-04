select distinct session_id
from {{ ref('stg_events')}} 
group by 1
having count(distinct order_id) > 1
