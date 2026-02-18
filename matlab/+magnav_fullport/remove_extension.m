% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function remove_extension(data_file::String, extension::String)
% Mechanical conversion draft: review before production use.
function out = remove_extension(data_file, extension)
    f = data_file
    e = extension
    l = length(e)
    length(f) <= l && (return f)
    f = lowercase(f[end-l+1:end]) == lowercase(e) ? f[1:end-l] : f
end % function remove_extension
end
