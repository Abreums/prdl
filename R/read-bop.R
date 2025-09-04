# read BoP

read_bop <- function(bop_file) {
  bom <- readxl::read_excel(bop_file) |>
    janitor::clean_names()
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
