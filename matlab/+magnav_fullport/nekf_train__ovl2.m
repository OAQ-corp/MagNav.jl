% Auto-generated from src/nekf.jl
% Original Julia signature: function nekf_train(ins::INS, meas, itp_mapS, x_nn::Matrix, y_nn::Matrix; P0                   = create_P0(),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = nekf_train__ovl2(ins, meas, itp_mapS, x_nn, y_nn, varargin)
    out = [];
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
    nekf_train(ins.lat,ins.lon,ins.alt,ins.vn,ins.ve,ins.vd,
               ins.fn,ins.fe,ins.fd,ins.Cnb,meas,ins.dt,itp_mapS,x_nn,y_nn;
               P0=P0,Qd=Qd,R=R,
               baro_tau   = baro_tau,
               acc_tau    = acc_tau,
               gyro_tau   = gyro_tau,
               fogm_tau   = fogm_tau,
               η_adam     = η_adam,
               epoch_adam = epoch_adam,
               hidden     = hidden,
               activation = activation,
               l_window   = l_window,
               date       = date,
               core       = core);
end % function nekf_train
end
