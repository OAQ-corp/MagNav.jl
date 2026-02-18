% Auto-generated from src/ekf_online.jl
% Original Julia signature: function ekf_online_setup(flux::MagV, meas, ind = trues(length(meas));
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = ekf_online_setup(flux, meas, ind)
    out = [];
                          Bt           = sqrt(flux.x.^2+flux.y.^2+flux.z.^2),
                          λ            = 0.025,
% TODO(Julia->MATLAB): terms        = [:permanent,:induced,:eddy,:bias],
                          pass1        = 0.1,
                          pass2        = 0.9,
                          fs           = 10.0,
% TODO(Julia->MATLAB): pole::Int    = 4,
% TODO(Julia->MATLAB): trim::Int    = 20,
% TODO(Julia->MATLAB): N_sigma::Int = 100,
                          Bt_scale     = 50000)

    (x0_TL,y_var) = create_TL_coef(flux,meas,ind;Bt=Bt,λ=λ,terms=terms,
                                   pass1=pass1,pass2=pass2,fs=fs,pole=pole,
                                   trim=trim,Bt_scale=Bt_scale,return_var=true)

    A     = create_TL_A(flux,ind;Bt=Bt,terms=terms,Bt_scale=Bt_scale)
    P0_TL = inv(A'*A)*y_var
    N_ind = length(meas(ind))
    N     = min(N_ind - max(2*trim,50), N_sigma) % avoid bpf issues
% TODO(Julia->MATLAB): inds  = sortperm(ind==1,rev=true)[1:N_ind]

    N_min = 10
% TODO(Julia->MATLAB): assert N >= N_min "increase N_sigma to $N_min or use more data"

    coef_set = zeros(eltype(A),size(A,2),N)
% TODO(Julia->MATLAB): for i = 1:N
% TODO(Julia->MATLAB): coef_set(:,i) = create_TL_coef(flux,meas,inds(i:end+i-N);
                                       Bt=Bt,λ=λ,terms=terms,pass1=pass1,
                                       pass2=pass2,fs=fs,pole=pole,trim=trim,
                                       Bt_scale=Bt_scale,return_var=false)
    end
end
