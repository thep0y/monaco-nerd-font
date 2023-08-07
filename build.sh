#!/bin/sh

set -e

OUTPUT_DIR=./out

rm -rf "$OUTPUT_DIR"
mkdir "$OUTPUT_DIR"

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

INPUT_DIRS="./ligaturized"
for input_dir in $INPUT_DIRS; do
	if [ "$input_dir" = './ligaturized' ]; then
		RUN_OPTS="run --rm -v $input_dir:/in -v $OUTPUT_DIR:/out nerdfonts/patcher --makegroups 1"
	else
		RUN_OPTS="run --rm -v $input_dir:/in -v $OUTPUT_DIR:/out nerdfonts/patcher"
	fi

	CMD1="$RUN_OPTS -c"
	CMD2="$RUN_OPTS -c -s"

	echo "Running container commands..."

	container_run $CMD1
	container_run $CMD2
done
echo "Done."
