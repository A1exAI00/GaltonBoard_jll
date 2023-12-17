using DrWatson
@quickactivate "Galton_board_Julia"

include(srcdir("GaltonSystem.jl"))
using .GaltonSystem

include(srcdir("GaltonPlots.jl"))

#########################################################################################

is_test_run = (length(ARGS) ≠ 0) && (ARGS[1] == "0")

#########################################################################################

_SAVE_DATA = true
SAVE_DATA = is_test_run ? true : _SAVE_DATA
DATA_SAVE_PREFIX = is_test_run ? "TEST" : "03-one_particle_sim"
DATA_SAVE_DIR = "sims03"

_SAVE_PLOT = false
SAVE_PLOT = is_test_run ? true : _SAVE_DATA
PLOT_SAVE_NAME = is_test_run ? "TEST.png" : "03-one_particle-$(time_ns()).png"

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

#########################################################################################

U₀ = [x₀, y₀, Vx₀, Vy₀]
t_span = (t_min, t_max)
t_range = range(t_min, t_max, N_t)

b = GaltonBoard(W, H, N, M, R)
p = GaltonParticle(b, g, γ, U₀)
integrate!(p, t_span, t_range)

#########################################################################################

if SAVE_DATA
    saving_name = savename(DATA_SAVE_PREFIX, (g=g, R=R, γ=γ), "jld2")
    safesave(datadir(DATA_SAVE_DIR, saving_name), Dict("p"=>p)) 
end

if SAVE_PLOT
    fig = create_fig()
    ax = create_Galton_board_axis(b, "One particle Galton board", "x", "y")
    plot_Galton_board_bounds!(ax, b)
    plot_Galton_board_pins!(ax, b)
    plot_Galton_traj!(ax, p)

    save(plotsdir(PLOT_SAVE_NAME), fig, px_per_unit=2)
end