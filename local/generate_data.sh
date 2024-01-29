#!/bin/bash
ROOT_DIR="$(pwd)"

# Make sure tmux is installed
if ! command -v tmux &>/dev/null; then
    echo "tmux could not be found, install tmux?"
    select yn in "Yes" "No"; do
        case $yn in
        Yes)
            sudo apt-get install tmux
            break
            ;;
        No) exit ;;
        esac
    done
fi

# This is the path where Isaac Sim is installed which contains the python.sh script
ISAAC_SIM_PATH="/home/franklinselva/.local/share/ov/pkg/isaac_sim-2023.1.1"

## Setup location of the SDG script
SCRIPT_PATH="$ROOT_DIR/standalone_palletjack_sdg.py"
OUTPUT_WAREHOUSE="$ROOT_DIR/palletjack_data/distractors_warehouse"
OUTPUT_ADDITIONAL="$ROOT_DIR/palletjack_data/distractors_additional"
OUTPUT_NO_DISTRACTORS="$ROOT_DIR/palletjack_data/no_distractors"

## Go to Isaac Sim location for running with ./python.sh
echo "Starting Data Generation"
CMD_PREFIX="$ISAAC_SIM_PATH/python.sh"

CMD_WAREHOUSE_SPAWNER=$CMD_PREFIX "$SCRIPT_PATH" --height 544 --width 960 --num_frames 2000 --distractors warehouse --data_dir "$OUTPUT_WAREHOUSE"

CMD_ADDITIONAL_DISTRACTORS=$CMD_PREFIX "$SCRIPT_PATH" --height 544 --width 960 --num_frames 2000 --distractors additional --data_dir "$OUTPUT_ADDITIONAL"

CMD_NO_DISTRATIONS=$CMD_PREFIX "$SCRIPT_PATH" --height 544 --width 960 --num_frames 1000 --distractors None --data_dir "$OUTPUT_NO_DISTRACTORS"

## Run the commands in tmux sessions
tmux new-session -d -s "synthetic-data-generation" "$CMD_WAREHOUSE_SPAWNER" \
    \; split-window -h "$CMD_ADDITIONAL_DISTRACTORS" \
    \; split-window -v "$CMD_NO_DISTRATIONS" \
    \; attach-session

