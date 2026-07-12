#!/usr/bin/env python3
"""Generate the paper's data-driven and schematic figures (vector PDF).
Numbers come from the reproducible research/*.jl CI results; see paper/README.md.
Run: python3 paper/make_figures.py  ->  paper/figs/*.pdf
"""
import os
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import FancyArrowPatch, Circle, Rectangle, FancyBboxPatch

plt.rcParams.update({
    "font.family": "serif", "font.size": 8, "axes.linewidth": 0.6,
    "xtick.labelsize": 7, "ytick.labelsize": 7, "legend.fontsize": 7,
    "axes.labelsize": 8, "figure.dpi": 150, "savefig.bbox": "tight",
    "savefig.pad_inches": 0.02, "pdf.fonttype": 42,
})
BLUE, RED, GRAY = "#2b6cb0", "#c0392b", "#888888"
OUT = os.path.join(os.path.dirname(__file__), "figs")
os.makedirs(OUT, exist_ok=True)


def fig_breadth():
    """Table II as a grouped log-scale bar chart; divergence made visible."""
    rows = [  # (label, EKF-online, FGO-win)  ; None EKF = divergence
        ("1003.02 M4", None, 42.6), ("1003.02 M5", 28.1, 21.7),
        ("1003.08 M4", None, 26.1), ("1003.08 M5", 21.1, 12.4),
        ("1006.08 M4", None, 193.9), ("1006.08 M5", 117.5, 122.0),
        ("1007.02 M4", None, 38.6), ("1007.02 M5", 31.6, 14.5),
        ("1007.06 M4", 46.7, 32.7), ("1007.06 M5", 17.8, 13.8),
    ]
    labels = [r[0] for r in rows]
    y = np.arange(len(rows))[::-1]
    h = 0.38
    fig, ax = plt.subplots(figsize=(3.4, 3.1))
    DIVX = 3e4  # plotted position for "diverged" EKF bars
    for i, (_, ek, fg) in enumerate(rows):
        yy = y[i]
        if ek is None:
            ax.barh(yy + h/2, DIVX, height=h, color=RED, alpha=0.35, hatch="///",
                    edgecolor=RED, linewidth=0.5)
            ax.text(DIVX, yy + h/2, "  diverged", va="center", ha="left",
                    fontsize=6, color=RED)
        else:
            ax.barh(yy + h/2, ek, height=h, color=RED, alpha=0.85,
                    edgecolor="k", linewidth=0.3)
        ax.barh(yy - h/2, fg, height=h, color=BLUE, alpha=0.95,
                edgecolor="k", linewidth=0.3)
    ax.set_yticks(y)
    ax.set_yticklabels(labels, fontsize=6.3)
    ax.set_xscale("log")
    ax.set_xlim(8, 1e5)
    ax.set_xlabel("horizontal DRMS [m]  (log scale)")
    ax.axvline(1e4, color=GRAY, lw=0.6, ls=":")
    from matplotlib.patches import Patch
    ax.legend(handles=[Patch(facecolor=RED, alpha=0.85, label="EKF-online (causal)"),
                       Patch(facecolor=BLUE, label="FGO window (ours)")],
              loc="lower right", frameon=False)
    ax.set_title("Cold-start cabin magnetometers, 5 lines", fontsize=8)
    ax.tick_params(length=2)
    for s in ("top", "right"):
        ax.spines[s].set_visible(False)
    fig.savefig(os.path.join(OUT, "fig_breadth.pdf"))
    plt.close(fig)


def fig_coldstart():
    """Line 1007.06 head-to-head vs reproduced/published EKF+TL+NN."""
    methods = ["FGO batch\n(static)", "FGO\nwin5", "FGO win5\n+Huber",
               "TL+NN\n(repro)", "TL+NN\n(paper)"]
    m4 = [123.7, 37.0, 32.6, 40.0, 37.0]
    m5 = [68.1, 15.1, 14.2, 17.5, 14.0]
    x = np.arange(len(methods)); w = 0.38
    fig, ax = plt.subplots(figsize=(3.5, 2.15))
    b1 = ax.bar(x - w/2, m4, w, label="Mag 4", color=BLUE, edgecolor="k", linewidth=0.3)
    b2 = ax.bar(x + w/2, m5, w, label="Mag 5", color="#e0a34a", edgecolor="k", linewidth=0.3)
    ours = [True, True, True, False, False]
    for i, o in enumerate(ours):
        if not o:
            ax.axvspan(i - 0.5, i + 0.5, color=GRAY, alpha=0.08, zorder=0)
    for b in (b1, b2):
        ax.bar_label(b, fmt="%.0f", fontsize=5.6, padding=1)
    ax.set_xticks(x); ax.set_xticklabels(methods, fontsize=6.2)
    ax.axvline(2.5, color=GRAY, lw=0.5, ls=":")
    ax.set_ylabel("DRMS [m]")
    ax.set_ylim(0, 138)
    ax.legend(loc="upper right", frameon=False, ncol=2)
    ax.set_title("Line 1007.06, uncompensated cabin mags", fontsize=8)
    ax.tick_params(length=2)
    for s in ("top", "right"):
        ax.spines[s].set_visible(False)
    fig.savefig(os.path.join(OUT, "fig_coldstart.pdf"))
    plt.close(fig)


def fig_factorgraph():
    """Schematic factor graph: nav-error chain + TL variable + factors."""
    fig, ax = plt.subplots(figsize=(3.4, 1.55))
    ax.set_xlim(0, 6); ax.set_ylim(0, 2.4); ax.axis("off")
    xs = [1, 2.5, 4, 5.5]
    def var(cx, cy, txt, fc):
        c = Circle((cx, cy), 0.24, fc=fc, ec="k", lw=0.8, zorder=3)
        ax.add_patch(c)
        ax.text(cx, cy, txt, ha="center", va="center", fontsize=7.5, zorder=4)
    def fac(cx, cy):
        ax.add_patch(Rectangle((cx-0.055, cy-0.055), 0.11, 0.11, fc="k", zorder=3))
    # navigation-error states (top row)
    for i, cx in enumerate(xs):
        var(cx, 1.75, r"$x_{%d}$" % (i+1), "#dbe7f5")
    # process factors between them
    for i in range(len(xs)-1):
        fx = (xs[i]+xs[i+1])/2
        fac(fx, 1.75)
        ax.plot([xs[i]+0.24, fx-0.055], [1.75, 1.75], "k-", lw=0.7)
        ax.plot([fx+0.055, xs[i+1]-0.24], [1.75, 1.75], "k-", lw=0.7)
    # TL compensation variable (shared)
    var(3.25, 0.45, r"$\beta$", "#f3ddb0")
    # measurement factors connecting each x_t and beta
    for cx in xs:
        fac(cx, 1.05)
        ax.plot([cx, cx], [1.75-0.24, 1.05+0.055], "k-", lw=0.7)
        ax.plot([cx, 3.25], [1.05-0.055, 0.45+0.24], "k-", lw=0.5, alpha=0.6)
    ax.text(0.15, 1.75, "nav.\nerror", fontsize=6, va="center", color="#444")
    ax.text(0.15, 0.45, "TL\ncoef.", fontsize=6, va="center", color="#444")
    ax.text(5.55, 1.05, r"$z_t$ factor", fontsize=6, va="center", color="#444")
    fig.savefig(os.path.join(OUT, "fig_graph.pdf"))
    plt.close(fig)


def fig_window():
    """Sliding fixed-lag window: commit stride + overlap look-ahead."""
    fig, ax = plt.subplots(figsize=(3.4, 1.35))
    ax.set_xlim(0, 10); ax.set_ylim(0, 3); ax.axis("off")
    ax.annotate("", xy=(10, 0.35), xytext=(0, 0.35),
                arrowprops=dict(arrowstyle="->", lw=0.8))
    ax.text(9.8, 0.05, "time", fontsize=6, ha="right")
    Lw, Lo, stride = 4.0, 1.2, 2.8
    ys = [2.2, 1.5, 0.85]
    starts = [0, stride, 2*stride]
    for k, (s, yy) in enumerate(zip(starts, ys)):
        ax.add_patch(FancyBboxPatch((s, yy-0.22), Lw, 0.44,
                     boxstyle="round,pad=0.01", fc="#dbe7f5", ec=BLUE, lw=0.8))
        ax.add_patch(Rectangle((s, yy-0.22), stride, 0.44, fc=BLUE, alpha=0.30, ec="none"))
        ax.text(s+stride/2, yy, "commit", fontsize=5.6, ha="center", va="center")
        ax.text(s+stride+(Lw-stride)/2, yy, "look-\nahead", fontsize=5.0,
                ha="center", va="center", color="#555")
        ax.text(s-0.05, yy, "w%d" % (k+1), fontsize=6, ha="right", va="center")
    ax.annotate("", xy=(starts[1], 1.5+0.28), xytext=(starts[0]+stride, 2.2-0.28),
                arrowprops=dict(arrowstyle="->", lw=0.7, color=RED))
    ax.text(starts[0]+stride, 2.72, "carry state + cov", fontsize=5.4, color=RED, ha="center")
    fig.savefig(os.path.join(OUT, "fig_window.pdf"))
    plt.close(fig)


if __name__ == "__main__":
    fig_breadth(); fig_coldstart(); fig_factorgraph(); fig_window()
    print("wrote figures to", OUT)
    for f in sorted(os.listdir(OUT)):
        print("  ", f)
