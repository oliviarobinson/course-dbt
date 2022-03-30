select {{ dbt_utils.star( ref('int_orders') ) }}
from {{ ref('int_orders') }}