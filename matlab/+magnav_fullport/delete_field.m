% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function delete_field(data_h5::String, field)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function nothing = delete_field(data_h5, field)
    nothing = [];
    data_h5 = add_extension(data_h5,".h5")
    field   = String(field)
    file    = h5open(data_h5,"r+") % read-write, preserve existing contents
    delete_object(file,field)
    close(file)
% return ([])
end % function delete_field
end
