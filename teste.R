

library(tidyverse)

mtcars |>
  glimpse()


mtcars <-
  mtcars |>
  rownames_to_column(var = "car_model")

mtcars |>
  count(cyl)
