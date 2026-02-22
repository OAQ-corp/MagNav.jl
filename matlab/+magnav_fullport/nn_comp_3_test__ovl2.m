% Auto-generated from src/compensation.jl
% Original Julia signature: function nn_comp_3_test(A, Bt, B_dot, x, y, data_norms::Tuple, model::Chain; model_type::Symbol = :m3s, y_type::Symbol     = :d, TL_coef::Vector    = zeros(Float32,18),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function [y_hat, err] = nn_comp_3_test__ovl2(A, Bt, B_dot, x, y, data_norms, model, varargin)
    y_hat = [];
% TODO(Julia->MATLAB): model_type::Symbol = :m3s,
% TODO(Julia->MATLAB): y_type::Symbol     = :d,
% TODO(Julia->MATLAB): TL_coef::Vector    = zeros(Float32,18),
% TODO(Julia->MATLAB): terms_A            = [:permanent,:induced,:eddy],
% TODO(Julia->MATLAB): l_segs::Vector     = [length(y)],
% TODO(Julia->MATLAB): l_window::Int      = 5,
% TODO(Julia->MATLAB): silent::Bool       = false)

% TODO(Julia->MATLAB): assert y_type in [:a,:b,:c,:d] "unsupported y_type = $y_type for nn_comp_3"

    % convert to Float32 for consistency with nn_comp_3_train
    y = Float32(y)

    % get results
    y_hat = nn_comp_3_fwd(A,Bt,B_dot,x,data_norms,model;
                          model_type = model_type,
                          y_type     = y_type,
                          TL_coef    = TL_coef,
                          terms_A    = terms_A,
                          l_segs     = l_segs,
                          l_window   = l_window)
    err   = err_segs(y_hat,y,l_segs;silent=silent_debug)
% TODO(Julia->MATLAB): silent || @info("test  error: $(round(std(err),digits=2)) nT")

% return (y_hat, err)
end % function nn_comp_3_test
end
