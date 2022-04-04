
# Short Answer Questions

## Part 1: Models

### What is our overall conversion rate?

62.4 %

### What is our conversion rate by product?

```sql
select 
  product_name
  , round(avg(has_checkout), 3)
from dbt_olivia_r.fact_session_products
group by 1
order by 1
```
product_name | round
--- | --- 
Alocasia Polly | 0.412
Aloe Vera | 0.492
Angel Wings Begonia | 0.393
Arrow Head | 0.556
Bamboo | 0.537
Bird of Paradise | 0.450
Birds Nest Fern | 0.423
Boston Fern | 0.413
Cactus | 0.545
Calathea Makoyana | 0.509
Devil's Ivy | 0.489
Dragon Tree | 0.468
Ficus | 0.426
Fiddle Leaf Fig | 0.500
Jade Plant | 0.478
Majesty Palm | 0.493
Money Tree | 0.464
Monstera | 0.510
Orchid | 0.453
Peace Lily | 0.409
Philodendron | 0.484
Pilea Peperomioides | 0.475
Pink Anthurium | 0.419
Ponytail Palm | 0.400
Pothos | 0.344
Rubber Plant | 0.519
Snake Plant | 0.397
Spider Plant | 0.475
String of pearls | 0.609
ZZ Plant | 0.540

A question to think about: Why might certain products be converting at higher/lower rates than others? Note: we don't actually have data to properly dig into this, but we can make some hypotheses. 

* Conversion may be higher on well known plants, since users might feel comfortable purchasing them. On more obscure plants, users might leave the site to learn more and then not come back to complete the purchase. 
* Our site may be promoting certain products more heavily with pop-ups, etc. 

## Part 2: Macros

* I created the macro to aggregate event types by session (or other grouping). I called it `agg_event_types` and I documented the macro in `macros/macros.yml`.

## Part 3: Granting Permissions

* Created the reporting role and added the macro `grant_role` to the post-hook. 

## Part 4:  Packages

* I've used several macros from dbt-utils in my project, including `dbt_utils.group_by`, `dbt_utils.datediff`, `dbt_utils.star`. 
* I also used the `codegen` package to create some documentation. 

## Part 5: Updated DAGs

Show (using dbt docs and the model DAGs) how you have simplified or improved a DAG using macros and/or dbt packages.

## Reflection Questions 

* Part 1: Were you able to create new models to answer the data questions on conversion rate? **Yes**

* Part 2: Were you able to add a new macro to your dbt project? **Yes**

* Part 3: Were you able to add a post hook to your project to apply grants to the role “reporting”? **Yes**

* Part 4: Were you able to install a package? **Yes**, `codegen` and `dbt_utils`.

### What was most challenging/surprising in completing this week’s project?

As my DAG got larger, it was harder to for me to remember which models to rely on when creating new models, such as `fact_session_products` that I used to answer the product level conversion questions. 

### Is there anywhere you are still stuck or confused? Or is there a particular part of the project where you want focused feedback from your reviewers?

* I created some singular tests, but the tests now show up as models in my dag. Is that supposed to happen? If not, how do I fix it? The tests are regular sql files with no jinja decorators, in the `tests/` directory. 
* Are intermediate models allowed to rely on each other?
* Otherwise, things make sense, though I wish I could have had more time to dive in on potential macros and hook operations. 

### What are you most proud of about your project?

I was able to create macros and tests that work together, so that the test confirms the data will enter the macro and return as expected. Also just continuing to push through and complete week 3 -- thanks to all the corise staff for the continued encouragement!