% Auto-generated from src/get_map.jl
% Original Julia signature: function save_comp_params(comp_params::CompParams, comp_params_bson::String = "comp_params.bson")
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = save_comp_params(comp_params, comp_params_bson)
    out = [];
% TODO(Julia->MATLAB): comp_params_bson::String = "comp_params.bson")
    comp_params_bson = add_extension(comp_params_bson,".bson")
    d = Dict{Symbol,Any}()
% TODO(Julia->MATLAB): % push!(d,:comp_params => comp_params) % do NOT do this, version issue
% TODO(Julia->MATLAB): for field in fieldnames(typeof(comp_params))
% TODO(Julia->MATLAB): push!(d,field => getfield(comp_params,field))
    end
end
