# PRAGMATA VR Fix Pack

Experimental third-person VR fixes for **PRAGMATA**, intended for gamepad play through REFramework and Virtual Desktop/VDXR.

Prepared and tested by **WinterWolf**, with coding assistance from GPT-6 Astra (Medium), building on the credited mod authors' work.

## Status

- Tested for approximately the first 90 minutes on Windows 11, RTX 4090, Quest 3, Virtual Desktop/VDXR, and a gamepad.
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

The modified REFramework source used for the included `dinput8.dll` is available on the [`pragmata-hacking-ui-stereo-test`](https://github.com/TokyoTKO/REFramework/tree/pragmata-hacking-ui-stereo-test) branch of the companion REFramework fork.

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
