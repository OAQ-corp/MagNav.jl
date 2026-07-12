#!/usr/bin/env python3
"""Geographic figures from the fgo_tracks.jl CSV dumps (real SGL Flt1003, 1003.02).
track_data.csv / map_grid.csv are produced by research/fgo_tracks.jl (also printed
to the CI log). Run: python3 paper/plot_tracks.py -> paper/figs/fig_map.pdf, fig_poserr.pdf
"""
import os
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1.inset_locator import inset_axes, mark_inset

plt.rcParams.update({
    "font.family": "serif", "font.size": 8, "axes.linewidth": 0.6,
    "xtick.labelsize": 7, "ytick.labelsize": 7, "legend.fontsize": 6.5,
    "axes.labelsize": 8, "figure.dpi": 150, "savefig.bbox": "tight",
    "savefig.pad_inches": 0.02, "pdf.fonttype": 42,
})
HERE = os.path.dirname(__file__)
OUT = os.path.join(HERE, "figs"); os.makedirs(OUT, exist_ok=True)
BLACK, GRAY, BLUE, GREEN = "#000000", "#888888", "#2b6cb0", "#1aa06d"

t = np.genfromtxt(os.path.join(HERE, "track_data.csv"), delimiter=",", names=True)
with open(os.path.join(HERE, "map_grid.csv")) as f:
    f.readline()                                  # header
    nlat, nlon, latlo, lathi, lonlo, lonhi = [float(x) for x in f.readline().split(",")]
    grid = np.loadtxt(f, delimiter=",")           # nlat rows x nlon cols


def fig_map():
    fig, ax = plt.subplots(figsize=(3.4, 2.9))
    im = ax.imshow(grid, extent=[lonlo, lonhi, latlo, lathi], origin="lower",
                   cmap="RdBu_r", aspect="auto", alpha=0.92,
                   vmin=np.percentile(grid, 2), vmax=np.percentile(grid, 98))
    ax.plot(t["tlon"], t["tlat"], "-", color=BLACK, lw=1.6, label="flight line 1003.02")
    cb = fig.colorbar(im, ax=ax, fraction=0.046, pad=0.02)
    cb.set_label("map anomaly [nT]", fontsize=7); cb.ax.tick_params(labelsize=6)
    ax.set_xlabel("longitude [deg]"); ax.set_ylabel("latitude [deg]")
    ax.set_title("Eastern_395 anomaly map and flight line", fontsize=8)
    # zoom inset: a short mid-flight window where the estimates separate
    n = len(t); i0 = n // 2; i1 = min(n, i0 + 14)
    axin = inset_axes(ax, width="42%", height="42%", loc="lower left",
                      bbox_to_anchor=(0.03, 0.06, 1, 1), bbox_transform=ax.transAxes)
    axin.plot(t["tlon"][i0:i1], t["tlat"][i0:i1], color=BLACK, lw=1.8, label="truth")
    axin.plot(t["ilon"][i0:i1], t["ilat"][i0:i1], color=GRAY, lw=1.2, ls="--", label="INS")
    axin.plot(t["elon"][i0:i1], t["elat"][i0:i1], color=BLUE, lw=1.2, label="EKF")
    axin.plot(t["flon"][i0:i1], t["flat"][i0:i1], color=GREEN, lw=1.5, label="FGO")
    axin.set_xticks([]); axin.set_yticks([])
    axin.set_title("zoom", fontsize=6, pad=1)
    for s in axin.spines.values():
        s.set_color(GRAY); s.set_linewidth(0.7)
    axin.legend(loc="upper center", bbox_to_anchor=(0.5, -0.02), ncol=2,
                frameon=False, fontsize=5.4, handlelength=1.2, columnspacing=0.8)
    fig.savefig(os.path.join(OUT, "fig_map.pdf"))
    plt.close(fig)


def fig_poserr():
    fig, ax = plt.subplots(figsize=(3.4, 1.9))
    ax.plot(t["tmin"], t["eins"], color=GRAY, lw=1.3,
            label="INS  (%.0f m)" % np.sqrt(np.mean(t["eins"] ** 2)))
    ax.plot(t["tmin"], t["eekf"], color=BLUE, lw=1.3,
            label="EKF  (%.1f m)" % np.sqrt(np.mean(t["eekf"] ** 2)))
    ax.plot(t["tmin"], t["efgo"], color=GREEN, lw=1.6,
            label="FGO  (%.1f m)" % np.sqrt(np.mean(t["efgo"] ** 2)))
    ax.set_xlabel("time [min]"); ax.set_ylabel("horizontal error [m]")
    ax.set_ylim(0, np.percentile(t["eins"], 99) * 1.05)
    ax.set_xlim(t["tmin"][0], t["tmin"][-1])
    ax.legend(loc="upper left", frameon=False, title="DRMS", title_fontsize=6.5)
    ax.set_title("Flt1003 line 1003.02 — position error", fontsize=8)
    ax.tick_params(length=2)
    for s in ("top", "right"):
        ax.spines[s].set_visible(False)
    fig.savefig(os.path.join(OUT, "fig_poserr.pdf"))
    plt.close(fig)


if __name__ == "__main__":
    fig_map(); fig_poserr()
    print("wrote fig_map.pdf, fig_poserr.pdf to", OUT)
