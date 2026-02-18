% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function write_field(data_h5::String, field, data)
% Mechanical conversion draft: review before production use.
function out = write_field(data_h5, field, data)
    data_h5 = add_extension(data_h5,".h5")
    field   = String(field)
    h5open(data_h5,"cw") do file % read-write, create file if not existing, preserve existing contents
        write(file,field,data)
    end
end
