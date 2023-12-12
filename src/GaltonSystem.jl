module GaltonSystem

using DifferentialEquations
using DrWatson
@quickactivate "Galton_board_Julia"

include(srcdir("GaltonBoard.jl"))
include(srcdir("GaltonParticle.jl"))

const ABSTOL::Float64 = 1e-5
const RELTOL::Float64 = 1e-5
const DELTA_T::Float64 = 5e-2

export GaltonBoard
export GaltonParticle
export integrate!

end