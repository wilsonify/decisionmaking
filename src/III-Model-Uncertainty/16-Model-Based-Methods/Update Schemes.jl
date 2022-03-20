"""
An method that
performs a full update of the value
function of U using the linear programming formulation from section 7.7.
"""
struct FullUpdate end
function update!(planner::FullUpdate, model, s, a, r, s′)
problem = MDP(model)
U = solve(problem).U
copy!(model.U, U)
return planner
end

"""
Maximum likelihood model-based reinforcement
learning with updates at randomized states. This approach performs a Bellman update at the previously visited state as well as at m
additional states chosen randomly.
"""
struct RandomizedUpdate
    m # number of updates
    end
    function update!(planner::RandomizedUpdate, model, s, a, r, s′)
    U = model.U
    U[s] = backup(model, U, s)
    for i in 1:planner.m
    s = rand(model.𝒮)
    U[s] = backup(model, U, s)
    end
    return planner
    end