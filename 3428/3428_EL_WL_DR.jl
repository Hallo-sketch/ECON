using DataFrames, CSV, StatsKit, Gadfly, LaTeXStrings, Compose, CausalityTools, Entropies

#Data Frames
df2 = CSV.read("/Users/liammartin/ECON/3428/Data/EL_IR_MW.csv", DataFrame)

deleteat!(df2,164)

df2[!,:CE16OV_PC1]=parse.(Float64, df2[!,:CE16OV_PC1])
df2[!,:LES1252881600Q_PC1]=parse.(Float64, df2[!,:LES1252881600Q_PC1])
df2[!,:REAINTRATREARAT1YE]=parse.(Float64, df2[!,:REAINTRATREARAT1YE])

df3 = CSV.read("/Users/liammartin/ECON/3428/Data/m_IR_EL.csv", DataFrame)

#Figure 4
rename!(df2,[:DATE,:Nl,:MWW,:i])


yticks = collect(-15:5:15)
p2 =plot(df2, x=:DATE, y=Col.value(:Nl,:MWW,:i), 
    color=Col.index(:Nl,:MWW,:i), Geom.line,  
    Guide.colorkey(title="Metric", labels=["d/dt Nl", "d/dt Adj. MWW", "i(t)"]),
    Guide.xlabel("Year"), Guide.ylabel("Percent, Percent Change"),
    Coord.cartesian(xmin=Date(1982-01-01), xmax=Date(2023-01-01), ymin=-15, ymax=15),
    Guide.yticks(ticks=yticks), Guide.xticks(ticks=DateTime("1980-01-01"):Year(10):DateTime("2020-01-01")))

#p2 |> SVG("Nl_MWW_i.svg", 12cm, 10cm,)

ans1 = jdd(df2.i, df2.Nl, B=20)
ans2 = jdd(df2.i, df2.MWW, B=20)
println([mean(ans1),mean(ans2)])

using Entropies
conditional_mutualinfo(df2.Nl,df2.MWW,df2.i, 30; base = 2, q = 1)