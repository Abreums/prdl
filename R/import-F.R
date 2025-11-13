
# Determina família
get_f_family_from_xpert_data <- function(novos_itens){

  novos_itens <-
    novos_itens |>
    mutate(grupo_estoque = "10") |>
    mutate(fam_mat = case_when(
      str_detect(prj_sigla, "CX") ~   "CXPLST",
      str_detect(prj_sigla, "X70") ~  "RNX70",
      str_detect(prj_sigla, "X62") ~  "RNX70",
      str_detect(prj_sigla, "1312") ~ "RN1312",
      str_detect(prj_sigla, "VIVA") ~ "GMVIVA",
      str_detect(prj_sigla, "V230") ~ "VWGOLF",
      str_detect(prj_sigla, "UPPP") ~ "VWUP",
      str_detect(prj_sigla, "UPC") ~  "VWUP",
      str_detect(prj_sigla, "UP") ~   "VWUP",
      str_detect(prj_sigla, "U79P") ~ "RNU79",
      str_detect(prj_sigla, "SCXD") ~ "PCSC",
      str_detect(prj_sigla, "SCDI") ~ "PCSC",
      str_detect(prj_sigla, "PM7") ~  "GMPM7",
      str_detect(prj_sigla, "PA") ~   "XXPA",
      str_detect(prj_sigla, "P426") ~ "VV426",
      str_detect(prj_sigla, "OTH") ~  "OUTROS",
      str_detect(prj_sigla, "NTC") ~  "MBNTC",
      str_detect(prj_sigla, "NCG") ~  "SCNCG",
      str_detect(prj_sigla, "MQBF") ~ "VWMQB",
      str_detect(prj_sigla, "MQB") ~  "VWMQB",
      str_detect(prj_sigla, "LTC") ~  "MBLTC",
      str_detect(prj_sigla, "L98") ~  "XXL98",
      str_detect(prj_sigla, "HPN") ~  "XXHPN",
      str_detect(prj_sigla, "HJF") ~  "RNHJF",
      str_detect(prj_sigla, "HJDE") ~ "RNHJDE",
      str_detect(prj_sigla, "HJDD") ~ "RNHJDD",
      str_detect(prj_sigla, "FX/J") ~ "XXSTFX",
      str_detect(prj_sigla, "FPN") ~  "XXFPN",
      str_detect(prj_sigla, "FOX") ~  "VWFOX",
      str_detect(prj_sigla, "F1H") ~  "STF1H",
      str_detect(prj_sigla, "CUVF") ~ "VW246",
      str_detect(prj_sigla, "CUV") ~  "VW246",
      str_detect(prj_sigla, "C4P") ~  "PCC4",
      str_detect(prj_sigla, "C4E") ~  "PCC4",
      str_detect(prj_sigla, "B02A") ~ "RNB02A",
      str_detect(prj_sigla, "AI94") ~ "PCAI94",
      str_detect(prj_sigla, "AI58") ~ "PCAI58",
      str_detect(prj_sigla, "A91") ~  "PC208",
      str_detect(prj_sigla, "516T") ~ "ST516",
      str_detect(prj_sigla, "270H") ~ "VW270",
      str_detect(prj_sigla, "23X") ~  "VW23X",
      str_detect(prj_sigla, "220P") ~ "VW220",
      str_detect(prj_sigla, "220C") ~ "VW220",
      str_detect(prj_sigla, "216T") ~ "VW216",
      str_detect(prj_sigla, "216C") ~ "VW216",
      TRUE ~ NA
    )) |>
    mutate(fam_mat = str_c(prj_sigla, "10")) |>
    mutate(fam_com = case_when(
      str_detect(prj_sigla, "CX") ~ "CX",
      str_detect(prj_sigla, "X70") ~  "RSA",
      str_detect(prj_sigla, "X62") ~  "RSA",
      str_detect(prj_sigla, "1312") ~ "RSA",
      str_detect(prj_sigla, "VIVA") ~ "GMB",
      str_detect(prj_sigla, "V230") ~ "VW",
      str_detect(prj_sigla, "UPPP") ~ "VW",
      str_detect(prj_sigla, "UPC") ~  "VW",
      str_detect(prj_sigla, "UP") ~   "VW",
      str_detect(prj_sigla, "U79P") ~ "RSA",
      str_detect(prj_sigla, "SCXD") ~ "STEL",
      str_detect(prj_sigla, "SCDI") ~ "STEL",
      str_detect(prj_sigla, "PM7") ~  "GMB",
      str_detect(prj_sigla, "PA") ~   "OUTROS",
      str_detect(prj_sigla, "P426") ~ "VOLVO",
      str_detect(prj_sigla, "OTH") ~  "OUTROS",
      str_detect(prj_sigla, "NTC") ~  "MBB",
      str_detect(prj_sigla, "NCG") ~  "SCANIA",
      str_detect(prj_sigla, "MQBF") ~ "VW",
      str_detect(prj_sigla, "MQB") ~  "VW",
      str_detect(prj_sigla, "LTC") ~  "MBB",
      str_detect(prj_sigla, "L98") ~  "OUTROS",
      str_detect(prj_sigla, "HPN") ~  "OUTROS",
      str_detect(prj_sigla, "HJF") ~  "RSA",
      str_detect(prj_sigla, "HJDE") ~ "RSA",
      str_detect(prj_sigla, "HJDD") ~ "RSA",
      str_detect(prj_sigla, "FX/J") ~ "STEL",
      str_detect(prj_sigla, "FPN") ~  "OUTROS",
      str_detect(prj_sigla, "FOX") ~  "VW",
      str_detect(prj_sigla, "F1H") ~  "STEL",
      str_detect(prj_sigla, "CUVF") ~ "VW",
      str_detect(prj_sigla, "CUV") ~  "VW",
      str_detect(prj_sigla, "C4P") ~  "STEL",
      str_detect(prj_sigla, "C4E") ~  "STEL",
      str_detect(prj_sigla, "B02A") ~ "RSA",
      str_detect(prj_sigla, "AI94") ~ "STEL",
      str_detect(prj_sigla, "AI58") ~ "STEL",
      str_detect(prj_sigla, "A91") ~  "STEL",
      str_detect(prj_sigla, "516T") ~ "STEL",
      str_detect(prj_sigla, "270H") ~ "VW",
      str_detect(prj_sigla, "23X") ~  "VW",
      str_detect(prj_sigla, "220P") ~ "VW",
      str_detect(prj_sigla, "220C") ~ "VW",
      str_detect(prj_sigla, "216T") ~ "VW",
      str_detect(prj_sigla, "216C") ~ "VW",
      TRUE ~ NA
    )) |>
    select(item,
           desc,
           grupo_estoque,
           fam_mat,
           fam_com,
           un,
           estabelecimento,
           cod_comp)
}


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
f_to_cd0209 <- function(f_df, out_file = "default.lst") {

  # Para importar matéria primas, vamos utilizar a listagem de
  # "Já Cadastrados" para avaliar se é uma nova inclusão ou uma atualização
  ja_cadastrados <- read_excel(here("data", "2025-11-10 ja-cadastrados.xlsx")) |>
    janitor::clean_names() |>
    filter(str_detect(item, "^F")) |>
    select(item) |>
    mutate(trx = 2)

  df <-
    f_df |>
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


# +----------------------------------------------------------------------------------------------------------------------------------+
#   |                                 Layout do Arquivo de Importação de ESTRUTURAS/ALTERNATIVOS                                       |
#   |----------------------------------------------------------------------------------------------------------------------------------|
#   |                                                Nome do Arquivo: A ser informado                                                  |
#   |                                                        Formato: Texto                                                            |
#   |                                            Tamanho do Registro: VARIAVEL                                                         |
#   |----------------------------------------------------------------------------------------------------------------------------------|
#   | Ordem |                         Descrição                       | Tamanho | Início | Término | Conteúdo | Decimais | Obrigatório |
#   |-------+---------------------------------------------------------+---------+--------+---------+----------+----------+-------------|
#   |    1  | Tipo de Transação                                       |     1   |     1  |     1   | Inteiro  |          |     Sim     |
#   |       | Onde: 1 - Estrutura                                     |         |        |         |          |          |             |
#   |       |       2 - Alternativo                                   |         |        |         |          |          |             |
#   |       |                                                         |         |        |         |          |          |             |
#   |-------+---------------------------------------------------------+---------+--------+---------+----------+----------+-------------|
#   |       | Layout para tipo de transação = 1 (Estrutura)           |         |        |         |          |          |             |
#     |       |                                                         |         |        |         |          |          |             |
#     |    2  | Código do Item Pai                                      |    16   |     2  |    17   | Caracter |          |     Sim     |
#     |    3  | Sequência                                               |     5   |    18  |    22   | Inteiro  |          |     Sim     |
#     |    4  | Código do Componente                                    |    16   |    23  |    38   | Caracter |          |     Sim     |
#     |    5  | Revisão                                                 |     8   |    39  |    46   | Caracter |          |     Não     |
#     |    6  | Fantasma (S/N)                                          |     1   |    47  |    47   | Caracter |          |     Sim     |
#     |    7  | Fator Perda                                             |     4   |    48  |    51   | Decimal  |     2    |     Não     |
#     |    8  | Proporção                                               |     5   |    52  |    56   | Decimal  |     2    |     Sim     |
#     |    9  | Série Inicial                                           |    12   |    57  |    68   | Caracter |          |     Não     |
#     |   10  | Série Final                                             |    12   |    69  |    80   | Caracter |          |     Não     |
#     |   11  | Quantidade Usada                                        |    16   |    81  |    96   | Decimal  |    10    |     Sim     |
#     |   12  | Tempo de Reserva (? ou um valor maior que zero)         |     4   |    97  |   100   | Inteiro  |          |     Não     |
#     |   13  | Data Início                                             |     8   |   101  |   108   | Data     |          |     Sim     |
#     |       | Formato ddmmaa                                          |         |        |         |          |          |             |
#     |       | Onde    dd   = Dia                                      |         |        |         |          |          |             |
#       |       |         mm   = Mês                                      |         |        |         |          |          |             |
#         |       |         aaaa = Ano                                      |         |        |         |          |          |             |
#           |   14  | Data Término                                            |     8   |   109  |   116   | Data     |          |     Sim     |
#           |       | Formato ddmmaaaa                                        |         |        |         |          |          |             |
#           |       | Onde    dd   = Dia                                      |         |        |         |          |          |             |
#             |       |         mm   = Mês                                      |         |        |         |          |          |             |
#               |       |         aaaa = Ano                                      |         |        |         |          |          |             |
#                 |   15  | Código Roteiro de Fabricação                            |    16   |   117  |   132   | Caracter |          |     Não     |
#                 |   16  | Código Operação                                         |     5   |   133  |   137   | Inteiro  |          |     Não     |
#                 |   17  | Local Montagem                                          |    55   |   138  |   192   | Caracter |          |     Não     |
#                 |   18  | Observação                                              |    40   |   193  |   232   | Caracter |          |     Não     |
#                 |   19  | Referência Pai                                          |     8   |   233  |   240   | Caracter |          |     Não     |
#                 |   20  | Referência Filho                                        |     8   |   241  |   248   | Caracter |          |     Não     |
#                 |   21  | Tipo Sobra                                              |     2   |   249  |   250   | Inteiro  |          |     Sim     |
#                 |       | 1 - Retorno de Requisição \                             |         |        |         |          |          |             |
#                 |       | 2 - Sobra                  > Quantidade Negativa        |         |        |         |          |          |             |
#                 |       | 3 - Coproduto             /                             |         |        |         |          |          |             |
#                 |       | 4 - Normal -> Quantidade Positiva                       |         |        |         |          |          |             |
#                 |   22  | Quantidade do Item Pai                                  |    12   |   251  |   262   | Decimal  |     4    |     Sim     |
#                 |   23  | Veículo (S/N)                                           |     1   |   263  |   263   | Caracter |          |     Não     |
#                 |   24  | Percentual Distribuição Veículo                         |     7   |   264  |   270   | Decimal  |     4    |     Não     |
#                 |   25  | Utiliza Quantidade Fixa?                                |     1   |   271  |   271   | Caracter |          |     Não     |
#                 |-------+---------------------------------------------------------+---------+--------+---------+----------+----------+-------------|
#                 |       | Layout para tipo de transação = 2 (Alternativo)         |         |        |         |          |          |             |
#                   |       |                                                         |         |        |         |          |          |             |
#                   |    2  | Código do Item Pai                                      |    16   |     2  |    17   | Caracter |          |     Sim     |
#                   |    3  | Sequência                                               |     5   |    18  |    22   | Inteiro  |          |     Sim     |
#                   |    4  | Código do Componente                                    |    16   |    23  |    38   | Caracter |          |     Sim     |
#                   |    5  | Ordem                                                   |     5   |    39  |    43   | Inteiro  |          |     Sim     |
#                   |    6  | Código do Componente Alternativo                        |    16   |    44  |    59   | Caracter |          |     Sim     |
#                   |    7  | Quantidade Usada                                        |    16   |    60  |    75   | Decimal  |    10    |     Sim     |
#                   |    8  | Fator de Perda                                          |     4   |    76  |    79   | Decimal  |     2    |     Não     |
#                   |    9  | Observação                                              |    40   |    80  |   119   | Caracter |          |     Não     |
#                   +----------------------------------------------------------------------------------------------------------------------------------+
#
#
#

build_file_to_en0113 <- function(data) {


  # * = obrigatório
  en0113_fix_width <- c(
    1,  # * trx: 1 - Estrutura   2 - Alternativo
    16, #  Código do Item Pai    | Caracter
    5,  #  Sequência             | Inteiro
    16, #  Código do Componente  | Caracter
    8,  #  Revisão               | Caracter |     Não
    1,  #  Fantasma (S/N)        | Caracter |
    4,  #  Fator Perda           | Decimal  |     Não     |
    5,  #  Proporção             | Decimal
    12, #  Série Inicial         | Caracter |     Não
    12, #  Série Final           | Caracter |    Não
    16, #  Quantidade Usada      | Decimal  |
    4,  #  Tempo de Reserva (? ou um valor maior que zero)   | Inteiro  | Não
    8,  #  Data Início          | Data     | Formato ddmmaaaa                                          |         |        |         |          |          |             |
    8,  #  Data Término         | Data     | Formato ddmmaaaa
    16, #  Código Roteiro de Fabricação    | Caracter |          |     Não
    5,  #  Código Operação      | Inteiro  |          |     Não     |
    55, #  Local Montagem       | Caracter |          |     Não     |
    40, #  Observação           | Caracter |          |     Não     |
    8,  #  Referência Pai       | Caracter |          |     Não     |
    8,  #  Referência Filho     | Caracter |          |     Não     |
    2,  #  Tipo Sobra           | Inteiro  | 1 - Retorno de Requisição 2 - Sobra > Quantidade Negativa 3 - Coproduto 4 - Normal -> Quantidade Positiva
    12, # Quantidade do Item Pai | Decimal  |
    1,  # Veículo (S/N)         | Caracter |          |     Não
    7,  # Percentual Distribuição Veículo  | Decimal  |     Não
    1,  # Utiliza Quantidade Fixa? |  Caracter |          |     Não
  )
}

