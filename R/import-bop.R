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
    mutate(machine_size = str_sub(machine, start = 4L, end = -1)) |>
    mutate(temp_dig = str_sub(machine, start = -1, end = -1)) |>
    mutate(machine_size = ifelse(temp_dig == 0, machine_size, str_sub(machine_size, start = 1, end = -2))) |>
    mutate(machine_size = as.integer(machine_size, na.rm = TRUE)) |>
    mutate(trx = 1) |>
    mutate(roteiro = "") |>
    mutate(cod_operacao = 10) |>
    mutate(grupo_maquina = case_when(
        str_detect(description, "MONTAGEM")  & str_detect(firm, "7") ~ "MONT SPI",
        str_detect(description, "MONTAGEM")  & str_detect(firm, "8") ~ "MONT SPB",
        str_detect(description, "TERMO")     & str_detect(firm, "7") ~ "TERMO SPI",
        str_detect(description, "TERMO")     & str_detect(firm, "8") ~ "TERMO SPB",
        str_detect(description, "EMBALAGEM") & str_detect(firm, "7") ~ "REEMB SPI",
        str_detect(description, "EMBALAGEM") & str_detect(firm, "8") ~ "REEMB SPB",
        str_detect(description, "PINTURA")   & str_detect(firm, "8") ~ "PINT SPB",
        str_detect(description, "INJECAO")   & machine_size < 451 & str_detect(firm, "7") ~ "I PEQ SPI",
        str_detect(description, "INJECAO")   & machine_size < 451 & str_detect(firm, "8") ~ "I PEQ SPB",
        str_detect(description, "INJECAO")   & machine_size < 801 & str_detect(firm, "7") ~ "I MED SPI",
        str_detect(description, "INJECAO")   & machine_size < 801 & str_detect(firm, "8") ~ "I MED SPB",
        str_detect(description, "INJECAO")   & str_detect(firm, "7") ~ "I GRD SPI",
        str_detect(description, "INJECAO")   & str_detect(firm, "8") ~ "I GRD SPB",
        TRUE ~ "PENDENTE"))

  to_exp <-
    to_exp |>
  mutate(cod_op_padrao = case_when(
        str_detect(description, "MONTAGEM")  & str_detect(firm, "7") ~ 204,
        str_detect(description, "MONTAGEM")  & str_detect(firm, "8") ~ 304,
        str_detect(description, "TERMO")     & str_detect(firm, "7") ~ 205,
        str_detect(description, "TERMO")     & str_detect(firm, "8") ~ 305,
        str_detect(description, "EMBALAGEM") & str_detect(firm, "7") ~ 206,
        str_detect(description, "EMBALAGEM") & str_detect(firm, "8") ~ 306,
        str_detect(description, "PINTURA")   & str_detect(firm, "8") ~ 307,
        str_detect(description, "INJECAO")   & machine_size < 451 & str_detect(firm, "7") ~ 203,
        str_detect(description, "INJECAO")   & machine_size < 451 & str_detect(firm, "8") ~ 303,
        str_detect(description, "INJECAO")   & machine_size < 801 & str_detect(firm, "7") ~ 202,
        str_detect(description, "INJECAO")   & machine_size < 801 & str_detect(firm, "8") ~ 302,
        str_detect(description, "INJECAO")   & str_detect(firm, "7") ~ 201,
        str_detect(description, "INJECAO")   & str_detect(firm, "8") ~ 301,
        str_detect(firm, "7") ~ 102,
        str_detect(firm, "8") ~ 103,
        TRUE ~ 999))

  to_exp <-
    to_exp |>
    mutate(cicle_type = ifelse(cicle_type == 0, 1, cicle_type)) |>
    mutate(tempo_maquina = 60 / as.numeric(cicle_type)) |>
    mutate(descricao_op = ifelse(!is.na(description_2),
                            sprintf("%s %s", description_1, description_2),
                            description_1),
           descricao_op = ifelse(str_length(descricao_op) > 34,
                            str_sub(descricao_op, start = 1, end = 34),
                            descricao_op)) |>
    mutate(descricao_op = str_to_upper(description)) |>
    mutate(descricao_op = str_replace_all(description, "[[:punct:]]", "")) |>
    mutate(descricao_op = iconv(description, to="ASCII//TRANSLIT"))

  to_exp <-
    to_exp |>
    mutate(revisao = "",
      tipo_operacao =  1,  # 1 iNTERNA, 2 EXTERNA
      dt_inicio = "01012025",
      dt_termino = "31129999",
      fator_refugo = 0,
      proporcao = str_remove_all(sprintf("%5s", sprintf("%.2f", 100)), "[[:punct:]]"), # 4, #   fator de perda (decimal, 2)100, DECIMAL, 2
      ficha_de_metodo = case_when(
        str_detect(description, "MONTAGEM") ~ 104,
        str_detect(description, "TERMO")    ~ 105,
        str_detect(description, "EMBALAGEM") ~ 106,
        str_detect(description, "PINTURA")   ~ 107,
        str_detect(description, "INJECAO")   ~ 100,
        TRUE ~ 100
      )) |>
    mutate(
      ponto_de_controle = "",
      codigo_mo_direta = "",
      emite_ficha = "N",
      ctrl_qual = "N",
      tempo_preparacao = str_remove_all(sprintf("%9s", sprintf("%.3f", as.integer(set_up_time))), "[[:punct:]]"),
      tempo_homem = "",
      tempo_maquina = str_remove_all(sprintf("%9s", sprintf("%.3f", tempo_maquina)), "[[:punct:]]"),
      unid_medida_tempo = 2, #   1 = Horas  2 = Minutos   3 = Segundos  4 = Dias
      num_unidades = 1,
      num_homens = "",
      num_operacoes_simultaneas = 1) |>
    mutate(
      dt_base = "",
      preco_base = "",
      dt_ultima_entrada = "",
      preco_ultima_entrada = "",
      dt_ultima_reposicao = "",
      preco_reposicao = "",
      cod_video_operacao = "",
      narrativa_1 = "",
      narrativa_2 = "",
      narrativa_3 = "",
      narrativa_4 = "",
      narrativa_5 = "",
      narrativa_6 = "",
      narrativa_7 = "",
      narrativa_8 = "",
      narrativa_9 = "",
      narrativa_10 = "",
      tempo_significativo = "")

  to_exp <-
    to_exp |>
    filter(!is.na(description_1))

  to_exp <-
    to_exp |>
  select(
      trx,
      item,
      roteiro,
      cod_operacao,
      cod_op_padrao,
      descricao_op,
      revisao,
      tipo_operacao,
      dt_inicio,
      dt_termino,
      fator_refugo,
      proporcao,
      grupo_maquina,
      ficha_de_metodo,
      ponto_de_controle,
      codigo_mo_direta,
      emite_ficha,
      ctrl_qual,
      tempo_preparacao,
      tempo_homem,
      tempo_maquina,
      unid_medida_tempo,
      num_unidades,
      num_homens,
      num_operacoes_simultaneas,
      dt_base,
      preco_base,
      dt_ultima_entrada,
      preco_ultima_entrada,
      dt_ultima_reposicao,
      preco_reposicao,
      cod_video_operacao,
      narrativa_1,
      narrativa_2,
      narrativa_3,
      narrativa_4,
      narrativa_5,
      narrativa_6,
      narrativa_7,
      narrativa_8,
      narrativa_9,
      narrativa_10,
      tempo_significativo
    )

  to_exp <- as.data.frame(to_exp)

  # * = obrigatório
  en0114_fix_width <- c(
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
     1  #  tempo_significativo
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
    width = en0114_fix_width,
    colnames = FALSE,
    rownames = FALSE,
    sep = ""
  )

}
