# PRACTICE WORKING WITH FACTORS - SOLUTIONS

# load required packages
library(tidyverse)
library(rcis)

# load the data
data("gun_deaths")
gun_deaths

# QUESTION 1: convert month into a factor column
# create a character vector with all month values
month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun", 
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)

# use mutate() and factor() to convert the column and store the result
(gun_deaths <- gun_deaths %>%
    mutate(month = factor(month,
                          levels = month_levels)))



# QUESTION 2: visualize the total gun deaths per month, in chronological order
ggplot(data = gun_deaths,
       mapping = aes(x = month)) +
  geom_bar() +
  labs(title = "Gun Deaths in the United States (2012-2014)",
       x = "Month",
       y = "Number of gun deaths")


# QUESTION 3: visualize the total gun deaths per month, sorted from lowest to highest

# with geom_col() and fct_reorder()
gun_deaths %>%
  count(month) %>%
  mutate(month = fct_reorder(.f = month, .x = n)) %>%
  ggplot(mapping = aes(x = month, y = n)) +
  geom_col() +
  labs(title = "Gun Deaths in the United States (2012-2014)",
       x = "Month",
       y = "Number of gun deaths")

# with geom_bar() and fct_infreq()
gun_deaths %>%
  mutate(month = fct_infreq(f = month) %>%
           fct_rev()) %>%
  ggplot(mapping = aes(x = month)) +
  geom_bar() +
  labs(title = "Gun Deaths in the United States (2012-2014)",
       x = "Month",
       y = "Number of gun deaths")
