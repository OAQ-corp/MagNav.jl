% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_cs(map_color::Symbol = :usgs)
% Mechanical conversion draft: review before production use.
function out = map_cs(map_color)

    if map_color == :usgs % standard for geological maps
        f = readdlm(usgs,',')
        c = cgrad([RGB(f[i,:]...) for i in axes(f,1)])
    elseif map_color == :gray % light gray
        c = cgrad(cgrad(:gist_gray)[61:90])
    elseif map_color == :gray1 % light gray (lower end)
        c = cgrad(cgrad(:gist_gray)[61:81])
    elseif map_color == :gray2 % light gray (upper end)
        c = cgrad(cgrad(:gist_gray)[71:90])
    else % :plasma, :magma
        c = cgrad(map_color)
    end
end
