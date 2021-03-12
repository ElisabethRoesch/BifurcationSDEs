
include("../../../src/includes.jl")

key = "1_1"
# load data
file_path_raw = string("test/nd_model_tests/2d_tests/data/rep_output_", key, "_raw.jld")
file_path_potential = string("test/nd_model_tests/2d_tests/data/rep_output_", key, "_potential.jld")
rep_output_raw = load(file_path_raw)[key]
rep_output_potential = load(file_path_potential)[key]


#####
# Entropy via InformationMeasures.jl

p_1 = [1,2,3]
p_2 = [1 2 3;
        4 5 6]
e_p_1 = InformationMeasures.get_entropy(p_1)
e_p_2 = InformationMeasures.get_entropy(p_2)
p2_b = slicematrix(rep_output_potential)
e_p_2 = InformationMeasures.get_entropy(p_2...)


a = slicematrix(rep_output_potential)

#####



#####
# Fisher infromation via FiniteDiff
using FiniteDiff
f(x) = x^2
res = FiniteDiff.hessian(f, [1])
#####


#####
# Entorpy with QuantumInformation
using

# Example:
p_1 = [1,2,3]
p_2 = [1 2 3;
        4 5 6]

s_e_p_1 = shannon_entropy(p_1)
v_e_p_1 = vonneumann_entropy(p_1)
s_e_p_2 = shannon_entropy(p_2) # Error
v_e_p_2 = vonneumann_entropy(p_2) # Error

s_e = shannon_entropy(a...) # Error
v_e = vonneumann_entropy(a...) # Error
####
