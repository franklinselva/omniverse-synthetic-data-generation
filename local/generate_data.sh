#!/bin/bash
ROOT_DIR="$(pwd)/palletjack_sdg"


# This is the path where Isaac Sim is installed which contains the python.sh script
ISAAC_SIM_PATH="$HOME/.local/share/ov/pkg/isaac_sim-2023.1.1"

## Setup location of the SDG script
SCRIPT_PATH="$ROOT_DIR/standalone_palletjack_sdg.py"
OUTPUT_WAREHOUSE="$ROOT_DIR/palletjack_data/distractors_warehouse"
OUTPUT_ADDITIONAL="$ROOT_DIR/palletjack_data/distractors_additional"
OUTPUT_NO_DISTRACTORS="$ROOT_DIR/palletjack_data/no_distractors"

## Go to Isaac Sim location for running with ./python.sh
echo "Starting Data Generation"
CMD_PREFIX="$ISAAC_SIM_PATH/python.sh"

$CMD_PREFIX "$SCRIPT_PATH" --height 544 --width 960 --num_frames 100 --distractors warehouse --data_dir "$OUTPUT_WAREHOUSE"

$CMD_PREFIX "$SCRIPT_PATH" --height 544 --width 960 --num_frames 100 --distractors additional --data_dir "$OUTPUT_ADDITIONAL"

$CMD_PREFIX "$SCRIPT_PATH" --height 544 --width 960 --num_frames 100 --distractors None --data_dir "$OUTPUT_NO_DISTRACTORS"
