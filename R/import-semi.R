# IMPORT ITENS CD0209

# f_to_cd0209 prepara um arquivo com componentes para serem importados em massa
# components é um tibble com os campos:
#       item,
#       desc,
#       grupo_estoque,
#       fam_mat,
#       fam_com,
#       un,
#       estabelecimento,
#       cod_comp
# out_file é o nome do arquivo gerado
#
semi_to_cd0209 <- function(df, out_file = "default.lst") {

  # Para importar matéria primas, vamos utilizar a listagem de
  # "Já Cadastrados" para avaliar se é uma nova inclusão ou uma atualização
  ja_cadastrados <- read_excel(here("data", "jah_cadastrados.xlsx")) |>
    janitor::clean_names() |>
    filter(str_detect(item, "^I")) |>
    select(item) |>
    mutate(trx = 2)

  df <-
    df |>
    left_join(ja_cadastrados, join_by("item")) |>
    mutate(trx = ifelse(is.na(trx), 1, trx)) |>
    mutate(desc = str_replace_all(desc, "[[:punct:]]", "")) |>
    mutate(desc = iconv(desc,to="ASCII//TRANSLIT"))


  to_exp <-
    df |>
    mutate(
      tipo_trx = trx,
      situacao = 1,
      dt_impl = "02022025",
      dt_lib = "02022025",
      folha = "",
      tipo_controle = ifelse(grupo_estoque == "80", 4, 2),
      aplicacao = ifelse(grupo_estoque == "90", 1, 2),
      lote_econ = "",
      info = "",
      imagem = "",
      narrativa = "",
      estabelecimento = ifelse(estabelecimento == "SPI", "102", "103")
    ) |>
    select(
      tipo_trx,
      item,
      desc,
      grupo_estoque,
      fam_mat,
      fam_com,
      un,
      estabelecimento,
      situacao,
      dt_impl,
      dt_lib,
      folha,
      tipo_controle,
      aplicacao,
      lote_econ,
      cod_comp,
      info,
      imagem,
      narrativa
    )

  to_exp <- as.data.frame(to_exp)

  # * = obrigatório
  cd0209_fix_width <- c(
    1,  # * trx: 1: create, 2: update, 3: delete
    16, # * id
    60, # * desc
    2,  # * grupo de estoque
    8,  # * família material
    8,  # família comercial
    2,  # * un
    5,  # * estabelecimento
    2,  # * situação: 1 ativo, 2 obsol ord auto, 3 obs todas, 4 totalmente obsoleto
    8,  # * data implantação
    8,  # * data liberação
    8,  # folha especificação
    2,  # * tipo controle: 1 físico, 2 total, 3 consignado, 4 débito direto
    2,  # * aplicação: 1 serviço, 2 material
    13, # lote econômico
    20, # código complementar
    16, # info complementares
    30, # imagem
    2000 # narrativa
  )

  #
  #
  # +----------------------------------------------------------------------------------------------------------------------------------+
  #   |                                             Layout do Arquivo de Importação de Itens                                             |
  #   |----------------------------------------------------------------------------------------------------------------------------------|
  #   |                                                     Nome do Arquivo: A ser informado                                             |
  #   |                                                             Formato: Texto                                                       |
  #   |                                                 Tamanho do Registro: 979                                                         |
  #   |----------------------------------------------------------------------------------------------------------------------------------|
  #   | Ordem |                         Descrição                       | Tamanho | Início | Término | Conteúdo | Decimais | Obrigatório |
  #   |-------+---------------------------------------------------------+---------+--------+---------+----------+----------+-------------|
  #   |    1  | Tipo de Transação                                       |     1   |     1  |     1   | Inteiro  |          |     Sim     |
  #   |       | Onde    1 - Inclusão                                    |         |        |         |          |          |             |
  #   |       |         2 - Modifição                                   |         |        |         |          |          |             |
  #   |       |         3 - Eliminação                                  |         |        |         |          |          |             |
  #   |    2  | Código do Item                                          |    16   |     2  |    17   | Caracter |          |     Sim     |
  #   |    3  | Descrição                                               |    60   |    18  |    77   | Caracter |          |     Sim     |
  #   |    4  | Código do Grupo de Estoque                              |     2   |    78  |    79   | Inteiro  |          |     Sim     |
  #   |    5  | Código da Família de Material                           |     8   |    80  |    87   | Caracter |          |     Sim     |
  #   |    6  | Família Comercial                                       |     8   |    88  |    95   | Caracter |          |     Não     |
  #   |    7  | Unidade de Medida                                       |     2   |    96  |    97   | Caracter |          |     Sim     |
  #   |    8  | Estabelecimento Padrão                                  |     5   |    98  |   102   | Caracter |          |     Sim     |
  #   |    9  | Situação                                                |     2   |   103  |   104   | Inteiro  |          |     Sim     |
  #   |       | Onde    1 - Ativo                                       |         |        |         |          |          |             |
  #   |       |         2 - Obsoleto Ordens Automáticas                 |         |        |         |          |          |             |
  #   |       |         3 - Obsoleto Todas as Ordens                    |         |        |         |          |          |             |
  #   |       |         data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAAbElEQVR4Xs2RQQrAMAgEfZgf7W9LAguybljJpR3wEse5JOL3ZObDb4x1loDhHbBOFU6i2Ddnw2KNiXcdAXygJlwE8OFVBHDgKrLgSInN4WMe9iXiqIVsTMjH7z/GhNTEibOxQswcYIWYOR/zAjBJfiXh3jZ6AAAAAElFTkSuQmCC4 - Totalmente Obsoleto                         |         |        |         |          |          |             |
  #   |   10  | Data de Implantação                                     |     8   |   105  |   112   | Data     |          |     Sim     |
  #   |       | Formato mmddaaaa                                        |         |        |         |          |          |             |
  #   |       | Onde    mm   = Mês                                      |         |        |         |          |          |             |
  #   |       |         dd   = Dia                                      |         |        |         |          |          |             |
  #   |       |         aaaa = Ano                                      |         |        |         |          |          |             |
  #   |   11  | Data de Liberação                                       |     8   |   113  |   120   | Data     |          |     Sim     |
  #   |       | Formato mmddaaaa                                        |         |        |         |          |          |             |
  #   |       | Onde    mm   = Mês                                      |         |        |         |          |          |             |
  #   |       |         dd   = Dia                                      |         |        |         |          |          |             |
  #   |       |         aaaa = Ano                                      |         |        |         |          |          |             |
  #   |   12  | Folha de Especificação                                  |     8   |   121  |   128   | Caracter |          |     Não     |
  #   |   13  | Tipo Controle                                           |     2   |   129  |   130   | Inteiro  |          |     Sim     |
  #   |       | Onde    1 - Físico                                      |         |        |         |          |          |             |
  #   |       |         2 - Total                                       |         |        |         |          |          |             |
  #   |       |         3 - Consignado                                  |         |        |         |          |          |             |
  #   |       |         4 - Débito Direto                               |         |        |         |          |          |             |
  #   |   14  | Aplicação (1-Serviço 2-Material)                        |     2   |   131  |   132   | Inteiro  |          |     Sim     |
  #   |       | Onde    1 - Serviço                                     |         |        |         |          |          |             |
  #   |       |         2 - Material                                    |         |        |         |          |          |             |
  #   |   15  | Lote Econômico                                          |    13   |   133  |   145   | Decimal  |     4    |     Não     |
  #   |   16  | Código Complementar                                     |    20   |   146  |   165   | Caracter |          |     Não     |
  #   |   17  | Informações Complementares                              |    16   |   166  |   181   | Caracter |          |     Não     |
  #   |   18  | Imagem                                                  |    30   |   182  |   211   | Caracter |          |     Não     |
  #   |   19  | Narrativa                                               |  2000   |   212  |  2211   | Caracter |          |     Não     |
  #   +----------------------------------------------------------------------------------------------------------------------------------+
  #
  #

  gdata::write.fwf(
    x = to_exp,
    file = out_file,
    width = cd0209_fix_width,
    colnames = FALSE,
    rownames = FALSE,
    sep = ""
  )

}
