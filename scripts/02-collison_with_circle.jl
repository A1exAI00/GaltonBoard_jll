using DrWatson
@quickactivate "Galton_board_Julia"

include(srcdir("GaltonSystem.jl"))
using .GaltonSystem

include(srcdir("GaltonPlots.jl"))

#########################################################################################

# Gravitational constant
g = 1.0

# Pin radius
R = 1.0

# Reflective constant
γ = 0.99

# Pin center coordinates
x_pin, y_pin = 1.0, 1.0

W, H = 2.0, 2.0

# Initial coordinates & velocities
x₀, y₀ = x_pin+R/2, y_pin
Vx₀, Vy₀ = 0.0, 0.0

# Integration time
t_min, t_max, N_t = 0.0, 10.0, 100

PLOT_NAME = "02-InPinBounce"

#########################################################################################

U₀ = [x₀, y₀, Vx₀, Vy₀]
pin_coord = (x_pin, y_pin, R)
pins = (pin_coord,)
t_span = (t_min, t_max)
t_range = range(t_min, t_max, N_t)

#########################################################################################

b = GaltonBoard(W, H, pins)
p = GaltonParticle(b, g, γ, U₀)
integrate!(p, t_span, t_range)

#########################################################################################

fig = create_fig()
ax = create_Galton_board_axis(b, "In pin Bounce", "x", "y")
plot_Galton_board_bounds!(ax, b)
plot_Galton_board_pins!(ax, b)
plot_Galton_traj!(ax, p)

save(plotsdir()*"/"*PLOT_NAME*"$(time_ns()).png", fig, px_per_unit=2)