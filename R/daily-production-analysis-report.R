
# Read - Daily Production Analysis Report

get_company_branch <- function(filename, file_sheet) {

  report <-
    readxl::read_excel(filename_report,
                       sheet = file_sheet,
                       range = anchored("D3", dim = c(1, 1)),
                       col_names = FALSE)
  branch <- ifelse(report[[1,1]] == "7", "SPI", ifelse(report[[1,1]] == "8", "SPB", NA))
}

read_report <- function(filename_report) {

  report <-
    readxl::read_excel(filename_report,
                     sheet = "S1",
                     skip = 8) |>
    janitor::clean_names()

  report <-
    report |>
    dplyr::select(gap:part) |>
    tidyr::fill(gap, shift, machine, pers_no, mould, order_no, part) |>
    dplyr::filter(!str_detect(mould, "^Sum")) |>
    tidyr:: separate(col = "machine",
                     into = c("posto", "workspace"),
                     sep = " - ") |>
    tidyr:: separate(col = "part",
                     into = c("item", "description"),
                     sep = " - ") |>
    mutate(branch = get_company_branch(filename_report, "S1")) |>
    select(branch, shift, posto, workspace, mould, item, description)
}


