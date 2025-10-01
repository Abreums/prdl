# read BOM

# use:
# read_bom(bom_file) para ter um arquivo com a bom extraida do XPert
#
# use:
# build_bom("F000999", bom) para obter uma bom de um item
#
# use:
# get_itens_of_bom(a_specific_bom, system_item) para obter uma lista das materias primas da bom

read_bom <- function(bom_file) {
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
  #id = "F01123003001A"
  upper_bom <-
    bom |>
    filter(material_number == id)

  final_bom <- upper_bom
  sub_bom <- upper_bom

  print(sub_bom |> first() |> pull(material_number))
  while(nrow(sub_bom) != 0){
    sub_bom <-
      get_bom_component(upper_bom) |>
      get_component_base(bom)
    print(sub_bom |> first() |> pull(material_number))

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
}


get_itens_of_bom <- function(bom, itens) {
  # bom <- f3040

  main_finish_product <-
    bom |>
    filter(str_detect(material_number, "^F")) |>
    distinct(material_number, plant)
  main_finish_product_plant <-
    main_finish_product |> pull(plant)
  estabelecimento <-
    ifelse(main_finish_product_plant == "SPI", 102, ifelse(main_finish_product_plant == "SPB", 103, NA))

  bom_components <-
    bom |> pull(bom_component)

  bom_itens <-
    itens |>
    filter(item %in% bom_components) |>
    select(item,
           desc,
           grupo_de_estoque,
           un,
           estabelecimento)
}

get_mp_from_bom <- function(bom, itens) {
  bom_components <-
    bom |> pull(bom_component)

  bom_itens <-
    itens |>
    filter(item %in% bom_components) |>
    mutate(fam_com = "") |>
    select(item,
           desc,
           grupo_de_estoque,
           fam_com,
           un,
           estabelecimento,
           cod_comp) |>
    filter(!str_detect(item, "^I")) |>
    filter(!str_detect(item, "^F")) |>
    filter(!str_detect(item, "^E1")) |>
    filter(!str_detect(item, "^E2")) |>
    filter(!str_detect(item, "^R1")) |>
    filter(!str_detect(item, "^V1")) |>
    group_by(item) |>
    summarise(desc = first(desc),
              grupo_de_estoque = first(grupo_de_estoque),
              un = first(un),
              estabelecimento = first(estabelecimento),
              fam_com = first(fam_com),
              cod_comp = first(cod_comp)) |>
    mutate(cod_comp = ifelse(is.na(cod_comp), " ", cod_comp))
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
