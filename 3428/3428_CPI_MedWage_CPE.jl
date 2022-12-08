using DataFrames, CSV, StatsKit, Gadfly, LaTeXStrings, Compose, CausalityTools
imp = "/Users/liammartin/ECON/3428/Data/PCEPILFE-CPI-LES.csv"
df1 = DataFrame(CSV.File(imp))

deleteat!(df1, 264)
deleteat!(df1, 1:88)

df1[!,:CPILFESL_NBD20120101]=parse.(Float64, df1[!,:CPILFESL_NBD20120101])
df1[!,:LES1252881600Q_NBD20120101]=parse.(Float64, df1[!,:LES1252881600Q_NBD20120101])
df1[!,:PCEPILFE]=parse.(Float64, df1[!,:PCEPILFE])

latex_fonts = Theme(major_label_font="CMU Serif", major_label_font_size=14pt,
                    minor_label_font="CMU Serif", minor_label_font_size=12pt,
                    key_title_font="CMU Serif", key_title_font_size=10pt,
                    key_label_font="CMU Serif", key_label_font_size=8pt)
#Gadfly.with_theme(latex_fonts) do
p1 = plot(df1, x=:DATE, y=Col.value(:PCEPILFE,:LES1252881600Q_NBD20120101, :CPILFESL_NBD20120101),
    color=Col.index(:PCEPILFE,:LES1252881600Q_NBD20120101, :CPILFESL_NBD20120101), 
    Geom.line, Guide.colorkey(title = "Metric", labels = ["PCE", "Adj. MWW", "CPI"]),
    Guide.ylabel("Points Indexed to 100 for 2012"), Guide.xlabel("Year"), 
    Coord.cartesian(xmin=Date(1980-01-01), xmax=Date(2025-01-01)),
    Guide.xticks(ticks=DateTime("1980-01-01"):Year(10):DateTime("2020-01-01")))
#end
render(p1)
set_default_plot_size(5inch, 4inch)
p1 |> SVG("3428/Exports/IrWt3.svg", 12cm,10cm)

x = df1.LES1252881600Q_NBD20120101
y = df1.PCEPILFE

crossmap(x, y, 1, 2)
crossmap(y, x, 1, 2)
B =jdd(x,y, B = 20)
