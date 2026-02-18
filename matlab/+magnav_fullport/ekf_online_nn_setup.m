% Auto-generated from src/ekf_online_nn.jl
% Original Julia signature: function ekf_online_nn_setup(x, y, m, y_norms; N_sigma::Int = 1000)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = ekf_online_nn_setup(x, y, m, y_norms, varargin)
    out = [];
    N_sigma_min = 10
% TODO(Julia->MATLAB): assert N_sigma >= N_sigma_min "increase N_sigma to $N_sigma_min"
    (y_bias,y_scale) = y_norms % unpack normalizations
    m = deepcopy(m) % don't modify original NN model
    (w_nn,re)  = destructure(m) % weights, restructure
    w_nn_store = zeros(eltype(w_nn),length(w_nn),N_sigma) % initialize weights matrix
    P = I(length(w_nn)) % initialize covariance matrix
% TODO(Julia->MATLAB): for i = 1:N_sigma   % run recursive least squares
        m = re(w_nn)
        K = P*w_nn/(1+w_nn'*P*w_nn)
% TODO(Julia->MATLAB): P     -= P*w_nn*w_nn'*P/(1+w_nn'*P*w_nn)
% TODO(Julia->MATLAB): w_nn  += K.*(y(i).-(m(x(i,:)).*y_scale.+y_bias)) ./ y_scale
        w_nn_store(:,i) = w_nn
        % println(w_nn(1))
    end
end
