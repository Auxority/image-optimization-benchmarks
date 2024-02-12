# !/bin/bash

# Constants
PERFORMANCE_FILE="./results/ffmpeg-results.txt"

# Load the RunTest function
source ./run-test.sh

# Test cropping functionality
TestCrop() {
    RunTest "ffmpeg -i INPUT -vf crop=128:128:10:10 -y -hide_banner -loglevel error OUTPUT" "crop" $PERFORMANCE_FILE
}

# Test compression functionality
TestCompress() {
    RunTest "ffmpeg -i INPUT -compression_level 10 -y -hide_banner -loglevel error OUTPUT" "compress" $PERFORMANCE_FILE
}

# Test resize functionality
TestResize() {
    RunTest "ffmpeg -i INPUT -vf scale=iw/2:ih/2 -y -hide_banner -loglevel error OUTPUT" "resize" $PERFORMANCE_FILE
}

# Test image format conversion
TestConvert() {
    RunTest "ffmpeg -i INPUT -y -hide_banner -loglevel error OUTPUT" "convert" $PERFORMANCE_FILE
}

# Run the tests
TestCrop
TestCompress
TestResize
TestConvert
