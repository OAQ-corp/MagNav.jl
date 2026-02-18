% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function add_extension(data_file::String, extension::String)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = add_extension(data_file, extension)
    out = [];
    f = data_file
    e = extension
    l = length(e)
    length(f) <= l && (return f*e)
% TODO(Julia->MATLAB): f = lowercase(f(end-l+1:end)) == lowercase(e) ? f : f*e
end % function add_extension
end
