#!/bin/sh

set -e

INPUT_DIR=./original
OUTPUT_DIR=./out

container_run() {
	if command -v podman >/dev/null; then
		echo "Using podman"
		podman "$@"
	elif command -v docker >/dev/null; then
		echo "Using docker"
		docker "$@"
	else
		echo "Error: podman and docker not installed" >&2
		return 1
	fi
}

RUN_OPTS="run --rm -v $INPUT_DIR:/in -v $OUTPUT_DIR:/out nerdfonts/patcher"

rm -rf "$OUTPUT_DIR"
mkdir "$OUTPUT_DIR"

CMD1="$RUN_OPTS -c"
CMD2="$RUN_OPTS -c -s"

echo "Running container commands..."

container_run $CMD1
container_run $CMD2

echo "Done."
