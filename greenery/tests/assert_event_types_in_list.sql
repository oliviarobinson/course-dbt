select distinct event_id 
from {{ ref('stg_events') }}
where event_type not in 
  ('page_view', 'add_to_cart', 'checkout', 'package_shipped')

