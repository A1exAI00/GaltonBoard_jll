using DrWatson
@quickactivate "GaltonBoard_jll"

include(srcdir("GaltonSystem.jl"))
using .GaltonSystem

include(srcdir("GaltonPlots.jl"))

#########################################################################################

PLOT_NAME = "04-ManyParticles$(time_ns()).png"

#########################################################################################

data = wload(datadir("sims04", "04-many_particles_sim_N_sols=10000_R=0.0133_g=1.0_γ=0.9.jld2"))

particles = data["ps"]
N_sols = length(particles)
plot_every_particle = 20
b = particles[1].board
N_bins = 300
x_end = [particles[i].sol[1,end] for i in 1:N_sols]

#########################################################################################

fig = create_fig((1000,700))
ax1, ax2 = create_Galton_board_axis_and_hist(b, "Many particles Galton board", "x", "y", N_sols)
plot_Galton_board_bounds!(ax1, b)

particles_to_plot = particles[(1:N_sols)[rem.(1:N_sols, plot_every_particle).==0]]
plot_Galton_traj!.(ax1, particles_to_plot)
plot_Galton_hist!(ax2, x_end, N_bins)
plot_Galton_board_pins!(ax1, b)

save(plotsdir(PLOT_NAME), fig, px_per_unit=2)