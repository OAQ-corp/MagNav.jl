% Auto-generated from src/dcm.jl
% Original Julia signature: function dcm2euler(dcm, order::Symbol = :body2nav)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = dcm2euler(dcm, order)
    out = [];

% TODO(Julia->MATLAB): if order == 'body2nav' % Cnb, shown in Titterton & Weston (pg. 41)
        roll  =  atan(dcm(3,2,:),dcm(3,3,:))
        pitch = -asin(dcm(3,1,:))
        yaw   =  atan(dcm(2,1,:),dcm(1,1,:))
% TODO(Julia->MATLAB): elseif order == 'nav2body' % Cbn, used by John Raquet in DcmToRpy()
        roll  =  atan(dcm(2,3,:),dcm(3,3,:))
        pitch = -asin(dcm(1,3,:))
        yaw   =  atan(dcm(1,2,:),dcm(1,1,:))
    else
% TODO(Julia->MATLAB): error("DCM rotation $order order not defined")
    end
end
