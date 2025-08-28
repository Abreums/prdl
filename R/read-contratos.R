# read contratos

read_contracts <- function(contract_filename) {
  # test:
  contract_filename <- here::here("data", "contratos 2025-06-04.xlsx")

  contracts <-
    readxl::read_excel(contract_filename) |>
    janitor::clean_names()
}

