# IMPORT ESTRUTURA EN0113

# Campos do XPERT:
# bom item número == posição na bom
# base quantide: * = fixo,  1 = 1, 2 = 10, 3 = 100, 4 = 1000, 5 = 10000, 6 = 100000, 7 = 1000000
# tetart: 2 - contabiliza, 4 - despesa direta


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

goto_en0113 <- function(df, out_file = "default.lst") {

  to_exp <-
    df |>
    mutate(
      tipo_trx = 1,
      id_pai = material_number,
      sequencia = as.integer(bom_item_number),
      id_filho = bom_component,
      revisão = "",
      fantasma = "N",
      fator_perda = str_remove_all(sprintf("%5s", sprintf("%.2f", 0)), "[[:punct:]]"), # 4, #   fator de perda (decimal, 2)
      temein = case_when(
        base_quantidade == "*" ~ 1,
        base_quantidade == "1" ~ 1,
        base_quantidade == "2" ~ 10,
        base_quantidade == "3" ~ 100,
        base_quantidade == "4" ~ 1000,
        base_quantidade == "5" ~ 10000,
        base_quantidade == "6" ~ 100000,
        base_quantidade == "7" ~ 1000000,
        base_quantidade == "8" ~ 10000000,
        TRUE ~ NA
      ),
      proporcao = str_remove_all(sprintf("%6s", sprintf("%.2f", 100)), "[[:punct:]]"),         #      5, # * proporcao (decimal, 2) 10000
      serie_inicial = "",
      serie_final = "",
      qtde = str_remove_all(sprintf("%17s", sprintf("%.10f", (as.numeric(qtd_carga) / temein))), "[[:punct:]]"),   # 16, # * qtde       (decimal, 10)
      qtde = ifelse(str_length(qtde) > 16, str_sub(qtde, 1, 16), qtde),
      tempo_de_reserva = "?",
      dt_inicio = "01012025",
      dt_termino = "31129999",
      codigo_roteiro_fabricacao = "",
      codigo_operacao = "",
      local_montagem = "",
      observacao = "",
      referencia_pai = "",
      referencia_filho = "",
      tipo_sobra = 4,
      qtde_item_pai = str_remove_all(sprintf("%13s", sprintf("%.4f", 1)), "[[:punct:]]"),
      veiculo = "",
      percentual_distribuicao_veiculo = str_remove_all(sprintf("%8s", sprintf("%.4f", 0)),"[[:punct:]]"),
      utiliza_qtde_fixa = "N"
    ) |>
    select(
      tipo_trx,
      id_pai,
      sequencia,
      id_filho,
      revisão,
      fantasma,
      fator_perda,
      proporcao,
      serie_inicial,
      serie_final,
      qtde,
      tempo_de_reserva,
      dt_inicio,
      dt_termino,
      codigo_roteiro_fabricacao,
      codigo_operacao,
      local_montagem,
      observacao,
      referencia_pai,
      referencia_filho,
      tipo_sobra,
      qtde_item_pai,
      veiculo,
      percentual_distribuicao_veiculo,
      utiliza_qtde_fixa
    )

  to_exp <- as.data.frame(to_exp)

  # * = obrigatório
  en0113_fix_width <- c(
     1,  # * trx: 1: estrutura, 2: alternativo
    16, # * id pai    (char)
     5, # * sequencia (integer)
    16, # * id filho  (char)
     8, #   revisao   (char)
     1, # * fantasma S/N
     4, #   fator de perda (decimal, 2)
     5, # * proporcao (decimal, 2) 10000
    12, #   serie inicial
    12, #   serie final
    16, # * qtde       (decimal, 10)
     4, #    tempo de reserva (? inteiro)
     8, # * data inicio  (DDMMAAAA)
     8, # * data término
    16, #   codigo roteiro fabricacao
     5, #   codigo operacao
    55, #   local montagem
    40, # observaco
     8, # referencia pai
     8, # referencia filho
     2, # tipo sobra
    12, # qtde item pai
     1, # veículo,
     7, # percentual distribuicao veículo
     1 # utiliza qtde fixa
  )
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
  #   |       | Onde: 1 - Estrutura 2 - Alternativo                                      |         |        |         |          |          |             |
  #   |-------+---------------------------------------------------------+---------+--------+---------+----------+----------+-------------|
  #   |       | Layout para tipo de transação = 1 (Estrutura)           |         |        |         |          |          |             |
  #   |       |                                                         |         |        |         |          |          |             |
  #   |    2  | Código do Item Pai                                      |    16   |     2  |    17   | Caracter |          |     Sim     |
  #   |    3  | Sequência                                               |     5   |    18  |    22   | Inteiro  |          |     Sim     |
  #   |    4  | Código do Componente                                    |    16   |    23  |    38   | Caracter |          |     Sim     |
  #   |    5  | Revisão                                                 |     8   |    39  |    46   | Caracter |          |     Não     |
  #   |    6  | Fantasma (S/N)                                          |     1   |    47  |    47   | Caracter |          |     Sim     |
  #   |    7  | Fator Perda                                             |     4   |    48  |    51   | Decimal  |     2    |     Não     |
  #   |    8  | Proporção                                               |     5   |    52  |    56   | Decimal  |     2    |     Sim     |
  #   |    9  | Série Inicial                                           |    12   |    57  |    68   | Caracter |          |     Não     |
  #   |   10  | Série Final                                             |    12   |    69  |    80   | Caracter |          |     Não     |
  #   |   11  | Quantidade Usada                                        |    16   |    81  |    96   | Decimal  |    10    |     Sim     |
  #   |   12  | Tempo de Reserva (? ou um valor maior que zero)         |     4   |    97  |   100   | Inteiro  |          |     Não     |
  #   |   13  | Data Início                                             |     8   |   101  |   108   | Data     |          |     Sim     |
  #   |   14  | Data Término                                            |     8   |   109  |   116   | Data     |          |     Sim     |
  #   |   15  | Código Roteiro de Fabricação                            |    16   |   117  |   132   | Caracter |          |     Não     |
  #   |   16  | Código Operação                                         |     5   |   133  |   137   | Inteiro  |          |     Não     |
  #   |   17  | Local Montagem                                          |    55   |   138  |   192   | Caracter |          |     Não     |
  #   |   18  | Observação                                              |    40   |   193  |   232   | Caracter |          |     Não     |
  #   |   19  | Referência Pai                                          |     8   |   233  |   240   | Caracter |          |     Não     |
  #   |   20  | Referência Filho                                        |     8   |   241  |   248   | Caracter |          |     Não     |
  #   |   21  | Tipo Sobra                                              |     2   |   249  |   250   | Inteiro  |          |     Sim     |
  #   |       | 1 - Retorno de Requisição \                             |         |        |         |          |          |             |
  #   |       | 2 - Sobra                  > Quantidade Negativa        |         |        |         |          |          |             |
  #   |       | 3 - Coproduto             /                             |         |        |         |          |          |             |
  #   |       | 4 - Normal -> Quantidade Positiva                       |         |        |         |          |          |             |
  #   |   22  | Quantidade do Item Pai                                  |    12   |   251  |   262   | Decimal  |     4    |     Sim     |
  #   |   23  | Veículo (S/N)                                           |     1   |   263  |   263   | Caracter |          |     Não     |
  #   |   24  | Percentual Distribuição Veículo                         |     7   |   264  |   270   | Decimal  |     4    |     Não     |
  #   |   25  | Utiliza Quantidade Fixa?                                |     1   |   271  |   271   | Caracter |          |     Não     |
  #   |-------+---------------------------------------------------------+---------+--------+---------+----------+----------+-------------|

  gdata::write.fwf(
    x = to_exp,
    file = out_file,
    width = en0113_fix_width,
    colnames = FALSE,
    rownames = FALSE,
    sep = ""
  )

}

