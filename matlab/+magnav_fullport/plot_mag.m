% Auto-generated from src/baseline_plots.jl
% Original Julia signature: function plot_mag(xyz::XYZ; ind                       = trues(xyz.traj.N),
% Mechanical conversion draft: review before production use.
function out = plot_mag(xyz, varargin)
                  ind                       = trues(xyz.traj.N),
                  detrend_data::Bool        = false,
                  use_mags::Vector{Symbol}  = [:all_mags],
                  vec_terms::Vector{Symbol} = [:all],
                  ylim::Tuple               = (),
                  dpi::Int                  = 200,
                  show_plot::Bool           = true,
                  save_plot::Bool           = false,
                  plot_png::String          = "scalar_mags.png")

    tt = (xyz.traj.tt[ind] .- xyz.traj.tt[ind][1]) / 60
    xlab = "time [min]"

    fields   = fieldnames(typeof(xyz))
    list_c   = [Symbol("mag_",i,"_c" ) for i = 1:num_mag_max]
    list_uc  = [Symbol("mag_",i,"_uc") for i = 1:num_mag_max]
    mags_c   = list_c[  list_c  .∈ (fields,)]
    mags_uc  = list_uc[ list_uc .∈ (fields,)]
    mags_c_  = findall((list_c  .∈ (fields,)) .& (list_uc .∈ (fields,)))
    mags_uc_ = findall((list_c  .∈ (fields,)) .& (list_uc .∈ (fields,)))
    mags_all = [mags_c; mags_uc]

    if :comp_mags in use_mags

        ylab = "magnetic field error [nT]"

        if isempty(ylim)
            p1 = plot(lw=2,dpi=dpi,xlab=xlab,ylab=ylab)
        else
            p1 = plot(lw=2,dpi=dpi,xlab=xlab,ylab=ylab,ylim=ylim)
        end
end
