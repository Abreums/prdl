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

build_bom <- function(component, bom) {
  upper_bom <- 
    bom |> 
    filter(material_number == component)
  final_bom <- upper_bom
  sub_bom <- upper_bom
  
  while(nrow(sub_bom) != 0){
    sub_bom <- 
      get_bom_component(upper_bom) |> 
      get_component_base(bom)
    
    if(nrow(sub_bom)){
      final_bom <- 
        final_bom |> 
        bind_rows(sub_bom)
      upper_bom <- sub_bom
    }
  }
  final_bom <- 
    final_bom |> 
    mutate(temein = as.integer(temein),
           comp_qtty = (as.numeric(str_replace_all(component_quantity, "[[:punct:]]", "")) / 10000000),
           ofator = (10^(as.numeric(temein)-1)),
           ncomp_qtty = ifelse(fixed_qty == "x", comp_qtty, comp_qtty / ofator))
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
