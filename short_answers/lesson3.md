
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

Create a macro to simplify part of a model(s). Think about what would improve the usability or modularity of your code by applying a macro. Large case statements, or blocks of SQL that are often repeated make great candidates. Document the macro(s) using a .yml file in the macros directory.

Note: One potential macro in our data set is aggregating event types per session. Start here as your first macro and add other macros if you want to go further.

## Part 3: Granting Permissions

Add a post hook to your project to apply grants to the role “reporting”. Create reporting role first by running CREATE ROLE reporting in your database instance.

NOTE: After you create the role you still need to grant it usage access on your schema dbt_<firstname>_<lastinitial> (what you set in your profiles.yml in week 1) which can be done using on-run-end

HINT: you can use the grant macro example from this week and make any necessary changes for postgres syntax

## Part 4:  Packages

Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project

## Part 5: Updated DAGs

Show (using dbt docs and the model DAGs) how you have simplified or improved a DAG using macros and/or dbt packages.


## Reflection Questions 

* Part 1: Were you able to create new models to answer the data questions on conversion rate? Y/N

* Part 2: Were you able to add a new macro to your dbt project? Y/N (indicate if you used a macro to aggregate event types per session or something else)

* Part 3: Were you able to add a post hook to your project to apply grants to the role “reporting”? Y/N

* Part 4: Were you able to install a package? Y/N (indicate what package you used)

### What was most challenging/surprising in completing this week’s project?

### Is there anywhere you are still stuck or confused? Or Is there a particular part of the project where you want focused feedback from your reviewers?

### What are you most proud of about your project?