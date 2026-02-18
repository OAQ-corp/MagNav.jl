% Auto-generated from src/analysis_util.jl
% Original Julia signature: function unpack_data_norms(data_norms::Tuple)
% Mechanical conversion draft: review before production use.
function out = unpack_data_norms(data_norms)
    if length(data_norms) == 7
        (A_bias,A_scale,v_scale,x_bias,x_scale,y_bias,y_scale) = data_norms
    elseif length(data_norms) == 6
        (A_bias,A_scale,x_bias,x_scale,y_bias,y_scale) = data_norms
        v_scale = I(size(x_scale,2))
    elseif length(data_norms) == 5
        (v_scale,x_bias,x_scale,y_bias,y_scale) = data_norms
        (A_bias,A_scale) = (0,1)
    elseif length(data_norms) == 4
        (x_bias,x_scale,y_bias,y_scale) = data_norms
        (A_bias,A_scale) = (0,1)
        v_scale = I(size(x_scale,2))
    elseif length(data_norms) > 7
        error("length of data_norms = $(length(data_norms)) > 7")
    else
        error("length of data_norms = $(length(data_norms)) < 4")
    end
end
