# Replicate the folder structure of a given directory

Replicate the folder structure of a given directory

## Usage

``` r
folder_structure_replicate(dir, to)
```

## Arguments

- dir:

  Character 1L. Path of directory which structure will be replicated

- to:

  Character 1L. Path of an output directory in which replicated
  structured will be placed

## Value

See directory indicated in `to` arg.

## Examples

``` r
library(magrittr)

temp_dir_to_replicate <- tempfile()
dir.create(temp_dir_to_replicate)

dir.create(file.path(temp_dir_to_replicate, "dir1"))
dir.create(file.path(temp_dir_to_replicate, "dir2"))

temp_dir_out <- tempfile()
dir.create(temp_dir_out)

folder_structure_replicate(
  dir = temp_dir_to_replicate, 
  to = temp_dir_out)

unlink(temp_dir_to_replicate)
unlink(temp_dir_out)
```
