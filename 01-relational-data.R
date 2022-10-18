# Practice working with relational data 
# see Chapter 13 https://r4ds.had.co.nz/relational-data.html#nycflights13-relational

# uncomment and run if nycflights13 is not already installed
# install.packages("nycflights13")

# load required packages
library(nycflights13)
library(tidyverse)


# QUESTION 1. Is there a relationship between the age of a plane and its departure delays?

# step 0: inspect the data frames -- which variables do you need to solve the problem?
glimpse(flights)
glimpse(planes)

# step 1: 
# use mutate() and the appropriate variables to calculate age using the planes table 
# then select the required variables from the planes table
plane_ages <- ________ %>%
    mutate( ________ = 2013 - ________ ) %>%
    select( _______ , _________ )

# step 2: 
# use inner_join() to combine the data frames (flights and plane_ages)
# generate a graph to shows the relationship between the required variables, use a smoothing line geom
_______ %>%
  inner_join(y = ______ ) %>%
  ggplot(mapping = aes(x = _______, y = ________)) +
  geom_smooth()



# QUESTION 2. Add the location of the origin and destination (i.e. `lat` and `lon`) to flights

# step 0: inspect the data frames -- which variables do you need to solve the problem?
glimpse(flights)
glimpse(airports)

# step 1: select only the necessary columns from airports, save them in airports_lite


# step 2: combine the columns using left_join()
# specify the names of the matching columns, and distinguish destination from origin
# save your results in a new dataframe
# hint: to distinguish distention from origin you need to add the suffix argument
# see https://dplyr.tidyverse.org/reference/mutate-joins.html


