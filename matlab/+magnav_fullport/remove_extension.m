% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function remove_extension(data_file::String, extension::String)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = remove_extension(data_file, extension)
    out = [];
    f = data_file
    e = extension
    l = length(e)
    length(f) <= l && (return f)
% TODO(Julia->MATLAB): f = lowercase(f(end-l+1:end)) == lowercase(e) ? f(1:end-l) : f
end % function remove_extension
end
