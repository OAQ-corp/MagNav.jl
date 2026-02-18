% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_interpolate(mapS::Union{MapS,MapSd,MapS3D}, type::Symbol = :cubic; return_vert_deriv::Bool = false)
% Mechanical conversion draft: review before production use.
function type = map_interpolate__ovl2(mapS, MapSd, MapS3D_, type, varargin)
                         return_vert_deriv::Bool = false)

    if return_vert_deriv
        if mapS isa Union{MapS,MapSd}
            map_map = upward_fft(mapS,mapS.alt+1).map - mapS.map
                    map_itp( map_map,mapS.xx,mapS.yy,type))
        elseif mapS isa MapS3D
            map_map = zero.(mapS.map)
            for i in eachindex(mapS.alt)
                mapS_ = MapS(mapS.info,mapS.map[:,:,i],
                             mapS.xx,mapS.yy,mapS.alt[i],mapS.mask[:,:,i])
                map_map[:,:,i] = upward_fft(mapS_,mapS_.alt+1).map - mapS.map[:,:,i]
            end
end
