#!/bin/bash
set -e
curl -O https://raw.githubusercontent.com/ag-archlinux/ag-archlinux/master/functions.sh && bash functions.sh
newperms "%wheel ALL=(ALL) NOPASSWD: ALL"