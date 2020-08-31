# load required packages
library(tidyverse)

# # uncomment and run if nycflights13 is not already installed
# install.packages("nycflights13")
library(nycflights13)

# Is there a relationship between the age of a plane and its departure delays?
## consider the data frames you need to use to solve the problem
glimpse(flights)
glimpse(planes)

## solution

### calculate plane age
(plane_ages <- planes %>%
  mutate(age = 2013 - year) %>%
  select(tailnum, age))

### generate graph using inner_join() to combine the data frames
### and use a smoothing line
flights %>%
  inner_join(y = plane_ages) %>%
  ggplot(mapping = aes(x = age, y = dep_delay)) +
  geom_smooth()

# Add the location of the origin and destination (i.e. the `lat` and `lon`) to `flights`
glimpse(flights)
glimpse(airports)

## solution
### select only the necessary columns from airports
airports_lite <- airports %>%
  select(faa, lat, lon)

### combine them using left_join(), specify the names of the matching
### columns, and distinguish destination from origin
flights %>%
  left_join(y = airports_lite, by = c(dest = "faa")) %>%
  left_join(y = airports_lite, by = c(origin = "faa"), suffix = c(".dest", ".origin"))
