% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function overwrite_field(data_h5::String, field, data)
% Mechanical conversion draft: review before production use.
function nothing = overwrite_field(data_h5, field, data)
    data_h5 = add_extension(data_h5,".h5")
    field   = String(field)
    delete_field(data_h5,field)
    write_field(data_h5,field,data)
end % function overwrite_field
end
