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
goto_en0114 <- function(df, out_file = "default.lst") {

  to_exp <-
    df |>
    mutate(
      trx = 1,
      item = part_number,
      roteiro = "",
      cod_operacao = 10,
      cod_op_padrao = 10,
      descricao_op = "op",
      8, #   revisao
      1, # * tipo_operacao 1 iNTERNA, 2 EXTERNA
      8, # * dt_inicio DDMMAAAA
      8, # * dt_termino DDMMAAAA
      5, # * fator_refugo DECIMAL, 2
      6, # * proporcao, DECIMAL, 2
      9, # * grupo_maquina,
      5, #   ficha_de_metodo
      3, #   ponto_de_controle
      5, #   codigo_mo_direta
      1, # * emite_ficha (S/N)
      1, # * ctrl_qual (S/N)
      8, #   tempo_preparacao,
      8, #   tempo_homem
      8, #   tempo_maquina
      1, # * unid_medida_tempo  1 = Horas  2 = Minutos   3 = Segundos  4 = Dias
      5, # * num_unidades
      3, #   num_homens
      2, # * num_operacoes_simultaneas INTEIRO
      8, #   dt_base
      16, #   preco_base
      8, #   dt_ultima_entrada
      16, #   preco_ultima_entrada  DECIMAL, 4
      8, #   dt_ultima_reposicao
      16, #   preco_reposicao,
      30, #   cod_video_operacao
      100, #  narrativa_1
      100, #  narrativa_2
      100, #  narrativa_3
      100, #  narrativa_4
      100, #  narrativa_5
      100, #  narrativa_6
      100, #  narrativa_7
      100, #  narrativa_8
      100, #  narrativa_9
      100, #  narrativa_10
      1,  #  tempo_significativo
    )

    ) |>
    select(
    )

  to_exp <- as.data.frame(to_exp)

  # * = obrigatório
  cd0209_fix_width <- c(
     1, # * trx: 1: create, 2: update, 3: delete
    16, # * item
    16, #   roteiro
     5, # * cod_operacao (INTEIRO)
     6, #   cod_op_padrao (INTEIRO)
    34, # * descricao_op
     8, #   revisao
     1, # * tipo_operacao 1 iNTERNA, 2 EXTERNA
     8, # * dt_inicio DDMMAAAA
     8, # * dt_termino DDMMAAAA
     5, # * fator_refugo DECIMAL, 2
     6, # * proporcao, DECIMAL, 2
     9, # * grupo_maquina,
     5, #   ficha_de_metodo
     3, #   ponto_de_controle
     5, #   codigo_mo_direta
     1, # * emite_ficha (S/N)
     1, # * ctrl_qual (S/N)
     8, #   tempo_preparacao,
     8, #   tempo_homem
     8, #   tempo_maquina
     1, # * unid_medida_tempo  1 = Horas  2 = Minutos   3 = Segundos  4 = Dias
     5, # * num_unidades
     3, #   num_homens
     2, # * num_operacoes_simultaneas INTEIRO
     8, #   dt_base
    16, #   preco_base
     8, #   dt_ultima_entrada
    16, #   preco_ultima_entrada  DECIMAL, 4
     8, #   dt_ultima_reposicao
    16, #   preco_reposicao,
    30, #   cod_video_operacao
    100, #  narrativa_1
    100, #  narrativa_2
    100, #  narrativa_3
    100, #  narrativa_4
    100, #  narrativa_5
    100, #  narrativa_6
    100, #  narrativa_7
    100, #  narrativa_8
    100, #  narrativa_9
    100, #  narrativa_10
     1,  #  tempo_significativo
  )

  #   |----------------------------------------------------------------------------------------------------------------------------------|
  #   | Ordem |                         Descrição                       | Tamanho | Início | Término | Conteúdo | Decimais | Obrigatório |
  #   |-------+---------------------------------------------------------+---------+--------+---------+----------+----------+-------------|
  #   |    1  | Tipo de Transação                                       |     1   |     1  |     1   | Inteiro  |          |     Sim     |
  #   |       | Onde    1 = Inclusão                                    |         |        |         |          |          |             |
  #   |       |         2 = Modifição                                   |         |        |         |          |          |             |
  #   |       |         3 = Eliminação                                  |         |        |         |          |          |             |
  #   |    2  | Código do Item                                          |    16   |     2  |    17   | Caracter |          |     Sim     |
  #   |    3  | Código do Roteiro                                       |    16   |    18  |    33   | Caracter |          |     Não     |
  #   |    4  | Código da Operação                                      |     5   |    34  |    38   | Inteiro  |          |     Sim     |
  #   |    5  | Código da Operação Padrão                               |     6   |    39  |    44   | Inteiro  |          |     Não     |
  #   |    6  | Descrição da Operação                                   |    34   |    45  |    78   | Caracter |          |     Sim     |
  #   |    7  | Revisão                                                 |     8   |    79  |    86   | Caracter |          |     Não     |
  #   |    8  | Tipo Operação                                           |     1   |    87  |    87   | Inteiro  |          |     Sim     |
  #   |       | Onde    1 = Interna                                     |         |        |         |          |          |             |
  #   |       |         2 = Externa                                     |         |        |         |          |          |             |
  #   |    9  | Data de Início                                          |     8   |    88  |    95   | Data     |          |     Sim     |
  #   |       | Formato ddmmaaaa                                        |         |        |         |          |          |             |
  #   |       | Onde    dd   = Dia                                      |         |        |         |          |          |             |
  #   |       |         mm   = Mês                                      |         |        |         |          |          |             |
  #   |       |         aaaa = Ano                                      |         |        |         |          |          |             |
  #   |   10  | Data de Término                                         |     8   |    96  |   103   | Data     |          |     Sim     |
  #   |       | Formato ddmmaaaa                                        |         |        |         |          |          |             |
  #   |       | Onde    dd   = Dia                                      |         |        |         |          |          |             |
  #   |       |         mm   = Mês                                      |         |        |         |          |          |             |
  #   |       |         aaaa = Ano                                      |         |        |         |          |          |             |
  #   |   11  | Fator de Refugo                                         |     5   |   104  |   108   | Decimal  |     2    |     Sim     |
  #   |   12  | Proporção                                               |     6   |   109  |   114   | Decimal  |     2    |     Sim     |
  #   |   13  | Grupo de Máquina                                        |     9   |   115  |   123   | Caracter |          |     Sim     |
  #   |   14  | Ficha de Método                                         |     5   |   124  |   128   | Inteiro  |          |     Não     |
  #   |   15  | Ponto de Controle                                       |     3   |   129  |   131   | Inteiro  |          |     Não     |
  #   |   16  | Código de Mão-de-Obra Direta                            |     5   |   132  |   136   | Caracter |          |     Não     |
  #   |   17  | Emite Ficha  (S/N)                                      |     1   |   137  |   137   | Lógico   |          |     Sim     |
  #   |   18  | Controle de Qualidade (S/N)                             |     1   |   138  |   138   | Lógico   |          |     Sim     |
  #   |   19  | Tempo de Preparação                                     |     8   |   139  |   146   | Decimal  |     3    |     Não     |
  #   |   20  | Tempo Homem                                             |     8   |   147  |   154   | Decimal  |     3    |     Não     |
  #   |   21  | Tempo Máquina                                           |     8   |   155  |   162   | Decimal  |     3    |     Não     |
  #   |   22  | Unidade de Medida do Tempo                              |     1   |   163  |   163   | Inteiro  |          |     Sim     |
  #   |       | Onde: 1 = Horas                                         |         |        |         |          |          |             |
  #   |       |       2 = Minutos                                       |         |        |         |          |          |             |
  #   |       |       3 = Segundos                                      |         |        |         |          |          |             |
  #   |       |       4 = Dias                                          |         |        |         |          |          |             |
  #   |   23  | Número de Unidades                                      |     5   |   164  |   168   | Inteiro  |          |     Sim     |
  #   |   24  | Número de Homens                                        |     3   |   169  |   171   | Inteiro  |          |     Não     |
  #   |   25  | Número de Operações Simultâneas                         |     2   |   172  |   173   | Inteiro  |          |     Sim     |
  #   |   26  | Data Base                                               |     8   |   174  |   181   | Data     |          |     Não     |
  #   |       | Formato ddmmaaaa                                        |         |        |         |          |          |             |
  #   |       | Onde    dd   = Dia                                      |         |        |         |          |          |             |
  #   |       |         mm   = Mês                                      |         |        |         |          |          |             |
  #   |       |         aaaa = Ano                                      |         |        |         |          |          |             |
  #   |   27  | Preço Base                                              |    16   |   182  |   197   | Decimal  |     4    |     Não     |
  #   |   28  | Data Última Entrada                                     |     8   |   198  |   205   | Data     |          |     Não     |
  #   |       | Formato ddmmaaaa                                        |         |        |         |          |          |             |
  #   |       | Onde    dd   = Dia                                      |         |        |         |          |          |             |
  #   |       |         mm   = Mês                                      |         |        |         |          |          |             |
  #   |       |         aaaa = Ano                                      |         |        |         |          |          |             |
  #   |   29  | Preço Última Entrada                                    |    16   |   206  |   221   | Decimal  |     4    |     Não     |
  #   |   30  | Data Última Reposição                                   |     8   |   222  |   229   | Data     |          |     Não     |
  #   |       | Formato ddmmaaaa                                        |         |        |         |          |          |             |
  #   |       | Onde    dd   = Dia                                      |         |        |         |          |          |             |
  #   |       |         mm   = Mês                                      |         |        |         |          |          |             |
  #   |       |         aaaa = Ano                                      |         |        |         |          |          |             |
  #   |   31  | Preço Reposição                                         |    16   |   230  |   245   | Decimal  |     4    |     Não     |
  #   |   32  | Código do Vídeo da Operação                             |    30   |   246  |   275   | Caracter |          |     Não     |
  #   |   33  | Narrativa da Operação[1]                                |   100   |   276  |   375   | Caracter |          |     Não     |
  #   |   34  | Narrativa da Operação[2]                                |   100   |   376  |   475   | Caracter |          |     Não     |
  #   |   35  | Narrativa da Operação[3]                                |   100   |   476  |   575   | Caracter |          |     Não     |
  #   |   36  | Narrativa da Operação[4]                                |   100   |   576  |   675   | Caracter |          |     Não     |
  #   |   37  | Narrativa da Operação[5]                                |   100   |   676  |   775   | Caracter |          |     Não     |
  #   |   38  | Narrativa da Operação[6]                                |   100   |   776  |   875   | Caracter |          |     Não     |
  #   |   39  | Narrativa da Operação[7]                                |   100   |   876  |   975   | Caracter |          |     Não     |
  #   |   40  | Narrativa da Operação[8]                                |   100   |   976  |  1075   | Caracter |          |     Não     |
  #   |   41  | Narrativa da Operação[9]                                |   100   |  1076  |  1175   | Caracter |          |     Não     |
  #   |   42  | Narrativa da Operação[10]                               |   100   |  1176  |  1275   | Caracter |          |     Não     |
  #   |   43  | Tempo Significativo                                     |     1   |  1276  |  1276   | Lógico   |          |     Não     |
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

