using Pkg

Pkg.add("Plots")
Pkg.add("DataFrames")
Pkg.add("CSV")
Pkg.add("StatsPlots")

using Plots, DataFrames, CSV, StatsPlots

p = "//Users//liammartin//ECON//3428//Data//CORESTICKM159SFRBATL.csv"
df1 = DataFrame(CSV.File(p))
print(df1)

