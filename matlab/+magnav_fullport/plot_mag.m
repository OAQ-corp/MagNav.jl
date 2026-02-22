% Auto-generated from src/baseline_plots.jl
% Original Julia signature: function plot_mag(xyz::XYZ; ind                       = trues(xyz.traj.N),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = plot_mag(xyz, varargin)
    out = [];
                  ind                       = trues(xyz.traj.N),
% TODO(Julia->MATLAB): detrend_data::Bool        = false,
% TODO(Julia->MATLAB): use_mags::Vector{Symbol}  = [:all_mags],
% TODO(Julia->MATLAB): vec_terms::Vector{Symbol} = [:all],
% TODO(Julia->MATLAB): ylim::Tuple               = (),
% TODO(Julia->MATLAB): dpi::Int                  = 200,
% TODO(Julia->MATLAB): show_plot::Bool           = true,
% TODO(Julia->MATLAB): save_plot::Bool           = false,
% TODO(Julia->MATLAB): plot_png::String          = "scalar_mags.png")

% TODO(Julia->MATLAB): tt = (xyz.traj.tt(ind) .- xyz.traj.tt(ind)[1]) / 60
    xlab = "time [min]"

    fields   = fieldnames(typeof(xyz))
% TODO(Julia->MATLAB): list_c   = [Symbol("mag_",i,"_c" ) for i = 1:num_mag_max]
% TODO(Julia->MATLAB): list_uc  = [Symbol("mag_",i,"_uc") for i = 1:num_mag_max]
    mags_c   = list_c(  list_c  .∈ (fields,))
    mags_uc  = list_uc( list_uc .∈ (fields,))
    mags_c_  = findall((list_c  .∈ (fields,)) .& (list_uc .∈ (fields,)))
    mags_uc_ = findall((list_c  .∈ (fields,)) .& (list_uc .∈ (fields,)))
    mags_all = [mags_c; mags_uc]

% TODO(Julia->MATLAB): if :comp_mags in use_mags

        ylab = "magnetic field error [nT]"

        if isempty(ylim)
            p1 = plot(lw=2,dpi=dpi,xlab=xlab,ylab=ylab)
        else
            p1 = plot(lw=2,dpi=dpi,xlab=xlab,ylab=ylab,ylim=ylim)
        end
end
