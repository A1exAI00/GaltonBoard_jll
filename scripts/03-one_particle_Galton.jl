using DrWatson
@quickactivate "Galton_board_Julia"

include(srcdir("GaltonSystem.jl"))
using .GaltonSystem

include(srcdir("GaltonPlots.jl"))

#########################################################################################

W, H = 1.0, 2.0
N, M = 7, 14
R = H/M/3

g = 1.0
γ = 0.9

x₀, y₀ = W/2, H
V = 0.1
Vx₀, Vy₀ = V*randn()/2, V*randn()/2

t_min, t_max, N_t = 0.0, 100.0, 5_000

PLOT_NAME = "03-OneParticle"

#########################################################################################

U₀ = [x₀, y₀, Vx₀, Vy₀]
t_span = (t_min, t_max)
t_range = range(t_min, t_max, N_t)

b = GaltonBoard(W, H, N, M, R)
p = GaltonParticle(b, g, γ, U₀)
integrate!(p, t_span, t_range)

#########################################################################################

fig = create_fig()
ax = create_Galton_board_axis(b, "One particle Galton board", "x", "y")
plot_Galton_board_bounds!(ax, b)
plot_Galton_board_pins!(ax, b)
plot_Galton_traj!(ax, p)

save(plotsdir()*"/"*PLOT_NAME*"$(time_ns()).png", fig, px_per_unit=2)