% Auto-generated from src/analysis_util.jl
% Original Julia signature: function unpack_data_norms(data_norms::Tuple)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = unpack_data_norms(data_norms)
    out = [];
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
% TODO(Julia->MATLAB): error("length of data_norms = $(length(data_norms)) > 7")
    else
% TODO(Julia->MATLAB): error("length of data_norms = $(length(data_norms)) < 4")
    end
end
