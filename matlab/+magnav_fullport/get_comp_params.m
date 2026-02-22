% Auto-generated from src/get_map.jl
% Original Julia signature: function get_comp_params(comp_params_bson::String, silent::Bool = false)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_comp_params(comp_params_bson, silent)
    out = [];

    comp_params_bson = add_extension(comp_params_bson,".bson")

% TODO(Julia->MATLAB): % load in fields of comp_params
    d = load(comp_params_bson)
% TODO(Julia->MATLAB): model_type  = :model_type in keys(d) ? d(:model_type) : []
    comp_params = []

% TODO(Julia->MATLAB): % get default field values (in case not in saved comp_params)
% TODO(Julia->MATLAB): if model_type in [:m1,:m2a,:m2b,:m2c,:m2d,:m3tl,:m3s,:m3v,:m3sc,:m3vc,:m3w,:m3tf]
        comp_params_default = NNCompParams()
% TODO(Julia->MATLAB): silent || @info("loading individual model $model_type NN compensation parameters")
% TODO(Julia->MATLAB): elseif model_type in [:TL,:mod_TL,:map_TL,:elasticnet,:plsr]
        comp_params_default = LinCompParams()
% TODO(Julia->MATLAB): silent || @info("loading individual model $model_type linear compensation parameters")
    else
        try
% TODO(Julia->MATLAB): comp_params = d(:comp_params)
            comp_params_default = []
% TODO(Julia->MATLAB): silent || @info("loading full compensation parameters struct")
        catch _
% TODO(Julia->MATLAB): error("$comp_params_bson compensation parameters BSON file is invalid")
        end
end
