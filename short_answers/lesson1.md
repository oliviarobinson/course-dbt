# Short Answer Questions

## Question 1: How many users do we have? 
Answer: 130 Users. 
```sql
select count(distinct user_id)
from dbt_olivia_r.stg_users;
```

## Question 2: On average, how many orders do we receive per hour?
Answer: 7.52
```sql
with base as (

select 
    date_trunc('hour', created_at_utc) as hr 
    , count(distinct order_id) as orders
from dbt_olivia_r.stg_orders
group by 1
)

select 
round(avg(orders), 2) as avg_orders
from base; 
```

## Question 3: On average, how long does an order take from being placed to being delivered?
Answer: 3.89 days 
```sql
select 
    round(
    avg(
        date_part('day', delivered_at_utc - created_at_utc)
    )::numeric, 2
    ) as avg_delivery_time 
from dbt_olivia_r.stg_orders
where status = 'delivered'
```

## Question 4: How many users have only made one purchase? Two purchases? Three+ purchases?
Answer: 
1 order - 25 users 
2 orders - 28 users
3+ orders - 71 users
```sql
with base as (
    select 
        user_id
        , count(distinct order_id) as n_orders 
    from dbt_olivia_r.stg_orders 
    group by 1
) 

select 
    case 
        when n_orders >= 3 then '3+'
        else n_orders::varchar
        end as orders
    , count(distinct user_id) as n_users
from base
group by 1
```

* Question 5: On average, how many unique sessions do we have per hour?
```sql
with base as (
    select 
        date_trunc('hour', created_at_utc) as hr 
        , count(distinct session_id) as sessions
    from dbt_olivia_r.stg_events
    group by 1
)

select 
    round(avg(sessions), 2) as avg_sessions
from base;
```

# Self Reflection Questions
## Part 2
* Were you able to create schema.yml files with model names and descriptions? Yes 
* Were you able to run your dbt models against the data warehouse? Yes

## Part 3
* Could you run the queries to answer key questions from the project instructions? Yes

## Reflection 
* What was most challenging/surprising in completing this week’s project?
The most challenging part was understanding the different components of a dbt project (schema.yml, source.yml, etc), how they fit together, and what is mandatory for a project to run vs just recommended. 

* Is there anywhere you are still stuck or confused? Or Is there a particular part of the project where you want focused feedback from your reviewers?
I added documentation to the src_postgres.yml file, which I think was helpful for me in exploring the data, but I didn't document every column, since some columns felt self explanatory. I also wasn't sure of what needed to be added in the schema.yml file. If I wrote tests on the source data and had very minimal changes in the staging models, should I also include tests for the models?  