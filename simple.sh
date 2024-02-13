# !/bin/bash
set -e

# constants
INPUT_DIR=./images/input
OUTPUT_DIR=./images/output
RESULTS_DIR=./results
NUMBER_OF_ITERATIONS=1

# load test functions
source ./components/compress.sh
source ./components/resize.sh
source ./components/crop.sh
source ./components/convert.sh

RandomlyExecuteCommands() {
    commands=("$@")
    num_commands=${#commands[@]}

    for ((j = 0; j < ${#commands[@]}; j++)); do
        random=$((RANDOM % ${#commands[@]}))
        temp=${commands[j]}
        commands[j]=${commands[random]}
        commands[random]=$temp
    done

    local image_file_name=$(basename "${input_image_path%.*}")

    for command in "${commands[@]}"; do
        # get the tool name from the command
        local tool_name=$(echo $command | awk '{print $1}')
        # replace some unclear tool names with the actual tool names
        tool_name=$(echo $tool_name | sed "s|convert|imagemagick|g" | sed "s|gm|graphicsmagick|g")

        # replace the placeholders in the output path & command with the actual values
        output_image_path=$(echo $OUTPUT_DIR/$image_file_name-OPERATION_NAME-TOOL_NAME.IMAGE_EXTENSION | sed "s|TOOL_NAME|$tool_name|g" | sed "s|OPERATION_NAME|$operation_name|g" | sed "s|IMAGE_EXTENSION|$image_extension|g")
        command=$(echo $command | sed "s|INPUT|$input_image_path|g" | sed "s|OUTPUT|$output_image_path|g")

        # calculate the duration of the command using the time command, filter the output to get the real time, and convert the minutes to seconds
        duration=$({ time $command; } 2>&1 | grep real | awk '{print $2}' | awk -F'm' '{print $1*60 + substr($2, 1, length($2)-1)}')
        original_extension=$(echo $input_image_path | awk -F'.' '{print $NF}')
        original_size=$(stat -f%z "$input_image_path")
        new_size=$(stat -f%z "$output_image_path")

        echo "$tool_name,$image_file_name,$original_extension,$original_size,$operation_name,$image_extension,$duration,$new_size" >>$RESULTS_DIR/results.csv
    done
}

ExecuteTestsOnSingleImage() {
    local input_image_path=$1

    # TestCompressToJPG $input_image_path
    # TestCompressToPNG $input_image_path
    TestCompressToWebP $input_image_path

    # TestResizeToJPG $input_image_path
    # TestResizeToPNG $input_image_path
    TestResizeToWebP $input_image_path

    # TestCropToJPG $input_image_path
    # TestCropToPNG $input_image_path
    TestCropToWebP $input_image_path

    # TestConvertToJPG $input_image_path
    # TestConvertToPNG $input_image_path
    TestConvertToWebP $input_image_path
}

ShowProgress() {
    local current_image=$1
    local total_image_count=$2

    local percent=$((100 * current_image / total_image_count))
    printf "\rProgress: [\033[32m%-50s\033[0m] \033[32m%d%%\033[0m" $(printf '#%.0s' $(seq 1 $((percent / 2)))) $percent
}

ExecuteTestsOnAllImages() {
    total_image_count=$(ls -v $INPUT_DIR/*.{jpg,jpeg,png,webp} 2>/dev/null | wc -l)
    current_image=0

    # iterate over all the images in the ./images/input directory in alphabetical order while silently ignoring errors.
    for input_image_path in $(ls -v $INPUT_DIR/*.{jpg,jpeg,png,webp} 2>/dev/null); do
        # skip if the file does not exist.
        if [ ! -f "$input_image_path" ]; then
            continue
        fi

        ((current_image++))
        ShowProgress $current_image $total_image_count

        for ((i = 0; i < $NUMBER_OF_ITERATIONS; i++)); do
            ExecuteTestsOnSingleImage $input_image_path
        done
    done

    # prints a new line after the program finishes.
    echo ""
}

ExecuteTestsOnAllImages
