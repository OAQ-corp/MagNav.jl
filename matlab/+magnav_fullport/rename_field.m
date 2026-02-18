% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function rename_field(data_h5::String, field_old, field_new)
% Mechanical conversion draft: review before production use.
function nothing = rename_field(data_h5, field_old, field_new)
    data_h5   = add_extension(data_h5,".h5")
    field_old = String(field_old)
    field_new = String(field_new)
    data      = read_field(data_h5,field_old)
    delete_field(data_h5,field_old)
    write_field(data_h5,field_new,data)
end % function rename_field
end
