using DataFrames, CSV, Statskit, Plots, StatsPlots

imp = "Data/PCEPILFE-CPI-LES.csv"
df1 = DataFrame(CSV.File(imp))
