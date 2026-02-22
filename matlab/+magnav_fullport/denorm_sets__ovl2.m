% Auto-generated from src/analysis_util.jl
% Original Julia signature: function denorm_sets(train_bias, train_scale, train, test)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function [train, test] = denorm_sets__ovl2(train_bias, train_scale, train, test)
    train = [];
    train = train .* train_scale .+ train_bias
    test  = test  .* train_scale .+ train_bias
% return (train, test)
end % function denorm_sets
end
