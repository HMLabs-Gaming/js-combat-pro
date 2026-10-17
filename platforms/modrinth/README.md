# JS Combat Pro

[![Modrinth](https://cdn.jsdelivr.net/npm/@intergrav/devins-badges@3/assets/cozy/available/modrinth_vector.svg)](https://modrinth.com/project/Dzmlr2F5)
[![GitHub](https://cdn.jsdelivr.net/npm/@intergrav/devins-badges@3/assets/cozy/available/github_vector.svg)](https://github.com/HMLabs-Gaming/js-combat-pro)

This modpack is engineered to give you the competitive edge in Minecraft PvP through maximum performance, reduced latency, and enhanced battlefield awareness.

The pack is designed to comply with the regulations of most major PvP networks. However, it remains your responsibility to verify the permitted mods for each specific server.

---

## Features

- **Peak Performance:** Built on the latest Fabric loader and optimized with **Sodium, Lithium, and more** to ensure ultra-high FPS and minimal input lag - essential for landing every hit.
- **Competitive HUD:** Includes vital on-screen info like **Armor Status, Potion Effects, and Totems**, allowing you to track your resources without losing focus on the fight.
- **Enhanced Visibility:** Featuring **Fullbright** and other visual improvements to ensure you spot opponents instantly, regardless of lighting or weather conditions.
- **Combat Fluidity:** Small tweaks like **reduced fire overlays** keep your view clear during intense, high-action encounters.
- **Fair Play:** No gameplay-altering cheats. This pack focuses on optimizing your client's efficiency and your own skill potential while staying within the vanilla mechanics.

## Development

### Prerequisites

- [packwiz](https://packwiz.infra.link/) CLI

### Useful Commands

```sh
# Install a mod from Modrinth
packwiz modrinth add <mod-slug>

# Remove a mod
packwiz remove <mod-slug>

# Update all mods
packwiz update --all

# Export for distribution
VERSION=26.3-1.0.0
packwiz modrinth export -o ../../JS\ Combat\ Pro-${VERSION}.mrpack
```

### Project Structure

```
mods/            — Mod metadata (.pw.toml files)
resourcepacks/   — Resource pack metadata
shaderpacks/     — Shader pack metadata
config/          — Mod configuration files
pack.toml        — Modpack metadata (name, version, loaders)
```

## Release

Create a release with the proper tag and name. The release workflow publishes the Modrinth package automatically.
