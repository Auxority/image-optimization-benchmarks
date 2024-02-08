#!/bin/bash

# Benchmarked using `time ./graphicsmagick.sh`

INPUT_PATH="./images/input/1.jpg"

TestCropping () {
    for i in 1 2 3 4 5 6 7 8 9 10
    do
        gm convert $INPUT_PATH -crop 100x100+10+10 ./images/output/1-cropped.jpg
    done
}

TestCompression () {
    for i in 1 2 3 4 5 6 7 8 9 10
    do
        gm convert $INPUT_PATH -quality 90 ./images/output/1-compressed.jpg
    done
}

TestResize () {
    for i in 1 2 3 4 5 6 7 8 9 10
    do
        gm convert $INPUT_PATH -resize 50% ./images/output/1-resized.jpg
    done
}

TestFormat () {
    for i in 1 2 3 4 5 6 7 8 9 10
    do
        gm convert $INPUT_PATH ./images/output/1-format.webp
    done
}

# TestCropping
# Time in seconds for 10 iterations:
# 2.34
# 2.34
# 2.35
# 2.34
# 2.35

# TestCompression
# Time in seconds for 10 iterations:
# 4.82
# 4.82
# 4.78
# 4.80
# 4.81

# TestResize
# Time in seconds for 10 iterations:
# 5.38
# 5.40
# 5.40
# 5.41
# 5.41

# TestFormat
# Time in seconds for 10 iterations:
# 23.78
# 24.30
# 23.98
# 24.21
# 24.32