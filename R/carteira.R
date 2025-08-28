# carteira pedidos

read_file_date <- function(file_ped_cart) {
  ped_cart_date <-
    readxl::read_excel(
      file_ped_cart,
      sheet = "S1",
      range = "B2:B2",
      col_names = FALSE
    )

  ped_cart_date <-
    str_extract(ped_cart_date[1][1], "\\d{1,2}.\\d{2}.\\d{4}.*") |>
    str_replace_all("[[:punct:]]", "-") |>  str_sub(1L, 10L) |>
    as.Date(format = "%d-%m-%Y")
}

read_item <- function(file_ped_cart) {
  # test:
  # file_ped_cart <- here::here("data/pedidos-em-carteira", "Pedidos em carteira.xls")

  file_date <- read_file_date(file_ped_cart)

  ped_cart_s1 <-
    readxl::read_excel(file_ped_cart, sheet = "S1", skip = 7) |>
    janitor::clean_names()

  ped_cart_s2 <-
    readxl::read_excel(file_ped_cart, sheet = "S2", skip = 7) |>
    janitor::clean_names()

  ped_cart <- ped_cart_s1 |> rbind(ped_cart_s2)

  ped_cart <-
    ped_cart |>
    select(
      customer_number,
      customer,
      shipping_address_5,
      shipping_address_6,
      customers_part_no,
      part_8,
      part_9
    ) |>
    group_by(id = part_8) |>
    summarise(
      desc = first(part_9),
      customer_number = first(customer_number),
      customer = first(customer),
      doca_code = first(shipping_address_5),
      doca_desc = first(shipping_address_6),
      customers_part_no = first(customers_part_no)
    ) |>
    ungroup() |>
    filter(str_detect(id, "^F")) |>
    mutate(file_date = file_date)
}


get_carteira_pedidos <- function() {

  files_list <-
    list.files(path = "./data/pedidos-em-carteira",
               pattern = "^Pedidos em carteira(.)*.xls",
               full.names = TRUE)

  df <-
    files_list |>
    map(read_item) |>
    reduce(bind_rows)

  carteira <-
    df |>
    select(id,
           # desc_carteira = desc,
           #file_date, customer_number, customer, doca_code, doca_desc,
           customers_part_no) |>
    # arrange(file_date) |>
    # group_by(item, desc, customer_number, customer) |>
    # summarise(last_edi = last(file_date),
    #           doca_code = first(doca_code),
    #           doca_desc = first(doca_desc)) |>
    # ungroup() |>
    # arrange(last_edi)
    count(id, customers_part_no) |>
    select(-n)
}
