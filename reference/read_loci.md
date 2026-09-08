# Read MSI locus tables from CLC reports in tidy format

`read_loci` reads in the locus genotype tables from a CLC MSI report and
converts them into a tidy format for easier data analysis.

## Usage

``` r
read_loci(filepath)
```

## Arguments

- filepath:

  The filepath to the CLC MSI report Excel

## Value

A dataframe of locus information in tidy format.

## Initial data format

MSI reports exported from CLC contain information on the genotype of
each tested locus, however the data structure is difficult to work with.

- The name of the locus marker is on one row

- The stability of the marker ("Stable" or "Unstable") is on the next
  row

- Then there is a genotype table including the repeat lengths of the
  locus and the percentage of reads in the sample and baseline
  associated with each length.

- There is a gap of two rows before the same information for the next
  marker, which may have different repeat lengths associated with it.

## What `read_loci` does

`read_loci` rearranges the initial format using 3 helper functions.

- `read_msi_locus_section`: first, the section of the Excel sheet
  containing the locus tables is read in as a single table.

- `mutate_msi_row_numbers`: the numbers of each row are annotated.

- `join_msi_locus_tables`: the three pieces of information for each
  marker (the name, stability and repeat table) are joined together
  based on their row numbers with : the marker name will be 2 rows above
  the repeat table, and the marker stability will be 1 row above.

## Output data format

This produces a dataframe which includes the information in the repeat
marker table, with the marker name and stability as additional columns.

## Usage

`read-loci` can be combined with `purr::map` and
[`purrr::list_rbind`](https://purrr.tidyverse.org/reference/list_c.html)
to combine marker tables from multiple CLC MSI reports.
