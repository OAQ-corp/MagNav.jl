% Auto-generated from src/tolles_lawson.jl
% Original Julia signature: function create_TL_A(flux::MagV, ind = trues(length(flux.x));
% Mechanical conversion draft: review before production use.
function out = create_TL_A__ovl2(flux, ind)
                     Bt       = sqrt.(flux.x.^2+flux.y.^2+flux.z.^2)[ind],
                     terms    = [:permanent,:induced,:eddy],
                     Bt_scale = 50000,
                     return_B = false)
    length(Bt) ~= length(flux.x[ind]) && (Bt = Bt[ind])
    create_TL_A(flux.x[ind],flux.y[ind],flux.z[ind];
                Bt=Bt,terms=terms,Bt_scale=Bt_scale,return_B=return_B)
end % function create_TL_A
end
