# !/bin/bash

# Some constant variables
INPUT_DIR="./images/input"
OUTPUT_DIR="./images/output"
PERFORMANCE_FILE="./results/ffmpeg-results.txt"

# Test cropping functionality
TestCrop() {
    for input_image in $INPUT_DIR/*.jpg; do
        output_image="$OUTPUT_DIR/$(basename "$input_image" .jpg)-cropped.jpg"
        command="ffmpeg -i $input_image -vf crop=100:100:10:10 $output_image -y -hide_banner -loglevel error"
        duration=$( { time $command; } 2>&1 | grep "real" | awk '{print substr($2, 3)}' | sed 's/s//')
        echo $duration >> $PERFORMANCE_FILE
    done
}

# Test compression functionality
TestCompress() {
    for input_image in $INPUT_DIR/*.jpg; do
        output_image="$OUTPUT_DIR/$(basename "$input_image" .jpg)-compressed.jpg"
        command="ffmpeg -i $input_image -compression_level 90 $output_image -y -hide_banner -loglevel error"
        duration=$( { time $command; } 2>&1 | grep "real" | awk '{print substr($2, 3)}' | sed 's/s//')
        echo $duration >> $PERFORMANCE_FILE
    done
}

# Test resize functionality
TestResize() {
    for input_image in $INPUT_DIR/*.jpg; do
        output_image="$OUTPUT_DIR/$(basename "$input_image" .jpg)-resized.jpg"
        command="ffmpeg -i $input_image -vf scale=iw/2:ih/2 $output_image -y -hide_banner -loglevel error"
        duration=$( { time $command; } 2>&1 | grep "real" | awk '{print substr($2, 3)}' | sed 's/s//')
        echo $duration >> $PERFORMANCE_FILE
    done
}

# Test image format conversion
TestConvert() {
    for input_image in $INPUT_DIR/*.jpg; do
        output_image="$OUTPUT_DIR/$(basename "$input_image" .jpg)-format.webp"
        command="ffmpeg -i $input_image $output_image -y -hide_banner -loglevel error"
        duration=$( { time $command; } 2>&1 | grep "real" | awk '{print substr($2, 3)}' | sed 's/s//')
        echo $duration >> $PERFORMANCE_FILE
    done
}

# Run the tests
TestCrop
TestCompress
TestResize
TestConvert
