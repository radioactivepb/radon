#!/bin/bash

set -ouex pipefail

./chromebook-fixes/fix

systemctl enable podman.socket
