% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function clear_fields(data_h5::String)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function nothing = clear_fields(data_h5)
    nothing = [];
    data_h5 = add_extension(data_h5,".h5")
    file    = h5open(data_h5,"cw") % read-write, create file if not existing, preserve existing contents
    close(file)
    file    = h5open(data_h5,"w") % read-write, destroy existing contents
    close(file)
% return ([])
end % function clear_fields
end
