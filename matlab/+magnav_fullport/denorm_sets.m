% Auto-generated from src/analysis_util.jl
% Original Julia signature: function denorm_sets(train_bias, train_scale, train)
% Mechanical conversion draft: review before production use.
function train = denorm_sets(train_bias, train_scale, train)
    train = train .* train_scale .+ train_bias
end % function denorm_sets
end
