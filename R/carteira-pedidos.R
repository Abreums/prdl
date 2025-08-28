# carteira pedidos

read_order_date <- function(order_filename) {
  # test:
  # order_filename <- here::here("./data/pedidos-em-carteira", "Pedidos em carteira - SPI - 2025-08-04.xls")

  S1 <- "S1"
  S2 <- "S2"

  order_date <-
    readxl::read_excel(
      order_filename,
      sheet = S1,
      range = "B2:B2",
      col_names = FALSE
    )

  order_date <-
    str_extract(order_date[1][1], "\\d{1,2}.\\d{2}.\\d{4}.*") |>
    str_replace_all("[[:punct:]]", "-") |>  str_sub(1L, 10L) |>
    as.Date(format = "%d-%m-%Y")
}

read_item <- function(file_ped_cart) {
  # test:
  # file_ped_cart <- here::here("./data/pedidos-em-carteira", "Pedidos em carteira - SPI - 2025-08-04.xls")

  order_date <- read_order_date(file_ped_cart)

  order_sheets <-
    readxl::excel_sheets(file_ped_cart)
  order_sheets <- order_sheets[-1]


  orders <-
    map(order_sheets,
        ~ readxl::read_excel(file_ped_cart, sheet = .x, skip = 7) |>
          janitor::clean_names()) |>
    reduce(rbind)

  orders <-
    orders |>
    select(
      customer_number,
      customer,
      doca_code = shipping_address_5,
      doca_desc = shipping_address_6,
      customers_part_no,
      item = part_8,
      desc = part_9
    ) |>
    mutate(order_date = order_date)
}


get_order_history <- function() {

  files_list <-
    list.files(path = "./data/pedidos-em-carteira",
               pattern = "^Pedidos em carteira",
               full.names = TRUE)

  df <-
    files_list |>
    map(read_item) |>
    reduce(bind_rows)
}
