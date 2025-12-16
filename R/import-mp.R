
get_mp_family <- function(df){
  df <-
    df |>
    mutate(fam_com = "MP") |>
    mutate(grupo_de_estoque = case_when(
      str_detect(item, "^56") ~ "70",
      str_detect(item, "^58") ~ "70",
      str_detect(item, "^77") ~ "70",
      str_detect(item, "^51") ~ "40",
      str_detect(item, "^52") ~ "40",
      str_detect(item, "^53") ~ "40",
      str_detect(item, "^59") ~ "40",
      str_detect(item, "^61") ~ "40",
      str_detect(item, "^62") ~ "40",
      str_detect(item, "^63") ~ "40",
      TRUE ~ "30"
    )) |>
    mutate(fam_mat = str_c(grupo_de_estoque, str_sub(item, 1, 2), "000")) |>
    mutate(fam_mat = case_when(
      str_detect(fam_mat, "^3012") ~ "3011000",
      str_detect(fam_mat, "^3031") ~ "UNKN",
      str_detect(fam_mat, "^3046") ~ "UNKN",
      str_detect(fam_mat, "^3072") ~ "UNKN",
      str_detect(fam_mat, "^3074") ~ "UNKN",
      str_detect(fam_mat, "^4052") ~ "4051000",
      str_detect(fam_mat, "^4053") ~ "4051000",
      str_detect(fam_mat, "^4059") ~ "4059000",
      str_detect(fam_mat, "^406") ~  "4051000",
      TRUE ~ fam_mat
      )) |>
    mutate(fam_com = case_when(
      str_detect(grupo_de_estoque, "^40") ~ "EMB",
      str_detect(grupo_de_estoque, "^70") ~ "EMB RET",
      TRUE ~ "MP"
    ))
}

# IMPORT ITENS CD0209

# mp_to_cd0209 prepara um arquivo com componentes para serem importados em massa
# components é um tibble com os campos:
#
# df <-
#   tibble(
#     tipo_trx = c(),
#     item = c(),
#     desc = c(),
#     grupo_estoque = c(),
#     fam_mat = c(),
#     fam_com = c(),
#     un = c(),
#     estabelecimento = c(),
#     situacao = c(),
#     dt_impl = c(),
#     dt_lib = c(),
#     folha = c(),
#     tipo_controle = c(),
#     aplicacao = c(),
#     lote_econ = c(),
#     cod_comp = c(),
#     info = c(),
#     imagem = c(),
#     narrativa = c()
#   )
#
# out_file é o nome do arquivo gerado
#
mp_to_cd0209 <- function(df, out_file = "default.lst") {

  df <- novos_mp
  to_exp <-
    df |>
    select(
      tipo_trx,
      item,
      desc,
      grupo_de_estoque,
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
      inf_comp,
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



update_cd0209 <- function(df, out_file = "cd0209.lst") {

   df <- as.data.frame(novos_mp)

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
    x = df,
    file = out_file,
    width = cd0209_fix_width,
    colnames = FALSE,
    rownames = FALSE,
    sep = ""
  )

}


