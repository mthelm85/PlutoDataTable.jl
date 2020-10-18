# PlutoDataTable

Display interactive data tables in your Pluto notebooks.


```julia
data_table(table; items_per_page = 10)
```

Display `table` as an interactive data table. `table` is any tabular data structure supporting the Tables.jl interface. The
`items_per_page` keyword argument determines the number of rows to display at one time (default is 10).