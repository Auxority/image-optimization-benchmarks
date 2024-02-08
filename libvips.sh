#!/bin/bash

# Benchmarked using `time ./libvips.sh`

INPUT_PATH="./images/input/1.jpg"

TestCropping () {
    for i in 1 2 3 4 5 6 7 8 9 10
    do
        # gm convert $INPUT_PATH -crop 100x100+10+10 ./images/output/1-cropped.jpg
        vips crop $INPUT_PATH ./images/output/1-cropped.jpg 10 10 110 110
    done
}

TestCompression () {
    for i in 1 2 3 4 5 6 7 8 9 10
    do
        vips jpegsave $INPUT_PATH ./images/output/1-compressed.jpg --optimize-coding -Q 90
    done
}

TestResize () {
    for i in 1 2 3 4 5 6 7 8 9 10
    do
        vips resize $INPUT_PATH ./images/output/1-resized.jpg 0.5
    done
}

TestFormat () {
    for i in 1 2 3 4 5 6 7 8 9 10
    do
        vips copy $INPUT_PATH ./images/output/1-format.webp
    done
}

# TestCropping
# Time in seconds for 10 iterations:
# 2.10
# 2.12
# 2.10
# 2.12
# 2.12

# TestCompression
# Time in seconds for 10 iterations:
# 4.91
# 4.94
# 4.94
# 4.95
# 4.94

# TestResize
# Time in seconds for 10 iterations:
# 3.10
# 3.09
# 3.10
# 3.13
# 3.13

# TestFormat
# Time in seconds for 10 iterations:
# 23.89
# 23.79
# 23.88
# 23.56
# 23.88