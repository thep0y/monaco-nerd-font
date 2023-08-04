#!/bin/sh

in_path=./original
out_path=./out

mkdir -p "$out_path"
podman run --rm -v "$in_path":/in -v "$out_path":/out nerdfonts/patcher -c --makegroups --xavgcharwidth --careful
# podman run --rm -v "$in_path":/in -v "$out_path":/out nerdfonts/patcher -c -s
