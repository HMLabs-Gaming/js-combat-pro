# JS Combat Pro

[![Modrinth](https://cdn.jsdelivr.net/npm/@intergrav/devins-badges@3/assets/cozy/available/modrinth_vector.svg)](https://modrinth.com/project/Dzmlr2F5)
[![GitHub](https://cdn.jsdelivr.net/npm/@intergrav/devins-badges@3/assets/cozy/available/github_vector.svg)](https://github.com/HMLabs-Gaming/js-combat-pro)

This modpack is engineered to give you the competitive edge in Minecraft PvP through maximum performance, reduced latency, and enhanced battlefield awareness.

The pack is designed to comply with the regulations of most major PvP networks. However, it remains your responsibility to verify the permitted mods for each specific server.

---

## Features

- **Peak Performance:** Built on the latest Fabric loader and optimized with **Sodium, Lithium, and more** to ensure ultra-high FPS and minimal input lag—essential for landing every hit.
- **Competitive HUD:** Includes vital on-screen info like **Armor Status, Potion Effects, and Totems**, allowing you to track your resources without losing focus on the fight.
- **Enhanced Visibility:** Featuring mods like **No Fog** and **Fullbright** to ensure you spot opponents instantly, regardless of lighting or weather conditions.
- **Combat Fluidity:** Small tweaks like **Reduced fire overlays** keep your view clear during intense, high-action encounters.
- **Fair Play:** No gameplay-altering cheats. This pack focuses on optimizing your client’s efficiency and your own skill potential while staying within the vanilla mechanics.

## Platform parity exceptions

The CI platform-parity check compares the projects in the Modrinth and CurseForge packs. When a project has a different display name on each platform, add an explicit entry to `platform-parity-exceptions.json` under `nameMappings`. For an intentional platform-exclusive project, add its platform and name under `platformOnly`.

The file is optional. Without it, the check uses only its built-in name normalizations and reports every other difference. Exceptions are limited to the exact names and platforms listed in the file; they do not disable the parity check.

Example:

```json
{
  "nameMappings": [
    {
      "modrinth": "Modrinth display name",
      "curseforge": "CurseForge display name"
    }
  ],
  "platformOnly": [
    {
      "platform": "modrinth",
      "name": "Modrinth-only project"
    }
  ]
}
```
