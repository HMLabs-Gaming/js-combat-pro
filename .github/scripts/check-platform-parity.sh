#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
temporary_dir="$(mktemp -d)"
trap 'rm -rf "$temporary_dir"' EXIT

normalize_list() {
    sed \
        -e 's/^3D Skin Layers$/Skin Layers 3D/' \
        -e 's/^Fabric Capes$/Capes/' \
        -e 's/^Entity Culling Fabric\/Forge$/Entity Culling/' \
        -e 's/^Cloth Config API (Fabric\/Forge\/NeoForge)$/Cloth Config API/' \
        -e 's/^Concurrent Chunk Management Engine (Fabric)$/Concurrent Chunk Management Engine/' \
        -e 's/^Lithium (Fabric\/NeoForge)$/Lithium/' \
        -e 's/^YetAnotherConfigLib$/YetAnotherConfigLib (YACL)/' \
        -e 's/^MoreCulling$/More Culling/' \
        -e 's/^Zoomify$/Zoomify (Zoom)/' \
        | sort
}

(cd "$repo_root/platforms/modrinth" && packwiz list) | normalize_list > "$temporary_dir/modrinth.txt"
(cd "$repo_root/platforms/curseforge" && packwiz list) | normalize_list > "$temporary_dir/curseforge.txt"

if ! diff -u "$temporary_dir/modrinth.txt" "$temporary_dir/curseforge.txt"; then
    printf '%s\n' 'Platform content mismatch: Modrinth and CurseForge packs must contain the same projects.' >&2
    exit 1
fi

printf 'Platform content parity verified (%s projects).\n' "$(wc -l < "$temporary_dir/modrinth.txt")"