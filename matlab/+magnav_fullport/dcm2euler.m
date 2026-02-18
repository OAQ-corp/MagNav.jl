% Auto-generated from src/dcm.jl
% Original Julia signature: function dcm2euler(dcm, order::Symbol = :body2nav)
% Mechanical conversion draft: review before production use.
function out = dcm2euler(dcm, order)

    if order == 'body2nav' % Cnb, shown in Titterton & Weston (pg. 41)
        roll  =  atan.(dcm[3,2,:],dcm[3,3,:])
        pitch = -asin.(dcm[3,1,:])
        yaw   =  atan.(dcm[2,1,:],dcm[1,1,:])
    elseif order == 'nav2body' % Cbn, used by John Raquet in DcmToRpy()
        roll  =  atan.(dcm[2,3,:],dcm[3,3,:])
        pitch = -asin.(dcm[1,3,:])
        yaw   =  atan.(dcm[1,2,:],dcm[1,1,:])
    else
        error("DCM rotation $order order not defined")
    end
end
