% Auto-generated from src/nekf.jl
% Original Julia signature: function nekf_train(lat, lon, alt, vn, ve, vd, fn, fe, fd, Cnb, meas, dt, itp_mapS, x_nn::Matrix, y_nn::Matrix; P0                   = create_P0(),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = nekf_train(lat, lon, alt, vn, ve, vd, fn, fe, fd, Cnb, meas, dt, itp_mapS, x_nn, y_nn, varargin)
    out = [];
% TODO(Julia->MATLAB): itp_mapS, x_nn::Matrix, y_nn::Matrix;
                    P0                   = create_P0(),
                    Qd                   = create_Qd(),
                    R                    = 1.0,
                    baro_tau             = 3600.0,
                    acc_tau              = 3600.0,
                    gyro_tau             = 3600.0,
                    fogm_tau             = 600.0,
                    η_adam               = 0.1,
% TODO(Julia->MATLAB): epoch_adam::Int      = 10,
% TODO(Julia->MATLAB): hidden::Int          = 1,
% TODO(Julia->MATLAB): activation::Function = swish,
% TODO(Julia->MATLAB): l_window::Int        = 50,
                    date                 = get_years(2020,185),
% TODO(Julia->MATLAB): core::Bool           = false)

    (N,Nf) = size(x_nn) % number of samples (instances) & features
    Ny = 1 % length of output
% TODO(Julia->MATLAB): m  = Chain(LSTM(Nf => hidden), Dense(hidden => Ny, activation))

% TODO(Julia->MATLAB): x_seqs = chunk_data(Float32(x_nn),zero(lat),l_window)[1]
% TODO(Julia->MATLAB): y_seqs = chunk_data(Float32(y_nn),zero(lat),l_window)[1]
% TODO(Julia->MATLAB): N_seqs = [[N_nn;;] for N_nn in l_window:l_window:N]

    % pre-compute Phi
    N   = length(lat)
    Phi = zeros(18,18,N)
% TODO(Julia->MATLAB): for t = 1:N
% TODO(Julia->MATLAB): Phi(:,:,t) = get_Phi(size(Phi)[1],lat(t),vn(t),ve(t),vd(t),
                             fn(t),fe(t),fd(t),Cnb(:,:,t),
                             baro_tau,acc_tau,gyro_tau,fogm_tau,dt)
    end
end
