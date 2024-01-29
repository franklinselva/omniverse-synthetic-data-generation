#!/bin/bash
ROOT_DIR="$(pwd)"

# This is the path where Isaac Sim is installed which contains the python.sh script
ISAAC_SIM_PATH="$HOME/.local/share/ov/pkg/isaac_sim-2023.1.1"

## Setup location of the SDG script
SCRIPT_PATH="$ROOT_DIR/examples/palletjack/standalone_palletjack_sdg.py"
OUTPUT_WAREHOUSE="$ROOT_DIR/data/palletjack/distractors_warehouse"
OUTPUT_ADDITIONAL="$ROOT_DIR/data/palletjack/distractors_additional"
OUTPUT_NO_DISTRACTORS="$ROOT_DIR/data/palletjack/no_distractors"

# Source Omniverse environment and SDK
# shellcheck source=/dev/null
source "ISAAC_SIM_PATH/setup_python_env.sh"

## Go to Isaac Sim location for running with ./python.sh
echo "Starting Data Generation"
CMD_PREFIX="$ISAAC_SIM_PATH/python.sh"

$CMD_PREFIX "$SCRIPT_PATH" --height 544 --width 960 --num_frames 100 --distractors warehouse --data_dir "$OUTPUT_WAREHOUSE"

$CMD_PREFIX "$SCRIPT_PATH" --height 544 --width 960 --num_frames 100 --distractors additional --data_dir "$OUTPUT_ADDITIONAL"

$CMD_PREFIX "$SCRIPT_PATH" --height 544 --width 960 --num_frames 100 --distractors None --data_dir "$OUTPUT_NO_DISTRACTORS"
