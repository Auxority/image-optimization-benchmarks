#!/bin/bash

# Benchmarked using `time ./ffmpeg.sh`

INPUT_PATH="./images/input/1.jpg"

TestCropping () {
    for i in 1 2 3 4 5 6 7 8 9 10
    do
        ffmpeg -i $INPUT_PATH -vf "crop=100:100:10:10" ./images/output/1-cropped.jpg -y -hide_banner -loglevel error
    done 
}

TestCompression () {
    for i in 1 2 3 4 5 6 7 8 9 10
    do
        ffmpeg -i $INPUT_PATH -compression_level 90 ./images/output/1-compressed.jpg -y -hide_banner -loglevel error
    done
}

TestResize () {
    for i in 1 2 3 4 5 6 7 8 9 10
    do
        ffmpeg -i $INPUT_PATH -vf scale="iw/2:ih/2" ./images/output/1-resized.jpg -y -hide_banner -loglevel error
    done
}

TestFormat () {
    for i in 1 2 3 4 5 6 7 8 9 10
    do
        ffmpeg -i $INPUT_PATH ./images/output/1-format.webp -y -hide_banner -loglevel error
    done
}

# TestCropping
# Time in seconds for 10 iterations:
# 1.59
# 1.59
# 1.59
# 1.59
# 1.60

# TestCompression
# Time in seconds for 10 iterations:
# 2.97
# 2.96
# 3.00
# 3.01
# 2.99

# TestResize
# Time in seconds for 10 iterations:
# 2.26
# 2.28
# 2.31
# 2.30
# 2.30

TestFormat
# Time in seconds for 10 iterations:
# 23.73
# 23.49
# 23.52
# 23.64
# 23.75