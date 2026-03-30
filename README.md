# OSS Capstone Audit — Git

**Student Name:** Arpita Gupta  
**Registration Number:** 24BCE10416  
**Course:** Open Source Software (OSS NGMC)  
**Chosen Software:** Git (GPL v2)  
**Repository:** `oss-audit-24BCE10416`

---

## Project Overview

This repository contains five shell scripts submitted as part of *The Open Source Audit* capstone project. Each script demonstrates core Linux and shell scripting concepts from Units 1–5 of the OSS NGMC course. The chosen software for this project is **Git**, the distributed version control system originally written by Linus Torvalds and licensed under the GNU General Public License v2.

---

## Repository Structure

```
oss-audit-24BCE10416/
├── script1_system_identity.sh    # System welcome screen with OS and license info
├── script2_package_inspector.sh  # Checks Git installation and prints philosophy note
├── script3_disk_auditor.sh       # Audits system directories for permissions and size
├── script4_log_analyzer.sh       # Analyzes a log file for keyword occurrences
├── script5_manifesto.sh          # Interactively generates a personal OSS manifesto
└── README.md                     # This file
```

---

## Scripts — Description and Concepts

### Script 1: System Identity Report (`script1_system_identity.sh`)

Displays a formatted welcome screen showing Linux distribution, kernel version, current user, home directory, uptime, date/time, and the license that covers Git.

**Concepts used:** Variables, `echo`, command substitution (`$()`), `uname`, `whoami`, `uptime`, `date`, `/etc/os-release` parsing, output formatting.

---

### Script 2: FOSS Package Inspector (`script2_package_inspector.sh`)

Checks whether Git is installed on the system using `dpkg` (Debian/Ubuntu) or `rpm` (RedHat/Fedora), prints version and license details, and uses a `case` statement to print an open-source philosophy note based on the package name.

**Concepts used:** `if-then-else`, `case` statement, `dpkg -l`, `rpm -qi`, `pipe`, `grep`, `awk`, `which`.

---

### Script 3: Disk and Permission Auditor (`script3_disk_auditor.sh`)

Loops through a list of important system directories (`/etc`, `/var/log`, `/home`, `/usr/bin`, `/tmp`, `/usr/share/doc`) and reports disk usage, owner, and permissions. Also audits Git-specific configuration paths.

**Concepts used:** `for` loop, arrays, `ls -ld`, `du -sh`, `awk`, `cut`, conditional directory checks.

---

### Script 4: Log File Analyzer (`script4_log_analyzer.sh`)

Reads a log file line by line, counts how many lines contain a specified keyword (default: `error`), and prints the last 5 matching lines as context. Includes a fallback retry loop if the specified file is not found.

**Concepts used:** `while read` loop, `if-then`, counter variables, command-line arguments (`$1`, `$2`), `grep -i`, `tail`, `wc -l`, do-while style retry.

---

### Script 5: Open Source Manifesto Generator (`script5_manifesto.sh`)

Interactively asks the user three questions and composes a personalised open-source philosophy statement. Saves the output to `manifesto_<username>.txt` and displays it.

**Concepts used:** `read -p`, string concatenation, writing to file with `>` and `>>`, `date`, `cat`, alias concept demonstrated via comment.

---

## How to Run Each Script on Linux

### Prerequisites

- A Linux system (Ubuntu, Debian, Fedora, or any major distribution)
- Bash shell (version 4.0 or higher — check with `bash --version`)
- Git installed (for Script 2): `sudo apt install git` or `sudo dnf install git`

### Step 1: Clone the Repository

```bash
git clone https://github.com/<your-username>/oss-audit-24BCE10416.git
cd oss-audit-24BCE10416
```

### Step 2: Make All Scripts Executable

```bash
chmod +x script1_system_identity.sh
chmod +x script2_package_inspector.sh
chmod +x script3_disk_auditor.sh
chmod +x script4_log_analyzer.sh
chmod +x script5_manifesto.sh
```

Or all at once:

```bash
chmod +x *.sh
```

### Step 3: Run Each Script

**Script 1 — System Identity Report:**
```bash
./script1_system_identity.sh
```

**Script 2 — FOSS Package Inspector:**
```bash
./script2_package_inspector.sh
```

**Script 3 — Disk and Permission Auditor:**
```bash
./script3_disk_auditor.sh
```
> Note: Some directories (e.g., `/var/log`) may require `sudo` to get accurate sizes:
> ```bash
> sudo ./script3_disk_auditor.sh
> ```

**Script 4 — Log File Analyzer:**
```bash
./script4_log_analyzer.sh /var/log/syslog error
```
Replace `/var/log/syslog` with any log file path. The second argument (keyword) is optional — defaults to `error`.

```bash
# Other examples:
./script4_log_analyzer.sh /var/log/auth.log failed
./script4_log_analyzer.sh /var/log/dmesg warning
```

**Script 5 — Manifesto Generator:**
```bash
./script5_manifesto.sh
```
Follow the three interactive prompts. Your manifesto will be saved as `manifesto_<yourusername>.txt` in the current directory.

---

## Dependencies

| Dependency | Purpose | Install Command |
|---|---|---|
| `bash` | Run all scripts | Pre-installed on all Linux systems |
| `git` | Required for Script 2 package check | `sudo apt install git` |
| `dpkg` / `rpm` | Package inspection in Script 2 | Pre-installed (distro-dependent) |
| `du`, `df` | Disk usage in Script 3 | Pre-installed (coreutils) |
| `grep`, `awk`, `cut` | Text processing across all scripts | Pre-installed (coreutils) |

---

## License

This project is submitted for academic purposes under the VIT Open Source Software course. The shell scripts are original work by Arpita Gupta (24BCE10416).

---

*"Every tool you will use in your career was shaped by people who chose to build in the open and share their work freely."*
# linux-project
