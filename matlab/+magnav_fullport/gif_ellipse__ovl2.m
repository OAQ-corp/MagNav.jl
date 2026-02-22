% Auto-generated from src/eval_filt.jl
% Original Julia signature: function gif_ellipse(filt_res::FILTres, filt_out::FILTout, map_map::Map         = mapS_null; dt                   = 0.1, di::Int              = 10, speedup::Int         = 60, conf_units::Symbol   = :m, μ                    = zeros(eltype(filt_res.P),2),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = gif_ellipse__ovl2(filt_res, filt_out, map_map, varargin)
    out = [];
% TODO(Julia->MATLAB): filt_out::FILTout,
% TODO(Julia->MATLAB): map_map::Map         = mapS_null;
                     dt                   = 0.1,
% TODO(Julia->MATLAB): di::Int              = 10,
% TODO(Julia->MATLAB): speedup::Int         = 60,
% TODO(Julia->MATLAB): conf_units::Symbol   = :m,
                     μ                    = zeros(eltype(filt_res.P),2),
                     conf                 = 0.95,
                     clip                 = Inf,
% TODO(Julia->MATLAB): n::Int               = 61,
                     lim                  = 500,
% TODO(Julia->MATLAB): dpi::Int             = 200,
% TODO(Julia->MATLAB): margin::Int          = 2,
% TODO(Julia->MATLAB): axis::Bool           = true,
% TODO(Julia->MATLAB): plot_eigax::Bool     = false,
% TODO(Julia->MATLAB): bg_color::Symbol     = :white,
% TODO(Julia->MATLAB): ce_color::Symbol     = :black,
% TODO(Julia->MATLAB): map_color::Symbol    = :usgs,
% TODO(Julia->MATLAB): clims::Tuple         = (),
% TODO(Julia->MATLAB): b_e::AbstractBackend = gr(),
% TODO(Julia->MATLAB): save_plot::Bool      = false,
% TODO(Julia->MATLAB): ellipse_gif::String  = "conf_ellipse.gif")

    dx = dlon2de(get_step(map_map.xx),mean(map_map.yy))
    dy = dlat2dn(get_step(map_map.yy),mean(map_map.yy))

% TODO(Julia->MATLAB): if !any(iszero([dx,dy]) .| isnan([dx,dy])) & isempty(clims)
        num = ceil(Int,1.5*lim/minimum([dx,dy]))
% TODO(Julia->MATLAB): x1  = findmin(abs(map_map.xx.-minimum(filt_out.lon)))[2]
% TODO(Julia->MATLAB): x2  = findmin(abs(map_map.xx.-maximum(filt_out.lon)))[2]
% TODO(Julia->MATLAB): y1  = findmin(abs(map_map.yy.-minimum(filt_out.lat)))[2]
% TODO(Julia->MATLAB): y2  = findmin(abs(map_map.yy.-maximum(filt_out.lat)))[2]
        (x1,x2)   = sort([x1,x2])
        (y1,y2)   = sort([y1,y2])
% TODO(Julia->MATLAB): (_,clims) = map_clims(map_cs(map_color),map_map.map(y1:y2,x1:x2,1))
    end
end
