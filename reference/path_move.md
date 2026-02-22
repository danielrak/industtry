# Move through paths

Move through paths

## Usage

``` r
path_move(path_vector, path_separator = "/", move)
```

## Arguments

- path_vector:

  Character. Vector of paths with equal number of levels

- path_separator:

  Character 1L. Path separator (adapted to your OS for instance)

- move:

  Integer 1L. If move \> 0, outputs path till specified level in move.
  If move \< 0, remove the last specified level(s) in move.

## Value

Character. Transformed vector of paths.

## Examples

``` r
pvector <- c(
  "level_1/level_2/level_3/file_1.ext", 
  "level_1/level_2/level_3/file_2.ext"
)

path_move(path_vector = pvector, 
          path_separator = "/", 
          move = 1)
#> [1] "level_1" "level_1"

path_move(path_vector = pvector, 
          path_separator = "/", 
          move = 2)
#> [1] "level_1/level_2" "level_1/level_2"

path_move(path_vector = pvector, 
          path_separator = "/", 
          move = - 1)
#> [1] "level_1/level_2/level_3" "level_1/level_2/level_3"

path_move(path_vector = pvector, 
          path_separator = "/", 
          move = - 2)
#> [1] "level_1/level_2" "level_1/level_2"
```
