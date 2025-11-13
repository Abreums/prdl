# read BoP

read_bop <- function(bop_file) {
  bop <- readxl::read_excel(bop_file) |>
    janitor::clean_names()

  bop <-
    bop |>
    mutate(description = str_to_upper(description)) |>
    mutate(description = str_replace_all(description, "[[:punct:]]", "")) |>
    mutate(description = iconv(description, to="ASCII//TRANSLIT")) |>
    mutate(description = case_when(
      str_detect(description, "ONTAGE")      ~ "MONTAGEM",
      str_detect(description, "INJE")         ~ "INJECAO",
      str_detect(description, "EMBALAGEM")    ~ "EMBALAGEM",
      str_detect(description, "EITQUET")      ~ "EMBALAGEM",
      str_detect(description, "CORTE")        ~ "TERMO",
      str_detect(description, "MONTA")        ~ "MONTAGEM",
      str_detect(description, "MOLDADOS")     ~ "INJECAO",
      str_detect(description, "TRANSBORDO")   ~ "TRANSBORDO",
      str_detect(description, "RETRABALHO")   ~ "EMBALAGEM",
      str_detect(description, "COMPRADO")     ~ "COMPRADO",
      str_detect(description, "INEJCAO")      ~ "INJECAO",
      str_detect(description, "MONTAGTEM")    ~ "MONTAGEM",
      str_detect(description, "MONATGEM")     ~ "MONTAGEM",
      str_detect(description, "MISTURA")      ~ "MISTURA",
      str_detect(description, "COLAGEM")      ~ "TERMO",
      str_detect(description, "MINTURA")      ~ "PINTURA",
      str_detect(description, "POSTO")        ~ "MONTAGEM",
      str_detect(description, "PINTURA")      ~ "PINTURA",
      TRUE ~ "INATIVO")) |>
    filter(!is.na(description)) |>
    filter(!str_detect(description, "INATIVO"))

}


get_bop_from_id <- function(id, bop) {

  item_bop <-
    bop |>
    filter(part_number == id)

  if(nrow(item_bop) == 0) {
    return(NA)
  }
  return(item_bop)
}

get_bom_component <- function(material){
  material |>
    select(bom_component) |>
    pull()
}

get_component_base <- function(component, bom){
  component |>
    map(~ bom |> filter(material_number == .)) |>
    reduce(bind_rows)
}


get_itens_from_bom <- function(bom, itens){
  components <-
    bom |> pull(bom_component)

  bom_itens <-
    itens |>
    arrange(estabelecimento, id, familia) |>
    filter(id %in% components) |>
    arrange(id)
}
