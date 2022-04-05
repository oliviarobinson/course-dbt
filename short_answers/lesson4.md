# Week 4 Short Answer Questions

## Part 1. dbt Snapshots

I added a snapshot and saw the data change in the orders table. 

## Part 2. Modeling challenge

I didn't have time to actually answer these questions, but I created the models and added an exposure. I added a boolean column to indicate whether a session reached each of the three levels of the funnel, and I used the `dbt_date` package to add columns indicating the week and month of the session to make analysis easier over time. 

# Self Review Questions

Part 1: Were you able to add snapshots against the orders data? Did you see any data change? **Yes**

Part 2: Were you able to answer the product funnel questions? **No**, ran out of time but did create the models. 

Part 2: Were you able to create an exposure on your product analytics model? **Yes**

## Reflection: What was most challenging/surprising in completing this week’s project?
Nothing in particular, I was short on time so didn't dig into the funnel modeling as much as I would have liked to. 

## Reflection: Is there anywhere you are still stuck or confused? Or Is there a particular part of the project where you want focused feedback from your reviewers?
Nothing in particular this week. 

## Reflection: What are you most proud of across the 4 weeks? 
I feel like I learned a lot about how to properly setup a dbt project, and definitely feel more confident in trying to roll out dbt at my organization now. 

# Reflection Questions 3A: 

## If your organization is thinking about using dbt, how would you pitch the value of dbt/analytics engineering to a decision maker at your organization?

We are definitely thinking of using dbt, and I made the pitch to my boss recently. The hardest part to overcome is the cost of dbt cloud, but it doesn't (yet) make sense for us to host dbt or coordinate production runs on our airflow instance. In my pitch, I focused on (1) how dbt helps my team work faster, allowing us to spend more time on creating insights rather than munging data and (2) how dbt tests will help make sure bad data doesn't make it into our BI tools, which will help build user trust in dashboards. 

## If you are thinking about moving to analytics engineering, what skills have you picked that give you the most confidence in pursuing this next step?

More confidence in data modeling best practices, ability to make modeling code more modular/ DRY with macros and other dbt tools. 