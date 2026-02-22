% Auto-generated from src/eval_filt.jl
% Original Julia signature: function units_ellipse(filt_res::FILTres, filt_out::FILTout; conf_units::Symbol = :m)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = units_ellipse__ovl2(filt_res, filt_out, varargin)
    out = [];
% TODO(Julia->MATLAB): conf_units::Symbol = :m)
    units_ellipse(float(filt_res.P(1:2,1:2,:));
                  conf_units = conf_units,
                  lat1       = mean(filt_out.lat))
end % function units_ellipse
end
