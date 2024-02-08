#!/bin/bash

# MacBook M3 Pro - 36GB memory
# Libvips 8.15.1

# Some constant variables
INPUT_DIR="./images/input"
OUTPUT_DIR="./images/output"
PERFORMANCE_FILE="./results/libvips-results.txt"

# Test cropping functionality
TestCrop() {
    for input_image in $INPUT_DIR/*.jpg; do
        output_image="$OUTPUT_DIR/$(basename "$input_image" .jpg)-cropped.jpg"
        command="vips crop $input_image $output_image 10 10 110 110"
        duration=$( { time $command; } 2>&1 | grep "real" | awk '{print substr($2, 3)}' | sed 's/s//')        
        echo $duration >> $PERFORMANCE_FILE
    done
}

# Test compression functionality
TestCompress() {
    for input_image in $INPUT_DIR/*.jpg; do
        output_image="$OUTPUT_DIR/$(basename "$input_image" .jpg)-compressed.jpg"
        command="vips jpegsave $input_image $output_image --optimize-coding -Q 90"
        duration=$( { time $command; } 2>&1 | grep "real" | awk '{print substr($2, 3)}' | sed 's/s//')
        echo $duration >> $PERFORMANCE_FILE
    done
}

# Test resize functionality
TestResize() {
    for input_image in $INPUT_DIR/*.jpg; do
        output_image="$OUTPUT_DIR/$(basename "$input_image" .jpg)-resized.jpg"
        command="vips resize $input_image $output_image 0.5"
        duration=$( { time $command; } 2>&1 | grep "real" | awk '{print substr($2, 3)}' | sed 's/s//')
        echo $duration >> $PERFORMANCE_FILE
    done
}

# Test image format conversion
TestConvert() {
    for input_image in $INPUT_DIR/*.jpg; do
        output_image="$OUTPUT_DIR/$(basename "$input_image" .jpg)-format.webp"
        command="vips copy $input_image $output_image"
        duration=$( { time $command; } 2>&1 | grep "real" | awk '{print substr($2, 3)}' | sed 's/s//')
        echo $duration >> $PERFORMANCE_FILE
    done
}

# Run the tests
TestCrop
TestCompress
TestResize
TestConvert
