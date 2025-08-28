# read ITENS from Excel
#
# Ajusta a família
#
# caso seja item F copia o código do cliente no campo customers_part_no

read_itens <- function(filename_itens) {

    #filename_itens <- here("data", "Artigos 2025-07-08.xlsx")
    itens <-
      readxl::read_excel(filename_itens) |>
      janitor::clean_names() |>
      mutate(estabelecimento = ifelse(empresa == "SPB", "103", "102")) |>
      mutate(tebez1 = ifelse(is.na(tebez1), " ", stringr::str_squish(tebez1)),
             tebez2 = ifelse(is.na(tebez2), " ", stringr::str_squish(tebez2)),
             desc = stringr::str_c(tebez1, " ", tebez2) |>
               stringr::str_squish(),
             desc2 = stringr::str_squish(tebez2)) |>
    mutate(
      familia = case_when(
        stringr::str_detect(temagr, "I1100")                ~ "3041002",
        stringr::str_detect(temagr, "I1300")                ~ "3041001",
        stringr::str_detect(temagr, "I1830")                ~ "3041003",
        stringr::str_detect(temagr, "I1820")                ~ "3041003",
        stringr::str_detect(temagr, "I1700")                ~ "3041003",
        stringr::str_detect(temagr, "I1630")                ~ "3041002",
        stringr::str_detect(temagr, "I1610")                ~ "3041002",
        stringr::str_detect(temagr, "I1600")                ~ "3041002",
        stringr::str_detect(temagr, "I1420")                ~ "3041003",
        stringr::str_detect(temagr, "I1400")                ~ "3041003",
        stringr::str_detect(temagr, "I1300")                ~ "3041003",
        stringr::str_detect(temagr, "I1230")                ~ "3041003",
        stringr::str_detect(temagr, "I1300")                ~ "3041003",
        stringr::str_detect(temagr, "I1220")                ~ "3041003",
        stringr::str_detect(temagr, "K5000")                ~ "3041003",
        stringr::str_detect(temagr, "K4000")                ~ "3041003",
        stringr::str_detect(temagr, "K3000")                ~ "3041003",
        stringr::str_detect(temagr, "K0200")                ~ "3041003",
        stringr::str_detect(mat_group_desc, "^PP T")    ~ "3011001",
        stringr::str_detect(mat_group_desc, "^PP COPO") ~ "3011002",
        stringr::str_detect(mat_group_desc, "^PP GF")   ~ "3011003",
        stringr::str_detect(mat_group_desc, "^PP HC")   ~ "3011004",
        stringr::str_detect(mat_group_desc, "^PP COPO REC") ~ "3011999",
        stringr::str_detect(mat_group_desc, "^PP")      ~ "3011000",
        stringr::str_detect(mat_group_desc, "^ABS-PC")  ~ "3013001",
        stringr::str_detect(mat_group_desc, "^ABS")     ~ "3013000",
        stringr::str_detect(mat_group_desc, "^ASA-PC")  ~ "3014001",
        stringr::str_detect(mat_group_desc, "^ASA")     ~ "3014000",
        stringr::str_detect(mat_group_desc, "^PA6.6")   ~ "3017002",
        stringr::str_detect(mat_group_desc, "^PA6 GF")  ~ "3017003",
        stringr::str_detect(mat_group_desc, "^PA6")     ~ "3017001",
        stringr::str_detect(mat_group_desc, "^PA")      ~ "3017000",
        stringr::str_detect(mat_group_desc, "^PC")      ~ "3018000",
        stringr::str_detect(mat_group_desc, "^TPE")     ~ "3019000",
        stringr::str_detect(mat_group_desc, "^POM")     ~ "3019200",
        stringr::str_detect(mat_group_desc, "^PS")      ~ "3020000",
        stringr::str_detect(mat_group_desc, "^PLASTIC CLIP")      ~ "3026000",
        stringr::str_detect(mat_group_desc, "^PVC")     ~ "3045200",
        stringr::str_detect(mat_group_desc, "^PES")     ~ "3045000",
        stringr::str_detect(mat_group_desc, "^MASTER ABS-PC") ~ "3032002",
        stringr::str_detect(mat_group_desc, "^MASTER ABS")    ~ "3032001",
        stringr::str_detect(mat_group_desc, "^MASTER TPE")    ~ "3032008",
        stringr::str_detect(mat_group_desc, "^MASTER PP")     ~ "3032009",
        stringr::str_detect(mat_group_desc, "^MASTER PE")     ~ "3032010",
        stringr::str_detect(mat_group_desc, "^MASTER")        ~ "3032000",
        stringr::str_detect(mat_group_desc, "^METALLIC CLIPS")    ~ "3041002",
        stringr::str_detect(mat_group_desc, "^METALLIC RIVETS")   ~ "3041001",
        stringr::str_detect(mat_group_desc, "METALLIC")     ~ "3041000",
        stringr::str_detect(mat_group_desc, "^ESPUMA")      ~ "3047000",
        stringr::str_detect(mat_group_desc, "^ELECTRICAL ") ~ "3048000",
        stringr::str_detect(tetenr, "^F01223") ~ "10VW243",
        stringr::str_detect(tetenr, "^I01223") ~ "20VW243",
        TRUE ~ "9999999"
      )
    ) |>
    mutate(un = case_when(
      unit_measure == "PCs" ~ "PC",
      unit_measure == "Unit" ~ "UN",
      TRUE ~ unit_measure)) |>
    mutate(
      grupo_estoque = case_when(
        tipo_de_materiais == "Raw materials" ~ "30",
        tipo_de_materiais == "Packaging" ~ "80",
        tipo_de_materiais == "Returnable packaging" ~ "80",
        tipo_de_materiais == "Semifinished Product" ~ "20",
        tipo_de_materiais == "Finished Product" ~ "10",
        tipo_de_materiais == "Services" ~ "90",
        TRUE ~ "90"
      )
    )
}

