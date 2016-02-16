#!/bin/sh

ECLIPSE="/home/alex/prologEclipse/bin/x86_64_linux/eclipse -g 512M"

GAME_FILE=$1
OUTPUT_FILE=$2
SECONDS_TO_RUN=$3

${ECLIPSE} -b "bin/main_perf" -e "main_perf:run_perf_test(\"${GAME_FILE}\", \"${OUTPUT_FILE}\", ${SECONDS_TO_RUN})"
