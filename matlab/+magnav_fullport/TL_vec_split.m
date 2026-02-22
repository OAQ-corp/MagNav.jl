% Auto-generated from src/compensation.jl
% Original Julia signature: function TL_vec_split(TL_coef::Vector, terms)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = TL_vec_split(TL_coef, terms)
    out = [];
% TODO(Julia->MATLAB): assert any([:permanent,:p,:permanent3,:p3] .∈ (terms,)) "permanent terms are required"
% TODO(Julia->MATLAB): assert any([:induced,:i,:induced6,:i6,:induced5,:i5,:induced3,:i3] .∈ (terms,)) "induced terms are required"
% TODO(Julia->MATLAB): assert !any([:fdm,:f,:fdm3,:f3,:bias,:b] .∈ (terms,)) "derivative & bias terms may not be used"

    N = length(TL_coef)
    A_test = create_TL_A([1.0],[1.0],[1.0];terms=terms)
    assert N == length(A_test) "TL_coef does not agree with specified terms"

    TL_p = TL_coef(1:3)

% TODO(Julia->MATLAB): if any([:induced,:i,:induced6,:i6] .∈ (terms,))
        TL_i = TL_coef(4:9)
% TODO(Julia->MATLAB): elseif any([:induced5,:i5] .∈ (terms,))
        TL_i = TL_coef(4:8)
% TODO(Julia->MATLAB): elseif any([:induced3,:i3] .∈ (terms,))
        TL_i = TL_coef(4:6)
    end
end
