

get_embalagem_from_bom <- function(item_bom){
  item_bom |>
    filter(str_detect(bom_component, "^[51, 52, 53, 54, 57, 58, 59, 61, 62, 63]")) |>
    left_join(itens |> select(item, desc), join_by(bom_component == item)) |>
    select(item = material_number, embalagem = bom_component, desc, qtd_carga, base_quantidade)
}


read_embalagens <- function(file_embalagem = NULL) {
  if (is.null(file_embalagem)) {
    file_embalagem <- here::here("data", "Embalagens 2025-07-02.xlsx")
  }
  emb <-
    readxl::read_excel(file_embalagem) |>
    janitor::clean_names()
}
