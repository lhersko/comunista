# comunista
This cleans up accents from municipality names of Chile and gets them in proper format

The comunista package contains two functions: clean_comunas() and code_comunas().

To install the package using library(pacman) simply use:
```
p_load_gh("lhersko/comunista")
```

To install it using library(devtools), use:
```
install_github("lhersko/comunista")
```

To use the clean_comunas() function first specify your data frame name and then the variable that contains municipality names in quotations. For example:
```
clean_comunas(your_data_frame, "municipality_variable")
```

To use the code_comunas() function first specify your data frame name and then the variable that contains municipality names in quotations. For example:

```
code_comunas(your_data_frame, "municipality_variable")
```
It is strongly suggested that you run clean_comunas() on your data before running code_comunas().
