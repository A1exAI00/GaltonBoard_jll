using DrWatson
@quickactivate "Galton_board_Julia"

include(srcdir("GaltonSystem.jl"))
using .GaltonSystem

include(srcdir("GaltonPlots.jl"))

#########################################################################################

# Number of pins in x,y directions respectively
N = 20
M = 40

# Size of Galton board in x,y directions respectively
W = 1.0
H = 2.0

# Radius of all the pins
R = 0.02

PLOT_NAME = "01-plot_pins"

#########################################################################################

b = GaltonBoard(W, H, N, M, R)

# pins = b.pins
# x_pins = [pins[i][1] for i in eachindex(pins)]
# y_pins = [pins[i][2] for i in eachindex(pins)]

#########################################################################################

# fig = Figure(size=(500,500))
# ax = Axis(fig[1, 1], 
#     title="Galton board pins!", 
#     xlabel="x", 
#     ylabel="y",
# 	xminorticksvisible = true, 
# 	xminorgridvisible = true, 
# 	yminorticksvisible = true, 
# 	yminorgridvisible = true, 
# 	xminorticks = IntervalsBetween(10),
# 	yminorticks = IntervalsBetween(10)
# )

# scatter!(ax, x_pins, y_pins)

fig = create_fig()
ax = create_Galton_board_axis(b, "Galton board pins!", "x", "y")
plot_Galton_board_bounds!(ax, b)
plot_Galton_board_pins!(ax, b)
# plot_Galton_traj!(ax, p)

save(plotsdir()*"/"*PLOT_NAME*"$(time_ns()).png", fig, px_per_unit=2)