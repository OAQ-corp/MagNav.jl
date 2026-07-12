#!/usr/bin/env python3
"""Data-driven and schematic figures for the manuscript (vector PDF).

Numbers come from the reproducible research/*.jl CI results; see paper/README.md.
Style follows paper/fig_style.py (Paper-Orchestra plot_style guide).
Run: python3 paper/make_figures.py  ->  paper/figs/*.pdf
"""
import os
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Circle, Rectangle, FancyBboxPatch, Patch

from fig_style import (apply_style, despine, COL_W,
                       C_PROPOSED, C_BASE1, C_REF)

apply_style()
OUT = os.path.join(os.path.dirname(__file__), "figs")
os.makedirs(OUT, exist_ok=True)


def fig_breadth():
    """Table II as a grouped log-scale bar chart; divergence made explicit."""
    rows = [  # (label, EKF-online, FGO-win) ; EKF None -> divergence
        ("1003.02  M4", None, 42.6), ("1003.02  M5", 28.1, 21.7),
        ("1003.08  M4", None, 26.1), ("1003.08  M5", 21.1, 12.4),
        ("1006.08  M4", None, 193.9), ("1006.08  M5", 117.5, 122.0),
        ("1007.02  M4", None, 38.6), ("1007.02  M5", 31.6, 14.5),
        ("1007.06  M4", 46.7, 32.7), ("1007.06  M5", 17.8, 13.8),
    ]
    labels = [r[0] for r in rows]
    y = np.arange(len(rows))[::-1]
    h = 0.38
    fig, ax = plt.subplots(figsize=(COL_W, 3.25))
    DIVX = 3e4
    for i, (_, ek, fg) in enumerate(rows):
        yy = y[i]
        if ek is None:
            ax.barh(yy + h/2, DIVX, height=h, color=C_BASE1, alpha=0.30,
                    hatch="////", edgecolor=C_BASE1, linewidth=0.6)
            ax.text(DIVX, yy + h/2, "  diverged", va="center", ha="left",
                    fontsize=7, color=C_BASE1, style="italic")
        else:
            ax.barh(yy + h/2, ek, height=h, color=C_BASE1, alpha=0.9,
                    edgecolor="k", linewidth=0.3)
        ax.barh(yy - h/2, fg, height=h, color=C_PROPOSED,
                edgecolor="k", linewidth=0.3)
    ax.set_yticks(y)
    ax.set_yticklabels(labels)
    ax.set_xscale("log")
    ax.set_xlim(8, 1e5)
    ax.set_xlabel("horizontal DRMS [m]  (log scale)")
    ax.axvline(1e4, color="0.4", lw=0.7, ls=":")
    ax.text(1e4, len(rows)-0.2, "10 km", fontsize=6.5, color="0.4",
            ha="center", va="bottom")
    ax.grid(True, axis="x", which="major")
    ax.legend(handles=[Patch(facecolor=C_BASE1, alpha=0.9, label="EKF, online TL (causal)"),
                       Patch(facecolor=C_PROPOSED, label="FGO window (proposed)")],
              loc="lower right", framealpha=0.9)
    ax.set_title("Cold-start cabin magnetometers, five lines")
    despine(ax)
    fig.savefig(os.path.join(OUT, "fig_breadth.pdf"))
    plt.close(fig)


def fig_coldstart():
    """Line 1007.06 head-to-head vs reproduced/published EKF+TL+NN."""
    methods = ["FGO\nbatch", "FGO\nwin 5", "FGO win 5\n+Huber",
               "EKF+NN\n(repro.)", "EKF+NN\n(paper)"]
    m4 = [123.7, 37.0, 32.6, 40.0, 37.0]
    m5 = [68.1, 15.1, 14.2, 17.5, 14.0]
    ours = [True, True, True, False, False]
    x = np.arange(len(methods)); w = 0.38
    fig, ax = plt.subplots(figsize=(COL_W, 2.4))
    c = [C_PROPOSED if o else C_BASE1 for o in ours]
    b1 = ax.bar(x - w/2, m4, w, color=c, edgecolor="k", linewidth=0.3)
    b2 = ax.bar(x + w/2, m5, w, color=c, alpha=0.5, edgecolor="k",
                linewidth=0.3)
    for i, o in enumerate(ours):
        if not o:
            ax.axvspan(i - 0.5, i + 0.5, color="0.5", alpha=0.08, zorder=0)
    for b in (b1, b2):
        ax.bar_label(b, fmt="%.0f", fontsize=6.2, padding=1)
    ax.axvline(2.5, color="0.4", lw=0.7, ls=":")
    ax.set_xticks(x); ax.set_xticklabels(methods, fontsize=7)
    ax.set_ylabel("horizontal DRMS [m]")
    ax.set_ylim(0, 142)
    ax.grid(True, axis="y")
    leg1 = ax.legend(handles=[Patch(facecolor=C_PROPOSED, label="proposed (FGO)"),
                              Patch(facecolor=C_BASE1, label="baseline (EKF+TL+NN)")],
                     loc="upper left", framealpha=0.9, fontsize=7)
    ax.add_artist(leg1)
    ax.legend(handles=[Patch(facecolor="0.3", label="Mag 4"),
                       Patch(facecolor="0.3", alpha=0.5, label="Mag 5")],
              loc="upper right", framealpha=0.9, fontsize=7)
    ax.set_title("Line 1007.06, uncompensated cabin mags")
    despine(ax)
    fig.savefig(os.path.join(OUT, "fig_coldstart.pdf"))
    plt.close(fig)


def fig_factorgraph():
    """Schematic factor graph: nav-error chain + shared TL variable + factors."""
    fig, ax = plt.subplots(figsize=(COL_W, 1.95))
    ax.set_xlim(0, 6.3); ax.set_ylim(0.0, 2.6); ax.axis("off")
    xs = [1.0, 2.6, 4.2, 5.8]
    yv = 2.0

    def var(cx, cy, txt, fc, r=0.28):
        ax.add_patch(Circle((cx, cy), r, fc=fc, ec="k", lw=1.0, zorder=3))
        ax.text(cx, cy, txt, ha="center", va="center", fontsize=9, zorder=4)

    def fac(cx, cy, fc="k"):
        ax.add_patch(Rectangle((cx-0.07, cy-0.07), 0.14, 0.14, fc=fc,
                     ec="k", lw=0.6, zorder=3))

    for i, cx in enumerate(xs):
        var(cx, yv, r"$\mathbf{x}_{%d}$" % (i+1), "#cfe0f3")
    for i in range(len(xs)-1):
        fx = (xs[i]+xs[i+1])/2
        fac(fx, yv)
        ax.plot([xs[i]+0.28, fx-0.07], [yv, yv], "k-", lw=0.9)
        ax.plot([fx+0.07, xs[i+1]-0.28], [yv, yv], "k-", lw=0.9)
    var(3.4, 0.45, r"$\boldsymbol{\beta}$", "#f6d99b", r=0.30)
    for cx in xs:
        fac(cx, 1.15, fc=C_PROPOSED)
        ax.plot([cx, cx], [yv-0.28, 1.15+0.07], "k-", lw=0.9)
        ax.plot([cx, 3.4], [1.15-0.07, 0.45+0.30], "-", color="0.35",
                lw=0.8, alpha=0.9)
    ax.text(0.05, yv, "nav.\nerror", fontsize=7.5, va="center", ha="left",
            color="#333")
    ax.text(0.05, 0.45, "TL\ncoef.", fontsize=7.5, va="center", ha="left",
            color="#333")
    ax.add_patch(Rectangle((5.93, 1.08), 0.14, 0.14, fc=C_PROPOSED, ec="k",
                 lw=0.6))
    ax.text(6.12, 1.15, "meas.\nfactor", fontsize=7, va="center",
            ha="left", color="#333")
    fig.savefig(os.path.join(OUT, "fig_graph.pdf"))
    plt.close(fig)


def fig_window():
    """Sliding fixed-lag window: commit stride + overlap look-ahead + carry."""
    fig, ax = plt.subplots(figsize=(COL_W, 1.8))
    ax.set_xlim(0, 10); ax.set_ylim(0, 3.1); ax.axis("off")
    ax.annotate("", xy=(9.9, 0.3), xytext=(0.1, 0.3),
                arrowprops=dict(arrowstyle="->", lw=1.0))
    ax.text(9.85, 0.02, "time", fontsize=7.5, ha="right")
    Lw, stride = 4.0, 2.8
    ys = [2.35, 1.6, 0.9]
    starts = [0.1, 0.1+stride, 0.1+2*stride]
    for k, (s, yy) in enumerate(zip(starts, ys)):
        ax.add_patch(FancyBboxPatch((s, yy-0.24), Lw, 0.48,
                     boxstyle="round,pad=0.008", fc="#cfe0f3",
                     ec=C_PROPOSED, lw=1.1))
        ax.add_patch(Rectangle((s, yy-0.24), stride, 0.48, fc=C_PROPOSED,
                     alpha=0.32, ec="none"))
        ax.text(s+stride/2, yy, "commit", fontsize=7, ha="center",
                va="center", color="#0a3355")
        ax.text(s+stride+(Lw-stride)/2, yy, "look-\nahead", fontsize=6.2,
                ha="center", va="center", color="#444")
        ax.text(s-0.08, yy, r"$w_{%d}$" % (k+1), fontsize=8, ha="right",
                va="center")
    for a, b in ((0, 1), (1, 2)):
        ax.annotate("", xy=(starts[b], ys[b]+0.30),
                    xytext=(starts[a]+stride, ys[a]-0.30),
                    arrowprops=dict(arrowstyle="->", lw=0.9, color=C_BASE1))
    ax.text(starts[0]+stride+0.05, ys[0]+0.42, "carry state $+$ covariance",
            fontsize=6.6, color=C_BASE1, ha="left")
    fig.savefig(os.path.join(OUT, "fig_window.pdf"))
    plt.close(fig)


if __name__ == "__main__":
    fig_breadth(); fig_coldstart(); fig_factorgraph(); fig_window()
    print("wrote figures to", OUT)
    for f in sorted(os.listdir(OUT)):
        print("  ", f)
