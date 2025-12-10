# +----------------------------------------------------------------------------------------------------------------------------------+
#   |                                 Lay-out do Arquivo de Importação de Saldos                                                       |
#   |----------------------------------------------------------------------------------------------------------------------------------|
#   |                                                     Nome do Arquivo: A ser informado                                             |
#   |                                                             Formato: Texto                                                       |
#   |                                                 Tamanho do Registro: 318                                                         |
#   |----------------------------------------------------------------------------------------------------------------------------------|
#   | Ordem |                         Descrição                       | Tamanho | Início | Término | Conteúdo | Decimais | Obrigatório |
#   |-------+---------------------------------------------------------+---------+--------+---------+----------+----------+-------------|
#   |    1  | Código do Item                                          |    16   |     1  |    16   | Caracter |          |     Sim     |
#   |    2  | Código do Depósito                                      |     3   |    20  |    22   | Caracter |          |     Sim     |
#   |    3  | Lote/Nr de Série até 10 caracteres                      |    10   |    23  |    32   | Caracter |          |     Sim     |
#   |    4  | Data de Validade do Lote                                |    10   |    33  |    42   | Data     |          |     Sim     |
#   |       | Formato dd/mm/aaaa                                      |         |        |         |          |          |             |
#   |       | Onde    dd   = Dia                                      |         |        |         |          |          |             |
#     |       |         mm   = Mês                                      |         |        |         |          |          |             |
#       |       |         aaaa = Ano                                      |         |        |         |          |          |             |
#         |    5  | Localização  até 10 caracteres                          |    10   |    43  |    52   | Caracter |          |     Sim     |
#         |    6  | Conta                                                   |    20   |    53  |    72   | Caracter |          |     Sim     |
#         |    7  | Centro de Custo                                         |    20   |    73  |    92   | Caracter |          |     Sim     |
#         |    8  | Unidade de Medida                                       |     2   |    93  |    94   | Caracter |          |     Sim     |
#         |    9  | Quantidade                                              |    14   |    95  |   108   | Decimal  |     4    |     Sim     |
#         |   10  | Valor Matéria Prima (moeda corrente)                    |    14   |   109  |   122   | Decimal  |     2    |     Sim     |
#         |   11  | Valor Matéria Prima (moeda alternativa 1)               |    14   |   123  |   136   | Decimal  |     2    |     Sim     |
#         |   12  | Valor Matéria Prima (moeda alternativa 2)               |    14   |   137  |   150   | Decimal  |     2    |     Sim     |
#         |   13  | Valor Mão de Obra (moeda corrente)                      |    14   |   151  |   164   | Decimal  |     2    |     Sim     |
#         |   14  | Valor Mão de Obra (moeda alternativa 1)                 |    14   |   165  |   178   | Decimal  |     2    |     Sim     |
#         |   15  | Valor Mão de Obra (moeda alternativa 2)                 |    14   |   179  |   192   | Decimal  |     2    |     Sim     |
#         |   16  | Gastos Gerais de Fabricação (moeda corrente)            |    14   |   193  |   206   | Decimal  |     2    |     Sim     |
#         |   17  | Gastos Gerais de Fabricação (moeda alternativa 1)       |    14   |   207  |   220   | Decimal  |     2    |     Sim     |
#         |   18  | Gastos Gerais de Fabricação (moeda alternativa 2)       |    14   |   221  |   234   | Decimal  |     2    |     Sim     |
#         |   19  | Código de Referência                                    |     8   |   235  |   242   | Caracter |          |     Não     |
#         |   20  | Fator de Concentração / PPM                             |    11   |   243  |   253   | Decimal  |     4    |     Não     |
#         |   21  | Código do Estabelecimento                               |     5   |   254  |   258   | Caracter |          |     Sim     |
#         |   22  | Lote/Nr de Série até 40 caracteres                      |    40   |   259  |   298   | Caracter |          |     Sim     |
#         |   23  | Localização  até 20 caracteres                          |    20   |   299  |   318   | Caracter |          |     Sim     |
#         +----------------------------------------------------------------------------------------------------------------------------------+
#
#         Obs: Caso o lote informado seja maior que 10 caracteres, deve-se utilizar a ordem 22. Caso lote seja menor que 10 caracteres, poderá
#       ser utilizada tanto a ordem 3 como a ordem 22.
#
#       Caso a localização informada seja maior que 10 caracteres, deve-se utilizar a ordem 23. Caso localização seja menor que 10
#       caracteres, poderá ser utilizada tanto a ordem 5 como a ordem 23.
#

# FORNECER TIBBLE COMO ABAIXO:
#
# teste <- tibble(
#   item = "f00417003002a",
#   brancos_3 = "   ",
#   deposito = "ALX",
#   lote = "1020000000",
#   lote_validade = "31/12/2025",
#   localizacao = "          ",
#   conta_contabil = "91210900",
#   centro_de_custo = "",
#   unidade_medida = "PC",
#   quantidade = 55000,
#   valor_mp_moeda_corrente = 15004.06,
#   valor_mp_moeda_alt_1 = 0.00,
#   valor_mp_moeda_alt_2 = 0.00,
#   valor_mo_moeda_corrente = 0.00,
#   valor_mo_moeda_alt_1 = 0.00,
#   valor_mo_moeda_alt_2 = 0.00,
#   gastos_fabricacao_moeda_corrente = 0.00,
#   gastos_fabricacao_moeda_alt_1 = 0.00,
#   gastos_fabricacao_moeda_alt_2 = 0.00,
#   codigo_referencia = "        ",
#   fator_concentracao = 0.00,
#   estabelecimento = "102",
#   lote_40_char = " ",
#   localizacao_20_char = " "
# )
#
#
# to_ce0000(teste)


      # IMPORTAR SALDOS CE0000

      to_ce0000 <- function(df, out_file = "ce0000.lst") {

        to_exp <-
          df |>
          mutate(
            quantidade = str_pad(str_remove_all(sprintf("%s", sprintf("%.4f", quantidade)), "[[:punct:]]"), 14, side = "left", "0"), # 4, #   fator de perda (decimal, 2)100, DECIMAL, 2
            valor_mp_moeda_corrente = str_pad(str_remove_all(sprintf("%s", sprintf("%.2f", valor_mp_moeda_corrente)), "[[:punct:]]"), 14, side = "left", "0"),
            valor_mp_moeda_alt_1 = str_pad(str_remove_all(sprintf("%s", sprintf("%.2f", valor_mp_moeda_alt_1)), "[[:punct:]]"), 14, side = "left", "0"),
            valor_mp_moeda_alt_2 = str_pad(str_remove_all(sprintf("%s", sprintf("%.2f", valor_mp_moeda_alt_2)), "[[:punct:]]"), 14, side = "left", "0"),
            valor_mo_moeda_corrente = str_pad(str_remove_all(sprintf("%s", sprintf("%.2f", valor_mo_moeda_corrente)), "[[:punct:]]"), 14, side = "left", "0"),
            valor_mo_moeda_alt_1 = str_pad(str_remove_all(sprintf("%s", sprintf("%.2f", valor_mo_moeda_alt_1)), "[[:punct:]]"), 14, side = "left", "0"),
            valor_mo_moeda_alt_2 = str_pad(str_remove_all(sprintf("%s", sprintf("%.2f", valor_mo_moeda_alt_2)), "[[:punct:]]"), 14, side = "left", "0"),
            gastos_fabricacao_moeda_corrente = str_pad(str_remove_all(sprintf("%s", sprintf("%.2f", gastos_fabricacao_moeda_corrente)), "[[:punct:]]"), 14, side = "left", "0"),
            gastos_fabricacao_moeda_alt_1 = str_pad(str_remove_all(sprintf("%s", sprintf("%.2f", gastos_fabricacao_moeda_alt_1)), "[[:punct:]]"), 14, side = "left", "0"),
            gastos_fabricacao_moeda_alt_2 = str_pad(str_remove_all(sprintf("%s", sprintf("%.2f", gastos_fabricacao_moeda_alt_2)), "[[:punct:]]"), 14, side = "left", "0"),
            fator_concentracao = str_pad(str_remove_all(sprintf("%s", sprintf("%.4f", fator_concentracao)), "[[:punct:]]"), 11, side = "left", "0"),
            ) |>
          select(
            item,
            brancos_3,
            deposito,
            lote,
            lote_validade,
            localizacao,
            conta_contabil,
            centro_de_custo,
            unidade_medida,
            quantidade,
            valor_mp_moeda_corrente,
            valor_mp_moeda_alt_1,
            valor_mp_moeda_alt_2,
            valor_mo_moeda_corrente,
            valor_mo_moeda_alt_1,
            valor_mo_moeda_alt_2,
            gastos_fabricacao_moeda_corrente,
            gastos_fabricacao_moeda_alt_1,
            gastos_fabricacao_moeda_alt_2,
            codigo_referencia,
            fator_concentracao,
            estabelecimento,
            lote_40_char,
            localizacao_20_char
          )

        to_exp <- as.data.frame(to_exp)

        # * = obrigatório
        ce0000_fix_width <- c(
          16,  # Código do Item 16                          |     1  |    16   | Caracter |          |     Sim     |
           3,  # brancos
           3,  # Código do Depósito                         | 3   |    20  |    22   | Caracter |          |     Sim     |
          10,  # Lote/Nr de Série até 10 caracteres         |    10   |    23  |    32   | Caracter |          |     Sim     |
          10,  # Data de Validade do Lote dd/mm/aaaa        |    10   |    33  |    42   | Data     |          |     Sim     |
          10,  # Localização  até 10 caracteres             |    10   |    43  |    52   | Caracter |          |     Sim     |
          20,  # Conta                                      |    20   |    53  |    72   | Caracter |          |     Sim     |
          20,  # Centro de Custo                            |    20   |    73  |    92   | Caracter |          |     Sim
           2,  # Unidade de Medida                          |     2   |    93  |    94   | Caracter |          |     Sim
          14,  # Quantidade                                 |    14   |    95  |   108   | Decimal  |     4    |     Sim     |
          14,  # Valor Matéria Prima (moeda corrente)       |    14   |   109  |   122   | Decimal  |     2    |     Sim     |
          14,  # Valor Matéria Prima (moeda alternativa 1)               |    14   |   123  |   136   | Decimal  |     2    |     Sim     |
          14,  # Valor Matéria Prima (moeda alternativa 2)               |    14   |   137  |   150   | Decimal  |     2    |     Sim     |
          14,  # Valor Mão de Obra (moeda corrente)                      |    14   |   151  |   164   | Decimal  |     2    |     Sim     |
          14,  # Valor Mão de Obra (moeda alternativa 1)                 |    14   |   165  |   178   | Decimal  |     2    |     Sim     |
          14,  # Valor Mão de Obra (moeda alternativa 2)                 |    14   |   179  |   192   | Decimal  |     2    |     Sim     |
          14,  # Gastos Gerais de Fabricação (moeda corrente)            |    14   |   193  |   206   | Decimal  |     2    |     Sim     |
          14,  # Gastos Gerais de Fabricação (moeda alternativa 1)       |    14   |   207  |   220   | Decimal  |     2    |     Sim     |
          14,  # Gastos Gerais de Fabricação (moeda alternativa 2)       |    14   |   221  |   234   | Decimal  |     2    |     Sim     |
           8,  # Código de Referência                                    |     8   |   235  |   242   | Caracter |          |     Não     |
          11,  # Fator de Concentração / PPM                             |    11   |   243  |   253   | Decimal  |     4    |     Não     |
           5,  # Código do Estabelecimento                               |     5   |   254  |   258   | Caracter |          |     Sim     |
          40,  # Lote/Nr de Série até 40 caracteres                      |    40   |   259  |   298   | Caracter |          |     Sim     |
          20   # Localização  até 20 caracteres                          |    20   |   299  |   318   | Caracter |          |     Sim     |
          )


        gdata::write.fwf(
          x = to_exp,
          file = out_file,
          width = ce0000_fix_width,
          colnames = FALSE,
          rownames = FALSE,
          sep = ""
        )

      }
