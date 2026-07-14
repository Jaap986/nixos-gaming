#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: scripts/build-installer-iso.sh [--out-dir DIR]

Build the x86_64-linux NixOS minimal installer ISO and copy it to ./dist.

Options:
  --out-dir DIR  Copy the ISO to DIR. Defaults to ./dist.
  -h, --help     Show this help.
EOF
}

out_dir=dist

while [ "$#" -gt 0 ]; do
  case "$1" in
    --out-dir)
      out_dir="${2:?missing value for --out-dir}"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
  shift
done

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
result_link="${repo_root}/result-installer-iso"
nix_flags=(--extra-experimental-features nix-command --extra-experimental-features flakes)
attr="nixosConfigurations.installer.config.system.build.isoImage"

echo "Building installer ISO..."
nix "${nix_flags[@]}" build "path:${repo_root}#${attr}" --out-link "${result_link}"

if [ ! -d "${result_link}/iso" ]; then
  echo "Could not find ISO directory: ${result_link}/iso" >&2
  exit 1
fi

mkdir -p "${repo_root}/${out_dir}"
cp "${result_link}/iso/"*.iso "${repo_root}/${out_dir}/"
chmod 644 "${repo_root}/${out_dir}/"*.iso

echo "ISO copied to ${out_dir}:"
ls -lh "${repo_root}/${out_dir}/"*.iso
