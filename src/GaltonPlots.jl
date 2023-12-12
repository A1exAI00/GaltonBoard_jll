using CairoMakie

function create_fig(size=(1000, 1000))
    return Figure(size=size)
end

function create_Galton_board_axis(b, title, xlabel, ylabel)
    ax = Axis(fig[1, 1], 
        title=title, 
        xlabel=xlabel, 
        ylabel=ylabel,
        xminorticksvisible = true, 
        xminorgridvisible = true, 
        yminorticksvisible = true, 
        yminorgridvisible = true, 
        xminorticks = IntervalsBetween(10),
        yminorticks = IntervalsBetween(10),
        aspect = DataAspect()
    )
    xlims!(ax, 0.0, b.board_width)
    return ax
end

function create_Galton_board_axis_and_hist(b, title, xlabel, ylabel, N_sols)
    ax1 = Axis(fig[1:3, 1], 
        title=title, 
        xlabel=xlabel, 
        ylabel=ylabel,
        xminorticksvisible = true, 
        xminorgridvisible = true, 
        yminorticksvisible = true, 
        yminorgridvisible = true, 
        xminorticks = IntervalsBetween(10),
        yminorticks = IntervalsBetween(10),
        aspect = DataAspect()
    )
    ax2 = Axis(fig[4, 1], 
        title="PDF, N_particles=$(N_sols)", 
        xlabel=xlabel, 
        ylabel="p",
        xminorticksvisible = true, 
        xminorgridvisible = true, 
        yminorticksvisible = true, 
        yminorgridvisible = true, 
        xminorticks = IntervalsBetween(10),
        yminorticks = IntervalsBetween(10)
    )
    xlims!(ax1, 0.0, b.board_width)
    xlims!(ax2, 0.0, b.board_width)
    return ax1, ax2
end

function plot_Galton_board_bounds!(ax, b)
    W, H = b.board_width, b.board_height
    vlines!(ax, 0.0, color=:black)
    hlines!(ax, 0.0, color=:black)
    vlines!(ax, W, color=:black)
    hlines!(ax, H, color=:black)
end

function plot_Galton_board_pins!(ax, b, color="black", linewidth=1.0)
    φ = range(0.0, 2π, 100)
    for pin in b.pins
        x_pin, y_pin, R_pin = pin
        x_circ = x_pin .+ R_pin .* cos.(φ)
        y_circ = y_pin .+ R_pin .* sin.(φ)
        lines!(ax, x_circ, y_circ, color=color, linewidth=linewidth)
    end
end

function plot_Galton_traj!(ax, p, color=nothing)
    sol = p.sol
    if isnothing(color)
        lines!(ax, sol[1,:], sol[2,:])
    else
        lines!(ax, sol[1,:], sol[2,:], color=color)
    end
end

function plot_Galton_hist!(ax, x_end, N_bins, color=nothing)
    if isnothing(color)
        hist!(ax, x_end, bins=N_bins, normalizetion=:pdf)
    else
        hist!(ax, x_end, bins=N_bins, normalizetion=:pdf, color=color)
    end
end