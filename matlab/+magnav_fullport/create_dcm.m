% Auto-generated from src/create_XYZ.jl
% Original Julia signature: function create_dcm(vn, ve, dt = 0.1, order::Symbol = :body2nav)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function dcm = create_dcm(vn, ve, dt, order)
    dcm = [];

    N     = length(vn)
    roll  = fogm(deg2rad(2  ),2,dt,N)
    pitch = fogm(deg2rad(0.5),2,dt,N)
    yaw   = fogm(deg2rad(1  ),2,dt,N)

    bpf   = get_bpf(;pass1=1e-6,pass2=1)
    roll  = bpf_data(roll ;bpf=bpf)
    pitch = bpf_data(pitch;bpf=bpf) .+ deg2rad(2)   % pitch typically ~2 deg
    yaw   = bpf_data(yaw  ;bpf=bpf) .+ atan(ve,vn) % yaw definition
    dcm   = euler2dcm(roll,pitch,yaw,order)

% return (dcm)
end % function create_dcm
end
