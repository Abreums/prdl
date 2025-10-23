# read BoP

read_bop <- function(bop_file) {
  bom <- readxl::read_excel(bop_file) |>
    janitor::clean_names()
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
