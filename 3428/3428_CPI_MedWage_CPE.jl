using DataFrames, CSV, StatsKit, Plots, StatsPlots, PlotThemes
imp = "/Users/liammartin/ECON/3428/Data/PCEPILFE-CPI-LES.csv"
df1 = DataFrame(CSV.File(imp))

deleteat!(df1, 264)
deleteat!(df1, 1:88)

df1[!,:CPILFESL_NBD20120101]=parse.(Float64, df1[!,:CPILFESL_NBD20120101])
df1[!,:LES1252881600Q_NBD20120101]=parse.(Float64, df1[!,:LES1252881600Q_NBD20120101])
df1[!,:PCEPILFE]=parse.(Float64, df1[!,:PCEPILFE])

plotlyjs()
@df df1 plot(cols(1), cols(2:4),
    labels = ["PCE" "CPI" "Adj. Med. Wage Weekly"],
    legend=:bottomright,
    xaxis = ("Quarter Start Dates",),
    yaxis = ("Index 2012 = 100", 20:10:140),
    grid = false)
