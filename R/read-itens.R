# read ITENS from Excel
#
# Ajusta a família
#
# caso seja item F copia o código do cliente no campo customers_part_no

read_itens_summary <- function(filename_itens = "default") {

  if(filename_itens == "default") {
    #filename_itens <- here("data", "Artigos 2025-07-08.xlsx")
    # filename_itens <- here("data", "Artigos 2025-09-02.xlsx")
    filename_itens <- here("data", "Artigos 2025-10-21.xlsx")
  }

  itens <-
    readxl::read_excel(filename_itens) |>
    janitor::clean_names()

  itens <-
    itens |>
    mutate(estabelecimento = ifelse(empresa == "SPB", "103", "102")) |>
    mutate(tebez1 = ifelse(is.na(tebez1), " ", stringr::str_squish(tebez1)),
           tebez2 = ifelse(is.na(tebez2), " ", stringr::str_squish(tebez2)),
           desc = stringr::str_c(tebez1, " ", tebez2) |> stringr::str_squish(),
           desc2 = stringr::str_squish(tebez2)) |>
    mutate(un = case_when(
      unit_measure == "PCs" ~   "PC",
      unit_measure == "Unit" ~   "UN",
      TRUE ~ unit_measure)) |>
    mutate(
      grupo_estoque = case_when(
        tipo_de_materiais == "Raw materials" ~ "30",
        tipo_de_materiais == "Packaging" ~ "40",
        tipo_de_materiais == "Returnable packaging" ~ "70",
        tipo_de_materiais == "Semifinished Product" ~ "20",
        tipo_de_materiais == "Finished Product" ~  "10",
        tipo_de_materiais == "Services" ~ "90",
        TRUE ~ "99")) |>
    mutate(teaucd = ifelse(is.na(teaucd), "N", teaucd),
           pseudo = ifelse(str_detect(teaucd, "P"), "S", "N")) |>
    select(item = tetenr,
           pseudo,
           estabelecimento = empresa,
           grupo_de_estoque = tipo_de_materiais,
           desc,
           desc2,
           un,
           prj_sigla = teprgr,
           prj_desc = fstext,
           cod_comp = tezinr,
           ncm = utclsf,
           xp_temagr = temagr,
           xp_mat_group_desc = mat_group_desc,
           xp_tematc = tematc,
           xp_teprgr = teprgr,
           xp_fstext = fstext)

}

read_itens <- function(filename_itens = "default") {

  if(filename_itens == "default") {
    #filename_itens <- here("data", "Artigos 2025-07-08.xlsx")
    # filename_itens <- here("data", "Artigos 2025-09-02.xlsx")
    filename_itens <- here("data", "Artigos 2025-10-21.xlsx")
  }

  itens <-
    readxl::read_excel(filename_itens) |>
    janitor::clean_names()

  itens <-
    itens |>
    mutate(estabelecimento = ifelse(empresa == "SPB", "103", "102")) |>
    mutate(tebez1 = ifelse(is.na(tebez1), " ", stringr::str_squish(tebez1)),
           tebez2 = ifelse(is.na(tebez2), " ", stringr::str_squish(tebez2)),
           desc = stringr::str_c(tebez1, " ", tebez2) |> stringr::str_squish(),
           desc2 = stringr::str_squish(tebez2)) |>
    mutate(un = case_when(
      unit_measure == "PCs" ~   "PC",
      unit_measure == "Unit" ~   "UN",
      TRUE ~ unit_measure)) |>
    mutate(
      grupo_estoque = case_when(
        tipo_de_materiais == "Raw materials" ~ "30",
        tipo_de_materiais == "Packaging" ~ "40",
        tipo_de_materiais == "Returnable packaging" ~ "70",
        tipo_de_materiais == "Semifinished Product" ~ "20",
        tipo_de_materiais == "Finished Product" ~  "10",
        tipo_de_materiais == "Services" ~ "90",
        TRUE ~ "99"))

}

make_item_unique <- function(itens) {
  itens <-
    itens |>
    arrange(estabelecimento) |>
    group_by(item) |>
    summarise(across(c(grupo_de_estoque, desc, desc2, un, prj_sigla, prj_desc,
                       cod_comp, xp_temagr, xp_mat_group_desc, xp_tematc,
                       xp_teprgr, xp_fstext), ~ first(.x)))
}

get_finished_itens <- function(itens) {
  # Apenas itens acabados "F"
  f_itens <-
    itens |>
    filter(str_detect(item, "^F"))

  source("R/read-bom.R")
  bom <- read_bom()

  f_itens <-
    f_itens |>
    mutate(item_bom = map(item, ~ get_bom_from_id(., bom)))

  f_itens <-
    f_itens |>
    filter(!is.na(item_bom))

}


set_item_family <- function(df_item) {

  item_w_family <-
    df_item |>
    mutate(xp_mat_group_desc = str_squish(xp_mat_group_desc)) |>
    mutate(grupo_estoque = case_when(
      str_detect(grupo_de_estoque, "Raw materials") ~ "30",
      str_detect(grupo_de_estoque, "Semifinished Product") ~ "20",
      str_detect(grupo_de_estoque, "Packaging") ~ "40",
      str_detect(grupo_de_estoque, "Returnable packaging") ~ "70",
      str_detect(grupo_de_estoque, "Operating supplies") ~ "60",
      str_detect(grupo_de_estoque, "Services") ~ "30",
      str_detect(grupo_de_estoque, "Finished Products") ~ "10",
      str_detect(grupo_de_estoque, "Product resource/tools") ~ "50",
      str_detect(grupo_de_estoque, "Services") ~ "99",
      str_detect(grupo_de_estoque, "SNon-Stock Material") ~ "99",
      TRUE ~ "99"
    )) |>
    mutate(fam_m = str_sub(item, start = 1L, end = 2L)) |>
    mutate(             # ATENÇÃO! A ORDEM ABAIXO IMPORTA !
      family = case_when(
        # str_detect(desc, "^PR FILM PLAS") ~ "44003",
        #
        # str_detect(mat_group_desc, "MASTER ABS-PC")   ~   "32002",
        # str_detect(mat_group_desc, "MASTER ABS")   ~   "32001",
        # str_detect(mat_group_desc, "MASTER PP")   ~   "32003",
        # str_detect(mat_group_desc, "MASTER PA6")   ~   "32004",
        # str_detect(mat_group_desc, "MASTER TPE")   ~   "32005",
        #
        # str_detect(mat_group_desc, "PP COPO REC")   ~   "11999",
        # str_detect(mat_group_desc, "PP COPO") ~   "11002",
        # str_detect(mat_group_desc, "PP T I")   ~   "11006",
        # str_detect(mat_group_desc, "PP T")    ~   "11001",
        # str_detect(mat_group_desc, "PP I")   ~   "11007",
        # str_detect(mat_group_desc, "PP GF")   ~   "11003",
        # str_detect(mat_group_desc, "PP HC")   ~   "11004",
        # str_detect(mat_group_desc, "PP LGF")   ~   "111005",
        # str_detect(mat_group_desc, "^PP")    ~   "11000",
        #
        # str_detect(mat_group_desc, "ABS REC")   ~   "13999",
        # str_detect(mat_group_desc, "ABS-PC")   ~   "13001",
        # str_detect(mat_group_desc, "ABS")   ~   "13000",
        #
        # str_detect(mat_group_desc, "PA6 GF")   ~   "17003",
        # str_detect(mat_group_desc, "PA6.6 T")   ~   "17002",
        # str_detect(mat_group_desc, "PA6")   ~   "17001",
        # str_detect(mat_group_desc, "ASA")   ~   "14000",
        #
        # str_detect(mat_group_desc, "ABS-PC")   ~   "18001",
        # str_detect(mat_group_desc, "PC")   ~   "18000",
        #
        # str_detect(mat_group_desc, "TPE")   ~   "19000",
        # # Elastômero Termoplástico
        # str_detect(mat_group_desc, "POM")   ~   "16000",
        # # Polioximetileno
        #
        # str_detect(mat_group_desc, "^METALLIC CLIPS")      ~   "41001",
        # #METALLIC CLIPS OMEGA
        # str_detect(mat_group_desc, "METAIS")            ~   "41000",
        # str_detect(mat_group_desc, "STAMPED STEEL SLEEVE") ~   "41002",
        # # MANGA DE AÇO ESTAMPADO
        # str_detect(mat_group_desc, "TORSION SPRING")       ~   "41003",
        # # mola de torçao
        # str_detect(mat_group_desc, "CASTING COMPONENTS")   ~   "41004",
        # # componentes de fundição
        # str_detect(mat_group_desc, "SELF-TAPPING SCREW P") ~   "41005",
        # # parafuso auto rosca
        # str_detect(mat_group_desc, "METALLIC RIVETS")      ~   "41006",
        # # rebites metálicos
        # str_detect(mat_group_desc, "TRACTION SPRING")      ~   "41007",
        # # mola de tração
        # str_detect(mat_group_desc, "OTHER METAL FASTENER") ~   "41008",
        # # OUTROS FIXADORES DE METAL
        # str_detect(mat_group_desc, "EXTRUDED PROFILES")    ~   "41009",
        # # PERFIS EXTRUDADOS
        # str_detect(mat_group_desc, "M DOUB. TWEEZER CLIP") ~   "41010",
        # # PINÇA DUPLA
        # str_detect(mat_group_desc, "METAL CLIP W/MET NUT") ~   "41011",
        # # CLIP DE METAL COM PORCA DE METAL
        # str_detect(mat_group_desc, "METAL CLIP W/PLT NUT") ~   "41012",
        # # METAL CLIP W/PLT NUT
        # str_detect(mat_group_desc, "NUTS TO RIVET")        ~   "41013",
        # # PORCAS PARA REBITE
        # str_detect(mat_group_desc, "STEEL TUBE")           ~   "41014",
        # # TUBO DE AÇO
        # str_detect(mat_group_desc, "TURNED INSERTS STEEL") ~   "41015",
        # # TORNEADOS DE AÇO
        # str_detect(mat_group_desc, "BRASS TUBE")           ~   "41016",
        # # TUBO DE LATÃO
        # str_detect(mat_group_desc, "METALLIC METRICSCREW") ~   "41017",
        # # PARAFUSO MÉTRICO METÁLICO
        # str_detect(mat_group_desc, "METRIC NUTS")          ~   "41018",
        # # PORCAS MÉTRICAS
        # str_detect(mat_group_desc, "SELF-TAPPING SCREW M") ~   "41019",
        # # PARAFUSO AUTO-ROSCA Metálico
        # str_detect(mat_group_desc, "SPRING WASHERS")        ~   "41020",
        # # ARRUELAS DE MOLA
        # str_detect(mat_group_desc, "STEEL REINFORCEMENTS") ~   "41021",
        # # REFORÇOS DE AÇO
        # str_detect(mat_group_desc, "METAL TWEEZERS CLIP")  ~   "41022",
        # # PARAFUSO MÉTRICO METÁLICO
        # str_detect(mat_group_desc, "OTHER STAMPED METAL")  ~   "41022",
        # # OUTROS METAIS ESTAMPADOS
        # str_detect(mat_group_desc, "OTHER NUTS")           ~   "41022",
        # # OUTRAS PORCAS METÁLICAS
        # str_detect(mat_group_desc, "OTHER SCREWS")         ~   "41023",
        # # OUTRAS PARAFUSOS METÁLICOS
        # str_detect(mat_group_desc, "OTHER WASHERS")        ~   "41024",
        # # OUTRAS ARRUELAS METÁLICAS
        # str_detect(mat_group_desc, "OTHERS SPRINGS")       ~   "41025",
        # # OUTRAS MOLAS METÁLICAS
        # str_detect(mat_group_desc, "M DOUB. TWEEZER CLIP") ~   "41026",
        # # PINÇA DUPLA METÁLICA
        #
        #
        # str_detect(mat_group_desc, "PLASTIC CLIPS")  ~   "42001",
        # # CLIPS DE PLÁSTICO REDONDOS
        # str_detect(mat_group_desc, "PLASTICS")             ~   "42000",
        # str_detect(mat_group_desc, "OTHER PLASTIC FAST.")  ~   "42002",
        # # FIXADOR DE PLÁSTICO
        #
        # str_detect(mat_group_desc, "IN MOULD LABELING")    ~   "44002",
        # # ETIQUETAGEM DE MOLDATEM
        # str_detect(mat_group_desc, "HOT STAMPING FILMS")   ~   "44003",
        # # FILMES DE ESTAMPAGEM A QUENTE
        #
        # str_detect(mat_group_desc, "PVC CUTTED")   ~   "45001",
        # # PVC CORTADO
        # str_detect(mat_group_desc, "PVC IN ROLL")   ~   "45002",
        # #
        # str_detect(mat_group_desc, "PVC")   ~   "45000",
        # # PVC
        #
        # str_detect(mat_group_desc, "PES FABRIC W/FOAM CT")   ~   "45102",
        # #
        # str_detect(mat_group_desc, "PES FABRIC IN ROLL")     ~   "45103",
        # #
        # str_detect(mat_group_desc, "PES FABRIC IN ROLL")     ~   "45104",
        # #
        # str_detect(mat_group_desc, "PES FABRIC W/FOAM RL")   ~   "45105",
        # #
        # str_detect(mat_group_desc, "PES FABRIC W/NW ROLL")   ~   "45106",
        # #
        # str_detect(mat_group_desc, "^PES FAB")   ~   "45101",
        # #
        # str_detect(mat_group_desc, "OTHER ELASTIC TEXT.")    ~   "45107",
        # #
        # str_detect(mat_group_desc, "TEXTILE NETS")           ~   "45201",
        # #
        # str_detect(mat_group_desc, "TPO CUTTED")             ~   "45202",
        # #
        # str_detect(mat_group_desc, "NW FB W/ ADHES CUT")     ~   "45203",
        # #
        # str_detect(mat_group_desc, "TPO IN ROLL")            ~   "45204",
        # #
        #
        # str_detect(mat_group_desc, "ESPUMA")                 ~   "47000",
        # #
        # str_detect(mat_group_desc, "EPDM FOAM OPEN CELL")    ~   "47001",
        # #
        # str_detect(mat_group_desc, "AGGLOMERATE PUR FOAM")   ~   "47002",
        # #
        # str_detect(mat_group_desc, "PVC FOAM")               ~   "47003",
        # #
        # str_detect(mat_group_desc, "PE FOAM OPEN CELL")      ~   "47004",
        # #
        # str_detect(mat_group_desc, "PUR FOAMS")              ~   "47005",
        # #
        # str_detect(mat_group_desc, "PE FOAM CLOSED CELL")    ~   "47006",
        # #
        # str_detect(mat_group_desc, "PUR GLUE POLYOL")    ~   "47101",
        # #
        #
        # str_detect(mat_group_desc, "POLIESTER")   ~   "47100",
        # #
        # str_detect(mat_group_desc, "PES SOUNDP. W/T ADH.")   ~   "47102",
        # #
        # str_detect(mat_group_desc, "PES SOUNDP. W/ ADH.")   ~   "47101",
        # #
        #
        # str_detect(mat_group_desc, "FELT FB W/T ADHESIVE")   ~   "47202",
        # #
        # str_detect(mat_group_desc, "FELT FB W/ ADHESIVE")   ~   "47201",
        # #
        # str_detect(mat_group_desc, "FELTRO")   ~   "47200",
        # #
        # str_detect(mat_group_desc, "OTHER FELT W/T ADHES")   ~   "47207",
        # #
        # str_detect(mat_group_desc, "SYNTH. FELT W/T ADH.")   ~   "47207",
        # #
        # str_detect(mat_group_desc, "FELT FB W/ ADHESIVE")   ~   "47208",
        #
        # str_detect(mat_group_desc, "SYNTH. FELT W ADHES.")   ~   "47203",
        # #
        # str_detect(mat_group_desc, "OTHER FELT W/ ADHES.")   ~   "47205",
        # #
        # str_detect(mat_group_desc, "BI-ADHESIVE TAPES")   ~   "47206",
        # #
        # str_detect(mat_group_desc, "TAKA WITH ADHESIVE")   ~   "47501",
        # #
        # str_detect(mat_group_desc, "OTHER SDP W/T ADHES.")   ~   "47601",
        # #
        #
        # str_detect(mat_group_desc, "ELETRIFICADOS")   ~   "48000",
        # #
        # str_detect(mat_group_desc, "ELECTRICAL COMPONENT")   ~   "48001",
        # #
        #
        # str_detect(mat_group_desc, "POLIURETANO")   ~   "49000",
        # # parte injetada de poliuretano
        # str_detect(mat_group_desc, "INJECTED PARTS-PUR")   ~   "49001",
        # # parte injetada de poliuretano
        # str_detect(mat_group_desc, "PAINT INJ PARTS-PUR")   ~   "49002",
        # #
        #
        # str_detect(mat_group_desc, "RUBBER STOP PAD")      ~   "49101",
        # # BATENTE DE BORRACHA")
        # str_detect(mat_group_desc, "RUBBER PROFILE")      ~   "49102",
        # str_detect(mat_group_desc, "OTHER RUBBER COMPO.")      ~   "49104",
        # str_detect(mat_group_desc, "SILICONE SHOCK PAD")      ~   "49151",
        #
        # str_detect(mat_group_desc, "INJECTED PARTS-SUB")   ~   "49201",
        # str_detect(mat_group_desc, "PAINT INJ PARTS-SUB")   ~   "49202",
        # str_detect(mat_group_desc, "CHROMATED INJ PARTS")   ~   "49203",
        #
        # str_detect(mat_group_desc, "CAIXA")   ~   "51000",
        # str_detect(mat_group_desc, "BOX 2 CORG W/T KRAFT")   ~   "51008",
        # str_detect(mat_group_desc, "SBOX 2CORG W/T KRAFT")   ~   "51009",
        # str_detect(mat_group_desc, "SBOX 2CORG W/ KRAFT")   ~   "51010",
        # str_detect(mat_group_desc, "BOX 2 CORG W/ KRAFT")   ~   "51001",
        # str_detect(mat_group_desc, "BOX 1 CORG W/T KRAFT")   ~   "51002",
        # str_detect(mat_group_desc, "PLASTIC BOX RIGID")   ~   "51003",
        # str_detect(mat_group_desc, "CLIENT PACK REUSABLE")   ~   "51004",
        # str_detect(mat_group_desc, "BOX 1 CORG W/T KRAFT")   ~   "51005",
        # str_detect(mat_group_desc, "BOX 1 CORG W/ KRAFT")   ~   "51006",
        # str_detect(mat_group_desc, "SBOX 1CORG W/T KRAFT")   ~   "51007",
        # str_detect(mat_group_desc, "BOX 3 CORG W/T KRAFT")   ~   "51011",
        # str_detect(mat_group_desc, "PLASTIC CONT RIGID")   ~   "51012",
        # str_detect(mat_group_desc, "METAL CONT FOLDABLE")   ~   "51013",
        # str_detect(mat_group_desc, "PACKAGING KITS")   ~   "51014",
        # str_detect(mat_group_desc, "BOXES LABELS")   ~   "51015",
        # str_detect(mat_group_desc, "PART RETRACT. FILM")   ~   "51016",
        # str_detect(mat_group_desc, "BI-ADHESIVE TAPES")   ~   "51501",
        #
        # str_detect(mat_group_desc, "CORRUGATED CARD CUT.")   ~   "51101",
        # str_detect(mat_group_desc, "OTHER SEPARAT&WEDGES")   ~   "51102",
        # str_detect(mat_group_desc, "PAPER WEDGE BLOCKS")   ~   "51103",
        # str_detect(mat_group_desc, "OTHER SEPARAT&WEDGES")   ~   "51104",
        # str_detect(mat_group_desc, "PLASTIC SEPARATORS")   ~   "51105",
        # str_detect(mat_group_desc, "PAPER SEPARATORS")   ~   "51106",
        # str_detect(mat_group_desc, "LABELS-PACKAGES")   ~   "51201",
        # str_detect(mat_group_desc, "LABELS-PARTS")   ~   "51202",
        # str_detect(mat_group_desc, "TEXTILE NETS")   ~   "51301",
        # str_detect(mat_group_desc, "FOAM PE BAGS")   ~   "51302",
        # str_detect(mat_group_desc, "PART RETRACT. FILM")   ~   "51303",
        # str_detect(mat_group_desc, "OTHER FELT W/T ADHES")   ~   "51304",
        # str_detect(mat_group_desc, "PALLET EXTENS. FILM")   ~   "51305",
        # str_detect(mat_group_desc, "PLAST/CARD CONT FOLD")   ~   "51306",
        #
        # str_detect(mat_group_desc, "PALETE")   ~   "56000",
        # str_detect(mat_group_desc, "WOOD PALLETS")   ~   "56001",
        # str_detect(mat_group_desc, "WOOD PALETTS REUSAB")   ~   "56002",
        # str_detect(mat_group_desc, "WOOD PALLETS6")   ~   "56003",
        #
        # str_detect(mat_group_desc, "PLASTIC PALLETS")   ~   "56003",
        #
        # str_detect(mat_group_desc, "BLISTERS")   ~   "51401",
        # # BOLHAS
        #
        # str_detect(mat_group_desc, "CAIXA METÁLICA")   ~   "51500",
        # str_detect(mat_group_desc, "METAL CONT RIGID")   ~   "51501",
        #
        # str_detect(mat_group_desc, "SACOLA PLÁSTICA")   ~   "62000",
        # str_detect(mat_group_desc, "PLASTIC BAG LDPE")   ~   "62001",
        # str_detect(mat_group_desc, "PLASTIC BAG HDPE")   ~   "62002",
        # str_detect(mat_group_desc, "^BUBBLE BAGS")   ~   "62003",
        # str_detect(mat_group_desc, "PLASTIC BAG LDPE REC")   ~   "62004",
        # str_detect(mat_group_desc, "FOAM PE BAGS")   ~   "62005",
        #
        # str_detect(mat_group_desc, "SOLVENTES")   ~   "71000",
        # str_detect(mat_group_desc, "SOLVENT BASE HARDE.")   ~   "71001",
        # str_detect(mat_group_desc, "SOLVENT SOFT PAINT")   ~   "71002",
        # str_detect(mat_group_desc, "SOLVENT DECOR PAINT")   ~   "71003",
        # str_detect(mat_group_desc, "SOLVENT CLEARC. SFT.")   ~   "71004",
        # str_detect(mat_group_desc, "SOLVENT SCRATCH COAT")   ~   "71004",
        #
        # str_detect(mat_group_desc, "PRIMERS")   ~   "72000",
        # str_detect(mat_group_desc, "SOLVENT ADHES. PRIM.")   ~   "71101",
        # str_detect(mat_group_desc, "SOLVENT FILLING PRIM")   ~   "71102",
        # str_detect(mat_group_desc, "SOLVENT ADH. PRIMER")   ~   "71103",
        # str_detect(mat_group_desc, "SOLVENT EXT ADH PRIM")   ~   "71104",
        #
        # str_detect(mat_group_desc, "^THINNER")   ~   "71201",
        #
        # str_detect(mat_group_desc, "WATER BASE HARDENER")   ~   "71301",
        # str_detect(mat_group_desc, "WATER SOFT PAINT")   ~   "71401",
        # str_detect(mat_group_desc, "WATER DECOR PAINT")   ~   "71402",
        #
        # str_detect(mat_group_desc, "CYANOACRYLATES")   ~   "72000",
        #
        # str_detect(mat_group_desc, "CONSUMABLES IT")   ~   "70888",
        # str_detect(mat_group_desc, "STATIONERY OFFICE")   ~   "70887",
        # str_detect(mat_group_desc, "^NON STATIONARY")   ~   "70886",
        # str_detect(mat_group_desc, "TEC. DOCUMENTATION")   ~   "70885",
        # TRUE ~   "9999999"
        str_detect(desc, "^PR FILM PLAS") ~ "003",

        str_detect(xp_mat_group_desc, "MASTER ABS-PC")   ~   "002",
        str_detect(xp_mat_group_desc, "MASTER ABS")   ~   "001",
        str_detect(xp_mat_group_desc, "MASTER PP")   ~   "003",
        str_detect(xp_mat_group_desc, "MASTER PA6")   ~   "004",
        str_detect(xp_mat_group_desc, "MASTER TPE")   ~   "005",

        str_detect(xp_mat_group_desc, "PP COPO REC")   ~   "999",
        str_detect(xp_mat_group_desc, "PP COPO") ~   "002",
        str_detect(xp_mat_group_desc, "PP T I")   ~   "006",
        str_detect(xp_mat_group_desc, "PP T")    ~   "001",
        str_detect(xp_mat_group_desc, "PP I")   ~   "007",
        str_detect(xp_mat_group_desc, "PP GF")   ~   "003",
        str_detect(xp_mat_group_desc, "PP HC")   ~   "004",
        str_detect(xp_mat_group_desc, "PP LGF")   ~   "005",
        str_detect(xp_mat_group_desc, "^PP")    ~   "000",

        str_detect(xp_mat_group_desc, "ABS REC")   ~   "999",
        str_detect(xp_mat_group_desc, "ABS-PC")   ~   "001",
        str_detect(xp_mat_group_desc, "ABS")   ~   "000",

        str_detect(xp_mat_group_desc, "PA6 GF")   ~   "003",
        str_detect(xp_mat_group_desc, "PA6.6 T")   ~   "002",
        str_detect(xp_mat_group_desc, "PA6")   ~   "001",
        str_detect(xp_mat_group_desc, "ASA")   ~   "000",

        str_detect(xp_mat_group_desc, "ABS-PC")   ~   "001",
        str_detect(xp_mat_group_desc, "PC")   ~   "000",

        str_detect(xp_mat_group_desc, "TPE")   ~   "000",
        # Elastômero Termoplástico
        str_detect(xp_mat_group_desc, "POM")   ~   "000",
        # Polioximetileno

        str_detect(xp_mat_group_desc, "^METALLIC CLIPS")      ~   "001",
        #METALLIC CLIPS OMEGA
        str_detect(xp_mat_group_desc, "METAIS")            ~   "000",
        str_detect(xp_mat_group_desc, "STAMPED STEEL SLEEVE") ~   "002",
        # MANGA DE AÇO ESTAMPADO
        str_detect(xp_mat_group_desc, "TORSION SPRING")       ~   "003",
        # mola de torçao
        str_detect(xp_mat_group_desc, "CASTING COMPONENTS")   ~   "004",
        # componentes de fundição
        str_detect(xp_mat_group_desc, "SELF-TAPPING SCREW P") ~   "005",
        # parafuso auto rosca
        str_detect(xp_mat_group_desc, "METALLIC RIVETS")      ~   "006",
        # rebites metálicos
        str_detect(xp_mat_group_desc, "TRACTION SPRING")      ~   "007",
        # mola de tração
        str_detect(xp_mat_group_desc, "OTHER METAL FASTENER") ~   "008",
        # OUTROS FIXADORES DE METAL
        str_detect(xp_mat_group_desc, "EXTRUDED PROFILES")    ~   "009",
        # PERFIS EXTRUDADOS
        str_detect(xp_mat_group_desc, "M DOUB. TWEEZER CLIP") ~   "010",
        # PINÇA DUPLA
        str_detect(xp_mat_group_desc, "METAL CLIP W/MET NUT") ~   "011",
        # CLIP DE METAL COM PORCA DE METAL
        str_detect(xp_mat_group_desc, "METAL CLIP W/PLT NUT") ~   "012",
        # METAL CLIP W/PLT NUT
        str_detect(xp_mat_group_desc, "NUTS TO RIVET")        ~   "013",
        # PORCAS PARA REBITE
        str_detect(xp_mat_group_desc, "STEEL TUBE")           ~   "014",
        # TUBO DE AÇO
        str_detect(xp_mat_group_desc, "TURNED INSERTS STEEL") ~   "015",
        # TORNEADOS DE AÇO
        str_detect(xp_mat_group_desc, "BRASS TUBE")           ~   "016",
        # TUBO DE LATÃO
        str_detect(xp_mat_group_desc, "METALLIC METRICSCREW") ~   "017",
        # PARAFUSO MÉTRICO METÁLICO
        str_detect(xp_mat_group_desc, "METRIC NUTS")          ~   "018",
        # PORCAS MÉTRICAS
        str_detect(xp_mat_group_desc, "SELF-TAPPING SCREW M") ~   "019",
        # PARAFUSO AUTO-ROSCA Metálico
        str_detect(xp_mat_group_desc, "SPRING WASHERS")        ~   "020",
        # ARRUELAS DE MOLA
        str_detect(xp_mat_group_desc, "STEEL REINFORCEMENTS") ~   "021",
        # REFORÇOS DE AÇO
        str_detect(xp_mat_group_desc, "METAL TWEEZERS CLIP")  ~   "022",
        # PARAFUSO MÉTRICO METÁLICO
        str_detect(xp_mat_group_desc, "OTHER STAMPED METAL")  ~   "022",
        # OUTROS METAIS ESTAMPADOS
        str_detect(xp_mat_group_desc, "OTHER NUTS")           ~   "022",
        # OUTRAS PORCAS METÁLICAS
        str_detect(xp_mat_group_desc, "OTHER SCREWS")         ~   "023",
        # OUTRAS PARAFUSOS METÁLICOS
        str_detect(xp_mat_group_desc, "OTHER WASHERS")        ~   "024",
        # OUTRAS ARRUELAS METÁLICAS
        str_detect(xp_mat_group_desc, "OTHERS SPRINGS")       ~   "025",
        # OUTRAS MOLAS METÁLICAS
        str_detect(xp_mat_group_desc, "M DOUB. TWEEZER CLIP") ~   "026",
        # PINÇA DUPLA METÁLICA


        str_detect(xp_mat_group_desc, "PLASTIC CLIPS")  ~   "001",
        # CLIPS DE PLÁSTICO REDONDOS
        str_detect(xp_mat_group_desc, "PLASTICS")             ~   "000",
        str_detect(xp_mat_group_desc, "OTHER PLASTIC FAST.")  ~   "002",
        # FIXADOR DE PLÁSTICO

        str_detect(xp_mat_group_desc, "IN MOULD LABELING")    ~   "002",
        # ETIQUETAGEM DE MOLDATEM
        str_detect(xp_mat_group_desc, "HOT STAMPING FILMS")   ~   "003",
        # FILMES DE ESTAMPAGEM A QUENTE

        str_detect(xp_mat_group_desc, "PVC CUTTED")   ~   "001",
        # PVC CORTADO
        str_detect(xp_mat_group_desc, "PVC IN ROLL")   ~   "002",
        #
        str_detect(xp_mat_group_desc, "PVC")   ~   "000",
        # PVC

        str_detect(xp_mat_group_desc, "PES FABRIC W/FOAM CT")   ~   "102",
        #
        str_detect(xp_mat_group_desc, "PES FABRIC IN ROLL")     ~   "103",
        #
        str_detect(xp_mat_group_desc, "PES FABRIC IN ROLL")     ~   "104",
        #
        str_detect(xp_mat_group_desc, "PES FABRIC W/FOAM RL")   ~   "105",
        #
        str_detect(xp_mat_group_desc, "PES FABRIC W/NW ROLL")   ~   "106",
        #
        str_detect(xp_mat_group_desc, "^PES FAB")   ~   "101",
        #
        str_detect(xp_mat_group_desc, "OTHER ELASTIC TEXT.")    ~   "107",
        #
        str_detect(xp_mat_group_desc, "TEXTILE NETS")           ~   "201",
        #
        str_detect(xp_mat_group_desc, "TPO CUTTED")             ~   "202",
        #
        str_detect(xp_mat_group_desc, "NW FB W/ ADHES CUT")     ~   "203",
        #
        str_detect(xp_mat_group_desc, "TPO IN ROLL")            ~   "204",
        #

        str_detect(xp_mat_group_desc, "ESPUMA")                 ~   "000",
        #
        str_detect(xp_mat_group_desc, "EPDM FOAM OPEN CELL")    ~   "001",
        #
        str_detect(xp_mat_group_desc, "AGGLOMERATE PUR FOAM")   ~   "002",
        #
        str_detect(xp_mat_group_desc, "PVC FOAM")               ~   "003",
        #
        str_detect(xp_mat_group_desc, "PE FOAM OPEN CELL")      ~   "004",
        #
        str_detect(xp_mat_group_desc, "PUR FOAMS")              ~   "005",
        #
        str_detect(xp_mat_group_desc, "PE FOAM CLOSED CELL")    ~   "006",
        #
        str_detect(xp_mat_group_desc, "PUR GLUE POLYOL")    ~   "101",
        #

        str_detect(xp_mat_group_desc, "POLIESTER")   ~   "100",
        #
        str_detect(xp_mat_group_desc, "PES SOUNDP. W/T ADH.")   ~   "102",
        #
        str_detect(xp_mat_group_desc, "PES SOUNDP. W/ ADH.")   ~   "101",
        #

        str_detect(xp_mat_group_desc, "FELT FB W/T ADHESIVE")   ~   "202",
        #
        str_detect(xp_mat_group_desc, "FELT FB W/ ADHESIVE")   ~   "201",
        #
        str_detect(xp_mat_group_desc, "FELTRO")   ~   "200",
        #
        str_detect(xp_mat_group_desc, "OTHER FELT W/T ADHES")   ~   "207",
        #
        str_detect(xp_mat_group_desc, "SYNTH. FELT W/T ADH.")   ~   "207",
        #
        str_detect(xp_mat_group_desc, "FELT FB W/ ADHESIVE")   ~   "208",

        str_detect(xp_mat_group_desc, "SYNTH. FELT W ADHES.")   ~   "203",
        #
        str_detect(xp_mat_group_desc, "OTHER FELT W/ ADHES.")   ~   "205",
        #
        str_detect(xp_mat_group_desc, "BI-ADHESIVE TAPES")   ~   "206",
        #
        str_detect(xp_mat_group_desc, "TAKA WITH ADHESIVE")   ~   "501",
        #
        str_detect(xp_mat_group_desc, "OTHER SDP W/T ADHES.")   ~   "601",
        #

        str_detect(xp_mat_group_desc, "ELETRIFICADOS")   ~   "000",
        #
        str_detect(xp_mat_group_desc, "ELECTRICAL COMPONENT")   ~   "001",
        #

        str_detect(xp_mat_group_desc, "POLIURETANO")   ~   "000",
        # parte injetada de poliuretano
        str_detect(xp_mat_group_desc, "INJECTED PARTS-PUR")   ~   "001",
        # parte injetada de poliuretano
        str_detect(xp_mat_group_desc, "PAINT INJ PARTS-PUR")   ~   "002",
        #

        str_detect(xp_mat_group_desc, "RUBBER STOP PAD")      ~   "101",
        # BATENTE DE BORRACHA")
        str_detect(xp_mat_group_desc, "RUBBER PROFILE")      ~   "102",
        str_detect(xp_mat_group_desc, "OTHER RUBBER COMPO.")      ~   "104",
        str_detect(xp_mat_group_desc, "SILICONE SHOCK PAD")      ~   "151",

        str_detect(xp_mat_group_desc, "INJECTED PARTS-SUB")   ~   "201",
        str_detect(xp_mat_group_desc, "PAINT INJ PARTS-SUB")   ~   "202",
        str_detect(xp_mat_group_desc, "CHROMATED INJ PARTS")   ~   "203",

        str_detect(xp_mat_group_desc, "CAIXA")   ~   "000",
        str_detect(xp_mat_group_desc, "BOX 2 CORG W/T KRAFT")   ~   "008",
        str_detect(xp_mat_group_desc, "SBOX 2CORG W/T KRAFT")   ~   "009",
        str_detect(xp_mat_group_desc, "SBOX 2CORG W/ KRAFT")   ~   "010",
        str_detect(xp_mat_group_desc, "BOX 2 CORG W/ KRAFT")   ~   "001",
        str_detect(xp_mat_group_desc, "BOX 1 CORG W/T KRAFT")   ~   "002",
        str_detect(xp_mat_group_desc, "PLASTIC BOX RIGID")   ~   "003",
        str_detect(xp_mat_group_desc, "CLIENT PACK REUSABLE")   ~   "004",
        str_detect(xp_mat_group_desc, "BOX 1 CORG W/T KRAFT")   ~   "005",
        str_detect(xp_mat_group_desc, "BOX 1 CORG W/ KRAFT")   ~   "006",
        str_detect(xp_mat_group_desc, "SBOX 1CORG W/T KRAFT")   ~   "007",
        str_detect(xp_mat_group_desc, "BOX 3 CORG W/T KRAFT")   ~   "011",
        str_detect(xp_mat_group_desc, "PLASTIC CONT RIGID")   ~   "012",
        str_detect(xp_mat_group_desc, "METAL CONT FOLDABLE")   ~   "013",
        str_detect(xp_mat_group_desc, "PACKAGING KITS")   ~   "014",
        str_detect(xp_mat_group_desc, "BOXES LABELS")   ~   "015",
        str_detect(xp_mat_group_desc, "PART RETRACT. FILM")   ~   "016",
        str_detect(xp_mat_group_desc, "BI-ADHESIVE TAPES")   ~   "501",

        str_detect(xp_mat_group_desc, "CORRUGATED CARD CUT.")   ~   "101",
        str_detect(xp_mat_group_desc, "OTHER SEPARAT&WEDGES")   ~   "102",
        str_detect(xp_mat_group_desc, "PAPER WEDGE BLOCKS")   ~   "103",
        str_detect(xp_mat_group_desc, "OTHER SEPARAT&WEDGES")   ~   "104",
        str_detect(xp_mat_group_desc, "PLASTIC SEPARATORS")   ~   "105",
        str_detect(xp_mat_group_desc, "PAPER SEPARATORS")   ~   "106",
        str_detect(xp_mat_group_desc, "LABELS-PACKAGES")   ~   "201",
        str_detect(xp_mat_group_desc, "LABELS-PARTS")   ~   "202",
        str_detect(xp_mat_group_desc, "TEXTILE NETS")   ~   "301",
        str_detect(xp_mat_group_desc, "FOAM PE BAGS")   ~   "302",
        str_detect(xp_mat_group_desc, "PART RETRACT. FILM")   ~   "303",
        str_detect(xp_mat_group_desc, "OTHER FELT W/T ADHES")   ~   "304",
        str_detect(xp_mat_group_desc, "PALLET EXTENS. FILM")   ~   "305",
        str_detect(xp_mat_group_desc, "PLAST/CARD CONT FOLD")   ~   "306",

        str_detect(xp_mat_group_desc, "PALETE")   ~   "000",
        str_detect(xp_mat_group_desc, "WOOD PALLETS")   ~   "001",
        str_detect(xp_mat_group_desc, "WOOD PALETTS REUSAB")   ~   "002",
        str_detect(xp_mat_group_desc, "WOOD PALLETS6")   ~   "003",

        str_detect(xp_mat_group_desc, "PLASTIC PALLETS")   ~   "003",

        str_detect(xp_mat_group_desc, "BLISTERS")   ~   "401",
        # BOLHAS

        str_detect(xp_mat_group_desc, "CAIXA METÁLICA")   ~   "500",
        str_detect(xp_mat_group_desc, "METAL CONT RIGID")   ~   "501",

        str_detect(xp_mat_group_desc, "SACOLA PLÁSTICA")   ~   "000",
        str_detect(xp_mat_group_desc, "PLASTIC BAG LDPE")   ~   "001",
        str_detect(xp_mat_group_desc, "PLASTIC BAG HDPE")   ~   "002",
        str_detect(xp_mat_group_desc, "^BUBBLE BAGS")   ~   "003",
        str_detect(xp_mat_group_desc, "PLASTIC BAG LDPE REC")   ~   "004",
        str_detect(xp_mat_group_desc, "FOAM PE BAGS")   ~   "005",

        str_detect(xp_mat_group_desc, "SOLVENTES")   ~   "000",
        str_detect(xp_mat_group_desc, "SOLVENT BASE HARDE.")   ~   "001",
        str_detect(xp_mat_group_desc, "SOLVENT SOFT PAINT")   ~   "002",
        str_detect(xp_mat_group_desc, "SOLVENT DECOR PAINT")   ~   "003",
        str_detect(xp_mat_group_desc, "SOLVENT CLEARC. SFT.")   ~   "004",
        str_detect(xp_mat_group_desc, "SOLVENT SCRATCH COAT")   ~   "004",

        str_detect(xp_mat_group_desc, "PRIMERS")   ~   "000",
        str_detect(xp_mat_group_desc, "SOLVENT ADHES. PRIM.")   ~   "101",
        str_detect(xp_mat_group_desc, "SOLVENT FILLING PRIM")   ~   "102",
        str_detect(xp_mat_group_desc, "SOLVENT ADH. PRIMER")   ~   "103",
        str_detect(xp_mat_group_desc, "SOLVENT EXT ADH PRIM")   ~   "104",

        str_detect(xp_mat_group_desc, "^THINNER")   ~   "201",

        str_detect(xp_mat_group_desc, "WATER BASE HARDENER")   ~   "301",
        str_detect(xp_mat_group_desc, "WATER SOFT PAINT")   ~   "401",
        str_detect(xp_mat_group_desc, "WATER DECOR PAINT")   ~   "402",

        str_detect(xp_mat_group_desc, "CYANOACRYLATES")   ~   "000",

        str_detect(xp_mat_group_desc, "CONSUMABLES IT")   ~   "888",
        str_detect(xp_mat_group_desc, "STATIONERY OFFICE")   ~   "887",
        str_detect(xp_mat_group_desc, "^NON STATIONARY")   ~   "886",
        str_detect(xp_mat_group_desc, "TEC. DOCUMENTATION")   ~   "885",
        TRUE ~   "999"
      )
    ) |>
    mutate(fam_m = ifelse(str_detect(fam_m, "12"), "11", fam_m)) |>
    mutate(fam_m = ifelse(str_detect(fam_m, "41"), ifelse(str_detect(xp_mat_group_desc, "PLASTIC"), "42", fam_m), fam_m)) |>
    mutate(fam_m = ifelse(str_detect(fam_m, "18"), "13", fam_m)) |>
    mutate(fam_m = ifelse(str_detect(fam_m, "19"), ifelse(str_detect(desc, "POM"),"16", fam_m), fam_m)) |>
    mutate(fam_m = ifelse(str_detect(fam_m, "46"), ifelse(str_detect(xp_mat_group_desc, "RUBBER"),"49", fam_m), fam_m)) |>
    mutate(fam_m = ifelse(str_detect(fam_m, "48"), ifelse(!str_detect(xp_mat_group_desc, "ELECTRIC"), "49", fam_m), fam_m)) |>
    mutate(fam_m = ifelse(str_detect(fam_m, "61"), "62", fam_m)) |>
    mutate(family = str_c(grupo_estoque, fam_m, family))
}

