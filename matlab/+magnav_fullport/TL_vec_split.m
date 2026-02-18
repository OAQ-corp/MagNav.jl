% Auto-generated from src/compensation.jl
% Original Julia signature: function TL_vec_split(TL_coef::Vector, terms)
% Mechanical conversion draft: review before production use.
function out = TL_vec_split(TL_coef, terms)
    assert any([:permanent,:p,:permanent3,:p3] .∈ (terms,)) "permanent terms are required"
    assert any([:induced,:i,:induced6,:i6,:induced5,:i5,:induced3,:i3] .∈ (terms,)) "induced terms are required"
    assert !any([:fdm,:f,:fdm3,:f3,:bias,:b] .∈ (terms,)) "derivative & bias terms may not be used"

    N = length(TL_coef)
    A_test = create_TL_A([1.0],[1.0],[1.0];terms=terms)
    assert N == length(A_test) "TL_coef does not agree with specified terms"

    TL_p = TL_coef[1:3]

    if any([:induced,:i,:induced6,:i6] .∈ (terms,))
        TL_i = TL_coef[4:9]
    elseif any([:induced5,:i5] .∈ (terms,))
        TL_i = TL_coef[4:8]
    elseif any([:induced3,:i3] .∈ (terms,))
        TL_i = TL_coef[4:6]
    end
end
