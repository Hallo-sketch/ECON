using DataFrames, CSV, StatsKit, Gadfly, LaTeXStrings, Compose, CausalityTools, Entropies, DataFramesMeta

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

#p2 |> SVG("3428/Exports/Nl_MWW_i.svg", 12cm, 10cm,)

ans1 = jdd(df2.i, df2.Nl, B=30)
ans2 = jdd(df2.i, df2.MWW, B=30)
println([mean(ans1),mean(ans2)])

conditional_mutualinfo(df2.Nl,df2.MWW,df2.i, 30; base = 2, q = 1)

#Figure 5
rename!(df3,[:D, :Nl, :i])
p3 = plot(df3, x=:D, y=Col.value(:Nl, :i), color=Col.index(:Nl, :i), Geom.line,
    Guide.xlabel("Year"), Guide.ylabel("Percent, Percent Change"),
    Guide.colorkey(title="Metric", labels=["d/dt Nl", "i(t)"]),
    Coord.cartesian(xmin=Date(2000-01-01), xmax=Date(2023-01-01), ymin=-15, ymax=15),
    Guide.yticks(ticks=yticks), Guide.xticks(ticks=DateTime("2000-01-01"):Year(4):DateTime("2022-01-01")))

p3 |> SVG("3428/Exports/Nl_i.svg", 12cm,10cm)

p4 = plot(df2, x=:DATE, y=Col.value(:MWW, :i), color=Col.index(:MWW, :i), Geom.line,
Guide.xlabel("Year"), Guide.ylabel("Percent, Percent Change"),
Guide.colorkey(title="Metric", labels=["d/dt MWW", "i(t)"]),
Coord.cartesian(xmin=Date(2000-01-01), xmax=Date(2023-01-01), ymin=-15, ymax=15),
Guide.yticks(ticks=yticks), Guide.xticks(ticks=DateTime("2000-01-01"):Year(4):DateTime("2022-01-01")))

p2a =plot(df2, x=:DATE, y=Col.value(:Nl,:MWW,:i), 
    color=Col.index(:Nl,:MWW,:i), Geom.line,  
    Guide.colorkey(title="Metric", labels=["d/dt Nl", "d/dt Adj. MWW", "i(t)"]),
   # Guide.xlabel("Year"), Guide.ylabel("Percent, Percent Change", orientation=:vertical),
    Coord.cartesian(xmin=Date(2000-01-01), xmax=Date(2022-01-01), ymin=-15, ymax=15),
    Guide.yticks(ticks=yticks), Guide.xticks(ticks=DateTime("2000-01-01"):Year(4):DateTime("2022-01-01"))
)

p5 = vstack(hstack(p3,p4),p2a)
p5 |> SVG("3428/Exports/fig5.svg", 13cm,20cm)

