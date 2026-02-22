% Auto-generated from src/eval_filt.jl
% Original Julia signature: function eval_filt(traj::Traj, ins::INS, filt_res::FILTres)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = eval_filt(traj, ins, filt_res)
    out = [];

    N  = traj.N
    dt = traj.dt
    N_fields = length(fieldnames(FILTout))
% TODO(Julia->MATLAB): filt_out = FILTout(N,dt,(zeros(N) for _ = 1:N_fields-2)...)

    filt_out.tt   = traj.tt
    filt_out.lat  = ins.lat + filt_res.x(1,:)
    filt_out.lon  = ins.lon + filt_res.x(2,:)
    filt_out.alt  = ins.alt + filt_res.x(3,:)
    filt_out.vn   = ins.vn  + filt_res.x(4,:)
    filt_out.ve   = ins.ve  + filt_res.x(5,:)
    filt_out.vd   = ins.vd  + filt_res.x(6,:)
    filt_out.tn   =           filt_res.x(7,:)
    filt_out.te   =           filt_res.x(8,:)
    filt_out.td   =           filt_res.x(9,:)
    filt_out.ha   =           filt_res.x(10,:)
    filt_out.ah   =           filt_res.x(11,:)
    filt_out.ax   =           filt_res.x(12,:)
    filt_out.ay   =           filt_res.x(13,:)
    filt_out.az   =           filt_res.x(14,:)
    filt_out.gx   =           filt_res.x(15,:)
    filt_out.gy   =           filt_res.x(16,:)
    filt_out.gz   =           filt_res.x(17,:)
    filt_out.fogm =           filt_res.x(end,:)

    filt_out.lat_std  = sqrt(filt_res.P(1,1,:))
    filt_out.lon_std  = sqrt(filt_res.P(2,2,:))
    filt_out.alt_std  = sqrt(filt_res.P(3,3,:))
    filt_out.vn_std   = sqrt(filt_res.P(4,4,:))
    filt_out.ve_std   = sqrt(filt_res.P(5,5,:))
    filt_out.vd_std   = sqrt(filt_res.P(6,6,:))
    filt_out.tn_std   = sqrt(filt_res.P(7,7,:))
    filt_out.te_std   = sqrt(filt_res.P(8,8,:))
    filt_out.td_std   = sqrt(filt_res.P(9,9,:))
    filt_out.ha_std   = sqrt(filt_res.P(10,10,:))
    filt_out.ah_std   = sqrt(filt_res.P(11,11,:))
    filt_out.ax_std   = sqrt(filt_res.P(12,12,:))
    filt_out.ay_std   = sqrt(filt_res.P(13,13,:))
    filt_out.az_std   = sqrt(filt_res.P(14,14,:))
    filt_out.gx_std   = sqrt(filt_res.P(15,15,:))
    filt_out.gy_std   = sqrt(filt_res.P(16,16,:))
    filt_out.gz_std   = sqrt(filt_res.P(17,17,:))
    filt_out.fogm_std = sqrt(filt_res.P(18,18,:))

    filt_out.n_std   = dlat2dn(filt_out.lat_std,filt_out.lat)
    filt_out.e_std   = dlon2de(filt_out.lon_std,filt_out.lat)

    filt_out.lat_err = filt_out.lat - traj.lat
    filt_out.lon_err = filt_out.lon - traj.lon
    filt_out.alt_err = filt_out.alt - traj.alt
    filt_out.vn_err  = filt_out.vn  - traj.vn
    filt_out.ve_err  = filt_out.ve  - traj.ve
    filt_out.vd_err  = filt_out.vd  - traj.vd

    n_tilt = zeros(eltype(filt_out.lat),N)
    e_tilt = zeros(eltype(filt_out.lat),N)
    d_tilt = zeros(eltype(filt_out.lat),N)

% TODO(Julia->MATLAB): for k = 1:N
        tilt_temp = ins.Cnb(:,:,k)*traj.Cnb(:,:,k)'
        n_tilt(k) = tilt_temp(3,2) % ≈ -tilt_temp(2,3)
        e_tilt(k) = tilt_temp(1,3) % ≈ -tilt_temp(3,1)
        d_tilt(k) = tilt_temp(2,1) % ≈ -tilt_temp(1,2)
    end
end
