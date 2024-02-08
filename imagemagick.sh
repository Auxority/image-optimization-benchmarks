#!/bin/bash

# Some constant variables
INPUT_DIR="./images/input"
OUTPUT_DIR="./images/output"
PERFORMANCE_FILE="./results/imagemagick-results.txt"

# Test cropping functionality
TestCrop() {
    for input_image in $INPUT_DIR/*.jpg; do
        output_image="$OUTPUT_DIR/$(basename "$input_image" .jpg)-cropped.jpg"
        command="convert $input_image -crop 100x100+10+10 $output_image"
        duration=$( { time $command; } 2>&1 | grep "real" | awk '{print substr($2, 3)}' | sed 's/s//')        
        echo $duration >> $PERFORMANCE_FILE
    done
}

# Test compression functionality
TestCompress() {
    for input_image in $INPUT_DIR/*.jpg; do
        output_image="$OUTPUT_DIR/$(basename "$input_image" .jpg)-compressed.jpg"
        command="convert $input_image -quality 90 $output_image"
        duration=$( { time $command; } 2>&1 | grep "real" | awk '{print substr($2, 3)}' | sed 's/s//')
        echo $duration >> $PERFORMANCE_FILE
    done
}

# Test resize functionality
TestResize() {
    for input_image in $INPUT_DIR/*.jpg; do
        output_image="$OUTPUT_DIR/$(basename "$input_image" .jpg)-resized.jpg"
        command="convert $input_image -resize 50% $output_image"
        duration=$( { time $command; } 2>&1 | grep "real" | awk '{print substr($2, 3)}' | sed 's/s//')
        echo $duration >> $PERFORMANCE_FILE
    done
}

# Test image format conversion
TestConvert() {
    for input_image in $INPUT_DIR/*.jpg; do
        output_image="$OUTPUT_DIR/$(basename "$input_image" .jpg)-format.webp"
        command="convert $input_image $output_image"
        duration=$( { time $command; } 2>&1 | grep "real" | awk '{print substr($2, 3)}' | sed 's/s//')
        echo $duration >> $PERFORMANCE_FILE
    done
}

# Run the tests
TestCrop
TestCompress
TestResize
TestConvert
