#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
temporary_dir="$(mktemp -d)"
trap 'rm -rf "$temporary_dir"' EXIT
exceptions_file="$repo_root/platform-parity-exceptions.json"

if [[ -f "$exceptions_file" ]]; then
    exceptions_json="$(jq -c 'if type != "object" then error("root must be an object") else . end |
        .nameMappings = (.nameMappings // []) |
        .platformOnly = (.platformOnly // []) |
        if (.nameMappings | type) != "array" then error("nameMappings must be an array") else . end |
        if (.platformOnly | type) != "array" then error("platformOnly must be an array") else . end |
        if any(.nameMappings[]; (type != "object") or (.modrinth | type) != "string" or (.curseforge | type) != "string")
            then error("each nameMappings entry needs string modrinth and curseforge values") else . end |
        if any(.platformOnly[]; (type != "object") or (.platform | type) != "string" or (.name | type) != "string" or
            ((.platform != "modrinth") and (.platform != "curseforge")))
            then error("each platformOnly entry needs a valid platform and string name") else . end' "$exceptions_file")" || {
        printf 'Invalid %s\n' "$exceptions_file" >&2
        exit 1
    }
else
    exceptions_json='{"nameMappings":[],"platformOnly":[]}'
fi

normalize_list() {
    local platform="$1"

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
        | jq -R -s --arg platform "$platform" --argjson exceptions "$exceptions_json" '
            ($exceptions.platformOnly | map(select(.platform == $platform) | .name)) as $platform_only |
            ($exceptions.nameMappings) as $mappings |
            split("\n")
            | map(select(length > 0))
            | map(. as $name | select(($platform_only | index($name)) == null) |
                if $platform == "modrinth" then
                    (($mappings | map(select(.modrinth == $name) | .modrinth)) as $matches |
                        if ($matches | length) == 1 then $matches[0] else $name end)
                else
                    (($mappings | map(select(.curseforge == $name) | .modrinth)) as $matches |
                        if ($matches | length) == 1 then $matches[0] else $name end)
                end)
            | sort[]'
}

(cd "$repo_root/platforms/modrinth" && packwiz list) | normalize_list modrinth > "$temporary_dir/modrinth.txt"
(cd "$repo_root/platforms/curseforge" && packwiz list) | normalize_list curseforge > "$temporary_dir/curseforge.txt"

if ! diff -u "$temporary_dir/modrinth.txt" "$temporary_dir/curseforge.txt"; then
    printf '%s\n' 'Platform content mismatch: Modrinth and CurseForge packs must contain the same projects.' >&2
    exit 1
fi

printf 'Platform content parity verified (%s projects).\n' "$(wc -l < "$temporary_dir/modrinth.txt")"