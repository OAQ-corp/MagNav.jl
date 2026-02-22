function Cnb_estimate = correct_Cnb(Cnb, tilt_err)
%CORRECT_CNB Apply XYZ tilt-angle errors to body-to-navigation DCM.
%   Cnb_estimate = magnav.correct_Cnb(Cnb, tilt_err)
%
%   Inputs:
%     Cnb      : 3x3xN direction cosine matrices (body-to-navigation)
%     tilt_err : 3xN tilt errors [rad]
%
%   Output:
%     Cnb_estimate : 3x3xN corrected DCMs

    n = size(tilt_err, 2);
    Cnb_estimate = zeros(3, 3, n);

    for i = 1:n
        m = norm(tilt_err(:, i));
        if m ~= 0
            s = [0,              -tilt_err(3,i),  tilt_err(2,i); ...
                 tilt_err(3,i),   0,             -tilt_err(1,i); ...
                -tilt_err(2,i),   tilt_err(1,i),  0            ];
            B = eye(3) - sin(m)/m * s - (1 - cos(m))/m^2 * (s^2);
            Cnb_estimate(:,:,i) = B * Cnb(:,:,i);
        else
            Cnb_estimate(:,:,i) = Cnb(:,:,i);
        end
    end
end
