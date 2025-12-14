
# MBB LTC L98 NTC PA

mbb176 <-
  tibble(
    item =   c("F00417002001A",
    "F00417003002A",
    "F00417002002A",
    "F02108026001A",
    "F02108027001A",
    "F02108015013A",
    "F02108015014A",
    "F02108015020A",
    "F02108015021A",
    "F02108015043A",
    "F02108015046A",
    "F02108017004A",
    "F02108023001A",
    "F02108023011A",
    "F02108023012A",
    "F02808008026A",
    "F02808008023A",
    "F01708020004A",
    "F02108012003A",
    "F02108026003A",
    "F02108027002A",
    "F02108018002A",
    "F02108018006A",
    "F02108001003A",
    "F02108001004A",
    "F02108002003A",
    "F02108002004A"))

s_itens |>
  filter(item %in% mbb176$item) |>
  View()

# Todos os itens estão cadastrados.
mbb176 |>
  left_join(s_itens) |> View()

# Precisa ajustar as famílias?
  # MBB LTC
  # MBB L98
  # MBB NTC
  # MBB PA

mbb176 |>
  left_join(bom, join_by(item == material_number)) |> View()

source("R/import-bom.R")
# goto_en0113 prepara um arquivo com componentes para serem importados em massa
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
bom_mbb176 <-
  mbb176 |>
  left_join(s_itens) |>
  select(item, pseudo) |>
  left_join(bom, join_by(item == material_number))


goto_en0113(df = bom_mbb176, out_file = "mbb.lst")

mbb_i <- tibble(
  item = c("I00417003003A",
           "I00417002003A",
           "I00417002004A",
           "I00417002005A",
           "I02108018005A",
           "I02108024001A",
           "I02108018005A",
           "I02108025001A",
           "I02108014002A", # sem bop
        "I02108015005A"
           )
)

bom_mbb_i <-
  mbb_i |>
  left_join(s_itens) |>
  select(item, pseudo) |>
  left_join(bom, join_by(item == material_number))

goto_en0113(bom_mbb_i, "bom_mbb_i.lst")





source("R/import-bop.R")
bop_mbb176 <-
  mbb176 |>
  left_join(bop, join_by(item == part_number))
goto_en0114(bop_mbb176, "bop_mbb.lst")


bop_mbb_i <-
  mbb_i |>
  left_join(bop, join_by(item == part_number))
goto_en0114(bop_mbb_i, "bop_mbb_i.lst")
