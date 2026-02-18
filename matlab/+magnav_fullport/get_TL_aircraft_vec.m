% Auto-generated from src/compensation.jl
% Original Julia signature: function get_TL_aircraft_vec(B_vec, B_vec_dot, TL_coef_p, TL_coef_i, TL_coef_e; return_parts::Bool = false)
% Mechanical conversion draft: review before production use.
function out = get_TL_aircraft_vec(B_vec, B_vec_dot, TL_coef_p, TL_coef_i, TL_coef_e, varargin)
                             return_parts::Bool = false)

    TL_perm    = TL_coef_p .* one.(B_vec)
    TL_induced = TL_coef_i * B_vec

    if length(TL_coef_e) > 0
        TL_eddy     = TL_coef_e * B_vec_dot
        TL_aircraft = TL_perm + TL_induced + TL_eddy
    else
        TL_eddy     = []
        TL_aircraft = TL_perm + TL_induced
    end
end
