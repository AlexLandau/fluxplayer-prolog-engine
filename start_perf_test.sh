#!/bin/sh

ECLIPSE="/home/alex/prologEclipse/bin/x86_64_linux/eclipse -g 512M"

GAME_FILE="/home/alex/code/fluxplayer-prolog-engine/sample_game.kif"
OUTPUT_FILE="/home/alex/code/fluxplayer-prolog-engine/output.out"
SECONDS_TO_RUN=1

${ECLIPSE} -b "bin/main_perf" -e "main_perf:run_perf_test(\"${GAME_FILE}\", \"${OUTPUT_FILE}\", ${SECONDS_TO_RUN})"

