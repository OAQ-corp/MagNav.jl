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
    fig, ax = plt.subplots(figsize=(COL_W, 3.0))
    im = ax.imshow(grid, extent=[lonlo, lonhi, latlo, lathi], origin="lower",
                   cmap="RdBu_r", aspect="auto", alpha=0.95,
                   vmin=np.percentile(grid, 2), vmax=np.percentile(grid, 98))
    ax.plot(t["tlon"], t["tlat"], "-", color="k", lw=1.7,
            label="flight line 1003.02")
    cb = fig.colorbar(im, ax=ax, fraction=0.046, pad=0.02)
    cb.set_label("map anomaly [nT]", fontsize=8)
    cb.ax.tick_params(labelsize=7)
    ax.set_xlabel("longitude [deg]")
    ax.set_ylabel("latitude [deg]")
    ax.set_title("Eastern_395 anomaly map and flight line")
    ax.legend(loc="upper right", framealpha=0.9, fontsize=7)

    # zoom inset: a short mid-flight window where the estimates separate
    n = len(t); i0 = n // 2; i1 = min(n, i0 + 14)
    axin = inset_axes(ax, width="42%", height="42%", loc="lower left",
                      bbox_to_anchor=(0.05, 0.14, 1, 1), bbox_transform=ax.transAxes)
    axin.set_facecolor("white")
    axin.plot(t["tlon"][i0:i1], t["tlat"][i0:i1], "-", color=C_REF, lw=2.0,
              label="truth")
    axin.plot(t["ilon"][i0:i1], t["ilat"][i0:i1], ":", color="0.45", lw=1.4,
              label="INS")
    axin.plot(t["elon"][i0:i1], t["elat"][i0:i1], "--", color=C_BASE1, lw=1.4,
              label="EKF")
    axin.plot(t["flon"][i0:i1], t["flat"][i0:i1], "-", color=C_PROPOSED, lw=1.7,
              label="FGO")
    axin.set_xticks([]); axin.set_yticks([])
    axin.set_title("zoom", fontsize=7, pad=1.5)
    for s in axin.spines.values():
        s.set_color("0.4"); s.set_linewidth(0.8)
    axin.legend(loc="upper center", bbox_to_anchor=(0.5, -0.03), ncol=2,
                frameon=False, fontsize=6, handlelength=1.4, columnspacing=0.9)
    ax.tick_params(length=2.5, width=0.7)
    fig.savefig(os.path.join(OUT, "fig_map.pdf"))
    plt.close(fig)


def fig_poserr():
    fig, ax = plt.subplots(figsize=(COL_W, 2.1))
    # shade the gap between the baseline EKF and the proposed FGO to make the
    # improvement visible at a glance
    ax.fill_between(t["tmin"], t["efgo"], t["eekf"],
                    where=(t["eekf"] >= t["efgo"]), color=C_PROPOSED,
                    alpha=0.12, interpolate=True, label="FGO improvement")
    ax.plot(t["tmin"], t["eins"], ":", color=C_REF, lw=1.3,
            label="INS  (%.0f m)" % np.sqrt(np.mean(t["eins"] ** 2)))
    ax.plot(t["tmin"], t["eekf"], "--", color=C_BASE1, lw=1.4,
            label="EKF  (%.1f m)" % np.sqrt(np.mean(t["eekf"] ** 2)))
    ax.plot(t["tmin"], t["efgo"], "-", color=C_PROPOSED, lw=1.9,
            label="FGO  (%.1f m)" % np.sqrt(np.mean(t["efgo"] ** 2)))
    ax.set_xlabel("time [min]")
    ax.set_ylabel("horizontal error [m]")
    ax.set_ylim(0, np.percentile(t["eins"], 99) * 1.05)
    ax.set_xlim(t["tmin"][0], t["tmin"][-1])
    ax.grid(True)
    ax.legend(loc="upper left", framealpha=0.9, title="DRMS", title_fontsize=7.5)
    ax.set_title("Flt1003 line 1003.02 — position error")
    despine(ax)
    fig.savefig(os.path.join(OUT, "fig_poserr.pdf"))
    plt.close(fig)


def fig_cdf():
    """Empirical CDF of horizontal error — separates the methods cleanly."""
    fig, ax = plt.subplots(figsize=(COL_W, 2.1))
    def cdf(e, **kw):
        xs = np.sort(e); ys = np.arange(1, len(xs)+1) / len(xs)
        ax.plot(xs, ys, **kw)
    cdf(t["eins"], ls=":", color=C_REF, lw=1.4, label="INS")
    cdf(t["eekf"], ls="--", color=C_BASE1, lw=1.5, label="EKF")
    cdf(t["efgo"], ls="-", color=C_PROPOSED, lw=1.9, label="FGO (proposed)")
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
    ax.grid(True)
    ax.legend(loc="lower right", framealpha=0.9)
    ax.set_title("Error distribution, line 1003.02")
    despine(ax)
    fig.savefig(os.path.join(OUT, "fig_cdf.pdf"))
    plt.close(fig)


if __name__ == "__main__":
    fig_map(); fig_poserr(); fig_cdf()
    print("wrote fig_map.pdf, fig_poserr.pdf, fig_cdf.pdf to", OUT)
