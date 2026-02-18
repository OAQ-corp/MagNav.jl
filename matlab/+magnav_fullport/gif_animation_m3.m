% Auto-generated from src/analysis_util.jl
% Original Julia signature: function gif_animation_m3(TL_perm::AbstractMatrix, TL_induced::AbstractMatrix, TL_eddy::AbstractMatrix, TL_aircraft::AbstractMatrix, B_unit::AbstractMatrix, y_nn::AbstractMatrix, y::Vector, y_hat::Vector, xyz::XYZ, filt_lat::Vector = [], filt_lon::Vector = []; ind              = trues(xyz.traj.N),
% Mechanical conversion draft: review before production use.
function out = gif_animation_m3(TL_perm, TL_induced, TL_eddy, TL_aircraft, B_unit, y_nn, y, y_hat, xyz, filt_lat, filt_lon, varargin)
                          TL_aircraft::AbstractMatrix, B_unit::AbstractMatrix, y_nn::AbstractMatrix,
                          y::Vector, y_hat::Vector, xyz::XYZ,
                          filt_lat::Vector = [],
                          filt_lon::Vector = [];
                          ind              = trues(xyz.traj.N),
                          tt_lim::Tuple    = (0, (xyz.traj(ind).N-1)*xyz.traj.dt/60),
                          skip_every::Int  = 5,
                          save_plot::Bool  = false,
                          mag_gif::String  = "comp_xai.gif")

    assert size(TL_perm,2) == size(TL_induced,2) == size(TL_eddy,2) == size(TL_aircraft,2) == size(B_unit,2)
    assert size(y_nn,2) == length(y) == length(y_hat) == xyz.traj(ind).N
    assert 0 < skip_every < xyz.traj(ind).N

    show_ins  = false
    show_filt = length(filt_lat) == length(filt_lon) == xyz.traj(ind).N

    % extract lat & lon
    traj     = xyz.traj(ind)
    ins      = xyz.ins(ind)
    filt_lat = rad2deg.(filt_lat)
    filt_lon = rad2deg.(filt_lon)
    gps_lat  = rad2deg.(traj.lat)
    gps_lon  = rad2deg.(traj.lon)

    xlim = get_lim(gps_lon,0.2)
    ylim = get_lim(gps_lat,0.2)
    ves  = traj.ve
    vns  = traj.vn
    dir  = atand.(vns,ves)

    % convert fields to 2D "compass" projections
    igrf_nav = get_igrf(xyz,ind;
                        frame     = :nav,
                        norm_igrf = true,
                        check_xyz = true)

    % compute dot product component of each field
    NN_comp = vec(sum(y_nn        .* B_unit, dims=1))
    TL_comp = vec(sum(TL_aircraft .* B_unit, dims=1))

    % %* note: body field can be projected onto 3D IGRF vector for full picture
    % most of the 3D vector may be in the "down" direction, which makes
    % the 2D plane tilt down towards the north pole. A remedy is to drop the
    % z-dimension and treat it like a compass, which is shown here.
    igrf_nav_2D = reduce(hcat, igrf_nav)
    igrf_nav_2D[3,:] .= 0.0
    normalize!.(eachcol(igrf_nav_2D))

    Cnb = iszero(traj.Cnb) ? ins.Cnb : traj.Cnb % body to navigation
    aircraft_2D_NN = project_body_field_to_2d_igrf.(eachcol(y_nn       ),eachcol(igrf_nav_2D),eachslice(Cnb,dims=3))
    aircraft_2D_TL = project_body_field_to_2d_igrf.(eachcol(TL_aircraft),eachcol(igrf_nav_2D),eachslice(Cnb,dims=3))
    perm_field_2D  = project_body_field_to_2d_igrf.(eachcol(TL_perm    ),eachcol(igrf_nav_2D),eachslice(Cnb,dims=3))
    ind_field_2D   = project_body_field_to_2d_igrf.(eachcol(TL_induced ),eachcol(igrf_nav_2D),eachslice(Cnb,dims=3))
    eddy_field_2D  = project_body_field_to_2d_igrf.(eachcol(TL_eddy    ),eachcol(igrf_nav_2D),eachslice(Cnb,dims=3))

    aircraft_2D_NN = reduce(hcat,aircraft_2D_NN)
    aircraft_2D_TL = reduce(hcat,aircraft_2D_TL)
    perm_field_2D  = reduce(hcat,perm_field_2D)
    ind_field_2D   = reduce(hcat,ind_field_2D)
    eddy_field_2D  = reduce(hcat,eddy_field_2D)

    tt      = (traj.tt .- traj.tt[1]) / 60
    i_start = findfirst(tt .>= tt_lim[1])
    i_end   = findlast( tt .<= tt_lim[2])

    % create gif
    l  = @layout [ a{0.6w} [b;c] ]
    p1 = plot(layout=l, size=(800,500), margin=4*mm)
    a1 = Animation()

    for i in i_start:skip_every:i_end
        p1 = plot(layout=l, size=(800,500), margin=4*mm)

        % move a vertical line across the magnetic field data
        plot!(p1[1],xlab="time [min]",ylab=" magnetic field [nT]",
              xlim=tt_lim,legend=:bottomleft)
        plot!(p1[1],tt,y      ,lab="true compensation"   ,lc=:gray, ls=:dash)
        plot!(p1[1],tt,y_hat  ,lab="model 3 compensation",lc=:black)
        plot!(p1[1],tt,TL_comp,lab="TL component"        ,lc=:blue)
        plot!(p1[1],tt,NN_comp,lab="NN component"        ,lc=:red)
        plot!(p1[1],[tt[i]]   ,lab=""                    ,lc=:black, lt=:vline)

        % draw compass plot for each field
        plot!(p1[2],xlab="east [nT]",ylab=" north [nT]",
              xlim=(-2500,2500),ylim=(-2500,2500),legend=:topright)
        plot!(p1[2],[0.0,aircraft_2D_TL[2,i]],[0.0,aircraft_2D_TL[1,i]],arrow=true,lab="TL",lc=:blue)
        plot!(p1[2],[0.0,aircraft_2D_NN[2,i]],[0.0,aircraft_2D_NN[1,i]],arrow=true,lab="NN",lc=:red)
        plot!(p1[2],[0.0,perm_field_2D[ 2,i]],[0.0,perm_field_2D[ 1,i]],arrow=true,lab="perm.")
        plot!(p1[2],[0.0,ind_field_2D[  2,i]],[0.0,ind_field_2D[  1,i]],arrow=true,lab="ind.")
        plot!(p1[2],[0.0,eddy_field_2D[ 2,i]],[0.0,eddy_field_2D[ 1,i]],arrow=true,lab="eddy")

        % plot airplane on map
        plot!(p1[3],xlab="longitude [deg]",ylab="latitude [deg]")
        plot!(p1[3],gps_lon[1:i] ,gps_lat[1:i] ,xlim=xlim,ylim=ylim,lab="GPS")
        show_ins  && (plot!(p1[3],ins_lon[1:i] ,ins_lat[1:i] ,xlim=xlim,ylim=ylim,lab="INS"))
        show_filt && (plot!(p1[3],filt_lon[1:i],filt_lat[1:i],xlim=xlim,ylim=ylim,lab="MagNav",xrotation=18))
        annotate!(gps_lon[i], gps_lat[i], Plots.text("✈", 20, rotation=dir[i]), subplot=3)

        frame(a1,p1)
    end
end
