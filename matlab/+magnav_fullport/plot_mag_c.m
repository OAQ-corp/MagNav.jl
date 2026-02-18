% Auto-generated from src/baseline_plots.jl
% Original Julia signature: function plot_mag_c(xyz::XYZ,xyz_comp::XYZ; ind                      = trues(xyz.traj.N),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = plot_mag_c(xyz, xyz_comp, varargin)
    out = [];
                    ind                      = trues(xyz.traj.N),
                    ind_comp                 = trues(xyz_comp.traj.N),
% TODO(Julia->MATLAB): detrend_data::Bool       = true,
                    λ                        = 0.025,
% TODO(Julia->MATLAB): terms                    = [:permanent,:induced,:eddy],
                    pass1                    = 0.1,
                    pass2                    = 0.9,
                    fs                       = 10.0,
% TODO(Julia->MATLAB): use_mags::Vector{Symbol} = [:all_mags],
% TODO(Julia->MATLAB): use_vec::Symbol          = :flux_a,
% TODO(Julia->MATLAB): plot_diff::Bool          = false,
% TODO(Julia->MATLAB): plot_mag_1_uc::Bool      = true,
% TODO(Julia->MATLAB): plot_mag_1_c::Bool       = true,
% TODO(Julia->MATLAB): dpi::Int                 = 200,
                    ylim                     = (),
% TODO(Julia->MATLAB): show_plot::Bool          = true,
% TODO(Julia->MATLAB): save_plot::Bool          = false,
% TODO(Julia->MATLAB): plot_png::String         = "scalar_mags_comp.png")

    field_check(xyz,use_vec,MagV)
% TODO(Julia->MATLAB): A = create_TL_A(getfield(xyz,use_vec),terms=terms)[ind,:]

% TODO(Julia->MATLAB): tt       = (xyz.traj.tt(ind) .- xyz.traj.tt(ind)[1]) / 60
    mag_1_c  = detrend_data ? detrend(xyz.mag_1_c(ind )) : xyz.mag_1_c(ind)
    mag_1_uc = detrend_data ? detrend(xyz.mag_1_uc(ind)) : xyz.mag_1_uc(ind)

    xlab = "time [min]"
    ylab = "magnetic field [nT]"

    if isempty(ylim)
        p1 = plot(lw=2,dpi=dpi,xlab=xlab,ylab=ylab)
    else
        p1 = plot(lw=2,dpi=dpi,xlab=xlab,ylab=ylab,ylim=ylim)
    end
end
