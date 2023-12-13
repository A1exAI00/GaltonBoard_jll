# using DrWatson
# @quickactivate "Galton_board_Julia"

# include(srcdir("Galton_board.jl"))

#########################################################################################

""" u = [x, y, Vx, Vy] \\
p = (g, R, γ, W, pins) """
function particle_DE(du, u, p, t)
    x, y, Vx, Vy = u
    g = p[1]

    du[1] = Vx
    du[2] = Vy
    du[3] = 0
    du[4] = -g
    return nothing
end

#########################################################################################

function condition(out, u, t, int)
    x, y, Vx, Vy = u
    g, γ, W, pins = int.p

    for i in eachindex(pins)
        x_pin, y_pin, R_pin = pins[i]
        out[i+3] = (x_pin-x)^2 + (y_pin-y)^2 - R_pin^2
    end
    out[1] = x
    out[2] = x - W
    out[3] = y
end

function affect!(int, idx)
    x, y, Vx, Vy = int.u
    g, γ, W, pins = int.p

    if (idx == 1) || (idx == 2) # collision with vertical walls
        int.u[3] *= -γ
    elseif idx == 3 # collision with bottom
        terminate!(int)
    else # collision with pins
        x_pin, y_pin, R_pin = pins[idx-3]
        Nx = (x-x_pin)/R_pin
        Ny = (y-y_pin)/R_pin
        V_N = Vx*Nx+Vy*Ny
        int.u[3] = (Vx - 2*V_N*Nx)*γ
        int.u[4] = (Vy - 2*V_N*Ny)*γ
    end
end

#########################################################################################

mutable struct GaltonParticle
    board::GaltonBoard
    g::Float64
    γ::Float64
    U₀

    sol
    x_final::Float64

    function GaltonParticle(board::GaltonBoard, g::Float64, γ::Float64, U₀)
        new(board, g, γ, U₀, NaN, NaN)
    end
end

function integrate!(p::GaltonParticle, t_span, t_range)
    b = p.board
    cb = VectorContinuousCallback(condition, affect!, b.N_pins+3)

    prob = ODEProblem(particle_DE, p.U₀, t_span, (p.g, p.γ, b.board_width, b.pins))
    sol = solve(prob; alg=Tsit5(), reltol=RELTOL, abstol=ABSTOL, 
        dt=DELTA_T, adaptive=false, callback=cb, saveat=t_range
    )
    p.sol = sol
    p.x_final = sol[1, end]
end