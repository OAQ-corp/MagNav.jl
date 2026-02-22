function [roll, pitch, yaw] = dcm2euler(dcm, order)
%DCM2EULER Convert direction cosine matrix to roll/pitch/yaw Euler angles.
%   [ROLL, PITCH, YAW] = magnav.dcm2euler(DCM) assumes body-to-navigation
%   rotation order.
%
%   [ROLL, PITCH, YAW] = magnav.dcm2euler(DCM, ORDER) accepts:
%     - 'body2nav' (default)
%     - 'nav2body'
%
%   Input DCM is 3x3xN or 3x3. Outputs are Nx1 vectors, or scalars when N=1.

    if nargin < 2 || isempty(order)
        order = 'body2nav';
    end

    if ndims(dcm) == 2
        dcm = reshape(dcm, 3, 3, 1);
    end

    switch order
        case 'body2nav'
            roll  = atan2(squeeze(dcm(3,2,:)), squeeze(dcm(3,3,:)));
            pitch = -asin(squeeze(dcm(3,1,:)));
            yaw   = atan2(squeeze(dcm(2,1,:)), squeeze(dcm(1,1,:)));
        case 'nav2body'
            roll  = atan2(squeeze(dcm(2,3,:)), squeeze(dcm(3,3,:)));
            pitch = -asin(squeeze(dcm(1,3,:)));
            yaw   = atan2(squeeze(dcm(1,2,:)), squeeze(dcm(1,1,:)));
        otherwise
            error('DCM rotation %s order not defined', order);
    end

    if numel(roll) == 1
        roll = roll(1);
        pitch = pitch(1);
        yaw = yaw(1);
    else
        roll = roll(:);
        pitch = pitch(:);
        yaw = yaw(:);
    end
end
