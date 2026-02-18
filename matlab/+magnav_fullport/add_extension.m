% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function add_extension(data_file::String, extension::String)
% Mechanical conversion draft: review before production use.
function out = add_extension(data_file, extension)
    f = data_file
    e = extension
    l = length(e)
    length(f) <= l && (return f*e)
    f = lowercase(f[end-l+1:end]) == lowercase(e) ? f : f*e
end % function add_extension
end
