using DrWatson
@quickactivate "GaltonBoard_jll"

include(srcdir("GaltonSystem.jl"))
using .GaltonSystem

include(srcdir("GaltonPlots.jl"))

#########################################################################################

PLOT_SAVE_NAME = "03-one_particle-$(time_ns()).png"

#########################################################################################

data = wload(datadir("sims03", "03-one_particle_sim_R=0.0476_g=1.0_γ=0.9.jld2"))

p = data["p"]
b = p.board

#########################################################################################

fig = create_fig()
ax = create_Galton_board_axis(b, "Collison With Circle", "x", "y")
plot_Galton_board_bounds!(ax, b)
plot_Galton_board_pins!(ax, b)
plot_Galton_traj!(ax, p)

save(plotsdir(PLOT_SAVE_NAME), fig, px_per_unit=2)