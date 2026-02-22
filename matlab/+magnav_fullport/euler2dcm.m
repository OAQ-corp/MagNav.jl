% Auto-generated from src/dcm.jl
% Original Julia signature: function euler2dcm(roll, pitch, yaw, order::Symbol = :body2nav)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = euler2dcm(roll, pitch, yaw, order)
    out = [];

    assert length(roll) == length(pitch) == length(yaw) "roll, pitch, and yaw must be the same length"

    r = vec([roll ;])
    p = vec([pitch;])
    y = vec([yaw  ;])

    cr = cos(r)
    sr = sin(r)
    cp = cos(p)
    sp = sin(p)
    cy = cos(y)
    sy = sin(y)

    dcm = zeros(3,3,length(roll))

% TODO(Julia->MATLAB): if order == 'body2nav' % Cnb, shown in Titterton & Weston (pg. 41)
        dcm(1,1,:) =  cp.*cy
        dcm(1,2,:) = -cr.*sy + sr.*sp.*cy
        dcm(1,3,:) =  sr.*sy + cr.*sp.*cy
        dcm(2,1,:) =  cp.*sy
        dcm(2,2,:) =  cr.*cy + sr.*sp.*sy
        dcm(2,3,:) = -sr.*cy + cr.*sp.*sy
        dcm(3,1,:) = -sp
        dcm(3,2,:) =  sr.*cp
        dcm(3,3,:) =  cr.*cp
% TODO(Julia->MATLAB): elseif order == 'nav2body' % Cbn, used by John Raquet in RpyToDcm()
        dcm(1,1,:) =  cp.*cy
        dcm(1,2,:) =  cp.*sy
        dcm(1,3,:) = -sp
        dcm(2,1,:) = -cr.*sy + sr.*sp.*cy
        dcm(2,2,:) =  cr.*cy + sr.*sp.*sy
        dcm(2,3,:) =  sr.*cp
        dcm(3,1,:) =  sr.*sy + cr.*sp.*cy
        dcm(3,2,:) = -sr.*cy + cr.*sp.*sy
        dcm(3,3,:) =  cr.*cp
    else
% TODO(Julia->MATLAB): error("DCM rotation $order order not defined")
    end
end
