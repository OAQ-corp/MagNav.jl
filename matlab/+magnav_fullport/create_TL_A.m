% Auto-generated from src/tolles_lawson.jl
% Original Julia signature: function create_TL_A(Bx, By, Bz; Bt       = sqrt.(Bx.^2+By.^2+Bz.^2),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = create_TL_A(Bx, By, Bz, varargin)
    out = [];
                     Bt       = sqrt(Bx.^2+By.^2+Bz.^2),
% TODO(Julia->MATLAB): terms    = [:permanent,:induced,:eddy],
                     Bt_scale = 50000,
                     return_B = false)

    terms = [terms;] % ensure vector

    Bx_hat = Bx ./ Bt
    By_hat = By ./ Bt
    Bz_hat = Bz ./ Bt

    Bx_dot = fdm(Bx)
    By_dot = fdm(By)
    Bz_dot = fdm(Bz)

    Bx_hat_Bx = Bx_hat .* Bx ./ Bt_scale
    Bx_hat_By = Bx_hat .* By ./ Bt_scale
    Bx_hat_Bz = Bx_hat .* Bz ./ Bt_scale
    By_hat_By = By_hat .* By ./ Bt_scale
    By_hat_Bz = By_hat .* Bz ./ Bt_scale
    Bz_hat_Bz = Bz_hat .* Bz ./ Bt_scale

    Bx_hat_Bx_dot = Bx_hat .* Bx_dot ./ Bt_scale
    Bx_hat_By_dot = Bx_hat .* By_dot ./ Bt_scale
    Bx_hat_Bz_dot = Bx_hat .* Bz_dot ./ Bt_scale
    By_hat_Bx_dot = By_hat .* Bx_dot ./ Bt_scale
    By_hat_By_dot = By_hat .* By_dot ./ Bt_scale
    By_hat_Bz_dot = By_hat .* Bz_dot ./ Bt_scale
    Bz_hat_Bx_dot = Bz_hat .* Bx_dot ./ Bt_scale
    Bz_hat_By_dot = Bz_hat .* By_dot ./ Bt_scale
    Bz_hat_Bz_dot = Bz_hat .* Bz_dot ./ Bt_scale

    % %* note: original (slightly incorrect) eddy current terms
    % Bx_hat_Bx_dot = Bx_hat .* fdm(Bx_hat) .* Bt ./ Bt_scale
    % Bx_hat_By_dot = Bx_hat .* fdm(By_hat) .* Bt ./ Bt_scale
    % Bx_hat_Bz_dot = Bx_hat .* fdm(Bz_hat) .* Bt ./ Bt_scale
    % By_hat_Bx_dot = By_hat .* fdm(Bx_hat) .* Bt ./ Bt_scale
    % By_hat_By_dot = By_hat .* fdm(By_hat) .* Bt ./ Bt_scale
    % By_hat_Bz_dot = By_hat .* fdm(Bz_hat) .* Bt ./ Bt_scale
    % Bz_hat_Bx_dot = Bz_hat .* fdm(Bx_hat) .* Bt ./ Bt_scale
    % Bz_hat_By_dot = Bz_hat .* fdm(By_hat) .* Bt ./ Bt_scale
    % Bz_hat_Bz_dot = Bz_hat .* fdm(Bz_hat) .* Bt ./ Bt_scale

    A = Matrix{eltype(Bt)}(undef,length(Bt),0)

    % add (3) permanent field terms - all
% TODO(Julia->MATLAB): if any([:permanent,:p,:permanent3,:p3] .∈ (terms,))
    	A = [A Bx_hat By_hat Bz_hat]
    end
end
