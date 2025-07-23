#!/bin/bash

set -ouex pipefail

/ctx/chromebook-fix.sh

systemctl enable podman.socket
