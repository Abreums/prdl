

library(tidyverse)

mtcars |>
  glimpse()


mtcars <-
  mtcars |>
  rownames_to_column(var = "car_model")

mtcars |>
  group_by(cyl) |>
  summarise(mpg = mean(mpg))
