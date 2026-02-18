% Auto-generated from src/get_map.jl
% Original Julia signature: function save_comp_params(comp_params::CompParams, comp_params_bson::String = "comp_params.bson")
% Mechanical conversion draft: review before production use.
function out = save_comp_params(comp_params, comp_params_bson)
                          comp_params_bson::String = "comp_params.bson")
    comp_params_bson = add_extension(comp_params_bson,".bson")
    d = Dict{Symbol,Any}()
    % push!(d,:comp_params => comp_params) % do NOT do this, version issue
    for field in fieldnames(typeof(comp_params))
        push!(d,field => getfield(comp_params,field))
    end
end
