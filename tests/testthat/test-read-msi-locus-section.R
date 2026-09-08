test_that("read_clc_msi_locus_section finds table", {

  df <- read_msi_locus_section("test_data/clc_msi_report_14_loci.xlsx")

  expect_true(all(dim(df) == c(452, 3)))

})

test_that("errors when section title is incorrect", {

  expect_error(read_msi_locus_section(filepath = "test_data/clc_msi_report_14_loci.xlsx",
                                      locus_section_title = "wrong title"),
               regexp = "No match for locus section title")

})

test_that("results file with only 1 locus is read correctly", {

  df_1_locus <- read_msi_locus_section("test_data/clc_msi_report_1_locus.xlsx")

  expect_true(all(dim(df) == c(16, 3)))

})

test_that("results file with 27 loci is read correctly", {

  df_27_locus <- read_msi_locus_section("test_data/clc_msi_report_27_loci.xlsx")

  expect_true(all(dim(df) == c(903, 3)))

})
