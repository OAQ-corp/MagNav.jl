% Auto-generated from src/map_fft.jl
% Original Julia signature: function smooth7(x::Int)
% Mechanical conversion draft: review before production use.
function out = smooth7(x)
    y = 2*x
    for i = 0:ceil(Int,log(7,x))
        for j = 0:ceil(Int,log(5,x))
            for k = 0:ceil(Int,log(3,x))
                z = 7^i*5^j*3^k
                z < 2*x && (y = min(y, 2^ceil(Int,log(2,x/z))*z))
            end
end
