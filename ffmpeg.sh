# !/bin/bash

# Some constant variables
INPUT_DIR="./images/input"
OUTPUT_DIR="./images/output"
PERFORMANCE_FILE="./results/ffmpeg-results.txt"

# Function to run a test
RunTest() {
    local command=$1
    local format_name=$2

    filenames=()
    for input_image in $INPUT_DIR/*.{jpg,jpeg,png,webp}; do
        if [ -f "$input_image" ]; then
            filename=$(basename "$input_image")
            base="${filename%.*}"
            if [[ ! " ${filenames[@]} " =~ " ${base} " ]]; then
                filenames+=("$base")
            fi
        fi
    done

    # Run the operations on each unique filename
    for filename in "${filenames[@]}"; do
        for extension in jpg jpeg png webp; do
            input_image="$INPUT_DIR/$filename.$extension"
            if [ -f "$input_image" ]; then
                local output_extension=$extension
                if [ "$format_name" == "convert" ]; then
                    output_extension="webp"
                fi

                output_image="$OUTPUT_DIR/${filename}-$format_name.$output_extension"
                command_to_run=$(echo $command | sed "s|INPUT|$input_image|g" | sed "s|OUTPUT|$output_image|g")

                # Calculate the duration of the command using the time command, filter the output to get the real time, and convert the minutes to seconds
                duration=$( { time $command_to_run; } 2>&1 | grep "real" | awk '{print $2}' | awk -F'm' '{print $1*60 + substr($2, 1, length($2)-1)}')
                echo $output_image $duration
                echo $duration >> $PERFORMANCE_FILE
            fi
        done
    done
}

# Test cropping functionality
TestCrop() {
    RunTest "ffmpeg -i INPUT -vf crop=100:100:10:10 -y -hide_banner -loglevel error OUTPUT" "crop"
}

# Test compression functionality
TestCompress() {
    RunTest "ffmpeg -i INPUT -compression_level 90 -y -hide_banner -loglevel error OUTPUT" "compress"
}

# Test resize functionality
TestResize() {
    RunTest "ffmpeg -i INPUT -vf scale=iw/2:ih/2 -y -hide_banner -loglevel error OUTPUT" "resize"
}

# Test image format conversion
TestConvert() {
    RunTest "ffmpeg -i INPUT -y -hide_banner -loglevel error OUTPUT" "convert"
}

# Run the tests
TestCrop
TestCompress
TestResize
TestConvert
