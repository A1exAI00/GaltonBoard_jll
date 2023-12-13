using DrWatson
@quickactivate "GaltonBoard_jll"

include(srcdir("GaltonSystem.jl"))
using .GaltonSystem

include(srcdir("GaltonPlots.jl"))

#########################################################################################

PLOT_NAME = "02-collison_with_circle"

#########################################################################################

data = wload(datadir("sims02", "02-collison_with_circle_sim_R=1.0_g=1.0_γ=0.99.jld2"))

p = data["p"]
b = p.board

#########################################################################################

fig = create_fig()
ax = create_Galton_board_axis(b, "Collison With Circle", "x", "y")
plot_Galton_board_bounds!(ax, b)
plot_Galton_board_pins!(ax, b)
plot_Galton_traj!(ax, p)

save(plotsdir(PLOT_NAME)*"$(time_ns()).png", fig, px_per_unit=2)