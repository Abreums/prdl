
read_ja_cadastrados <- function(force = FALSE) {

  ja_cadastrados = NULL
  if(force | !file.exists("data/ja-cadastrados.rds")) {
    ja_cadastrados <-
      readxl::read_excel(here::here("data", "2025-11-10 ja-cadastrados.xlsx"),
                         col_types = "text") |>
      janitor::clean_names()
    ja_cadastrados |> write_rds("data/ja-cadastrados.rds")
  } else{
    ja_cadastrados <- read_rds("data/ja-cadastrados.rds")
  }
  return(ja_cadastrados)
}
