# load required packages
library(tidyverse)
library(rcfss)

# load the data
data("gun_deaths")
gun_deaths

# Convert month into a factor column
## create a character vector with all month values
month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun", 
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)

## or use the built-in constant
month.abb

## use mutate() and factor() to convert the column and store the result
(gun_deaths <- gun_deaths %>%
    mutate(month = factor(month,
                          levels = month_levels)))

# Visualize the total gun deaths per month, in chronological order
ggplot(data = gun_deaths,
       mapping = aes(x = month)) +
  geom_bar() +
  labs(title = "Gun Deaths in the United States (2012-2014)",
       x = "Month",
       y = "Number of gun deaths")

# Visualize the total gun deaths per month, sorted from lowest to highest
## with geom_col() and fct_reorder()
gun_deaths %>%
  count(month) %>%
  ggplot(mapping = aes(x = fct_reorder(.f = month, .x = n), y = n)) +
  geom_col() +
  labs(title = "Gun Deaths in the United States (2012-2014)",
       x = "Month",
       y = "Number of gun deaths")

## with geom_bar() and fct_infreq()
ggplot(data = gun_deaths,
       mapping = aes(x = month %>%
                       fct_infreq() %>%
                       fct_rev())) +
  geom_bar() +
  labs(title = "Gun Deaths in the United States (2012-2014)",
       x = "Month",
       y = "Number of gun deaths")

# Visualize the frequency of intent of gun deaths using a bar chart,
# sorted from most to least frequent

## identify all possible types of intent
intent_levels <- c("Accidental", "Homicide", "Suicide", "Undetermined")

gun_deaths %>%
  # remove rows with missing intent values
  drop_na(intent) %>%
  # parse_factor() is a tidyverse friendly form of factor()
  mutate(intent = parse_factor(intent, levels = intent_levels)) %>%
  ggplot(mapping = aes(x = intent %>%
                         fct_infreq() %>%
                         fct_rev())) +
  geom_bar() +
  labs(title = "Gun Deaths in the United States (2012-2014)",
       x = "Intent of death",
       y = "Number of gun deaths") +
  coord_flip()

# Visualize total gun deaths by season of the year using a bar chart
gun_deaths %>%
  # use fct_collapse() to condense into 4 categories
  mutate(season = fct_collapse(month,
                               "Winter" = c("Jan", "Feb", "Mar"),
                               "Spring" = c("Apr", "May", "Jun"),
                               "Summer" = c("Jul", "Aug", "Sep"),
                               "Fall" = c("Oct", "Nov", "Dec"))) %>%
  ggplot(mapping = aes(x = season)) +
  geom_bar() +
  labs(title = "Gun Deaths in the United States (2012-2014)",
       x = "Season",
       y = "Number of gun deaths")


