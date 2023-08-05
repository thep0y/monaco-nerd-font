#!/bin/sh

in_path=./original
out_path=./out

container_exec() {
  if command -v podman &>/dev/null; then
    podman "$@"
  elif command -v docker &>/dev/null; then  
    docker "$@"
  else
    echo "Error: podman and docker are not installed" >&2
    return 1
  fi
}

mkdir -p "$out_path"
container_exec run --rm -v "$in_path":/in -v "$out_path":/out nerdfonts/patcher -c
container_exec run --rm -v "$in_path":/in -v "$out_path":/out nerdfonts/patcher -c -s
