% Auto-generated from src/dcm.jl
% Original Julia signature: function correct_Cnb(Cnb, tilt_err)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = correct_Cnb(Cnb, tilt_err)
    out = [];

    N = size(tilt_err,2)
    Cnb_estimate = zeros(3,3,N)
% TODO(Julia->MATLAB): for i = 1:N
        m = norm(tilt_err(:,i))
        if m ~= 0
            s = [             0 -tilt_err(3,i)  tilt_err(2,i)
                  tilt_err(3,i)              0 -tilt_err(1,i)
                 -tilt_err(2,i)  tilt_err(1,i)              0]
            B = I - sin(m)/m*s - (1-cos(m))/m^2*s^2 % ≈ I - s - 0.5*s^2
            Cnb_estimate(:,:,i) = B*Cnb(:,:,i)
        else
            Cnb_estimate(:,:,i) =   Cnb(:,:,i)
        end
end
