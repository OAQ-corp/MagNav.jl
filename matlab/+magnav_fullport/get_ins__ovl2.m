% Auto-generated from src/get_XYZ.jl
% Original Julia signature: function get_ins(xyz::XYZ, ind = trues(xyz.ins.N);
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_ins__ovl2(xyz, ind)
    out = [];
% TODO(Julia->MATLAB): N_zero_ll::Int  = 0,
% TODO(Julia->MATLAB): t_zero_ll::Real = 0,
% TODO(Julia->MATLAB): err::Real       = 0.0)
    N_zero = t_zero_ll > 0 ? floor(Int,t_zero_ll/xyz.ins.dt+1) : N_zero_ll
    if N_zero > 0
% TODO(Julia->MATLAB): lat = xyz.traj.lat(ind)[1:N_zero]
% TODO(Julia->MATLAB): lon = xyz.traj.lon(ind)[1:N_zero]
        xyz.ins(ind;err=err,lat=lat,lon=lon)
    else
        xyz.ins(ind;err=err)
    end
end
