
read_venda <- function(filename) {
  #filename = "./reports/vendas/SPB/2024-07-31 SPB.xlsx"
  date_string <- str_extract(filename, "\\d{4}-\\d{2}-\\d{2}")

  abas <- readxl::excel_sheets(filename)

  df <- readxl::read_excel(path = filename,
                           sheet = abas[[1]],
                           range = cellranger::cell_cols("A:E"),
                           col_types = c("text", "text", "text", "numeric", "numeric")) |>
    janitor::clean_names() |>
    filter(!is.na(item)) |>
    mutate(status = as.Date(date_string))
  colnames(df) <- c("cliente", "item", "desc", "qtde", "valor", "status")
  df <-
    df |>
    fill(cliente, .direction = "down") |>
    mutate(projeto = str_sub(item, start = 1L, end = 6L))
  #df |> View()
}

get_files <- function(path) {
  #path = "./reports/vendas/SPB"
  files_list <-
    list.files(path = path,
               full.names = TRUE)
}

get_itens_from_branch <- function(branch){
  itens <-
    get_files(str_c("./reports/vendas/", branch)) |>
    map(read_venda) |>
    reduce(bind_rows) |>
    mutate(ano = str_sub(projeto, start = 5, end = 6),
           seq = str_sub(projeto, start = 3, end = 4))
}


get_clientes_from_branch <- function(branch) {
  clientes <-
    get_files(str_c("./reports/vendas/", branch)) |>
    map(read_venda) |>
    reduce(bind_rows) |>
    distinct(cliente)

}
