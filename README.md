# My Custom Bash Setup for CachyOS (Arch)

A curated setup combining Chris Titus's Bash logic with Dacrab's Fastfetch visuals.

## Components & Credits

### Bash Configuration (.bashrc) & Prompt (Starship)
- **Source:** ChrisTitusTech
- **Repository:** [ChrisTitusTech/mybash](https://github.com/ChrisTitusTech/mybash)
- **Files:** `.bashrc`, `starship.toml`

### System Fetch (Fastfetch)
- **Source:** Dacrab
- **Repository:** [dacrab/fastfetch-config](https://github.com/dacrab/fastfetch-config)
- **Files:** `config.jsonc`

---

## 1. Prerequisites (Day Zero)

Before running the setup script, ensure our system has the required dependencies and fonts.

### Check Dependencies
Run this one-liner to check for missing packages or commands:

```bash
for i in bash tar bat tree unzip fc-list fontconfig bash-completion fastfetch starship fzf trash-cli multitail zoxide ripgrep; do if pacman -Qi "$i" &>/dev/null; then echo "[OK-PKG] $i"; elif type -P "$i" &>/dev/null; then echo "[OK-CMD] $i"; else echo -e "\e[31m[MISSING] $i\e[0m"; fi; done
````

**Example Output:**

```text
[OK-PKG] bash
[MISSING] starship
[MISSING] trash-cli
```

### Install Missing Packages

If any items were `[MISSING]` above, install them (using `yay` covers both official repos and AUR):

```bash
yay -S starship trash-cli multitail
```

### Install Nerd Font

A Nerd Font is required for the Starship prompt icons.

1.  **Search** for a font (e.g., Meslo, JetBrains, Hack):
    ```bash
    pacman -Ss nerd | grep meslo
    ```
2.  **Install** (Example for Meslo):
    ```bash
    sudo pacman -S ttf-meslo-nerd
    ```
3.  **Verify** installation:
    ```bash
    fc-list | grep -i "meslo"
    ```

-----

## 2\. Installation

This step will do a one-time download of the config files to `~/mybash` and symlink them to our system configuration folders.

1.  **Make the script executable:**

    ```bash
    chmod +x setup_mybash.sh
    ```

2.  **Run the script:**

    ```bash
    ./setup_mybash.sh
    ```

*Note: This script will backup any existing `.bashrc` or configs before overwriting.*

-----

## 3\. Post-Install Configuration

### Clean up .bashrc

Open our new `.bashrc` file:

```bash
nano ~/.bashrc
```

**Required edits:**

1.  **Remove broken sources:** Look for lines starting with `source` or `.` that point to files we didn't download (e.g., `source ~/scripts/aliases.sh`).
2.  **Clean bloat:** Remove specific checks for other distros (Debian/Fedora) if we want a cleaner file.
3. **Add what we need:** Add own alias and configs where needed

### Apply Changes

Reload shell to see the results:

```bash
source ~/.bashrc
```


