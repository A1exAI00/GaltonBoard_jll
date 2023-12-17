using DrWatson
@quickactivate "Galton_board_Julia"

include(srcdir("GaltonSystem.jl"))
using .GaltonSystem

include(srcdir("GaltonPlots.jl"))

#########################################################################################

is_test_run = (length(ARGS) ≠ 0) && (ARGS[1] == "0")

#########################################################################################

# Number of pins in x,y directions respectively
N = 20
M = 40

# Size of Galton board in x,y directions respectively
W = 1.0
H = 2.0

# Radius of all the pins
R = 0.02

PLOT_SAVE_NAME = is_test_run ? "TEST.png" : "01-plot_pins$(time_ns()).png"
PLOT_SAVE_PATH = plotsdir(PLOT_SAVE_NAME)

#########################################################################################

b = GaltonBoard(W, H, N, M, R)

#########################################################################################

fig = create_fig()
ax = create_Galton_board_axis(b, "Galton board pins!", "x", "y")
plot_Galton_board_bounds!(ax, b)
plot_Galton_board_pins!(ax, b)

save(PLOT_SAVE_PATH, fig, px_per_unit=2)