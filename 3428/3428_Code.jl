using Pkg

Pkg.add("Plots")
Pkg.add("DataFrames")
Pkg.add("CSV")
Pkg.add("StatsPlots")
Pkg.add("StatsKit")

using Plots, DataFrames, CSV, StatsPlots

p = "//Users//liammartin//ECON//3428//Data//CORESTICKM159SFRBATL.csv"
df1 = DataFrame(CSV.File(p))
print(df1)


plot(df1.DATE, df1.CORESTICKM159SFRBATL, labels=["CORESTICKM159SFRBATL"], legend=:topleft)

p1 = "//Users//liammartin//ECON//3428//Data//fredgraph.csv"
df2 = DataFrame(CSV.File(p1))
print(df2)
using StatsKit
print(Matrix(df2[!, Not(:DATE)]))
MultinomialLRTest(Matrix(df2[]))

