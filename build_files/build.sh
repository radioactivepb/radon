#!/bin/bash

set -ouex pipefail

python3 /ctx/chromebook-fix.py

systemctl enable podman.socket
