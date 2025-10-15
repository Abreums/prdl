# CD1302 Importação Cliente Fornecedor


# | Ordem |                         Descrição                       | Tamanho | Início | Término | Conteúdo | Decimais | Obrigatório |
#   |-------+---------------------------------------------------------+---------+--------+---------+----------+----------+-------------|
#   |    1  | Brancos                                                 |     6   |     1  |     6   | Caracter |          |     Não     |
#   |    2  | Nome abreviado do Cliente/Fornecedor                    |    12   |     7  |    18   | Caracter |          |     Sim     |
#   |    3  | C.G.C.M.F./C.I.C.                                       |    19   |    19  |    37   | Caracter |          |     Sim     |
#   |    4  | Identificação                                           |     1   |    38  |    38   | Inteiro  |          |     Sim     |
#   |       |      1 - Cliente                                        |         |        |         |          |          |             |
#   |       |      2 - Fornecedor                                     |         |        |         |          |          |             |
#   |       |      3 - Ambos                                          |         |        |         |          |          |             |
#   |    5  | Natureza                                                |     1   |    39  |    39   | Inteiro  |          |     Sim     |
#   |       |      1 - Pessoa Física                                  |         |        |         |          |          |             |
#   |       |      2 - Pessoa Jurídica                                |         |        |         |          |          |             |
#   |       |      3 - Estrangeiro                                    |         |        |         |          |          |             |
#   |       |      4 - Trading                                        |         |        |         |          |          |             |
#   |    6  | Brancos                                                 |    40   |    40  |    79   | Caracter |          |     Não     |
#   |    7  | Endereço                                                |    40   |    80  |   119   | Caracter |          |     Sim     |
#   |    8  | Bairro                                                  |    30   |   120  |   149   | Caracter |          |     Não     |
#   |    9  | Brancos                                                 |    25   |   150  |   174   | Caracter |          |     Sim     |
#   |   10  | Estado                                                  |     4   |   175  |   178   | Caracter |          |     Sim     |
#   |   11  | Código Endereþamento Postal (C.E.P.)                    |    12   |   179  |   190   | Caracter |          |     Sim     |
#   |   12  | Caixa Postal                                            |    10   |   191  |   200   | Caracter |          |     Não     |
#   |   13  | País                                                    |    20   |   201  |   220   | Caracter |          |     Não     |
#   |   14  | Inscrição Estadual                                      |    19   |   221  |   239   | Caracter |          |     Não     |
#   |   15  | Brancos                                                 |     2   |   240  |   241   | Caracter |          |     Não     |
#   |   16  | Taxa Financeira                                         |     5   |   242  |   246   | Decimal  |     2    |     Não     |
#   |   17  | Data Taxa Financeira                                    |     8   |   247  |   254   | DDMMAAAA |          |     Não     |
#   |   18  | Código Transportador Padrão                             |     5   |   255  |   259   | Inteiro  |          |     Não     |
#   |   19  | Código do Grupo do Fornecedor                           |     2   |   260  |   261   | Inteiro  |          |     Sim     |
#   |   20  | Linha de Produtos                                       |     8   |   262  |   269   | Caracter |          |     Não     |
#   |   21  | Ramo de Atividade                                       |    12   |   270  |   281   | Caracter |          |     Não     |
#   |   22  | Telefax                                                 |    15   |   282  |   296   | Caracter |          |     Não     |
#   |   23  | Ramal do Telefax                                        |     5   |   297  |   301   | Caracter |          |     Não     |
#   |   24  | Telex                                                   |    15   |   302  |   316   | Caracter |          |     Não     |
#   |   25  | Data Implantação                                        |     8   |   317  |   324   | DDMMAAAA |          |     Não     |
#   |   26  | Compras no Período                                      |    14   |   325  |   338   | Decimal  |     2    |     Não     |
#   |   27  | Contribuinte ICMS                                       |     1   |   339  |   339   | Inteiro  |          |     Não     |
#   |       |      1 - Sim                                            |         |        |         |          |          |             |
#   |       |      2 - Não                                            |         |        |         |          |          |             |
#   |   28  | Brancos                                                 |     2   |   340  |   341   | Caracter |          |     Não     |
#   |   29  | Categoria                                               |     3   |   342  |   344   | Caracter |          |     Não     |
#   |   30  | Código do Representante                                 |     5   |   345  |   349   | Inteiro  |          |     Não     |
#   |   31  | Brancos                                                 |     2   |   350  |   351   | Caracter |          |     Não     |
#   |   32  | Bonificação (Desconto Padrão cliente)                   |     5   |   352  |   356   | Decimal  |     2    |     Não     |
#   |   33  | Abrangência da Avaliação de Crédito                     |     1   |   357  |   357   | Inteiro  |          |     Sim     |
#   |       |      1 - Cliente                                        |         |        |         |          |          |             |
#   |       |      2 - Matriz                                         |         |        |         |          |          |             |
#   |   34  | Brancos                                                 |     2   |   358  |   359   | Inteiro  |          |     Sim     |
#   |   35  | Limite de Crédito                                       |    11   |   360  |   370   | Decimal  |     2    |     Não     |
#   +----------------------------------------------------------------------------------------------------------------------------------+                                                        |
  # |----------------------------------------------------------------------------------------------------------------------------------|
  # | Ordem |                         Descrição                       | Tamanho | Início | Término | Conteúdo | Decimais | Obrigatório |
  # |-------+---------------------------------------------------------+---------+--------+---------+----------+----------+-------------|
  # |   36  | Data Limite de Crédito                                  |     8   |   371  |   378   | DDMMAAAA |          |     Não     |
  # |   37  | Percentual Máximo Faturado por Período                  |     3   |   379  |   381   | Inteiro  |          |     Não     |
  # |   38  | Portador                                                |     5   |   382  |   386   | Inteiro  |          |     Não     |
  # |   39  | Modalidade                                              |     2   |   387  |   388   | Inteiro  |          |     Não     |
  # |       |      1 - Cb simples                                     |         |        |         |          |          |             |
  # |       |      2 - Descontos                                      |         |        |         |          |          |             |
  # |       |      3 - Caução                                         |         |        |         |          |          |             |
  # |       |      4 - Judicial                                       |         |        |         |          |          |             |
  # |       |      5 - Repres                                         |         |        |         |          |          |             |
  # |       |      6 - Carteira                                       |         |        |         |          |          |             |
  # |       |      7 - Vendor                                         |         |        |         |          |          |             |
  # |   40  | Aceita Faturamento Parcial                              |     1   |   389  |   389   | Inteiro  |          |     Não     |
  # |       |      1 - Sim                                            |         |        |         |          |          |             |
  # |       |      2 - Não                                            |         |        |         |          |          |             |
  # |   41  | Indicador de Crédito                                    |     1   |   390  |   390   | Inteiro  |          |     Não     |
  # |       |      1 - Normal                                         |         |        |         |          |          |             |
  # |       |      2 - Automático                                     |         |        |         |          |          |             |
  # |       |      3 - Caução                                         |         |        |         |          |          |             |
  # |       |      4 - Suspenso                                       |         |        |         |          |          |             |
  # |       |      5 - Pagamento à vista                              |         |        |         |          |          |             |
  # |   42  | Avaliação de Crédito Para Aprovação de Pedido           |     1   |   391  |   391   | Inteiro  |          |     Não     |
  # |       |      1 - Sim                                            |         |        |         |          |          |             |
  # |       |      2 - Não                                            |         |        |         |          |          |             |
  # |   43  | Natureza de Operação                                    |     6   |   392  |   397   | Caracter |          |     Não     |
  # |   44  | Desativado                                              |   150   |   398  |   547   | Caracter |          |     Não     |
  # |   45  | Percentual Minimo Por Faturamento Parcial               |     4   |   548  |   551   | Decimal  |     2    |     Não     |
  # |   46  | Meio Para Emissão de Pedido de Compra                   |     1   |   552  |   552   | Inteiro  |          |     Sim     |
  # |       |      1 - Formulário                                     |         |        |         |          |          |             |
  # |       |      2 - Magnético                                      |         |        |         |          |          |             |
  # |       |      3 - Faxm                                           |         |        |         |          |          |             |
  # |   47  | Nome Fantasia da Matriz do Cliente                      |    12   |   553  |   564   | Caracter |          |     Sim     |
  # |   48  | Telefone Modem                                          |    15   |   565  |   579   | Caracter |          |     Não     |
  # |   49  | Ramal do Modem                                          |     5   |   580  |   584   | Caracter |          |     Não     |
  # |   50  | Telefax                                                 |    15   |   585  |   599   | Caracter |          |     Não     |
  # |   51  | Ramal do Telefax                                        |     5   |   600  |   604   | Caracter |          |     Não     |
  # |   52  | Agência do Cliente/Fornecedor                           |     7   |   605  |   611   | Caracter |          |     Não*    |
  # |   53  | Brancos                                                 |     1   |   612  |   612   | Caracter |          |     Não     |
  # |   54  | Número de Títulos                                       |     8   |   613  |   620   | Inteiro  |          |     Não     |
  # |   55  | Número de Dias                                          |     8   |   621  |   628   | Inteiro  |          |     Não     |
  # |   56  | Percentual Máximo de cancelamento Quant. Aberto         |     4   |   629  |   632   | Decimal  |     2    |     Não     |
  # |   57  | Data da Última Nota Fiscal Emitida                      |     8   |   633  |   640   | DDMMAAAA |          |     Não     |
  # |   58  | Emite Bloquete Para Título                              |     1   |   641  |   641   | Inteiro  |          |     Sim     |
  # |       |      1 - Sim                                            |         |        |         |          |          |             |
  # |       |      2 - Não                                            |         |        |         |          |          |             |
  # |   59  | Emite Etiqueta Para Correspondência                     |     1   |   642  |   642   | Inteiro  |          |     Sim     |
  # |       |      1 - Sim                                            |         |        |         |          |          |             |
  # |       |      2 - Não                                            |         |        |         |          |          |             |
  # |   60  | Valores de Recebimento                                  |     1   |   643  |   643   | Inteiro  |          |     Sim     |
  # |       |      1 - Trunca                                         |         |        |         |          |          |             |
  # |       |      2 - Arredonda                                      |         |        |         |          |          |             |
  # |   10  | Gera Aviso de Débito                                    |     1   |   644  |   644   | Inteiro  |          |     Sim     |
  # |       |      1 - Sim                                            |         |        |         |          |          |             |
  # |       |      2 - Não                                            |         |        |         |          |          |             |
  # |   62  | Portador Preferencial                                   |     5   |   645  |   649   | Inteiro  |          |     Não     |
  # |   63  | Modalidade Preferencial                                 |     2   |   650  |   651   | Inteiro  |          |     Não     |
  # |       |      1 - Cb simples                                     |         |        |         |          |          |             |
  # |       |      2 - Descontos                                      |         |        |         |          |          |             |
  # |       |      3 - Caução                                         |         |        |         |          |          |             |
  # |       |      4 - Judicial                                       |         |        |         |          |          |             |
  # |       |      5 - Repres                                         |         |        |         |          |          |             |
  # |       |      6 - Carteira                                       |         |        |         |          |          |             |
  # |       |      7 - Vendor                                         |         |        |         |          |          |             |
  # |   64  | Baixa Não Acatada                                       |     3   |   652  |   654   | Inteiro  |          |     Não     |
  # |   65  | Conta Corrente do Cliente/Fornecedor                    |    10   |   655  |   664   | Inteiro  |          |     Não     |
  # |   66  | Dígito da Conta Corrente do Cliente/Fornecedor          |     2   |   665  |   666   | Caracter |          |     Não     |
  # |   67  | Condição de Pagamento                                   |     4   |   667  |   670   | Inteiro  |          |     Não     |
  # |   68  | Brancos                                                 |     4   |   671  |   674   | Caracter |          |     Não     |
  # |   69  | Número de Cópias do Pedido de Compra                    |     2   |   675  |   676   | Inteiro  |          |     Não     |
  # |   70  | Código Suframa                                          |    20   |   677  |   696   | Caracter |          |     Não     |
  # |   71  | Código Cacex                                            |    20   |   697  |   716   | Caracter |          |     Não     |
  # +----------------------------------------------------------------------------------------------------------------------------------+                                                     |
  # |----------------------------------------------------------------------------------------------------------------------------------|
  # | Ordem |                         Descrição                       | Tamanho | Início | Término | Conteúdo | Decimais | Obrigatório |
  # |-------+---------------------------------------------------------+---------+--------+---------+----------+----------+-------------|
  # |   72  | Gera Diferença de Preço                                 |     1   |   717  |   717   | Inteiro  |          |     Não     |
  # |   73  | Tabela de Preços                                        |     8   |   718  |   725   | Caracter |          |     Não     |
  # |   74  | Indicador de Avaliação                                  |     1   |   726  |   726   | Inteiro  |          |     Não     |
  # |       |      1 - Não Avalia                                     |         |        |         |          |          |             |
  # |       |      2 - Somente Atrasos Duplicatas                     |         |        |         |          |          |             |
  # |       |      3 - Limites e Atrasos Duplicatas                   |         |        |         |          |          |             |
  # |   75  | Usuário libera Crédito                                  |    12   |   727  |   738   | Caracter |          |     Não     |
  # |   76  | Vencimento Domingo                                      |     1   |   739  |   739   | Inteiro  |          |     Não     |
  # |       |      1 - Prorroga                                       |         |        |         |          |          |             |
  # |       |      2 - Antecipa                                       |         |        |         |          |          |             |
  # |       |      3 - Mantém                                         |         |        |         |          |          |             |
  # |   77  | Vencimento Sábado                                       |     1   |   740  |   740   | Inteiro  |          |     Não     |
  # |       |      1 - Prorroga                                       |         |        |         |          |          |             |
  # |       |      2 - Antecipa                                       |         |        |         |          |          |             |
  # |       |      3 - Mantém                                         |         |        |         |          |          |             |
  # |   78  | C.G.C. Cobrança                                         |    19   |   741  |   759   | Caracter |          |     Não     |
  # |   79  | C.E.P. Cobrança                                         |    12   |   760  |   771   | Caracter |          |     Não     |
  # |   80  | Estado Cobrança                                         |     4   |   772  |   775   | Caracter |          |     Não     |
  # |   81  | Brancos                                                 |    25   |   776  |   800   | Caracter |          |     Não     |
  # |   82  | Bairro Cobrança                                         |    30   |   801  |   830   | Caracter |          |     Não     |
  # |   83  | Endereço Cobrança                                       |    40   |   831  |   870   | Caracter |          |     Não     |
  # |   84  | Caixa Postal Cobrança                                   |    10   |   871  |   880   | Caracter |          |     Não     |
  # |   85  | Inscrição Estadual Cobrança                             |    19   |   881  |   899   | Caracter |          |     Não     |
  # |   86  | Banco do Cliente/Fornecedor                             |     3   |   900  |   902   | Inteiro  |          |     Não*    |
  # |   87  | Próximo Aviso Débito                                    |     6   |   903  |   908   | Inteiro  |          |     Não     |
  # |   88  | Tipo do Registro                                        |     1   |   909  |   909   | Inteiro  |          |     Sim     |
  # |       |      1 - Implantação                                    |         |        |         |          |          |             |
  # |       |      2 - Alteração                                      |         |        |         |          |          |             |
  # |   89  | Vencimento Feriado                                      |     1   |   910  |   910   | Inteiro  |          |     Não     |
  # |       |      1 - Prorroga                                       |         |        |         |          |          |             |
  # |       |      2 - Antecipa                                       |         |        |         |          |          |             |
  # |       |      3 - Mantém                                         |         |        |         |          |          |             |
  # |   90  | Tipo de Pagamento                                       |     2   |   911  |   912   | Inteiro  |          |     Não     |
  # |       |      1 - DOC                                            |         |        |         |          |          |             |
  # |       |      2 - Crédito conta corrente                         |         |        |         |          |          |             |
  # |       |      3 - Cheque administrativo                          |         |        |         |          |          |             |
  # |       |      4 - Cobrança                                       |         |        |         |          |          |             |
  # |       |      5 - Cheque Nominal                                 |         |        |         |          |          |             |
  # |       |    Outras opções a partir da Versão 2.02 do Banco       |         |        |         |          |          |             |
  # |       |      6 - Débito em Conta Corrente                       |         |        |         |          |          |             |
  # |       |      7 - Cartão de Crédito                              |         |        |         |          |          |             |
  # |       |      8 - Agendamento Eletrônico                         |         |        |         |          |          |             |
  # |   91  | Tipo de Cobrança das Despesas                           |     1   |   913  |   913   | Inteiro  |          |     Não     |
  # |       |      1 - Primeira Duplicata                             |         |        |         |          |          |             |
  # |       |      2 - Rateio entre todas as Duplicatas               |         |        |         |          |          |             |
  # |       |      3 - Rateio entre todas com IPI na Primeira         |         |        |         |          |          |             |
  # |       |      4 - Apenas IPI na Primeira e Rateio nas Restantes  |         |        |         |          |          |             |
  # |   92  | Inscrição Municipal                                     |    19   |   914  |   932   | Caracter |          |     Não     |
  # |   93  | Tipo de Despesa Padrão                                  |     3   |   933  |   935   | Inteiro  |          |     Não     |
  # |   94  | Tipo de Receita Padrão                                  |     3   |   936  |   938   | Inteiro  |          |     Não     |
  # |   95  | Código de Endereçamento Postal Estrangeiro              |    12   |   939  |   950   | Caracter |          |     Não     |
  # |   96  | Micro Região                                            |    12   |   951  |   962   | Caracter |          |     Não     |
  # |   97  | Brancos                                                 |     3   |   963  |   965   | Caracter |          |     Não     |
  # |   98  | Telefone[1]                                             |    15   |   966  |   980   | Caracter |          |     Não     |
  # |   99  | Telefone[2]                                             |    15   |   981  |   995   | Caracter |          |     Não     |
  # |  100  | Número de Meses Inativos                                |     2   |   996  |   997   | Inteiro  |          |     Sim     |
  # |  101  | Instrução Bancária(1)                                   |     3   |   998  |  1000   | Inteiro  |          |     Não     |
  # |  102  | Instrução Bancária(2)                                   |     3   |  1001  |  1003   | Inteiro  |          |     Não     |
  # |  103  | Natureza Interestadual                                  |     6   |  1004  |  1009   | Caracter |          |     Não     |
  # |  104  | Código do Cliente                                       |     9   |  1010  |  1018   | Inteiro  |          |     Sim     |
  # |  105  | Código do Cliente de Cobrança                           |     9   |  1019  |  1027   | Inteiro  |          |     Sim     |
  # |  106  | Utiliza Verba de Publicidade                            |     1   |  1028  |  1028   | Logico   |          |     Não     |
  # |  107  | Percentual de Verba de Publicidade                      |     6   |  1029  |  1034   | Decimal  |     2    |     Não     |
  # |  108  | E-mail                                                  |    40   |  1035  |  1074   | Caracter |          |     Não     |
  # |  109  | Indicador de Avaliação de Embarque                      |     1   |  1075  |  1075   | Inteiro  |          |     Não     |
  # |       |      1 - Não Avalia                                     |         |        |         |          |          |             |
  # |       |      2 - Somente Atrasos Duplicatas                     |         |        |         |          |          |             |
  # |       |      3 - Limites e Atrasos Duplicatas                   |         |        |         |          |          |             |
  # |  110  | Canal de Venda                                          |     3   |  1076  |  1078   | Inteiro  |          |     Não     |
  # |  111  | Endereço Cobrança Completo                              |  2000   |  1079  |  3078   | Caracter |          |     Não     |
  # |  112  | Endereço Completo                                       |  2000   |  3079  |  5078   | Caracter |          |     Não     |
  # |  113  | País de Cobrança                                        |    20   |  5079  |  5098   | Caracter |          |     Não     |
  # |  114  | Situação do Fornecedor                                  |     1   |  5099  |  5099   | Inteiro  |          |     Não     |
  # |       |      1 - Ativo                                          |         |        |         |          |          |             |
  # |       |      2 - Restrição Compras                              |         |        |         |          |          |             |
  # |       |      3 - Restrição Compras e Recebimento                |         |        |         |          |          |             |
  # |       |      4 - Inativo                                        |         |        |         |          |          |             |
  # |  115  | Data de Vigência Inicial                                |     8   |  5100  |  5107   | DDMMAAAA |          |     Não     |
  # |  116  | Data de Vigência Final                                  |     8   |  5108  |  5115   | DDMMAAAA |          |     Não     |
  # |  117  | Inscrição INSS                                          |    20   |  5116  |  5135   | Caracter |          |     Não     |
  # |  118  | Tributa COFINS                                          |     1   |  5136  |  5136   | Inteiro  |          |     Não     |
  # |       |      1 - Tributa Cofins                                 |         |        |         |          |          |             |
  # |       |      2 - Isento                                         |         |        |         |          |          |             |
  # |  119  | Tributa PIS                                             |     1   |  5137  |  5137   | Inteiro  |          |     Não     |
  # |       |      1 - Tributa PIS                                    |         |        |         |          |          |             |
  # |       |      2 - Isento                                         |         |        |         |          |          |             |
  # |  120  | Controla Valor Máximo INSS                              |     1   |  5138  |  5138   | Logico   |          |     Não     |
  # |       |      S - Sim                                            |         |        |         |          |          |             |
  # |       |      N - Não                                            |         |        |         |          |          |             |
  # |  121  | Calcula PIS/COFINS por Unidade                          |     1   |  5139  |  5139   | Logico   |          |     Não     |
  # |       |      S - Sim                                            |         |        |         |          |          |             |
  # |       |      N - Não                                            |         |        |         |          |          |             |
  # |  122  | Retem Pagto                                             |     1   |  5140  |  5140   | Logico   |          |     Não     |
  # |       |      S - Sim                                            |         |        |         |          |          |             |
  # |       |      N - Não                                            |         |        |         |          |          |             |
  # |  123  | Portador Fornecedor                                     |     5   |  5141  |  5145   | Inteiro  |          |     Não     |
  # |  124  | Modalidade Fornecedor                                   |     2   |  5146  |  5147   | Inteiro  |          |     Não     |
  # |       |      1 - Cb simples                                     |         |        |         |          |          |             |
  # |       |      2 - Descontos                                      |         |        |         |          |          |             |
  # |       |      3 - Caução                                         |         |        |         |          |          |             |
  # |       |      4 - Judicial                                       |         |        |         |          |          |             |
  # |       |      5 - Repres                                         |         |        |         |          |          |             |
  # |       |      6 - Carteira                                       |         |        |         |          |          |             |
  # |       |      7 - Vendor                                         |         |        |         |          |          |             |
  # |  125  | Contribuinte Substituto Intermediário                   |     1   |  5148  |  5148   | Caracter |          |     Não     |
  # |       |      S - Sim                                            |         |        |         |          |          |             |
  # |       |      N - Não                                            |         |        |         |          |          |             |
  # |  126  | Nome do Cliente/Fornecedor                              |    80   |  5149  |  5228   | Caracter |          |     Sim     |
  # |  127  | Cidade                                                  |    50   |  5329  |  5378   | Caracter |          |     Sim     |
  # |  128  | Cidade Cobrança                                         |    50   |  5379  |  5428   | Caracter |          |     Não     |
  # |  129  | Grupo do Cliente                                        |     4   |  5429  |  5432   | Inteiro  |          |     Sim     |
  # |  130  | Observação 1                                            |  2000   |  5433  |  7432   | Caracter |          |     Não     |
  # |  131  | Vencimento Igual a data do fluxo                        |     1   |  7433  |  7433   | inteiro  |          |     Não     |
  # |       |      1 - Sim                                            |         |        |         |          |          |             |
  # |       |      2 - Não                                            |         |        |         |          |          |             |
  # +----------------------------------------------------------------------------------------------------------------------------------+                                                 |
#   ************************************************************************************************************************
#   Para Implantação do arquivo de Clientes/Fornecedores implantar previamente os seguintes cadastros:
#   - Grupo de Clientes
# - Portador
# - Transportador
# - Grupo de Fornecedores
# - Representantes  (se importar clientes)
# - Países (se Modulo Exportação implantado)
# - Unidade de FederaþÒo
# - Impostos
# - Tipo de retensão de Ganancias
# - Tipo de retensão de IVA
# - Tipo de documento


# Obs.: Os campos DECIMAIS deverão ser informados sem a vírgula, respeitando-se o Número de Dígitos decimais.
# Os campos "Utiliza Verba de Publicidade" e "Percentual de Verba de Publicidade" somente poderão ser usados
# a partir da versão 2.03 e com a função "EMS_202_VERBA_PUBLICIDADE" cadastrada.
# Os campos "Agência do Cliente/Fornecedor" e Conta Corrente do Cliente/Fornecedor deverão ser informados
# sem os caracteres ".", "-" ou "/".
# Os campos C.G.C. C.E.P. e Inscrição Estadual não aceitam caracteres especiais, apenas números.
# Os campos Cidade Cobrança, Estado Cobrança e País Cobrança se tornam obrigatórios quando parametrizado para
# "Validar Cidade" nos Parâmetros Globais (CD0101).
# ************************************************************************************************************************

# file_to_cd0209 prepara um arquivo com componentes para serem importados em massa
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
mp_to_cd0209 <- function(df, out_file) {

  df <-
    fo |>
    filter(str_detect(fo_id, "90012674"))

  # Para importar matéria primas, vamos utilizar a listagem de
  # "Já Cadastrados" para avaliar se é uma nova inclusão ou uma atualização
  # ja_cadastrados <- read_excel(here("data", "fornecedores_ja_cadastrados.xlsx")) |>
  #   janitor::clean_names()

  # df <-
  #   df |>
  #   left_join(ja_cadastrados, join_by("???")) |>
  #   mutate(trx = ifelse(is.na(trx), 1, trx)) |>
  #     TRUE ~ "UN"
  #   )) |>
  #   mutate(desc = str_replace_all(desc, "[[:punct:]]", "")) |>
  #   mutate(desc = iconv(desc,to="ASCII//TRANSLIT")) |>
  #   mutate(grupo_estoque = str_sub(fam_mat, start = 1L, end = 2L))

  out_file = "teste.lst"
  to_exp <-
    df |>
    mutate(fo_country = "BRASIL") |>
    mutate(
        b1_6b = " ",
        nome_abreviado_fornecedor = fo_matchcode, # fo_matchcode,       # *
        fornecedor_cnpj = fo_cnpj, # fo_cnpj = "",            # *
        fornecedor_identificacao = 2,       # 1 cliente 2 fornecedor 3 ambos
        fornecedor_natureza = 2,         # 1 PF 2 PJ 3 Estrang *
        b2_40b = " ",          # brancos
        fornecedor_endereco = fo_end1,         # *
        fornecedor_bairro = fo_end2,           #
        b3_25b = " ",               # brancos *
        fornecedor_estado = fo_uf,   # fo_uf,              # *
        fornecedor_cep = fo_cep,      # fo_cep,             # *
        cx_postal = " ",           #
        pais = fo_country,                #
        inscricao_estadual = fo_ie,  #
        b4_2b = " ",               # brancos
        taxa_financeira = " ",     #
        dt_taxa_financeira = " ",  #
        cod_transportador_padrao = " ", #
        cod_grupo_fornecedor = 10,     #  (INTEIRO) *
        linha_produtos = " ",      #
        fornecedor_ramo_atividade = " ",  #
        fo_telefax = " ",         #
        fo_ramal_telefax = " ",   #
        fo_telex = " ",           #
        fo_dt_implantacao = "01012025", # (DDMMAAAA)
        fo_compras_no_periodo = " ", # (Decimal)
        fo_contribuinte_icms = 1,# 1 - Sim   2 - Não (inteiro)
        b5_2b = " ",              # Brancos
        fo_categoria = " ",       #
        representante = " ",      # (Inteiro)
        b6_2b = " ",           # Brancos
        bonificacao = " ",     # (Desconto Padrão cliente) (DECIMAL)
        abrangencia_da_avaliacao_de_credito = 1,          # 1 - Cliente  2 - Matriz (INTEIRO) *
        b7_2b = " ",           # Brancos
        limite_de_credito = " ",        # Limite de Crédito  (DECIMAL)
        data_limite_de_credito = " ",     # Data Limite de Crédito (DDMMAAAA)
        percentual_max_fat_periodo = " ", # Percentual Máximo Faturado por Período (Inteiro)
        portador = "",                   # Portador (Inteiro)
        modalidade = " ",                 # 1 - Cb simples 2 - Descontos 3 - Caução 4 - Judicial 5 - Repres 6 - Carteira 7 - Vendor
        aceita_fat_parcial = " ",         # Aceita Faturamento Parcial (Inteiro) 1 - Sim 2 - Não
        indicador_de_credito = 1,       # Indicador de Crédito (Inteiro) 1 - Normal  2 - Automático 3 - Caução 4 - Suspenso 5 - Pagamento à vista
        avaliacao_credito_aprovacao_pedido = " ", # Avaliação de Crédito Para Aprovação de Pedido (Inteiro) 1 - Sim 2 - Não
        fo_natureza_de_operacao = " ",    # Natureza de Operação (Caracter)
        desativado = " ",                 # Desativado (Caracter)
        perc_min_fat_parcial = " ",       # Percentual Minimo Por Faturamento Parcial
        meio_emissao_pedido_compra = 1, # Meio Para Emissão de Pedido de Compra (Inteiro) 1 - Formulário 2 - Magnético 3 - Faxm
        nome_fantasia_matriz = fo_matchcode, # Nome fantasia da Matriz
        telefone1 = " ",         # Telefone Modem
        ramal1 = " ",   # Ramal do Modem
        telefax2 = " ",       # Telefax
        ramal_telefax2 = " ", # Ramal do Telefax
        agencia = " ",       # Agência do Cliente/Fornecedor
        b8_1b = " ",          # Brancos
        num_titutlos = " ",        # Número de Títulos (Inteiro)
        num_dias = " ",       # Número de Dias (Inteiro)
        per_max_cancel_qnt_aberto = " ", # Percentual Máximo de cancelamento Quant. Aberto (Decimal)
        dt_ultima_nota_emitida = " ",    # Data da Última Nota Fiscal Emitida (DDMMAAAA)
        emite_bloquete = 1,     # Emite Bloquete Para Título (Inteiro) 1 - Sim  2 - Não
        emite_etiqueta = 1, # Emite Etiqueta Para Correspondência (Inteiro)  1 - Sim 2 - Não
        valores_rec = 1, # Valores de Recebimento (Inteiro) 1 - Trunca 2 - Arredonda
        gera_aviso_deb = 1, # Gera Aviso de Débito (Inteiro) 1 - Sim  2 - Não      *
        portador_pref = "", # Portador Preferencial (Inteiro)
        mod_pref = " ", # Modalidade Preferencial (Inteiro) 1 - Cb simples  2 - Descontos  3 - Caução  4 - Judicial  5 - Repres  6 - Carteira
        baix_nao_acatada = " ", # Baixa Não Acatada (Inteiro)
        fornecedor_conta_corrente = "", # Conta Corrente do Cliente/Fornecedor (Inteiro)
        fornecedor_dig_cc = "", # Dígito da Conta Corrente do Cliente/Fornecedor
        cond_pgto = " ", # Condição de Pagamento (Inteiro)
        b9_4b = " ", # Brancos
        num_copias_pedido_compra = " ", # Número de Cópias do Pedido de Compra (Inteiro)
        suframa = " ", # Código Suframa
        cacex = " ", # Código Cacex
        gera_dif_preco = " ", # Gera Diferença de Preço (Inteiro)
        tbl_preco = " ", # Tabela de Preços
        ind_avaliacao = " ", # Indicador de Avaliação (Inteiro) 1 - Não Avalia  2 - Somente Atrasos Duplicatas  3 - Limites e Atrasos Duplicatas
        usuario_libera_cred = " ", # Usuário libera Crédito
        venc_dom = " ", # Vencimento Domingo (Inteiro) 1 - Prorroga  2 - Antecipa 3 - Mantém
        venc_sab = " ", # Vencimento Sábado (Inteiro) 1 - Prorroga   2 - Antecipa 3 - Mantém
        cnpj_cobranca = fo_cnpj, # C.G.C. Cobrança (Caracter)
        cep_cobranca = fo_cep, # C.E.P. Cobrança
        uf_cobranca = fo_uf, # Estado Cobrança
        b10_4b = " ", # Brancos
        bairro_cobranca = fo_end2, # Bairro Cobrança
        end_cobranca = fo_end1, # Endereço Cobrança
        cx_postal_cobranca = " ", # Caixa Postal Cobrança
        ie_cobranca = fo_ie, # Inscrição Estadual Cobrança
        banco_fornecedor = " ", # Banco do Cliente/Fornecedor
        prox_aviso_debito = " ", # Próximo Aviso Débito (Inteiro)
        tipo_registro = 1, # Tipo do Registro (Inteiro) *  1 - Implantação 2 - Alteração
        venc_feriado = " ", # Vencimento Feriado (Inteiro)  1 - Prorroga 2 - Antecipa 3 - Mantém
        tipo_pgto = " ", # Tipo de Pagamento (Inteiro) 1 - DOC 2 - Crédito conta corrente 3 - Cheque administrativo 4 - Cobrança 5 - Cheque Nominal  6 - Débito em Conta Corrente 7 - Cartão de Crédito 8 - Agendamento Eletrônico
        tip_cobranca = " ", # Tipo de Cobrança das Despesas (Inteiro) 1 - Primeira Duplicata 2 - Rateio entre todas as Duplicatas 3 - Rateio entre todas com IPI na Primeira  4 - Apenas IPI na Primeira e Rateio nas Restantes
        inscric_municipal = " ", # Inscrição Municipal
        tipo_desp_padrao = " ", # Tipo de Despesa Padrão (Inteiro)
        tipo_receita_padrao = " ", # Tipo de Receita Padrão
        cod_enderecamento = " ", # Código de Endereçamento Postal Estrangeiro
        micro_regiao = " ", # Micro Região
        b11_3b = " ", # Brancos
        telefone3 = " ", # Telefone[1]
        telefone4 = "", # Telefone[2]
        num_meses_inativo = 4, # Número de Meses Inativos (Inteiro) *
        instrucao_bancaria = " ", # Instrução Bancária(1) (Inteiro)
        instrucao_bancaria2 = " ", # Instrução Bancária(2) (Inteiro)
        nat_interestadual = " ", # Natureza Interestadual
        cod_cliente = 444, # Código do Cliente (Inteiro) *
        cod_cliente_cobranca = 444, # Código do Cliente de Cobrança (Inteiro) *
        utiliza_verba_publicidade = " ", # Utiliza Verba de Publicidade (Logico)
        percentual_verba_publicidade = "", # Percentual de Verba de Publicidade (Decimal)
        email_cliente = " ", # E-mail
        ind_aval_embarque = " ", # Indicador de Avaliação de Embarque  (Inteiro) 1 - Não Avalia  2 - Somente Atrasos Duplicatas  3 - Limites e Atrasos Duplicatas
        canal_venda = " ", # Canal de Venda (Inteiro)
        ender_cobranca_completo = fo_end1, # Endereço Cobrança Completo
        endereco_completo = fo_end1, # Endereço Completo
        pais_cobranca = fo_country, # País de Cobrança
        situacao_fornecedor = " ", # Situação do Fornecedor (Inteiro)  1 - Ativo  2 - Restrição Compras  3 - Restrição Compras e Recebimento 4 - Inativo
        dt_vigencia_inicial = " ", # Data de Vigência Inicial (DDMMAAAA)
        dt_vigencia_final = " ", # Data de Vigência Final  (DDMMAAAA)
        inscricao_inss = " ", # Inscrição INSS
        tributa_cofins = " ", # Tributa COFINS (Inteiro) 1 - Tributa Cofins   2 - Isento
        tributa_pis = " ", # Tributa PIS (Inteiro)  1 - Tributa PIS    2 - Isento
        ctrl_max_inss = " ", # Controla Valor Máximo INSS (Logico) S - Sim    N - Não
        calc_pis_cofins = " ", # Calcula PIS/COFINS por Unidade  (Logico) S - Sim    N - Não
        retem_pagto = " ", # Retem Pagto  (Logico) S - Sim    N - Não
        portador_fornecedor = 99999, # Portador Fornecedor (Inteiro)
        mod_fornecedor = " ", # Modalidade Fornecedor (Inteiro) 1 - Cb simples 2 - Descontos 3 - Caução 4 - Judicial 5 - Repres 6 - Carteira 7 - Vendor
        contribuinte_substituto_intermediario = " ",  # Contribuinte Substituto Intermediário (Caracter)  S - Sim N - Não
        fornecedor_name = fo_name, # Nome do Cliente/Fornecedor
        brancos_extras = "     ",
        fornecedor_cidade = fo_cidade, # Cidade
        cidade_cobranca = fo_cidade, # Cidade Cobrança
        grupo_cliente = 10, # Grupo do Cliente (Inteiro) *
        obs = "123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890", # Observação 1
        venc = " " # Vencimento Igual a data do fluxo (inteiro) 1 - Sim  2 - Não
      ) |>
    select(
      b1_6b,
      fo_matchcode, # nome_abreviado_fornecedor,       # *
      fo_cnpj,      #fornecedor_cnpj,                 #  *
      fornecedor_identificacao,
      fornecedor_natureza,
      b2_40b,
      fo_end1, # fornecedor_endereco,             # *
      fo_end2, # fornecedor_bairro,               #
      b3_25b,
      fo_uf,   # fornecedor_estado,               # *
      fo_cep,  # fornecedor_cep,                  # *
      cx_postal,
      pais,
      inscricao_estadual, # inscricao_estadual,
      b4_2b,
      taxa_financeira,
      dt_taxa_financeira,
      cod_transportador_padrao,
      cod_grupo_fornecedor,  #  (INTEIRO) *
      linha_produtos,
      fornecedor_ramo_atividade,
      fo_telefax,
      fo_ramal_telefax,
      fo_telex,
      fo_dt_implantacao, # (DDMMAAAA)
      fo_compras_no_periodo,
      fo_contribuinte_icms, # 1 - Sim   2 - Não (inteiro)
      b5_2b,
      fo_categoria,       #
      representante,
      b6_2b,
      bonificacao,
      abrangencia_da_avaliacao_de_credito,          # 1 - Cliente  2 - Matriz (INTEIRO) *
      b7_2b,
      limite_de_credito,
      data_limite_de_credito,
      percentual_max_fat_periodo,
      portador,
      modalidade,
      aceita_fat_parcial,
      indicador_de_credito,
      avaliacao_credito_aprovacao_pedido,
      fo_natureza_de_operacao,
      desativado,
      perc_min_fat_parcial,
      meio_emissao_pedido_compra,
      nome_fantasia_matriz,
      telefone1,
      ramal1,
      telefax2,
      ramal_telefax2,
      agencia,
      b8_1b,
      num_titutlos,
      num_dias,
      per_max_cancel_qnt_aberto,
      dt_ultima_nota_emitida,
      emite_bloquete,
      emite_etiqueta,
      valores_rec,
      gera_aviso_deb,  # *
      portador_pref,
      mod_pref,
      baix_nao_acatada,
      fornecedor_conta_corrente,
      fornecedor_dig_cc,
      cond_pgto,
      b9_4b,
      num_copias_pedido_compra,
      suframa,
      cacex,
      gera_dif_preco,
      tbl_preco,
      ind_avaliacao,
      usuario_libera_cred,
      venc_dom,
      venc_sab,
      cnpj_cobranca,
      cep_cobranca,
      uf_cobranca,
      b10_4b,
      bairro_cobranca,
      end_cobranca,
      cx_postal_cobranca,
      ie_cobranca,
      banco_fornecedor,
      prox_aviso_debito,
      tipo_registro,
      venc_feriado,
      tipo_pgto,
      tip_cobranca,
      inscric_municipal,
      tipo_desp_padrao,
      tipo_receita_padrao,
      cod_enderecamento,
      micro_regiao,
      b11_3b,
      telefone3,
      telefone4,
      num_meses_inativo, #  *
      instrucao_bancaria,
      instrucao_bancaria2,
      nat_interestadual,
      cod_cliente, # Código do Cliente (Inteiro) *
      cod_cliente_cobranca, # *
      utiliza_verba_publicidade,
      percentual_verba_publicidade,
      email_cliente,
      ind_aval_embarque,
      canal_venda,
      ender_cobranca_completo,
      endereco_completo,
      pais_cobranca,
      situacao_fornecedor,
      dt_vigencia_inicial,
      dt_vigencia_final,
      inscricao_inss,
      tributa_cofins,
      tributa_pis,
      ctrl_max_inss,
      calc_pis_cofins,
      retem_pagto,
      portador_fornecedor,
      mod_fornecedor,
      contribuinte_substituto_intermediario,
      fornecedor_name,
      brancos_extras,
      fornecedor_cidade,
      cidade_cobranca,
      grupo_cliente, # *
      obs,
      venc
        )

  cd1302_fix_width <- c(
    6,  # brancos
    12, # nome abreviado *
    19, # cnpj           *
    1,  # 1 = cliente, 2 = fornecedor, 3 = ambos (inteiro)         *
    1,  # natureza: 1 PF, 2 PJ, 3 Estrangeiro, 4 Trading (inteiro) *
    40, # brancos
    40, # endereco            *
    30, # bairro
    25, # brancos             *
    4,  # UF                  *
    12, # cep                 *
    10, # caixa postal
    20, # país
    19, # IE
    2,  # brancos
    5, # taxa financeira (decimal)
    8, # data da taxa financeira (DDMMAAAA)
    5, # Código Transportador Padrão (INTEIRO)
    2, # código do grupo do fornecedor (INTEIRO) *
    8, # Linha de Produtos
    12, # Ramo de Atividade
    15, # Telefax
    5,  # Ramal do Telefax
    15, # Telex
    8, # Data Implantação (DDMMAAAA)
    14, # Compras no Período (Decimal)
    1, # Contribuinte ICMS: 1 - Sim   2 - Não (inteiro)
    2, # Brancos
    3, # Categoria
    5, # Código do Representante (Inteiro)
    2, # Brancos
    5, # Bonificação (Desconto Padrão cliente) (DECIMAL)
    1, # Abrangência da Avaliação de Crédito: 1 - Cliente  2 - Matriz (INTEIRO) *
    2, # Brancos
    11, # Limite de Crédito  (DECIMAL)
    8, # Data Limite de Crédito (DDMMAAAA)
    3, # Percentual Máximo Faturado por Período (Inteiro)
    5, # Portador (Inteiro)
    2, # Modalidade (Inteiro) 1 - Cb simples 2 - Descontos 3 - Caução 4 - Judicial 5 - Repres 6 - Carteira 7 - Vendor
    1, # Aceita Faturamento Parcial (Inteiro) 1 - Sim 2 - Não
    1, # Indicador de Crédito (Inteiro) 1 - Normal  2 - Automático 3 - Caução 4 - Suspenso 5 - Pagamento à vista
    1, # Avaliação de Crédito Para Aprovação de Pedido (Inteiro) 1 - Sim 2 - Não
    6, # Natureza de Operação (Caracter)
    150, # Desativado (Caracter)
    4, # Percentual Minimo Por Faturamento Parcial
    1, # Meio Para Emissão de Pedido de Compra (Inteiro) 1 - Formulário 2 - Magnético 3 - Faxm
    12, # Nome Fantasia da Matriz do Cliente *
    15, # Telefone Modem
    5, # Ramal do Modem
   15, # Telefax
    5, # Ramal do Telefax
    7, # Agência do Cliente/Fornecedor
    1, # Brancos
    8, # Número de Títulos (Inteiro)
    8, # Número de Dias (Inteiro)
    4, # Percentual Máximo de cancelamento Quant. Aberto (Decimal)
    8, # Data da Última Nota Fiscal Emitida (DDMMAAAA)
    1, # Emite Bloquete Para Título (Inteiro) 1 - Sim  2 - Não
    1, # Emite Etiqueta Para Correspondência (Inteiro)  1 - Sim 2 - Não
    1, # Valores de Recebimento (Inteiro) 1 - Trunca 2 - Arredonda
    1, # Gera Aviso de Débito (Inteiro) 1 - Sim  2 - Não      *
    5, # Portador Preferencial (Inteiro)
    2, # Modalidade Preferencial (Inteiro) 1 - Cb simples  2 - Descontos  3 - Caução  4 - Judicial  5 - Repres  6 - Carteira
    3, # Baixa Não Acatada (Inteiro)
    10, # Conta Corrente do Cliente/Fornecedor (Inteiro)
    2, # Dígito da Conta Corrente do Cliente/Fornecedor
    4, # Condição de Pagamento (Inteiro)
    4, # Brancos
    2, # Número de Cópias do Pedido de Compra (Inteiro)
    20, # Código Suframa
    20, # Código Cacex
    1, # Gera Diferença de Preço (Inteiro)
    8, # Tabela de Preços
    1, # Indicador de Avaliação (Inteiro) 1 - Não Avalia  2 - Somente Atrasos Duplicatas  3 - Limites e Atrasos Duplicatas
    12, # Usuário libera Crédito
    1, # Vencimento Domingo (Inteiro) 1 - Prorroga  2 - Antecipa 3 - Mantém
    1, # Vencimento Sábado (Inteiro) 1 - Prorroga   2 - Antecipa 3 - Mantém
    19, # C.G.C. Cobrança (Caracter)
    12, # C.E.P. Cobrança
    4, # Estado Cobrança
    25, # Brancos
    30, # Bairro Cobrança
    40, # Endereço Cobrança
    10, # Caixa Postal Cobrança
    19, # Inscrição Estadual Cobrança
    3, # Banco do Cliente/Fornecedor
    6, # Próximo Aviso Débito (Inteiro)
    1, # Tipo do Registro (Inteiro) *  1 - Implantação 2 - Alteração
    1, # Vencimento Feriado (Inteiro)  1 - Prorroga 2 - Antecipa 3 - Mantém
    2, # Tipo de Pagamento (Inteiro) 1 - DOC 2 - Crédito conta corrente 3 - Cheque administrativo 4 - Cobrança 5 - Cheque Nominal  6 - Débito em Conta Corrente 7 - Cartão de Crédito 8 - Agendamento Eletrônico
    1, # Tipo de Cobrança das Despesas (Inteiro) 1 - Primeira Duplicata 2 - Rateio entre todas as Duplicatas 3 - Rateio entre todas com IPI na Primeira  4 - Apenas IPI na Primeira e Rateio nas Restantes
    19, # Inscrição Municipal
    3, # Tipo de Despesa Padrão (Inteiro)
    3, # Tipo de Receita Padrão
    12, # Código de Endereçamento Postal Estrangeiro
    12, # Micro Região
    3, # Brancos
    15, # Telefone[1]
    15, # Telefone[2]
    2, # Número de Meses Inativos (Inteiro) *
    3, # Instrução Bancária(1) (Inteiro)
    3, # Instrução Bancária(2) (Inteiro)
    6, # Natureza Interestadual
    9, # Código do Cliente (Inteiro) *
    9, # Código do Cliente de Cobrança (Inteiro) *
    1, # Utiliza Verba de Publicidade (Logico)
    6, # Percentual de Verba de Publicidade (Decimal)
    40, # E-mail
    1, # Indicador de Avaliação de Embarque  (Inteiro) 1 - Não Avalia  2 - Somente Atrasos Duplicatas  3 - Limites e Atrasos Duplicatas
    3, # Canal de Venda (Inteiro)
    2000, # Endereço Cobrança Completo
    2000, # Endereço Completo
    20, # País de Cobrança
    1, # Situação do Fornecedor (Inteiro)  1 - Ativo  2 - Restrição Compras  3 - Restrição Compras e Recebimento 4 - Inativo
    8, # Data de Vigência Inicial (DDMMAAAA)
    8, # Data de Vigência Final  (DDMMAAAA)
    20, # Inscrição INSS
    1, # Tributa COFINS (Inteiro) 1 - Tributa Cofins   2 - Isento
    1, # Tributa PIS (Inteiro)  1 - Tributa PIS    2 - Isento
    1, # Controla Valor Máximo INSS (Logico) S - Sim    N - Não
    1, # Calcula PIS/COFINS por Unidade  (Logico) S - Sim    N - Não
    1, # Retem Pagto  (Logico) S - Sim    N - Não
    5, # Portador Fornecedor (Inteiro)
    2, # Modalidade Fornecedor (Inteiro) 1 - Cb simples 2 - Descontos 3 - Caução 4 - Judicial 5 - Repres 6 - Carteira 7 - Vendor
    1, # Contribuinte Substituto Intermediário (Caracter)  S - Sim N - Não
    80, # Nome do Cliente/Fornecedor
  100, # brancos extras
    50, # Cidade
    50, # Cidade Cobrança
    4, # Grupo do Cliente (Inteiro) *
    2000, # Observação 1
    1 # Vencimento Igual a data do fluxo (inteiro) 1 - Sim  2 - Não
  )

  to_exp <- as.data.frame(to_exp)


  gdata::write.fwf(
    x = to_exp,
    file = out_file,
    width = cd1302_fix_width,
    colnames = FALSE,
    sep = ""
  )

}

