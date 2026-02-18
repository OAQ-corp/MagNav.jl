% Auto-generated from src/tolles_lawson.jl
% Original Julia signature: function create_TL_coef(flux::MagV, B, ind = trues(length(flux.x));
% Mechanical conversion draft: review before production use.
function out = create_TL_coef__ovl2(flux, B, ind)
                        Bt         = sqrt.(flux.x.^2+flux.y.^2+flux.z.^2)[ind],
                        λ          = 0,
                        terms      = [:permanent,:induced,:eddy],
                        pass1      = 0.1,
                        pass2      = 0.9,
                        fs         = 10.0,
                        pole::Int  = 4,
                        trim::Int  = 20,
                        Bt_scale   = 50000,
                        return_var = false)
    length(Bt) ~= length(flux.x[ind]) && (Bt = Bt[ind])
    create_TL_coef(flux.x[ind],flux.y[ind],flux.z[ind],B[ind];
                   Bt=Bt,λ=λ,terms=terms,pass1=pass1,pass2=pass2,fs=fs,
                   pole=pole,trim=trim,Bt_scale=Bt_scale,return_var=return_var)
end % function create_TL_coef
end
