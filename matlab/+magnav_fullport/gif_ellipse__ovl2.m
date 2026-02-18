% Auto-generated from src/eval_filt.jl
% Original Julia signature: function gif_ellipse(filt_res::FILTres, filt_out::FILTout, map_map::Map         = mapS_null; dt                   = 0.1, di::Int              = 10, speedup::Int         = 60, conf_units::Symbol   = :m, μ                    = zeros(eltype(filt_res.P),2),
% Mechanical conversion draft: review before production use.
function out = gif_ellipse__ovl2(filt_res, filt_out, map_map, varargin)
                     filt_out::FILTout,
                     map_map::Map         = mapS_null;
                     dt                   = 0.1,
                     di::Int              = 10,
                     speedup::Int         = 60,
                     conf_units::Symbol   = :m,
                     μ                    = zeros(eltype(filt_res.P),2),
                     conf                 = 0.95,
                     clip                 = Inf,
                     n::Int               = 61,
                     lim                  = 500,
                     dpi::Int             = 200,
                     margin::Int          = 2,
                     axis::Bool           = true,
                     plot_eigax::Bool     = false,
                     bg_color::Symbol     = :white,
                     ce_color::Symbol     = :black,
                     map_color::Symbol    = :usgs,
                     clims::Tuple         = (),
                     b_e::AbstractBackend = gr(),
                     save_plot::Bool      = false,
                     ellipse_gif::String  = "conf_ellipse.gif")

    dx = dlon2de(get_step(map_map.xx),mean(map_map.yy))
    dy = dlat2dn(get_step(map_map.yy),mean(map_map.yy))

    if !any(iszero.([dx,dy]) .| isnan.([dx,dy])) & isempty(clims)
        num = ceil(Int,1.5*lim/minimum([dx,dy]))
        x1  = findmin(abs.(map_map.xx.-minimum(filt_out.lon)))[2]
        x2  = findmin(abs.(map_map.xx.-maximum(filt_out.lon)))[2]
        y1  = findmin(abs.(map_map.yy.-minimum(filt_out.lat)))[2]
        y2  = findmin(abs.(map_map.yy.-maximum(filt_out.lat)))[2]
        (x1,x2)   = sort([x1,x2])
        (y1,y2)   = sort([y1,y2])
        (_,clims) = map_clims(map_cs(map_color),map_map.map[y1:y2,x1:x2,1])
    end
end
