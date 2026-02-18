% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function read_field(data_h5::String, field)
% Mechanical conversion draft: review before production use.
function out = read_field(data_h5, field)
    data_h5 = add_extension(data_h5,".h5")
    field   = String(field)
    h5open(data_h5,"r") do file % read-only
        read(file,field)
    end
end
