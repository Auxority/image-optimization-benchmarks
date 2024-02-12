#!/bin/bash

# Constants
PERFORMANCE_FILE="./results/imagemagick-results.txt"

# Load the RunTest function
source ./run-test.sh

# Test cropping functionality
TestCrop() {
    RunTest "convert INPUT -crop 128x128+10+10 -quality 100 OUTPUT" "crop" $PERFORMANCE_FILE
}

# Test compression functionality
TestCompress() {
    RunTest "convert INPUT -quality 90 OUTPUT" "compress" $PERFORMANCE_FILE
}

# Test resize functionality
TestResize() {
    RunTest "convert INPUT -resize 50% -quality 100 OUTPUT" "resize" $PERFORMANCE_FILE
}

# Test image format conversion
TestConvert() {
    RunTest "convert INPUT -quality 100 OUTPUT" "convert" $PERFORMANCE_FILE
}

# Run the tests
TestCrop
TestCompress
TestResize
TestConvert
