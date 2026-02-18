% Auto-generated from src/analysis_util.jl
% Original Julia signature: function denorm_sets(train_bias, train_scale, train, test)
% Mechanical conversion draft: review before production use.
function [train, test] = denorm_sets__ovl2(train_bias, train_scale, train, test)
    train = train .* train_scale .+ train_bias
    test  = test  .* train_scale .+ train_bias
end % function denorm_sets
end
