<p align="center">
  <img src="https://raw.githubusercontent.com/qrbounty/bootstrapper/master/warning.png">
</p>

# Bootstrapper
A personal bootstrap script for my new systems. From fresh Debian install to ready to work in about 8 minutes.

## Purpose
This works in tandem with my dotfiles repo when run on a new system. It will detect the current OS and install the relevant packages and applications needed, as well as pull down my dotfiles. It is currently scoped to Debian only.

## What It Does
Installation workflow goes like this:
1. Check for & install apt updates
2. Install relevant apt packages
3. Install VMware Tools, if needed.
4. Run custom installer functions. Currently:
    * Selected Python3 packages
    * LightDM
    * Zsh
    * VS Code
    * Bat
    * Grab some random wallpapers
    * Grab user dotfiles
    * Configure Docker & pull down selected images
    * Install VimPlug
5. Reboot - and done!

## Usage
1. Do a fresh install of your OS, defaults should be fine however you can deselect any UI stuff if you want.
2. Make your account a member of the sudo group (see Requirements below)
3. `wget https://raw.githubusercontent.com/qrbounty/bootstrapper/master/bootstrap.sh`
4. Examine `bootstrap.sh` and customize as needed
5. `chmod +x bootstrap.sh`
6. `sudo ./bootstrap.sh`
7. After a reboot everything should be complete!

Alternatively, if you're feeling extremely dangerous, replace steps 3-6 with: `sudo su -c "bash <(wget -qO- https://git.io/JvIcy)"` 

Just promise you'll tell everyone else to never run random scripts from the internet with bash, particularly with sudo...

## Requirements
If you're a debian user (like me) you'll want to make sure your user is set up to use sudo before continuing.

Debian 9 or older: add the user account to the group sudo with `adduser username sudo`. Where username is your user account.

Debian 10: add the user account to the group sudo with `/sbin/adduser username sudo`. Where username is your user account.

## Package Tracking
The following helps me track which versions of certain packages are available between distros. This is mostly to help me evaluate which distributions are keeping up with tools I use.

| Package | BlackArch | Kali Rolling | Parrot | FreeBSD | Debian Testing | Manjaro | Void | 
| --- |  --- |  --- |  --- |  --- |  --- |  --- |  --- | 
| amass | ![](https://repology.org/badge/version-for-repo/blackarch/amass.svg?header=) | ![](https://repology.org/badge/version-for-repo/kali_rolling/amass.svg?header=) | ![](https://repology.org/badge/version-for-repo/parrot/amass.svg?header=) | ![](https://repology.org/badge/version-for-repo/freebsd/amass.svg?header=) | ![](https://repology.org/badge/version-for-repo/debian_testing/amass.svg?header=) | ![](https://repology.org/badge/version-for-repo/manjaro_stable/amass.svg?header=) | ![](https://repology.org/badge/version-for-repo/void_x86_64/amass.svg?header=) | 
| i3 | ![](https://repology.org/badge/version-for-repo/blackarch/i3.svg?header=) | ![](https://repology.org/badge/version-for-repo/kali_rolling/i3.svg?header=) | ![](https://repology.org/badge/version-for-repo/parrot/i3.svg?header=) | ![](https://repology.org/badge/version-for-repo/freebsd/i3.svg?header=) | ![](https://repology.org/badge/version-for-repo/debian_testing/i3.svg?header=) | ![](https://repology.org/badge/version-for-repo/manjaro_stable/i3.svg?header=) | ![](https://repology.org/badge/version-for-repo/void_x86_64/i3.svg?header=) | 
| i3-gaps | ![](https://repology.org/badge/version-for-repo/blackarch/i3-gaps.svg?header=) | ![](https://repology.org/badge/version-for-repo/kali_rolling/i3-gaps.svg?header=) | ![](https://repology.org/badge/version-for-repo/parrot/i3-gaps.svg?header=) | ![](https://repology.org/badge/version-for-repo/freebsd/i3-gaps.svg?header=) | ![](https://repology.org/badge/version-for-repo/debian_testing/i3-gaps.svg?header=) | ![](https://repology.org/badge/version-for-repo/manjaro_stable/i3-gaps.svg?header=) | ![](https://repology.org/badge/version-for-repo/void_x86_64/i3-gaps.svg?header=) | 
| metasploit | ![](https://repology.org/badge/version-for-repo/blackarch/metasploit.svg?header=) | ![](https://repology.org/badge/version-for-repo/kali_rolling/metasploit.svg?header=) | ![](https://repology.org/badge/version-for-repo/parrot/metasploit.svg?header=) | ![](https://repology.org/badge/version-for-repo/freebsd/metasploit.svg?header=) | ![](https://repology.org/badge/version-for-repo/debian_testing/metasploit.svg?header=) | ![](https://repology.org/badge/version-for-repo/manjaro_stable/metasploit.svg?header=) | ![](https://repology.org/badge/version-for-repo/void_x86_64/metasploit.svg?header=) | 
| radare2 | ![](https://repology.org/badge/version-for-repo/blackarch/radare2.svg?header=) | ![](https://repology.org/badge/version-for-repo/kali_rolling/radare2.svg?header=) | ![](https://repology.org/badge/version-for-repo/parrot/radare2.svg?header=) | ![](https://repology.org/badge/version-for-repo/freebsd/radare2.svg?header=) | ![](https://repology.org/badge/version-for-repo/debian_testing/radare2.svg?header=) | ![](https://repology.org/badge/version-for-repo/manjaro_stable/radare2.svg?header=) | ![](https://repology.org/badge/version-for-repo/void_x86_64/radare2.svg?header=) | 
| ghidra | ![](https://repology.org/badge/version-for-repo/blackarch/ghidra.svg?header=) | ![](https://repology.org/badge/version-for-repo/kali_rolling/ghidra.svg?header=) | ![](https://repology.org/badge/version-for-repo/parrot/ghidra.svg?header=) | ![](https://repology.org/badge/version-for-repo/freebsd/ghidra.svg?header=) | ![](https://repology.org/badge/version-for-repo/debian_testing/ghidra.svg?header=) | ![](https://repology.org/badge/version-for-repo/manjaro_stable/ghidra.svg?header=) | ![](https://repology.org/badge/version-for-repo/void_x86_64/ghidra.svg?header=) | 
| nmap | ![](https://repology.org/badge/version-for-repo/blackarch/nmap.svg?header=) | ![](https://repology.org/badge/version-for-repo/kali_rolling/nmap.svg?header=) | ![](https://repology.org/badge/version-for-repo/parrot/nmap.svg?header=) | ![](https://repology.org/badge/version-for-repo/freebsd/nmap.svg?header=) | ![](https://repology.org/badge/version-for-repo/debian_testing/nmap.svg?header=) | ![](https://repology.org/badge/version-for-repo/manjaro_stable/nmap.svg?header=) | ![](https://repology.org/badge/version-for-repo/void_x86_64/nmap.svg?header=) | 
| masscan | ![](https://repology.org/badge/version-for-repo/blackarch/masscan.svg?header=) | ![](https://repology.org/badge/version-for-repo/kali_rolling/masscan.svg?header=) | ![](https://repology.org/badge/version-for-repo/parrot/masscan.svg?header=) | ![](https://repology.org/badge/version-for-repo/freebsd/masscan.svg?header=) | ![](https://repology.org/badge/version-for-repo/debian_testing/masscan.svg?header=) | ![](https://repology.org/badge/version-for-repo/manjaro_stable/masscan.svg?header=) | ![](https://repology.org/badge/version-for-repo/void_x86_64/masscan.svg?header=) | 
| go | ![](https://repology.org/badge/version-for-repo/blackarch/go.svg?header=) | ![](https://repology.org/badge/version-for-repo/kali_rolling/go.svg?header=) | ![](https://repology.org/badge/version-for-repo/parrot/go.svg?header=) | ![](https://repology.org/badge/version-for-repo/freebsd/go.svg?header=) | ![](https://repology.org/badge/version-for-repo/debian_testing/go.svg?header=) | ![](https://repology.org/badge/version-for-repo/manjaro_stable/go.svg?header=) | ![](https://repology.org/badge/version-for-repo/void_x86_64/go.svg?header=) | 
| testssl.sh | ![](https://repology.org/badge/version-for-repo/blackarch/testssl.sh.svg?header=) | ![](https://repology.org/badge/version-for-repo/kali_rolling/testssl.sh.svg?header=) | ![](https://repology.org/badge/version-for-repo/parrot/testssl.sh.svg?header=) | ![](https://repology.org/badge/version-for-repo/freebsd/testssl.sh.svg?header=) | ![](https://repology.org/badge/version-for-repo/debian_testing/testssl.sh.svg?header=) | ![](https://repology.org/badge/version-for-repo/manjaro_stable/testssl.sh.svg?header=) | ![](https://repology.org/badge/version-for-repo/void_x86_64/testssl.sh.svg?header=) | 
| wpscan | ![](https://repology.org/badge/version-for-repo/blackarch/wpscan.svg?header=) | ![](https://repology.org/badge/version-for-repo/kali_rolling/wpscan.svg?header=) | ![](https://repology.org/badge/version-for-repo/parrot/wpscan.svg?header=) | ![](https://repology.org/badge/version-for-repo/freebsd/wpscan.svg?header=) | ![](https://repology.org/badge/version-for-repo/debian_testing/wpscan.svg?header=) | ![](https://repology.org/badge/version-for-repo/manjaro_stable/wpscan.svg?header=) | ![](https://repology.org/badge/version-for-repo/void_x86_64/wpscan.svg?header=) | 
| sqlmap | ![](https://repology.org/badge/version-for-repo/blackarch/sqlmap.svg?header=) | ![](https://repology.org/badge/version-for-repo/kali_rolling/sqlmap.svg?header=) | ![](https://repology.org/badge/version-for-repo/parrot/sqlmap.svg?header=) | ![](https://repology.org/badge/version-for-repo/freebsd/sqlmap.svg?header=) | ![](https://repology.org/badge/version-for-repo/debian_testing/sqlmap.svg?header=) | ![](https://repology.org/badge/version-for-repo/manjaro_stable/sqlmap.svg?header=) | ![](https://repology.org/badge/version-for-repo/void_x86_64/sqlmap.svg?header=) | 
| binwalk | ![](https://repology.org/badge/version-for-repo/blackarch/binwalk.svg?header=) | ![](https://repology.org/badge/version-for-repo/kali_rolling/binwalk.svg?header=) | ![](https://repology.org/badge/version-for-repo/parrot/binwalk.svg?header=) | ![](https://repology.org/badge/version-for-repo/freebsd/binwalk.svg?header=) | ![](https://repology.org/badge/version-for-repo/debian_testing/binwalk.svg?header=) | ![](https://repology.org/badge/version-for-repo/manjaro_stable/binwalk.svg?header=) | ![](https://repology.org/badge/version-for-repo/void_x86_64/binwalk.svg?header=) | 
| mitmproxy | ![](https://repology.org/badge/version-for-repo/blackarch/mitmproxy.svg?header=) | ![](https://repology.org/badge/version-for-repo/kali_rolling/mitmproxy.svg?header=) | ![](https://repology.org/badge/version-for-repo/parrot/mitmproxy.svg?header=) | ![](https://repology.org/badge/version-for-repo/freebsd/mitmproxy.svg?header=) | ![](https://repology.org/badge/version-for-repo/debian_testing/mitmproxy.svg?header=) | ![](https://repology.org/badge/version-for-repo/manjaro_stable/mitmproxy.svg?header=) | ![](https://repology.org/badge/version-for-repo/void_x86_64/mitmproxy.svg?header=) | 
| wireshark | ![](https://repology.org/badge/version-for-repo/blackarch/wireshark.svg?header=) | ![](https://repology.org/badge/version-for-repo/kali_rolling/wireshark.svg?header=) | ![](https://repology.org/badge/version-for-repo/parrot/wireshark.svg?header=) | ![](https://repology.org/badge/version-for-repo/freebsd/wireshark.svg?header=) | ![](https://repology.org/badge/version-for-repo/debian_testing/wireshark.svg?header=) | ![](https://repology.org/badge/version-for-repo/manjaro_stable/wireshark.svg?header=) | ![](https://repology.org/badge/version-for-repo/void_x86_64/wireshark.svg?header=) | 
| cewl | ![](https://repology.org/badge/version-for-repo/blackarch/cewl.svg?header=) | ![](https://repology.org/badge/version-for-repo/kali_rolling/cewl.svg?header=) | ![](https://repology.org/badge/version-for-repo/parrot/cewl.svg?header=) | ![](https://repology.org/badge/version-for-repo/freebsd/cewl.svg?header=) | ![](https://repology.org/badge/version-for-repo/debian_testing/cewl.svg?header=) | ![](https://repology.org/badge/version-for-repo/manjaro_stable/cewl.svg?header=) | ![](https://repology.org/badge/version-for-repo/void_x86_64/cewl.svg?header=) | 
| tor | ![](https://repology.org/badge/version-for-repo/blackarch/tor.svg?header=) | ![](https://repology.org/badge/version-for-repo/kali_rolling/tor.svg?header=) | ![](https://repology.org/badge/version-for-repo/parrot/tor.svg?header=) | ![](https://repology.org/badge/version-for-repo/freebsd/tor.svg?header=) | ![](https://repology.org/badge/version-for-repo/debian_testing/tor.svg?header=) | ![](https://repology.org/badge/version-for-repo/manjaro_stable/tor.svg?header=) | ![](https://repology.org/badge/version-for-repo/void_x86_64/tor.svg?header=) | 
| nikto | ![](https://repology.org/badge/version-for-repo/blackarch/nikto.svg?header=) | ![](https://repology.org/badge/version-for-repo/kali_rolling/nikto.svg?header=) | ![](https://repology.org/badge/version-for-repo/parrot/nikto.svg?header=) | ![](https://repology.org/badge/version-for-repo/freebsd/nikto.svg?header=) | ![](https://repology.org/badge/version-for-repo/debian_testing/nikto.svg?header=) | ![](https://repology.org/badge/version-for-repo/manjaro_stable/nikto.svg?header=) | ![](https://repology.org/badge/version-for-repo/void_x86_64/nikto.svg?header=) | 
| bettercap | ![](https://repology.org/badge/version-for-repo/blackarch/bettercap.svg?header=) | ![](https://repology.org/badge/version-for-repo/kali_rolling/bettercap.svg?header=) | ![](https://repology.org/badge/version-for-repo/parrot/bettercap.svg?header=) | ![](https://repology.org/badge/version-for-repo/freebsd/bettercap.svg?header=) | ![](https://repology.org/badge/version-for-repo/debian_testing/bettercap.svg?header=) | ![](https://repology.org/badge/version-for-repo/manjaro_stable/bettercap.svg?header=) | ![](https://repology.org/badge/version-for-repo/void_x86_64/bettercap.svg?header=) |

Removed from the list:
- Pentoo (Coverage, outdated)
- OpenBSD (Coverage, outdated)
- Debian Stable (Outdated)
- Devuan 4 (Identical to Debian Testing)
