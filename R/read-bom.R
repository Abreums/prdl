# read BOM

# use:
# read_bom(bom_file) para ter um arquivo com a bom extraida do XPert
#
# use:
# build_bom("F000999", bom) para obter uma bom de um item
#
# use:
# get_itens_of_bom(a_specific_bom, system_item) para obter uma lista das materias primas da bom

read_bom <- function(bom_file = here::here("data", "BOM 2025-09-02.xlsx")) {
  bom <- readxl::read_excel(bom_file) |>
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

get_bom_from_id <- function(id, bom) {
  # id = "F01123003001A"
  # id = "F00322003001B" # empty
  upper_bom <-
    bom |>
    filter(material_number == id)

  final_bom <- upper_bom
  sub_bom <- upper_bom

  #print(sub_bom |> first() |> pull(material_number))
  while(nrow(sub_bom) != 0){
    sub_bom <-
      get_bom_component(upper_bom) |>
      get_component_base(bom)
    #print(sub_bom |> first() |> pull(material_number))

    if(nrow(sub_bom)){
      final_bom <-
        final_bom |>
        bind_rows(sub_bom)
      upper_bom <- sub_bom
    }
  }
  final_bom  <-
    final_bom |>
    mutate(estabelecimento = ifelse(plant == "SPB", 103, ifelse(plant == "SPI", 102, NA)))

  if(nrow(final_bom) == 0) {
    return(NA)
  }
  return(final_bom)
}


get_itens_from_bom <- function(bom) {
  bom_components <-
    bom |>
    distinct(bom_component)
}

get_semi_from_bom <- function(bom) {
  semi <-
    bom |>
    distinct(bom_component) |>
    filter(str_detect(bom_component, "^I") | str_detect(bom_component, "^F"))

  if (nrow(semi) == 0) {
    return(NA)
  } else {
    return(semi)
  }
}

get_mp_from_bom <- function(bom) {
  mp <-
    bom |>
    distinct(bom_component) |>
    filter(!str_detect(bom_component, "^I")) |>
    filter(!str_detect(bom_component, "^F"))

  if(nrow(mp) == 0) {
      return(NA)
    } else {
      return(mp)
    }
}

build_bom <- function(component, bom) {
  # component <- "F00717053001A"
  upper_bom <-
    bom |>
    filter(material_number == component)
  final_bom <- upper_bom
  sub_bom <- upper_bom

  while(nrow(sub_bom) != 0){
    sub_bom <-
      get_bom_component(upper_bom) |>
      get_component_base(bom)
    #print(sub_bom |> first() |> pull(material_number))

    if(nrow(sub_bom)){
      final_bom <-
        final_bom |>
        bind_rows(sub_bom)
      upper_bom <- sub_bom
    }
  }
  final_bom <-
    final_bom
  # mutate(base_quantidade = base_quantidade
  #        temein = temein,
  #        unit_measure = unit_measure,
  #
  #   temein = as.integer(temein),
  #        # comp_qtty = (as.numeric(str_replace_all(component_quantity, "[[:punct:]]", "")) / 10000000),
  #        ofator = (10^(as.numeric(temein)-1)),
  #        ncomp_qtty = ifelse(fixed_qty == "x", comp_qtty, comp_qtty / ofator))
}
