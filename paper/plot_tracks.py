#!/usr/bin/env python3
"""Geographic figures from the fgo_tracks.jl CSV dumps (real SGL Flt1003, 1003.02).

track_data.csv / map_grid.csv are produced by research/fgo_tracks.jl (also printed
to the CI log). Style follows paper/fig_style.py.
Run: python3 paper/plot_tracks.py -> paper/figs/fig_map.pdf, fig_poserr.pdf
"""
import os
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1.inset_locator import inset_axes

from fig_style import (apply_style, despine, COL_W,
                       C_PROPOSED, C_BASE1, C_REF)

apply_style()
HERE = os.path.dirname(__file__)
OUT = os.path.join(HERE, "figs"); os.makedirs(OUT, exist_ok=True)

t = np.genfromtxt(os.path.join(HERE, "track_data.csv"), delimiter=",", names=True)
with open(os.path.join(HERE, "map_grid.csv")) as f:
    f.readline()
    nlat, nlon, latlo, lathi, lonlo, lonhi = [float(x) for x in f.readline().split(",")]
    grid = np.loadtxt(f, delimiter=",")


def fig_map():
    """Geographic context: the flight line over the anomaly field, with a zoom
    on the fine anomaly structure the map-matching factor exploits. The
    estimator-vs-estimator comparison is in Figs. for error/CDF, not here:
    at ~80 m/s a meter-level track error is smaller than one 12 s sample and
    cannot be resolved on a map."""
    from mpl_toolkits.axes_grid1.inset_locator import mark_inset
    fig, ax = plt.subplots(figsize=(COL_W, 3.1))
    im = ax.imshow(grid, extent=[lonlo, lonhi, latlo, lathi], origin="lower",
                   cmap="RdBu_r", aspect="auto", alpha=0.95,
                   vmin=np.percentile(grid, 2), vmax=np.percentile(grid, 98))
    ax.plot(t["tlon"], t["tlat"], "-", color="k", lw=1.6,
            solid_capstyle="round", solid_joinstyle="round")
    cb = fig.colorbar(im, ax=ax, fraction=0.046, pad=0.02)
    cb.set_label("map anomaly [nT]", fontsize=8)
    cb.ax.tick_params(labelsize=7)
    ax.set_xlabel("longitude [deg]")
    ax.set_ylabel("latitude [deg]")
    # direct label on the flight line, parked in a track-free corner with a
    # light halo box so it never sits on the black line
    ax.text(0.03, 0.965, "flight line 1003.02", transform=ax.transAxes,
            fontsize=7.5, fontweight="bold", color="k", va="top", ha="left",
            bbox=dict(boxstyle="round,pad=0.25", fc="white", ec="0.6", lw=0.6,
                      alpha=0.85))

    # inset: zoom on a strong-gradient patch the line crosses (why map-matching
    # is well conditioned here) -- NOT an estimator comparison
    zlon = (-75.99, -75.84); zlat = (44.66, 44.80)
    axin = inset_axes(ax, width="38%", height="38%", loc="lower left",
                      bbox_to_anchor=(0.035, 0.045, 1, 1),
                      bbox_transform=ax.transAxes)
    axin.imshow(grid, extent=[lonlo, lonhi, latlo, lathi], origin="lower",
                cmap="RdBu_r", aspect="auto",
                vmin=np.percentile(grid, 2), vmax=np.percentile(grid, 98))
    axin.plot(t["tlon"], t["tlat"], "-", color="k", lw=1.4,
              solid_capstyle="round")
    axin.set_xlim(*zlon); axin.set_ylim(*zlat)
    axin.set_xticks([]); axin.set_yticks([])
    axin.set_title("anomaly detail", fontsize=6.8, pad=2)
    for s in axin.spines.values():
        s.set_color("0.35"); s.set_linewidth(0.9)
    mark_inset(ax, axin, loc1=2, loc2=4, fc="none", ec="0.35", lw=0.7)
    ax.tick_params(length=2.5, width=0.7)
    fig.savefig(os.path.join(OUT, "fig_map.pdf"))
    plt.close(fig)


def fig_poserr():
    fig, ax = plt.subplots(figsize=(COL_W, 2.35))
    tm = t["tmin"]
    # shade the gap between the baseline EKF and the proposed FGO to make the
    # improvement visible at a glance
    ax.fill_between(tm, t["efgo"], t["eekf"],
                    where=(t["eekf"] >= t["efgo"]), color=C_PROPOSED,
                    alpha=0.12, interpolate=True)
    ax.plot(tm, t["eins"], ":", color=C_REF, lw=1.4)
    ax.plot(tm, t["eekf"], "--", color=C_BASE1, lw=1.4)
    ax.plot(tm, t["efgo"], "-", color=C_PROPOSED, lw=2.0)
    ax.set_xlabel("time [min]")
    ax.set_ylabel("horizontal error [m]")
    ymax = np.max(t["eins"]) * 1.16          # headroom for the INS peak label
    ax.set_ylim(0, ymax)
    ax.set_xlim(tm[0], tm[-1])
    ax.grid(True, axis="y")
    lead = dict(arrowprops=dict(arrowstyle="-", lw=0.6, color="0.5"),
                fontsize=7, textcoords="data")
    # INS: label sits just above its peak (kept clear by the y headroom)
    ip = int(np.argmax(t["eins"]))
    ax.annotate("INS  —  %.0f m DRMS" % np.sqrt(np.mean(t["eins"]**2)),
                xy=(tm[ip], t["eins"][ip]), xytext=(tm[ip], ymax * 0.985),
                ha="center", va="top", fontsize=7, color=C_REF)
    # EKF and FGO: labels parked in the empty mid-band with thin leader lines
    ie = int(np.argmin(np.abs(tm - 47)))
    ax.annotate("EKF  —  %.1f m" % np.sqrt(np.mean(t["eekf"]**2)),
                xy=(tm[ie], t["eekf"][ie]), xytext=(tm[ie] - 1, ymax * 0.60),
                ha="center", va="bottom", color=C_BASE1, **lead)
    ifg = int(np.argmin(np.abs(tm - 20)))
    ax.annotate("FGO  —  %.1f m" % np.sqrt(np.mean(t["efgo"]**2)),
                xy=(tm[ifg], t["efgo"][ifg]), xytext=(tm[ifg], ymax * 0.42),
                ha="center", va="bottom", color=C_PROPOSED, weight="bold", **lead)
    despine(ax)
    fig.savefig(os.path.join(OUT, "fig_poserr.pdf"))
    plt.close(fig)


def fig_cdf():
    """Empirical CDF of horizontal error — separates the methods cleanly."""
    fig, ax = plt.subplots(figsize=(COL_W, 2.1))
    def cdf(e, **kw):
        xs = np.sort(e); ys = np.arange(1, len(xs)+1) / len(xs)
        ax.plot(xs, ys, **kw)
    cdf(t["eins"], ls=":", color=C_REF, lw=1.4)
    cdf(t["eekf"], ls="--", color=C_BASE1, lw=1.5)
    cdf(t["efgo"], ls="-", color=C_PROPOSED, lw=1.9)
    # direct labels at the 0.55 quantile of each curve
    ax.annotate("INS", (np.percentile(t["eins"], 55), 0.55),
                textcoords="offset points", xytext=(8, -4), fontsize=7,
                color=C_REF, ha="left")
    ax.annotate("EKF", (np.percentile(t["eekf"], 72), 0.72),
                textcoords="offset points", xytext=(8, -4), fontsize=7,
                color=C_BASE1, ha="left")
    ax.annotate("FGO (proposed)", (np.percentile(t["efgo"], 30), 0.30),
                textcoords="offset points", xytext=(9, -3), fontsize=7,
                color=C_PROPOSED, ha="left", weight="bold")
    # mark the 95th percentile of each
    for e, c in ((t["efgo"], C_PROPOSED), (t["eekf"], C_BASE1)):
        p95 = np.percentile(e, 95)
        ax.plot([p95, p95], [0, 0.95], color=c, lw=0.7, ls="-", alpha=0.35)
    ax.axhline(0.95, color="0.5", lw=0.6, ls=":")
    ax.text(np.percentile(t["eins"], 92), 0.955, "95th pct", fontsize=6.5,
            color="0.4", va="bottom", ha="right")
    ax.set_xlabel("horizontal error [m]")
    ax.set_ylabel("empirical CDF")
    ax.set_xlim(0, np.percentile(t["eins"], 99))
    ax.set_ylim(0, 1.02)
    ax.grid(True, axis="both")
    despine(ax)
    fig.savefig(os.path.join(OUT, "fig_cdf.pdf"))
    plt.close(fig)


if __name__ == "__main__":
    fig_map(); fig_poserr(); fig_cdf()
    print("wrote fig_map.pdf, fig_poserr.pdf, fig_cdf.pdf to", OUT)
