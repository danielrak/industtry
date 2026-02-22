
# industtry

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/danielrak/industtry/branch/master/graph/badge.svg)](https://app.codecov.io/gh/danielrak/industtry?branch=master)
[![R-CMD-check](https://github.com/danielrak/industtry/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/danielrak/industtry/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

`industtry` is a toolkit for **industrial-style exploitation of
structured datasets** (primarily data frames), with an emphasis on
**set-level operations**: applying the *same* procedure to *many* inputs
as long as they share an identified structure.

A large part of the package is built around two pragmatic ideas:

1.  **“Collections first”**: many workflows fail to scale because they
    are designed for a single dataset; `industtry` pushes common tasks
    to the *collection* level (importing, inspecting, detecting schema
    differences, batch conversion, etc.).  
2.  **“Operational tooling”**: lightweight helpers for day-to-day work
    (paths, duplicates, joins checks, string replacements, etc.) that
    tend to recur in production data pipelines.

> Some features integrate tightly with **RStudio** (background jobs /
> interactive workflows). Those parts degrade gracefully when RStudio is
> not available (examples are marked accordingly).

------------------------------------------------------------------------

## Installation

You can install the development version from GitHub:

``` r
# install.packages("devtools")
devtools::install_github("danielrak/industtry")
```

------------------------------------------------------------------------

## API map (what the package covers)

The exported surface is intentionally broad; the table below is a
*functional map* of the main user-facing tools.

``` r
library(industtry)
api_map <- tibble::tribble(
  ~ "Area",
  ~ "Main intent",
  ~ "Key functions",
  "Import collections",
  "Load multiple datasets into the Global Environment (serialized or parallelized).",
  "serial_import(), parallel_import()",
  "Batch conversion / renaming",
  "Operate through Excel masks to convert file formats or rename files at scale.",
  "mask_convert_r(), convert_r(), mask_rename_r(), rename_r()",
  "Inspection & profiling",
  "Inspect one dataset or a whole folder of datasets; export diagnostics to Excel.",
  "inspect(), inspect_write(), inspect_vars()",
  "Schema detection / consistency",
  "Detect variables across datasets and compare classes/structures.",
  "vars_detect*(), vars_compclasses*(), chars_structure*(), detect_chars_structure*()",
  "Data hygiene helpers",
  "Duplicate diagnostics, join checks, proportions, etc.",
  "dupl_show(), dupl_sources(), ljoin_checks(), table_prop()",
  "Paths & filesystem",
  "Replicate folder structures / move files.",
  "folder_structure_replicate(), path_move()",
  "Utilities",
  "String replacement, global assignment, script location, etc.",
  "replace_multiple(), assign_to_global(), current_script_location()"
)

knitr::kable(api_map)
```

| Area | Main intent | Key functions |
|:---|:---|:---|
| Import collections | Load multiple datasets into the Global Environment (serialized or parallelized). | serial_import(), parallel_import() |
| Batch conversion / renaming | Operate through Excel masks to convert file formats or rename files at scale. | mask_convert_r(), convert_r(), mask_rename_r(), rename_r() |
| Inspection & profiling | Inspect one dataset or a whole folder of datasets; export diagnostics to Excel. | inspect(), inspect_write(), inspect_vars() |
| Schema detection / consistency | Detect variables across datasets and compare classes/structures. | vars_detect*(), vars_compclasses*(), chars_structure*(), detect_chars_structure*() |
| Data hygiene helpers | Duplicate diagnostics, join checks, proportions, etc. | dupl_show(), dupl_sources(), ljoin_checks(), table_prop() |
| Paths & filesystem | Replicate folder structures / move files. | folder_structure_replicate(), path_move() |
| Utilities | String replacement, global assignment, script location, etc. | replace_multiple(), assign_to_global(), current_script_location() |

------------------------------------------------------------------------

## Core workflow 1 — import datasets as a collection

A lot of analysis pipelines begin with import. When you have **many**
datasets, importing them “one by one” (and keeping names consistent)
becomes error-prone.

`industtry` provides:

- `serial_import()` to import a set of datasets *sequentially*.  
- `parallel_import()` to import a set of datasets *in parallel* (RStudio
  only).

``` r
library(industtry)

yourdir <- system.file("permadir_examples_and_tests/importations", package = "industtry")

lfiles <- list.files(yourdir, full.names = TRUE) %>%
  purrr::keep(stringr::str_detect(., "\\.rds$"))

lfiles
```

### Sequential import

``` r
rm(list = ls())     # clean example workspace
serial_import(lfiles)

ls()
```

### Parallel import (RStudio)

`{r, eval = FALSE} # RStudio only: parallel_import(lfiles)`

------------------------------------------------------------------------

## Core workflow 2 — inspect datasets (single + collection)

When datasets come from heterogeneous sources (different producers,
different time windows, different exports), a fast “schema + variable”
diagnostic helps you converge quickly.

### Inspect one data frame to Excel

``` r
# built-in dataset as a simple example
data(cars)

out_dir <- tempdir()
inspect_write(
  data_frame_name = "cars",
  output_path = out_dir,
  output_label = "cars"
)

list.files(out_dir)
```

### Inspect a whole folder of datasets to Excel

``` r
mydir <- file.path(tempdir(), "inspect_vars_readme_example")
dir.create(mydir, showWarnings = FALSE)

saveRDS(cars, file.path(mydir, "cars1.rds"))
saveRDS(mtcars, file.path(mydir, "cars2.rds"))

inspect_vars(
  input_path = mydir,
  output_path = mydir,
  output_label = "cardata",
  considered_extensions = "rds"
)

list.files(mydir)
```

------------------------------------------------------------------------

## Core workflow 3 — industrialized conversion (mask-driven)

`convert_r()` is designed for **batch conversion of dataset file
formats** using an Excel mask: a deterministic, auditable interface to
define *what to convert* and *how to name outputs*.

High-level pattern:

1.  Create a mask with `mask_convert_r()`.  
2.  Fill the mask columns.  
3.  Run `convert_r(mask_filepath, output_path)` (RStudio only).

``` r
mydir <- system.file("permadir_examples_and_tests/convert_r", package =
                "industtry")

mask_convert_r(output_path = mydir) 

convert_r(mask_filepath =
            file.path(mydir, "mask_convert_r.xlsx"),
          output_path = mydir)
```

------------------------------------------------------------------------

## Core workflow 4 — industrialized file renaming (mask-driven)

Similarly, `rename_r()` performs **batch renaming** based on an Excel
mask created by `mask_rename_r()`.

``` r
mydir <- tempfile()
dir.create(mydir)

saveRDS(cars, file.path(mydir, "cars.rds"))
saveRDS(mtcars, file.path(mydir, "mtcars.rds"))

mask_rename_r(input_path = mydir)

list.files(mydir)
```

    ## [1] "cars.rds"           "mask_rename_r.xlsx" "mtcars.rds"

``` r
rename_r(mask_filepath = file.path(mydir, "mask_rename_r.xlsx"))
```

    ## Warning in file.rename(file.path(dirname(mask_filepath), x[["file"]]),
    ## file.path(dirname(mask_filepath), : impossible de renommer le fichier
    ## ‘C:/Users/rheri/AppData/Local/Temp/Rtmpqq1K44/file1264ab73327/NA' en
    ## ‘C:/Users/rheri/AppData/Local/Temp/Rtmpqq1K44/file1264ab73327/NA', à cause de
    ## 'Le fichier spécifié est introuvable'
    ## Warning in file.rename(file.path(dirname(mask_filepath), x[["file"]]),
    ## file.path(dirname(mask_filepath), : impossible de renommer le fichier
    ## ‘C:/Users/rheri/AppData/Local/Temp/Rtmpqq1K44/file1264ab73327/NA' en
    ## ‘C:/Users/rheri/AppData/Local/Temp/Rtmpqq1K44/file1264ab73327/NA', à cause de
    ## 'Le fichier spécifié est introuvable'

    ## $`NA`
    ## [1] FALSE
    ## 
    ## $`NA`
    ## [1] FALSE
