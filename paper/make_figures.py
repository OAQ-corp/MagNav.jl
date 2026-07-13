#!/usr/bin/env python3
"""Data-driven and schematic figures for the manuscript (vector PDF).

Numbers come from the reproducible research/*.jl CI results; see paper/README.md.
Style follows paper/fig_style.py (Paper-Orchestra plot_style guide).
Run: python3 paper/make_figures.py  ->  paper/figs/*.pdf
"""
import os
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Circle, Rectangle, FancyBboxPatch, Patch, FancyArrowPatch

from fig_style import (apply_style, despine, COL_W,
                       C_PROPOSED, C_BASE1, C_REF, C_ACCENT)

apply_style()
OUT = os.path.join(os.path.dirname(__file__), "figs")
os.makedirs(OUT, exist_ok=True)


def fig_breadth():
    """Table II as a grouped log-scale bar chart; divergence made explicit."""
    rows = [  # (label, EKF-online, FGO-win); None -> diverged, "err" -> off-map abort
        ("1003.02  M4", None, 42.6), ("1003.02  M5", 28.1, 21.7),
        ("1003.08  M4", "err", 26.1), ("1003.08  M5", 21.1, 12.4),
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
        if ek is None or ek == "err":
            lab = "  diverged" if ek is None else "  err. (off-map)"
            ax.barh(yy + h/2, DIVX, height=h, color=C_BASE1, alpha=0.30,
                    hatch="////", edgecolor=C_BASE1, linewidth=0.6)
            ax.text(DIVX, yy + h/2, lab, va="center", ha="left",
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
    """Faithful factor graph of one window: INS error chain x_t (18 states),
    time-varying TL chain beta_t (random walk), joint prior, robust scalar-mag
    factors, factor parameters (INS mech., fluxgate, map) as dashed inputs,
    optional sensor-error variables theta. Full two-column width."""
    fig, ax = plt.subplots(figsize=(7.16, 3.15))
    ax.set_xlim(0, 15.6); ax.set_ylim(-0.15, 5.6); ax.axis("off")
    xs = [2.5, 5.3, 8.1, 10.9]          # epoch positions
    YX, YZ, YB = 4.15, 2.85, 1.55       # x-chain, z-factor, beta-chain rows
    R = 0.30

    def var(cx, cy, txt, fc, r=R, ec="k", ls="-"):
        ax.add_patch(Circle((cx, cy), r, fc=fc, ec=ec, lw=1.0, ls=ls, zorder=4))
        ax.text(cx, cy, txt, ha="center", va="center", fontsize=8.5, zorder=5)

    def fac(cx, cy, fc="k", s=0.13):
        ax.add_patch(Rectangle((cx-s/2, cy-s/2), s, s, fc=fc, ec="k",
                     lw=0.6, zorder=4))

    def seg(x1, y1, x2, y2, **kw):
        ax.plot([x1, x2], [y1, y2], zorder=2,
                **{**dict(color="k", lw=0.9, ls="-"), **kw})

    # ---- variable chains -------------------------------------------------
    for i, cx in enumerate(xs):
        var(cx, YX, r"$\mathbf{x}_{%d}$" % (i+1), "#cfe0f3")
        var(cx, YB, r"$\boldsymbol{\beta}_{%d}$" % (i+1), "#f6d99b")
    ax.text(xs[-1]+1.15, YX, r"$\cdots$", fontsize=12, va="center")
    ax.text(xs[-1]+1.15, YB, r"$\cdots$", fontsize=12, va="center")
    seg(xs[-1]+R, YX, xs[-1]+0.9, YX); seg(xs[-1]+R, YB, xs[-1]+0.9, YB)

    # ---- process factors (Pinson-FOGM) and TL random walk ---------------
    for i in range(len(xs)-1):
        fx = (xs[i]+xs[i+1])/2
        fac(fx, YX); seg(xs[i]+R, YX, xs[i+1]-R, YX)
        fac(fx, YB); seg(xs[i]+R, YB, xs[i+1]-R, YB)
    ax.text((xs[0]+xs[1])/2, YX+0.42,
            r"$\|\mathbf{x}_{t+1}-\boldsymbol{\Phi}_t\mathbf{x}_t\|^2_{\mathbf{Q}_t^{-1}}$",
            fontsize=7.5, ha="center")
    ax.text((xs[0]+xs[1])/2, YB-0.48,
            r"$\|\boldsymbol{\beta}_{t+1}-\boldsymbol{\beta}_t\|^2_{(\mathbf{Q}^{\beta})^{-1}}$",
            fontsize=7.5, ha="center")

    # ---- joint prior on (x_1, beta_1) ------------------------------------
    fac(1.15, YZ, fc="0.35", s=0.16)
    seg(1.15, YZ+0.08, xs[0]-R*0.72, YX-R*0.72)
    seg(1.15, YZ-0.08, xs[0]-R*0.72, YB+R*0.72)
    ax.text(0.92, YZ-0.42, "joint prior\n$\\mathbf{P}_0$ / carried\nfrom window $k{-}1$",
            fontsize=6.6, ha="center", va="top", color="#333")

    # ---- measurement factors ---------------------------------------------
    for cx in xs:
        fac(cx, YZ, fc=C_PROPOSED)
        seg(cx, YX-R, cx, YZ+0.065); seg(cx, YZ-0.065, cx, YB+R)
    ax.annotate(
        r"$\rho(r_t/\sqrt{R}),\;\;r_t=z_t-h(\bar{\mathbf{p}}_t{+}\delta\mathbf{p}_t)-\mathbf{A}_t^{\top}\boldsymbol{\beta}_t-S_t$",
        xy=(xs[1]+0.09, YZ-0.06), xytext=(7.9, 0.42),
        fontsize=7.5, ha="center", va="center", color="#0a3355",
        arrowprops=dict(arrowstyle="->", lw=0.7, ls="--", color="#0a3355",
                        alpha=0.7))

    # ---- factor parameters (dashed inputs, not variables) ----------------
    ax.annotate(r"INS mech.: $\mathbf{f}^n,\,\mathbf{C}^n_b\rightarrow \boldsymbol{\Phi}_t,\mathbf{Q}_t$",
                xy=((xs[2]+xs[3])/2, YX+0.09), xytext=(12.15, 5.12),
                fontsize=6.8, color="0.25", ha="left",
                arrowprops=dict(arrowstyle="->", lw=0.7, ls="--", color="0.45"))
    ax.annotate(r"fluxgate: $\mathbf{B}_t\rightarrow \mathbf{A}_t$;  map: $h,\ \mathbf{g}_t=\nabla h$",
                xy=(xs[3], YZ), xytext=(12.15, 2.85),
                fontsize=6.8, color="0.25", ha="left",
                arrowprops=dict(arrowstyle="->", lw=0.7, ls="--", color="0.45"))

    # ---- state contents annotations --------------------------------------
    ax.text(0.1, 5.32, "INS error state  "
            r"$\mathbf{x}_t=[\,\delta\mathbf{p}\;\delta\mathbf{v}\;\boldsymbol{\psi}\;"
            r"h_a\;\hat{a}\;\mathbf{b}_a\;\mathbf{b}_g\;S\,]^{\top}\in\mathbb{R}^{18}$",
            fontsize=7.5, ha="left", color="#0a3355")
    ax.text(0.1, 0.02, "TL coefficients  "
            r"$\boldsymbol{\beta}_t\in\mathbb{R}^{n_\beta}$"
            "\n(permanent 3, induced 6, eddy 9, bias 1)",
            fontsize=7, ha="left", va="bottom", color="#7a5200")

    # ---- optional sensor-error variables ----------------------------------
    thx, thy = 13.6, 1.05
    var(thx, thy, r"$\boldsymbol{\theta}$", "#e9e9e9", r=0.27, ec="0.4", ls="--")
    for cx in xs[2:]:
        seg(thx-0.24, thy+0.14, cx+0.10, YZ-0.10, ls="--", color="0.55", lw=0.7)
    ax.text(thx+0.38, thy, "optional sensor-error\nvariables (Sec. III-F):\n"
            r"$\{a_k,b_k\},\,b^{\mathrm{hi}},\,\gamma_0,\gamma_1$"
            "\n(couple to every $z_t$)",
            fontsize=6.4, ha="left", va="center", color="#333")

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


def fig_winlen():
    """DRMS vs window length (line 1007.06 cold start) — the U-shaped tradeoff."""
    wl = [2.0, 5.0, 87.0]           # window length [min]; 87 = whole-line static
    m4 = [45.9, 37.0, 123.7]
    m5 = [17.1, 15.1, 68.1]
    fig, ax = plt.subplots(figsize=(COL_W, 2.15))
    ax.plot(wl, m4, "-o", color=C_PROPOSED, lw=1.7, ms=4.5, label="Mag 4")
    ax.plot(wl, m5, "--s", color=C_BASE1, lw=1.5, ms=4.0, label="Mag 5")
    for x, y in zip(wl, m4):
        ax.annotate("%.0f" % y, (x, y), textcoords="offset points",
                    xytext=(3, 5), fontsize=6.2, color=C_PROPOSED)
    ax.set_xscale("log")
    ax.set_xticks(wl); ax.set_xticklabels(["2", "5", "87\n(static)"])
    ax.set_xlabel("window length $L_w$ [min]")
    ax.set_ylabel("horizontal DRMS [m]")
    ax.set_ylim(0, 135)
    ax.grid(True)
    ax.axvspan(3.5, 7, color=C_PROPOSED, alpha=0.06)
    ax.text(5, 128, "sweet spot", fontsize=6.5, ha="center", color="#0a3355")
    ax.legend(loc="upper center", framealpha=0.9)
    ax.set_title("Window length vs accuracy, line 1007.06")
    despine(ax)
    fig.savefig(os.path.join(OUT, "fig_winlen.pdf"))
    plt.close(fig)


def fig_obs():
    """Observability schematic: range(G), range(Psi), and their intersection."""
    fig, ax = plt.subplots(1, 2, figsize=(COL_W, 1.9))
    for a in ax:
        a.set_xlim(-1.35, 1.35); a.set_ylim(-1.2, 1.35); a.axis("off")
        a.set_aspect("equal")

    def plane(a, ang, color, label, lx, ly):
        th = np.deg2rad(ang)
        dx, dy = np.cos(th), np.sin(th)
        a.plot([-dx, dx], [-dy, dy], color=color, lw=2.2)
        a.text(lx, ly, label, color=color, fontsize=8, ha="center")

    plane(ax[0], 20, C_PROPOSED, r"range$(\mathbf{G})$", 1.05, 0.55)
    plane(ax[0], 110, C_BASE1, r"range$(\boldsymbol{\Psi})$", -0.7, 0.95)
    ax[0].plot(0, 0, "ko", ms=3)
    ax[0].text(0, -1.12, "observable\n(intersect $=\\{\\mathbf{0}\\}$)",
               ha="center", fontsize=7)
    plane(ax[1], 25, C_PROPOSED, r"range$(\mathbf{G})$", 1.02, 0.62)
    plane(ax[1], 30, C_BASE1, r"range$(\boldsymbol{\Psi})$", -0.55, -0.75)
    ax[1].plot([-1.1, 1.1], [-0.53, 0.53], color=C_ACCENT, lw=1.0, ls=":")
    ax[1].text(0, -1.12, "collapse\n(nontrivial overlap)", ha="center", fontsize=7)
    fig.savefig(os.path.join(OUT, "fig_obs.pdf"))
    plt.close(fig)


def fig_pipeline():
    """Double-column system architecture: sensors -> factor graph -> window
    solver -> outputs, with the anomaly map feeding the map-match factor."""
    fig, ax = plt.subplots(figsize=(7.0, 2.35))
    ax.set_xlim(0, 15.2); ax.set_ylim(0, 5.0); ax.axis("off")

    def box(x, y, w, h, txt, fc="#eef2f7", ec="#4a5568", fs=8, lw=1.0, tc="#111"):
        ax.add_patch(FancyBboxPatch((x, y), w, h, boxstyle="round,pad=0.03",
                     fc=fc, ec=ec, lw=lw))
        ax.text(x+w/2, y+h/2, txt, ha="center", va="center", fontsize=fs,
                color=tc, zorder=5)

    def arrow(x0, y0, x1, y1, color="#4a5568", lw=1.3):
        ax.add_patch(FancyArrowPatch((x0, y0), (x1, y1),
                     arrowstyle="-|>", mutation_scale=11, lw=lw, color=color,
                     shrinkA=1, shrinkB=1))

    # --- sensors (left column) ---
    box(0.1, 3.5, 2.5, 1.0, "INS / IMU\n(Pinson error)", fc="#eef2f7")
    box(0.1, 2.0, 2.5, 1.0, "3-axis fluxgate\n(TL basis $\\mathbf{A}_t$)", fc="#eef2f7")
    box(0.1, 0.5, 2.5, 1.0, "scalar\nmagnetometer $z_t$", fc="#eef2f7")

    # --- factor graph (center, highlighted) ---
    gx, gy, gw, gh = 3.5, 0.35, 5.1, 4.3
    ax.add_patch(FancyBboxPatch((gx, gy), gw, gh, boxstyle="round,pad=0.04",
                 fc="#eaf2fb", ec=C_PROPOSED, lw=1.6))
    ax.text(gx+gw/2, gy+gh-0.32, "Factor graph", ha="center", va="center",
            fontsize=9, color=C_PROPOSED, weight="bold")
    box(gx+0.35, 3.05, gw-0.7, 0.75, "process factors  $\\|\\mathbf{x}_{t+1}"
        "-\\mathbf{\\Phi}_t\\mathbf{x}_t\\|$", fc="white", fs=7.5, ec="#8aa")
    box(gx+0.35, 2.15, gw-0.7, 0.75, "TL compensation  $c_t=\\mathbf{A}_t^{\\top}"
        "\\boldsymbol{\\beta}_t$", fc="#fff4de", fs=7.5, ec="#c99")
    box(gx+0.35, 1.25, gw-0.7, 0.75, "map-match  $z_t-h(\\mathbf{p}_t)-c_t$",
        fc="white", fs=7.5, ec="#8aa")
    box(gx+0.35, 0.55, gw-0.7, 0.60, "sensor-error factors (heading, bias, "
        "drift)", fc="white", fs=6.8, ec="#8aa")

    # --- solver ---
    box(9.5, 1.9, 2.6, 1.2, "Fixed-lag window\nGN/QR $+$ Huber",
        fc="#eaf2fb", ec=C_PROPOSED, fs=8, lw=1.4, tc="#0a3355")

    # --- outputs ---
    box(12.9, 3.0, 2.2, 1.05, "position\n$\\hat{\\mathbf{p}}_t$", fc="#e7f3ec",
        ec="#1a7", fs=8)
    box(12.9, 1.05, 2.2, 1.05, "TL coef.\n$\\hat{\\boldsymbol{\\beta}}_t$",
        fc="#e7f3ec", ec="#1a7", fs=8)

    # sensor -> graph arrows
    arrow(2.6, 4.0, 3.5, 3.42)
    arrow(2.6, 2.5, 3.5, 2.52)
    arrow(2.6, 1.0, 3.5, 1.62)
    # graph -> solver -> outputs
    arrow(gx+gw, 2.5, 9.5, 2.5)
    arrow(12.1, 2.7, 12.9, 3.3)
    arrow(12.1, 2.3, 12.9, 1.7)
    # anomaly map box below graph feeding map-match factor
    box(9.5, 0.15, 2.6, 1.15, "anomaly map\n$h(\\cdot)$ (IGRF core)", fc="#f3eaf7",
        ec=C_ACCENT, fs=7.5)
    arrow(9.5, 0.9, gx+gw-0.2, 1.55, color=C_ACCENT)
    fig.savefig(os.path.join(OUT, "fig_pipeline.pdf"))
    plt.close(fig)


if __name__ == "__main__":
    fig_breadth(); fig_coldstart(); fig_factorgraph(); fig_window(); fig_pipeline()
    fig_winlen(); fig_obs()
    print("wrote figures to", OUT)
    for f in sorted(os.listdir(OUT)):
        print("  ", f)
