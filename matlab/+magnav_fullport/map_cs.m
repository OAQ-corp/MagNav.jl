% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_cs(map_color::Symbol = :usgs)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = map_cs(map_color)
    out = [];

% TODO(Julia->MATLAB): if map_color == :usgs % standard for geological maps
        f = readdlm(usgs,',')
% TODO(Julia->MATLAB): c = cgrad([RGB(f(i,:)...) for i in axes(f,1)])
% TODO(Julia->MATLAB): elseif map_color == :gray % light gray
% TODO(Julia->MATLAB): c = cgrad(cgrad(:gist_gray)[61:90])
% TODO(Julia->MATLAB): elseif map_color == :gray1 % light gray (lower end)
% TODO(Julia->MATLAB): c = cgrad(cgrad(:gist_gray)[61:81])
% TODO(Julia->MATLAB): elseif map_color == :gray2 % light gray (upper end)
% TODO(Julia->MATLAB): c = cgrad(cgrad(:gist_gray)[71:90])
% TODO(Julia->MATLAB): else % :plasma, :magma
        c = cgrad(map_color)
    end
end
