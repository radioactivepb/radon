#!/bin/bash

set -ouex pipefail

### Install packages
DNF=$(which dnf5 || which dnf) &>/dev/null
DNF_INSTALL_ARGS=(
	-y
	--skip-unavailable
	--skip-broken
)
DNF_INSTALL="${DNF} install ${DNF_INSTALL_ARGS[@]}"

DNF_GROUPS=(
    "@virtualization"
    "@development-tools"
    "@c-development"
    "@core"
    "@multimedia"
    "@sound-and-video"
)

DNF_PACKAGES=(
    akmod-nvidia
    xorg-x11-drv-nvidia
    xorg-x11-drv-nvidia-cuda
    nvidia-settings
    nvidia-container-toolkit
    nvidia-vaapi-driver
    xpadneo
    ghostty
    bat
    bsdtar
    btop
    btrfs-assistant
    bzip2
    cabextract
    ccache
    cifs-utils
    cmake
    curl
    distrobox
    dkms
    fuse
    libfuse2
    xorg-x11-font-utils
    docker
    dtc
    fastfetch
    fd-find
    fzf
    gamemode
    gdisk
    gh
    git
    golang
    goverlay
    gperftools-libs
    gzip
    hyperfine
    inotify-tools
    jq
    just
    kdenlive
    libX11-devel
    libXcursor-devel
    libXi-devel
    libXinerama-devel
    libXrandr-devel
    libXxf86vm-devel
    libdnf5-plugin-actions
    liberation-sans-fonts
    libglvnd-devel
    libva-utils
    libxkbcommon-devel
    lsdev
    lshw
    luarocks
    lutris
    lz4
    lzip
    mail
    mangohud
    mesa-libGL-devel
    nasm
    neovim
    net-tools
    ninja-build
    nodejs
    npm
    obs-studio
    openrgb
    p7zip
    p7zip-plugins
    pbzip2
    perl-FindBin
    perl-IPC-Cmd
    perl-lib
    pigz
    piper
    plasma-workspace-x11
    plymouth-kcm
    plymouth-plugin-script
    protontricks
    qemu
    qt6-qtbase-devel
    qt6-qtmultimedia-devel
    qt6-qttools-devel
    qt6-qtwayland-devel
    ranger
    ripgrep
    rlwrap
    rpmconf
    rust
    rustup
    setroubleshoot
    snapper
    sqlite3
    steam
    steam-devices
    stow
    tar
    tealdeer
    telnet
    trash-cli
    unrar
    unzip
    valgrind
    vulkan
    vulkan-loader-devel
    vulkan-tools
    vulkan-validation-layers
    wayland-devel
    wine
    winetricks
    xxd
    xz
    zig
    zip
    zlib-ng-compat-static
    zoxide
    zsh
    zstd
)

$DNF install -y \
		https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
$DNF install -y \
		https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
$DNF install -y --nogpgcheck --repofrompath \
		'terra,https://repos.fyralabs.com/terra$releasever' terra-release
$DNF update --refresh -y

# $DNF_INSTALL "${DNF_GROUPS[@]}"
$DNF_INSTALL "${DNF_PACKAGES[@]}"
$DNF swap -y ffmpeg-free ffmpeg
$DNF update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y

systemctl enable podman.socket
systemctl disable initial-setup.service
systemctl disable NetworkManager-wait-online.service
