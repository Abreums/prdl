

library(tidyverse)
library(janitor)
library(here)
library(readxl)



file <- "data/jit-spb.txt"

dt <- readLines(file)

itens <- list("")
i = 1

for(line in dt) {
  if(str_detect(line, "^LIN")) {
    item = str_sub(line, start = 8, end = 30)
    itens[i] = item
    i <- i + 1
  }
}

itens <- unlist(itens)

itens <- unique(itens)

itens <- str_trim(itens, "both")

edi <- str_remove_all(itens, "[:blank:]")

source("R/read-itens.R")

itens <- read_itens()


itens_f <- itens |> filter(str_detect(item, "^F"))

itens_f <-
  itens_f |>
  mutate(cod_comp = str_remove_all(cod_comp, "[:blank:]"))

itens_f |> glimpse()

itens_f |>
  filter(estabelecimento == "SPB") |>
  filter(str_detect(prj_desc, "Volks")) |> glimpse()

cadstr <-
  itens_f |>
  filter(cod_comp %in% edi)

cadstr |> View()

cadstr |> count(item, cod_comp) |> View()

cadstr2 <-
  cadstr |>
  select(-estabelecimento) |>
  group_by(item, cod_comp) |>
  summarise(desc = first(desc),
            un = first(un),
            prj_sigla = first(prj_sigla))


cadstr2 |> View()
