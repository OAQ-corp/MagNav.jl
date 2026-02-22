% Auto-generated from src/analysis_util.jl
% Original Julia signature: function denorm_sets(train_bias, train_scale, train)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function train = denorm_sets(train_bias, train_scale, train)
    train = [];
    train = train .* train_scale .+ train_bias
% return (train)
end % function denorm_sets
end
