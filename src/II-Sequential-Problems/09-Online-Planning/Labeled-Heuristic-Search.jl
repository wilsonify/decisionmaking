struct LabeledHeuristicSearch
    """
    Labeled heuristic search, which runs simulations
starting from the current state to
a depth d until the current state
is solved. The search is guided by
a heuristic upper bound on the
value function Uhi and maintains a
growing set of solved states solved .
States are considered solved when
their utility residuals fall below δ .
A value function policy is returned.
    """
    problem::Any
    # problem
    Uhi::Any
    # upper bound on value function
    d::Any
    # depth
    δ::Any
    # gap threshold
end
function (π::LabeledHeuristicSearch)(s)
    U, solved = [π.Uhi(s) for s in problem.𝒮], Set()
    while s ∉ solved
        simulate!(π, U, solved, s)
    end
    return greedy(π.problem, U, s).a
end

function simulate!(π::LabeledHeuristicSearch, U, solved, s)
    """
    Simulations are
run from the current state to a maximum depth d . We stop a simulation at depth d or if we encounter a
state that is in the set solved . After
a simulation, we call label! on the
states we visited in reverse order.
    """
    visited = []
    for d = 1:π.d
        if s ∈ solved
            break
        end
        push!(visited, s)
        a, u = greedy(π.problem, U, s)
        U[s] = u
        s = rand(π.problem.T(s, a))
    end
    while !isempty(visited)
        if label!(π, U, solved, pop!(visited))
            break
        end
    end
end
