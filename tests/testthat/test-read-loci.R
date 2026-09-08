test_that("read_loci creates dataframe of correct size with 1 locus", {

  df_1_locus <- read_loci("test_data/clc_msi_report_1_locus.xlsx")

  # 11 marker lengths for 1 marker in Excel
  expect_true(all(dim(df_1_locus) == c(11, 5)))

})

test_that("read_loci creates dataframes of appropriate size with 14 loci", {

  df_14_loci <- read_loci("test_data/clc_msi_report_14_loci.xlsx")

  # 11+10+14+49+49+9+16+8+24+43+31+37+33+35 = 369 marker
  # lengths for 14 markers in Excel
  expect_true(all(dim(df_14_loci) == c(369, 5)))

})

test_that("read_loci creates dataframe of appropriate size with 27 loci", {

  df_27_loci <- read_loci("test_data/clc_msi_report_27_loci.xlsx")

  excel_rows <- c(1, 11,8,47,10,61,14,49,37,43,49,31,11,35,9,1,12,8,24,37,41,35,31,37,41,33,35)

  # 751 markers lengths for 27 markers in Excel
  expect_true(all(dim(df_27_loci)==c(sum(excel_rows), 5)))

})

test_that("loci without reads are correctly formatted", {

  df_27_loci <- read_loci("test_data/clc_msi_report_27_loci.xlsx")

  df_missing <- df_27_loci |>
    dplyr::filter(locus %in% c("BAT40(T)37", "D13S153(CA)32"))

  expect_equal(df_missing$stability, c("No matching reads at this locus",
                                      "No matching reads at this locus"))

})

test_that("read_loci can be used to collate files with different locus counts", {

  excel_filepaths <- list.files(path = "test_data/",
                                pattern = "^clc_msi_report_\\d{1,2}_(loci|locus).xlsx$",
                                full.names = TRUE)

  collated_data <- excel_filepaths |>
    purrr::map(\(excel_filepaths) read_loci(excel_filepaths)) |>
    rlang::set_names(excel_filepaths) |>
    purrr::list_rbind(names_to = "filepath")

  expect_true(all(dim(collated_data)==c(11+369+751, 6)))

})
