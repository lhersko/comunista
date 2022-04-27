
<!-- README.md is generated from README.Rmd. Please edit that file -->

# comunista

<!-- badges: start -->
<!-- badges: end -->

The goal of comunista is to clean up accents from municipality names of
Chile and gets them in proper format to make joining datasets by
municipality easier.

## Installation

You can install the development version of comunista from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("lhersko/comunista")
```

If you use pacman, you can install it using:

    # install.packages("pacman")
    # library(pacman)
    p_load_gh("lhersko/comunista")

## Example

To use the clean\_comunas() function first specify your data frame name
and then the variable that contains municipality names in quotations.
For example:

``` r
library(comunista)
df <- data.frame(comunas=c("ñuñoa", "Peñalolén", "PEñaflor", "Las condes"))
clean_comunas(df, "comunas")
#>      comunas
#> 1      Nunoa
#> 2  Penalolen
#> 3   Penaflor
#> 4 Las Condes
```

To use the code\_comunas() function first specify your data frame name
and then the variable that contains municipality names in quotations.
For example:

``` r
library(comunista)
df <- data.frame(comunas=c("ñuñoa", "Peñalolén", "PEñaflor", "Las condes"))
df_clean <- clean_comunas(df, "comunas")
code_comunas(df_clean, "comunas")
#>      comunas cod_comuna
#> 1 Las Condes      13114
#> 2      Nunoa      13120
#> 3   Penaflor      13605
#> 4  Penalolen      13122
```

It is strongly suggested that you run clean\_comunas() on your data
before running code\_comunas().
