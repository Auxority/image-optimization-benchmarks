#!/bin/bash

# Benchmarked using `time ./imagemagick.sh`

INPUT_PATH="./images/input/1.jpg"

TestCropping () {
    for i in 1 2 3 4 5 6 7 8 9 10
    do
        convert $INPUT_PATH -crop 100x100+10+10 ./images/output/1-cropped.jpg
    done
}

TestCompression () {
    for i in 1 2 3 4 5 6 7 8 9 10
    do
        convert $INPUT_PATH -quality 90 ./images/output/1-compressed.jpg
    done
}

TestResize () {
    for i in 1 2 3 4 5 6 7 8 9 10
    do
        convert $INPUT_PATH -resize 50% ./images/output/1-resized.jpg
    done
}

TestFormat () {
    for i in 1 2 3 4 5 6 7 8 9 10
    do
        convert $INPUT_PATH ./images/output/1-format.webp
    done
}

# TestCropping
# Time in seconds for 10 iterations:
# 2.37
# 2.36
# 2.38
# 2.39
# 2.39

# TestCompression
# Time in seconds for 10 iterations:
# 4.59
# 4.57
# 4.57
# 4.59
# 4.58

# TestResize
# Time in seconds for 10 iterations:
# 11.55
# 11.58
# 11.56
# 11.59
# 11.55

# TestFormat
# Time in seconds for 10 iterations:
# 24.13
# 24.17
# 24.89
# 24.76
# 24.45