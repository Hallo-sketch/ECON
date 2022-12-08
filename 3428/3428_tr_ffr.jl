using DataFrames, CSV, StatsKit, Gadfly, LaTeXStrings, Compose, CausalityTools, Entropies, DataFramesMeta, FredData

df1 = CSV.read("/Users/liammartin/ECON/3428/Data/DFF_NFF.csv", DataFrame)
rename!(df1, [:DATE, :DFF, :NFF])


p6 = plot(stack(df1, [:DFF, :NFF]), x=:DATE, y=:value, Geom.line, color=:variable,
    Guide.colorkey(title="Metric", labels=["FEDFUNDS", "Taylor Rule"]),
    Guide.xlabel("Year"), Guide.ylabel("Percentage"),
    Coord.cartesian(xmin = DateTime("1998-01-01"), xmax = Date("2022-07-01"), ymax=16),
    Guide.xticks(ticks=DateTime("2000-01-01"):Year(4):DateTime("2024-07-01")),
    Guide.yticks(ticks=-5:5:15))

p6 |> SVG("3428/Exports/fig6.svg", 13cm,13cm)

df2 = @chain df1 begin
    @rsubset :DATE >= Date(2000-01-01)
    @select(:DFF, :NFF)
end

ans1 = L2dist(df2.DFF,df2.NFF)
ans2 = cor(df2.DFF,df2.NFF)
describe(df2)