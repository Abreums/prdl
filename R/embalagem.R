

get_embalagem <- function(item_bom){
  item_bom |>
    filter(str_detect(bom_component, "^58")) |>
    left_join(itens |> select(item, desc), join_by(bom_component == item)) |>
    select(item = material_number, embalagem = bom_component, desc, qtd_carga, base_quantidade)
}
