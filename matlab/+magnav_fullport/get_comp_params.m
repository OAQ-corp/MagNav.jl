% Auto-generated from src/get_map.jl
% Original Julia signature: function get_comp_params(comp_params_bson::String, silent::Bool = false)
% Mechanical conversion draft: review before production use.
function out = get_comp_params(comp_params_bson, silent)

    comp_params_bson = add_extension(comp_params_bson,".bson")

    % load in fields of comp_params
    d = load(comp_params_bson)
    model_type  = :model_type in keys(d) ? d[:model_type] : nothing
    comp_params = nothing

    % get default field values (in case not in saved comp_params)
    if model_type in [:m1,:m2a,:m2b,:m2c,:m2d,:m3tl,:m3s,:m3v,:m3sc,:m3vc,:m3w,:m3tf]
        comp_params_default = NNCompParams()
        silent || @info("loading individual model $model_type NN compensation parameters")
    elseif model_type in [:TL,:mod_TL,:map_TL,:elasticnet,:plsr]
        comp_params_default = LinCompParams()
        silent || @info("loading individual model $model_type linear compensation parameters")
    else
        try
            comp_params = d[:comp_params]
            comp_params_default = nothing
            silent || @info("loading full compensation parameters struct")
        catch _
            error("$comp_params_bson compensation parameters BSON file is invalid")
        end
end
