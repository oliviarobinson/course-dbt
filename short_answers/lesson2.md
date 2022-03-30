# Short Answer Questions

## Part 1: Models

### Question 1: What is our User Repeat Rate? 

79.8% 

```sql
select avg(is_repeat_customer)
from dbt_olivia_r.fact_user_orders;
```

### Question 2: What are good indicators of a user who will likely purchase again? 

I would split potential features into two categories -- 1) customer interest in plants and 2) customer satisfaction with our store. 

In the first category, I would look at the type and quantity of products the customer purchased. E.g. a customer who purchases a pothos or Aloe Vera plant might be a new plant parent, where as someone who purchases and orchid might be more dedicated to plants and more likely to re-purchase.

For customer satisfaction, it would be great if we had review data in our database, but we could also look at delivery time, whether the order was early or late, and whether the customer used a promo code. 

### Question 3: Explain the marts models you added. 

I spent most of my time creating two models in the core section -- `fact_orders` and `fact_address_orders`. I was interested in the address info since I found early on that users often had multiple addresses, and addresses were often shipped to by multiple users. Initially I had `fact_address_orders` depending on `fact_orders`, but learned that isn't best practice, so instead I had them both depend on `int_orders`, and also moved the calculations on delivery time to a separate model, `int_orders_delivery_times`. 

For the marketing mart, I created a model `fact_promo_usage` with stats about how many times each promo code had been used. I would have liked to spend more time on the product models, but I ran out of time so just did the standard `fact_events` and `fact_sessions` tables. 

## Part 2: Tests 

### Question 1: What assumptions are you making about each model? (i.e. why are you adding each test?)
* Products Mart: I'm assuming that all products have unique ids, but that it's okay for products to have duplicate names. I also assume that price and inventory must both be greater than zero. 
* Users: Assuming unique and not null IDs.
* Orders: Assuming unique and not null IDs, and that each order has an associated (but not neccesarily unique) User ID. 
* Promo Usage: Assuming a unique ID, because I assume that when a promo goes from active to inactive, the row gets replaced in the postgres source (rather than a new row getting added). This could be a good table to use a dbt snapshot on. 

### Question 2: Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
Initially I assumed that each address would only be associated with one user, but I found that wasn't the case, so I created the `fact_address_orders` table. 

### Question 3: Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.
At my organization we're planning to use dbt cloud, so I run the dbt project including dbt test every day and use the email and slack alerting on dbt cloud to ping my team if there was a data error. As we get more advanced, I could also imagine us using the `dbt_artifacts` package to create dashboards that report on model runs and failures. 

## Self Reflection Questions 

* Part 1: Were you able to answer the data question asked i.e. What is our user repeat rate? **Yes**

* Part 1: Were you able to create a marts folder for the three business lines? **Yes**

* Part 1: Were you able to create at least 1 intermediate model and 1 dimension/fact model within each marts model? **No** 
    * I created fact models for all the marts and multiple intermediate models in the core mart, but I didn't spend as much time in marketing or product marts, and couldn't think of a transformation that needed an intermediate model there. 

* Part 2: Were you able to apply dbt tests to your week 1 or week 2 models? **Yes**

### Reflection: What was most challenging/surprising in completing this week’s project?
This project was super interesting, but just took a lot of time during a week when I was behind at work. 

### Reflection: Is there anywhere you are still stuck or confused? Or Is there a particular part of the project where you want focused feedback from your reviewers?
I'm read the conversations in slack, but I'm still not sure why fact models shouldn't depend on each other, especially if you're using the OBT approach and then parsing that down to smaller tables at different aggregation levels. Right now my `fact_orders` is just a select star from my `int_orders`, which seems like unneccesary duplication. 

### Reflection: What are you most proud of about your project?
I love how I was able to answer the user rate question with just two lines of SQL because of the modeling choices I made! And even though the project overall took a lot of time, it was more thinking time rather than code-writing time -- it was great to see how much faster I can develop a set of interconnected tables using dbt than on my old tools. 