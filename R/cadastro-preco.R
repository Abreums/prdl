

salva_carga_preco <- function(nome_tabela, df) {

  # valido_desde <- as.character(valido_de)
  # nome_tabela <- str_c(nome_tabela, "-", valido_desde)
  nome_tabela <- str_c(nome_tabela, ".csv")

  df |>
    filter(!is.na(preco)) |>
    mutate(referencia = "",
           qtde_min = 0,
           desc_qtde = 0,
           preco_venda = preco,
           preco_fob = preco,
           preco_min = preco,
           preco_min_fob = preco) |>
    select(item, referencia, qtde_min, desc_qtde, preco_venda, preco_fob, preco_min, preco_min_fob) |>
    write_csv(str_c("preco/", nome_tabela))
}
