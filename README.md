# PRAGMATA VR Fix Pack

Experimental third-person VR fixes for **PRAGMATA**, intended for gamepad play through REFramework and Virtual Desktop/VDXR.

Prepared and tested by **WinterWolf**, with coding assistance from GPT-6 Astra (Medium), building on the credited mod authors' work.

## Current release: v1.1.0-experimental

[Download the updated package](https://github.com/TokyoTKO/Pragmata-VR-Fix-Pack/releases/tag/v1.1.0-experimental).
Includes V18 menu trails treatment (both Stamp Club interfaces, Bot Database, and shared detection for high-priority list menus) and the verified orange HUD workaround. The workaround suppresses one corrupting EffectTexture leaf; the energy HUD remained functional in and out of combat with no noticeable downside reported. It may also suppress that effect's intended glow.

Existing users: close the game, back up and replace **only `dinput8.dll`**, and add/replace **`reframework/autorun/zzzzzzzz_pragmata_hud_orange_test.lua`**. Keep other scripts, dependencies and configuration unchanged. If those exact tested files are already installed, no reinstall is needed. The previous release and its download link remain available.

## Status

- Tested through menu, hacking and combat sessions on Windows 11, RTX 4090, Quest 3, Virtual Desktop/VDXR, and a gamepad.
- The assembled package has not yet been validated on another PC or a clean Steam installation.
- Other GPUs, headsets, runtimes, game editions, and later-game interfaces remain unverified.
- Experimental and provided as-is. Compatibility, individual support, and future updates are not promised.

## Download and installation

Download the playable ZIP from this repository's **Releases** page. Read `START_HERE.txt` inside the ZIP before installing it.

The package requires three separate downloads:

1. [_ScriptCore 1.2.06](https://www.nexusmods.com/pragmata/mods/24?tab=files) by alphaZomega and SilverEzredes.
2. [HUD Controls 1.3.0](https://www.nexusmods.com/pragmata/mods/8?tab=files) by kagenocookie.
3. [PureDark AFW beta.6](https://github.com/PureDark/REFramework/releases/tag/RE9_AFW_v1.0-beta.6). Copy **only** `PDAFWPlugin.dll` from that archive.

Do not install another REFramework nightly or overwrite the included modified REFramework build with another AFW build.

## What this repository contains

- `scripts/` — the project-specific Lua fixes. Their existing filenames are retained even when they contain `probe`, `inspect`, or `test`; these scripts implement required runtime fixes.
- `config/` — the tested REFramework configuration and HUD layout.
- `docs/` — installation instructions, build information, package manifest, tested graphics reference, and checksums.
- `notices/` — upstream license and third-party notices.

The playable release ZIP also contains the tested modified REFramework binary and OpenXR loader. `PDAFWPlugin.dll`, HUD Controls, and _ScriptCore remain separate downloads.

## Native source

The V18 native build uses the [reproducible source patch](https://github.com/TokyoTKO/Pragmata-VR-Fix-Pack/blob/4564cf24a0fa7ad481c1893d8d7565afe11f20ae/source/pragmata-vr-fixes.patch), applied to PureDark/REFramework commit `c619b761ee71f793e06c2559d8b762dacb43dbc4`. [Build run](https://github.com/TokyoTKO/Pragmata-VR-Fix-Pack/actions/runs/35452983120). The companion fork retains the earlier source history.

REFramework is by praydog and is distributed under the MIT License. OpenXR loader licensing and REFramework third-party notices are preserved in `notices/` and in the release ZIP.

## Improvements and known compromises

The fixes cover HUD placement, several hacking interfaces and obstructing effects, objectives and hints, cinematic side masks, Shelter holoscreens, costume selection, the Firmware Updater, head-following subtitles, and main-menu stability.

Known compromises include reflective-surface artifacts (especially in the Shelter), dark or faint location labels, reticle depth/vergence mismatch, and occasional loading-screen or cinematic artifacts.

## Credits

- WinterWolf — project direction and headset testing
- GPT-6 Astra (Medium) — coding assistance
- praydog — REFramework
- PureDark — AFW
- kagenocookie — HUD Controls
- alphaZomega and SilverEzredes — _ScriptCore
- Khronos Group/OpenXR contributors — OpenXR loader

PRAGMATA is the property of CAPCOM. This is an unofficial fan project and is not affiliated with or endorsed by CAPCOM.
