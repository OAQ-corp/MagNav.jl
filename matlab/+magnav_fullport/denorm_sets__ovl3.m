% Auto-generated from src/analysis_util.jl
% Original Julia signature: function denorm_sets(train_bias, train_scale, train, val, test)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function [train, val, test] = denorm_sets__ovl3(train_bias, train_scale, train, val, test)
    train = [];
    train = train .* train_scale .+ train_bias
    val   = val   .* train_scale .+ train_bias
    test  = test  .* train_scale .+ train_bias
% return (train, val, test)
end % function denorm_sets
end
