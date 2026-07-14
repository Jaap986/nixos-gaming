# ❄️ Jaap986 NixOS Flake

![NixOS](https://img.shields.io/badge/NixOS-unstable-blue.svg?style=flat-square&logo=NixOS&logoColor=white)
![Flake](https://img.shields.io/badge/Flake-enabled-blue.svg?style=flat-square&logo=NixOS&logoColor=white)

Personal NixOS configuration for my gaming machines. Structured around reusable NixOS modules and Home Manager profiles.

## 🖥️ Hosts

| Host | Description | Main traits |
| :--- | :--- | :--- |
| `steambox` | Living room PC | Jovian Steam session, GNOME, AMD GPU, 8BitDo input |
| `steamdeck`| Valve Steam Deck | Jovian Steam session, Deck vendor pkgs, Decky Loader |
| `ally` | ASUS ROG Ally | Jovian Steam session, GNOME, Handheld Daemon, 8BitDo |

*Also includes an `installer` output for a custom minimal install ISO.*

## 📂 Structure

- `flake.nix` / `generate-nixos-config.nix` — Entry points and host builder
- `nixos/<host>/` — Machine-specific configurations
- `home/` — Home Manager profiles (`systems`, `common`, `software`)
- `modules/` / `common/` — Reusable system and user settings
- `scripts/` — Automation and utilities

## 🚀 Usage

**Rebuild local host:**
```bash
sudo nixos-rebuild switch --flake .#<host>
```

**Build Installer ISO:**
```bash
scripts/build-installer-iso.sh [--out-dir /tmp/nixos-installer]
```

**Using the Installer:**
Boot the built ISO, connect to Wi-Fi if needed (using `nmtui`), and run the helper to format the disk and install a host profile:
```bash
install-nixos
```
*Note: The script prompts for a host (`ally`, `steambox`, or `steamdeck`). It is **destructive** to the target disk and the default user `gamer` has the initial password `changeme`.*

**SSH Access:**
SSH is enabled by default. Public keys are automatically fetched from GitHub for the user `Jaap986` and applied to the `gamer` account on boot. Password authentication over SSH is disabled. To change the GitHub user, update the `githubUserName` variable in [`common/ssh.nix`](common/ssh.nix).
