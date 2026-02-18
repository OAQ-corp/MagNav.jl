% Auto-generated from src/compensation.jl
% Original Julia signature: function TL_mat2vec(TL_coef_p, TL_coef_i, TL_coef_e, terms; Bt_scale = 50000f0)
% Mechanical conversion draft: review before production use.
function out = TL_mat2vec(TL_coef_p, TL_coef_i, TL_coef_e, terms, varargin)

    if any([:induced,:i,:induced6,:i6] .∈ (terms,))
        TL_coef_i = [TL_coef_i[1,1:3]; TL_coef_i[2,2:3]; TL_coef_i[3,3]] * Bt_scale
        TL_coef_i[[2,3,5]] .*= 2
    elseif any([:induced5,:i5] .∈ (terms,))
        TL_coef_i = [TL_coef_i[1,1:3]; TL_coef_i[2,2:3]                ] * Bt_scale
        TL_coef_i[[2,3,5]] .*= 2
    elseif any([:induced3,:i3] .∈ (terms,))
        TL_coef_i = [TL_coef_i[1,1]  ; TL_coef_i[2,2]  ; TL_coef_i[3,3]] * Bt_scale
    end
end
