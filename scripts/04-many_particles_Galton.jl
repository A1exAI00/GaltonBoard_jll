using DrWatson
@quickactivate "Galton_board_Julia"

include(srcdir("GaltonSystem.jl"))
using .GaltonSystem

include(srcdir("GaltonPlots.jl"))

#########################################################################################

# Pin placement
N, M = 45, 15
W, H = 3.0, 1.0
R = H/M/5

# Dynamics
g, γ = 1.0, 0.9
V, Δx₀ = 0.1, 0.1

# Time span
t_min, t_max, N_t = 0.0, 100.0, 1_000

# Number of particles
N_sols = 100_000
plot_every_particle = 200

N_bins = 300

PLOT_NAME = "04-ManyParticles"

#########################################################################################

t_span = (t_min, t_max)
t_range = range(t_min, t_max, N_t)

b = GaltonBoard(W, H, N, M, R)

#########################################################################################

println("Precompile started")
U₀_precompile = [0.0001, 0.0001, 0.0, 0.0]
p_precompile =GaltonParticle(b, g, γ, U₀_precompile)
integrate!(p_precompile, t_span, t_range)
println("Precompile finished")

#########################################################################################

generate_random_U₀() = [W/2 + Δx₀*randn(), H, V*randn(), V*randn()]

particles = [GaltonParticle(b, g, γ, generate_random_U₀()) for i in 1:N_sols]
for i in 1:N_sols
    (rem(i, plot_every_particle) == 0) && (@show i)
    integrate!(particles[i], t_span, t_range)
end

x_end = [particles[i].sol[1,end] for i in 1:N_sols]

#########################################################################################

fig = create_fig((1000,700))
ax1, ax2 = create_Galton_board_axis_and_hist(b, "Many particles Galton board", "x", "y", N_sols)
plot_Galton_board_bounds!(ax1, b)

particles_to_plot = particles[(1:N_sols)[rem.(1:N_sols, plot_every_particle).==0]]
plot_Galton_traj!.(ax1, particles_to_plot)

plot_Galton_hist!(ax2, x_end, N_bins)

plot_Galton_board_pins!(ax1, b)

save(plotsdir()*"/"*PLOT_NAME*"$(time_ns()).png", fig, px_per_unit=2)
