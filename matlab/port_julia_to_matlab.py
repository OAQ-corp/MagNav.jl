#!/usr/bin/env python3
"""Mechanical Julia->MATLAB function exporter for MagNav source files.

This utility extracts top-level `function ... end` blocks from `src/*.jl`
and emits one MATLAB `.m` file per function under `matlab/+magnav_fullport`.

The output is intentionally marked as a mechanical draft and requires manual
review for full numerical/runtime parity.
"""

from __future__ import annotations
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SRC_DIR = ROOT / "src"
OUT_DIR = ROOT / "matlab" / "+magnav_fullport"


def sanitize_name(name: str) -> str:
    name = name.replace("!", "_bang")
    name = name.replace("?", "_q")
    name = re.sub(r"[^A-Za-z0-9_]", "_", name)
    if not re.match(r"^[A-Za-z]", name):
        name = f"f_{name}"
    return name


def find_function_ranges(lines: list[str]) -> list[tuple[int, int]]:
    ranges: list[tuple[int, int]] = []
    i = 0
    while i < len(lines):
        if lines[i].startswith("function "):
            start = i
            depth = 0
            while i < len(lines):
                stripped = lines[i].strip()
                if stripped.startswith("function "):
                    depth += 1
                if re.match(r"^end(\b|\s|$)", stripped):
                    depth -= 1
                    if depth == 0:
                        ranges.append((start, i))
                        break
                i += 1
        i += 1
    return ranges


def get_signature(lines: list[str], start: int, end: int) -> str:
    sig_parts = []
    for i in range(start, end + 1):
        sig_parts.append(lines[i].strip())
        if ")" in lines[i]:
            break
    return " ".join(sig_parts)


def parse_signature(sig: str) -> tuple[str | None, list[str]]:
    m = re.match(r"^function\s+([^\(\s]+)\s*\((.*)\).*", sig)
    if not m:
        return None, []
    raw_name = m.group(1)
    args_part = m.group(2)
    has_kwargs = ";" in args_part
    args_part = args_part.split(";")[0]

    args: list[str] = []
    for arg in args_part.split(","):
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

    return raw_name, args


def infer_outputs(block: list[str]) -> list[str]:
    outputs = None
    for line in block:
        stripped = line.strip()
        m = re.match(r"^return\s*\(([^)]*)\)", stripped)
        if m:
            cands = []
            for x in m.group(1).split(","):
                x = x.strip()
                if re.match(r"^[A-Za-z_]\w*$", x):
                    cands.append(sanitize_name(x))
            if cands:
                outputs = cands

    if outputs:
        return outputs

    for line in block:
        stripped = line.strip()
        m = re.match(r"^return\s+([A-Za-z_]\w*)\s*$", stripped)
        if m:
            return [sanitize_name(m.group(1))]

    return ["out"]


def convert_line(line: str) -> str:
    s = line.rstrip("\n")
    s = s.replace("#", "%")
    s = s.replace("@assert", "assert")
    s = s.replace("!=", "~=")
    s = re.sub(r"\bzeros\(Float64\s*,", "zeros(", s)
    s = re.sub(r"\bones\(Float64\s*,", "ones(", s)
    s = s.replace(":body2nav", "'body2nav'")
    s = s.replace(":nav2body", "'nav2body'")
    s = s.replace("π", "pi")
    return s


def main() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    name_counts: dict[str, int] = {}
    count = 0

    for src_file in sorted(SRC_DIR.glob("*.jl")):
        lines = src_file.read_text().splitlines()
        for start, end in find_function_ranges(lines):
            signature = get_signature(lines, start, end)
            raw_name, args = parse_signature(signature)
            if not raw_name:
                continue

            base_name = sanitize_name(raw_name)
            name_counts[base_name] = name_counts.get(base_name, 0) + 1
            if name_counts[base_name] == 1:
                matlab_name = base_name
            else:
                matlab_name = f"{base_name}__ovl{name_counts[base_name]}"

            block = lines[start : end + 1]
            outputs = infer_outputs(block)

            if len(outputs) == 1:
                header = f"function {outputs[0]} = {matlab_name}({', '.join(args)})"
            else:
                header = f"function [{', '.join(outputs)}] = {matlab_name}({', '.join(args)})"

            content = [
                f"% Auto-generated from src/{src_file.name}",
                f"% Original Julia signature: {signature}",
                "% Mechanical conversion draft: review before production use.",
                header,
            ]

            for line in block[1:]:
                stripped = line.strip()
                if stripped.startswith("return "):
                    continue
                content.append(convert_line(line))

            content.append("end")
            (OUT_DIR / f"{matlab_name}.m").write_text("\n".join(content) + "\n")
            count += 1

    print(f"Generated {count} MATLAB draft functions in {OUT_DIR.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
