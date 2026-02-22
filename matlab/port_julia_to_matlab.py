#!/usr/bin/env python3
"""Julia->MATLAB exporter for MagNav source files.

Creates syntax-normalized MATLAB draft functions from `src/*.jl` into
`matlab/+magnav_fullport`.

Goal: every generated `.m` file should be *loadable/callable* in MATLAB as a
function file, while preserving original equations where mechanically possible.
When a Julia-only construct cannot be translated safely, the line is retained
as a commented TODO for manual debugging.
"""

from __future__ import annotations
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SRC_DIR = ROOT / "src"
OUT_DIR = ROOT / "matlab" / "+magnav_fullport"
STATUS_FILE = ROOT / "matlab" / "PORT_STATUS.md"


def sanitize_name(name: str) -> str:
    name = name.replace("!", "_bang").replace("?", "_q")
    name = re.sub(r"[^A-Za-z0-9_]", "_", name)
    if not re.match(r"^[A-Za-z]", name):
        name = f"f_{name}"
    return name


def find_function_ranges(lines: list[str]) -> list[tuple[int, int]]:
    out: list[tuple[int, int]] = []
    i = 0
    while i < len(lines):
        if lines[i].startswith("function "):
            start = i
            depth = 0
            while i < len(lines):
                t = lines[i].strip()
                if t.startswith("function "):
                    depth += 1
                if re.match(r"^end(\b|\s|$)", t):
                    depth -= 1
                    if depth == 0:
                        out.append((start, i))
                        break
                i += 1
        i += 1
    return out


def get_signature(lines: list[str], start: int, end: int) -> str:
    sig = []
    for i in range(start, end + 1):
        sig.append(lines[i].strip())
        if ")" in lines[i]:
            break
    return " ".join(sig)


def parse_signature(sig: str) -> tuple[str | None, list[str]]:
    m = re.match(r"^function\s+([^\(\s]+)\s*\((.*)\).*", sig)
    if not m:
        return None, []
    name = m.group(1)
    arg_part = m.group(2)
    has_kwargs = ";" in arg_part
    arg_part = arg_part.split(";")[0]

    args = []
    for arg in arg_part.split(","):
        arg = arg.strip()
        if not arg:
            continue
        arg = arg.split("=")[0].strip()
        arg = re.sub(r"::.*$", "", arg).strip()
        arg = sanitize_name(arg)
        if re.match(r"^[A-Za-z]\w*$", arg):
            args.append(arg)

    if has_kwargs:
        args.append("varargin")
    return name, args


def infer_outputs(block: list[str]) -> list[str]:
    outs = None
    for line in block:
        t = line.strip()
        m = re.match(r"^return\s*\(([^)]*)\)", t)
        if m:
            cands = []
            for x in m.group(1).split(","):
                x = x.strip()
                if re.match(r"^[A-Za-z_]\w*$", x):
                    cands.append(sanitize_name(x))
            if cands:
                outs = cands
    if outs:
        return outs

    for line in block:
        t = line.strip()
        m = re.match(r"^return\s+([A-Za-z_]\w*)\s*$", t)
        if m:
            return [sanitize_name(m.group(1))]

    return ["out"]


def basic_rewrite(s: str) -> str:
    s = s.replace("#", "%")
    s = s.replace("@assert", "assert")
    s = s.replace("!=", "~=")
    s = s.replace("nothing", "[]")
    s = s.replace("π", "pi")
    s = s.replace(":body2nav", "'body2nav'")
    s = s.replace(":nav2body", "'nav2body'")
    s = re.sub(r"\bzeros\(Float64\s*,", "zeros(", s)
    s = re.sub(r"\bones\(Float64\s*,", "ones(", s)
    s = re.sub(r"\b(\w+)\.\(", r"\1(", s)  # sin.(x) -> sin(x)
    s = s.replace(".=", "=")
    s = s.replace("end # function", "end")
    s = re.sub(r"\bend\b", "end", s)

    # a[1,2:end] -> a(1,2:end)
    s = re.sub(r"([A-Za-z_]\w*)\[([^\]]+)\]", r"\1(\2)", s)

    # `where {T}` is Julia-only
    s = re.sub(r"\s+where\s+\{[^}]+\}", "", s)
    return s


UNSUPPORTED_PATTERNS = [
    r"\bstruct\b",
    r"\bmutable struct\b",
    r"\busing\b",
    r"\bimport\b",
    r"\bmacro\b",
    r"::",
    r"\.\.\.",
    r"=>",
    r"\bdo\b",
    r"\bin\b",
    r"\$",
    r":[A-Za-z_]",
    r"\)\[",
    r"\+=|-=|\*=|/=",
    r"![A-Za-z_]",
    r"!\(",
]


def convert_line(line: str) -> tuple[str, bool]:
    s = basic_rewrite(line.rstrip("\n"))
    stripped = s.strip()

    if not stripped:
        return s, False

    for p in UNSUPPORTED_PATTERNS:
        if re.search(p, stripped):
            return f"% TODO(Julia->MATLAB): {stripped}", True

    if stripped.startswith("return "):
        return "% " + stripped, False

    return s, False


def main() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    for old in OUT_DIR.glob("*.m"):
        old.unlink()

    counts: dict[str, int] = {}
    total = 0
    total_todo = 0
    status_rows: list[tuple[str, int]] = []

    for src_file in sorted(SRC_DIR.glob("*.jl")):
        lines = src_file.read_text().splitlines()
        for start, end in find_function_ranges(lines):
            sig = get_signature(lines, start, end)
            raw_name, args = parse_signature(sig)
            if not raw_name:
                continue

            base = sanitize_name(raw_name)
            counts[base] = counts.get(base, 0) + 1
            matlab_name = base if counts[base] == 1 else f"{base}__ovl{counts[base]}"

            block = lines[start : end + 1]
            outputs = infer_outputs(block)
            out_init = outputs[0] if len(outputs) == 1 else outputs[0]
            header = (
                f"function {outputs[0]} = {matlab_name}({', '.join(args)})"
                if len(outputs) == 1
                else f"function [{', '.join(outputs)}] = {matlab_name}({', '.join(args)})"
            )

            content = [
                f"% Auto-generated from src/{src_file.name}",
                f"% Original Julia signature: {sig}",
                "% Executable draft: unsupported Julia-specific lines are commented with TODO.",
                header,
                f"    {out_init} = [];",
            ]

            todo_count = 0
            for line in block[1:]:
                converted, is_todo = convert_line(line)
                if is_todo:
                    todo_count += 1
                content.append(converted)

            content.append("end")
            (OUT_DIR / f"{matlab_name}.m").write_text("\n".join(content) + "\n")
            total += 1
            total_todo += todo_count
            status_rows.append((matlab_name, todo_count))

    status_rows.sort(key=lambda x: (-x[1], x[0]))
    top = status_rows[:30]
    STATUS_FILE.write_text(
        "# MATLAB Full Port Status\n\n"
        f"- Generated functions: **{total}**\n"
        f"- TODO-marked lines (manual debug needed): **{total_todo}**\n\n"
        "## Top functions by TODO count\n\n"
        "| Function | TODO lines |\n|---|---:|\n"
        + "\n".join(f"| `{name}` | {todo} |" for name, todo in top)
        + "\n"
    )

    print(f"Generated {total} MATLAB draft functions in {OUT_DIR.relative_to(ROOT)}")
    print(f"Wrote status report to {STATUS_FILE.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
