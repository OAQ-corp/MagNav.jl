% Auto-generated from src/analysis_util.jl
% Original Julia signature: function krr_test(x, y, data_norms::Tuple, model::Tuple; l_segs::Vector = [length(y)],
% Mechanical conversion draft: review before production use.
function [y_hat, err] = krr_test(x, y, data_norms, model, varargin)
                  l_segs::Vector = [length(y)],
                  silent::Bool   = false)

    % unpack data normalizations
    (x_bias,x_scale,y_bias,y_scale) = data_norms
    x_norm = (x .- x_bias) ./ x_scale

    % unpack KRR model weights
    (k,kt,x_norm_) = model
    K = kernelmatrix(k,x_norm,x_norm_;obsdim=1)

    % get results
    y_hat_norm = K*kt
    y_hat      = denorm_sets(y_bias,y_scale,y_hat_norm)
    err        = err_segs(y_hat,y,l_segs;silent=silent_debug)
    silent || @info("test  error: $(round(std(err),digits=2)) nT")

end % function krr_test
end
