#!/bin/bash

# Constants
PERFORMANCE_FILE="./results/libvips-results.txt"

# Load the RunTest function
source ./run-test.sh

# Test cropping functionality
TestCrop() {
    RunTest "vips crop INPUT OUTPUT 10 10 138 138 -Q 100" "crop" $PERFORMANCE_FILE
}

# Test compression functionality
TestCompress() {
    RunTest "vips jpegsave INPUT OUTPUT --optimize-coding -Q 90" "compress" $PERFORMANCE_FILE
}

# Test resize functionality
TestResize() {
    RunTest "vips resize INPUT OUTPUT 0.5 -Q 100" "resize" $PERFORMANCE_FILE
}

# Test image format conversion
TestConvert() {
    RunTest "vips copy INPUT OUTPUT -Q 100" "convert" $PERFORMANCE_FILE
}

# Run the tests
TestCrop
TestCompress
TestResize
TestConvert
