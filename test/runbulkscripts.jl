using DrWatson, Test
@quickactivate "Galton_board_Julia"

#########################################################################################

command(julia_path, project_path, script_path) = `$(julia_path) -q --color=yes --project="$(project_path)" "$(script_path)" 0`
command(script_path) = command(julia_path, project_path, script_path)

julia_path = "/home/lubuntu-01-23/.julia/juliaup/julia-1.9.4+0.x64.linux.gnu/bin/julia"
project_path = projectdir()
# TODO get all the scripts in scriptsdir and automate this line
script_names = ("01-plot_pins.jl", "02-collison_with_circle.jl", 
    "03-one_particle_Galton.jl", "04-many_particles_Galton.jl")

#########################################################################################

println("\nScripts test runs")
ti = time()

for i in eachindex(script_names)
    curr_script_name = script_names[i]
    curr_script_path = scriptsdir(curr_script_name)
    print("Running $(curr_script_name): ")
    try
        run(command(curr_script_path))
    catch
        println("CRASH")
    end
    println("success")
end

ti = time() - ti
print("\nTest took total time of: $(round(ti/60, digits = 3)) minutes")