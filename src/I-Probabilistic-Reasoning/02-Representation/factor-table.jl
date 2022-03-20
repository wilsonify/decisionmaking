"""
A factor table is a mapping from assignments to real values. 
This mapping is represented by a dictionary.
Any assignments not contained in the dictionary are set to 0. 
"""
const FactorTable = Dict{Assignment,Float64}
