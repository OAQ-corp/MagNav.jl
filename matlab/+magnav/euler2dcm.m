function dcm = euler2dcm(roll, pitch, yaw, order)
%EULER2DCM Convert roll/pitch/yaw Euler angles to direction cosine matrix.
%   DCM = magnav.euler2dcm(ROLL, PITCH, YAW) computes body-to-navigation
%   rotation matrices.
%
%   DCM = magnav.euler2dcm(..., ORDER) accepts:
%     - 'body2nav' (default)
%     - 'nav2body'
%
%   Inputs can be scalars or vectors of equal length. Output is 3x3xN for
%   vector inputs and 3x3 for scalar input.

    if nargin < 4 || isempty(order)
        order = 'body2nav';
    end

    roll = roll(:);
    pitch = pitch(:);
    yaw = yaw(:);

    assert(numel(roll) == numel(pitch) && numel(pitch) == numel(yaw), ...
        'roll, pitch, and yaw must be the same length');

    cr = cos(roll);
    sr = sin(roll);
    cp = cos(pitch);
    sp = sin(pitch);
    cy = cos(yaw);
    sy = sin(yaw);

    n = numel(roll);
    dcm = zeros(3, 3, n);

    switch order
        case 'body2nav'
            dcm(1,1,:) =  cp .* cy;
            dcm(1,2,:) = -cr .* sy + sr .* sp .* cy;
            dcm(1,3,:) =  sr .* sy + cr .* sp .* cy;
            dcm(2,1,:) =  cp .* sy;
            dcm(2,2,:) =  cr .* cy + sr .* sp .* sy;
            dcm(2,3,:) = -sr .* cy + cr .* sp .* sy;
            dcm(3,1,:) = -sp;
            dcm(3,2,:) =  sr .* cp;
            dcm(3,3,:) =  cr .* cp;
        case 'nav2body'
            dcm(1,1,:) =  cp .* cy;
            dcm(1,2,:) =  cp .* sy;
            dcm(1,3,:) = -sp;
            dcm(2,1,:) = -cr .* sy + sr .* sp .* cy;
            dcm(2,2,:) =  cr .* cy + sr .* sp .* sy;
            dcm(2,3,:) =  sr .* cp;
            dcm(3,1,:) =  sr .* sy + cr .* sp .* cy;
            dcm(3,2,:) = -sr .* cy + cr .* sp .* sy;
            dcm(3,3,:) =  cr .* cp;
        otherwise
            error('DCM rotation %s order not defined', order);
    end

    if n == 1
        dcm = dcm(:,:,1);
    end
end
