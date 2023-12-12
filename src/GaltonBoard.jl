
#########################################################################################

function pin_centers(W::Float64, H::Float64, N::Int, M::Int)
    w = W/(N+1)
    h = H/(M+1)
    offset_to_ceil = h

    x_pins = []
    y_pins = []
    for i in 1:N, j in 1:M
        offset_to_wall = isodd(j) ? w/2 : w
        push!(x_pins, offset_to_wall+(i-1)*w)
        push!(y_pins, offset_to_ceil+(j-1)*h)
    end

    return x_pins, y_pins
end

mutable struct GaltonBoard
    board_width::Float64
    board_height::Float64

    N_pins::Int
    pins

    function GaltonBoard(W::Float64, H::Float64, N::Int64, M::Int64, R::Float64)
        x_pins, y_pins = pin_centers(W, H, N, M)
        N_pins = length(x_pins)
        R_pins = fill(R, N_pins)
        new(W, H, N_pins, tuple(zip(x_pins, y_pins, R_pins)...))
    end

    function GaltonBoard(W, H, pins)
        new(W, H, length(pins), pins)
    end
end