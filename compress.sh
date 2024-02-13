IMAGE_QUALITY=90 # Higher is better, ranges from 1-100.
FFMPEG_IMAGE_QUALITY=2 # Lower is better, ranges from 1-31. A value of 2 is roughly equal to 90% quality of other tools.

TestCompressToJPG() {
    local input_image_path=$1
    local operation_name=compress
    local image_extension=jpg

    commands=(
        "ffmpeg -i INPUT -q:v $FFMPEG_IMAGE_QUALITY -y -hide_banner -loglevel error OUTPUT"
        "vips copy $input_image_path OUTPUT[Q=$IMAGE_QUALITY]"
        "convert INPUT -quality $IMAGE_QUALITY OUTPUT"
        "gm convert INPUT -quality $IMAGE_QUALITY OUTPUT"
    )

    RandomlyExecuteCommands "${commands[@]}"
}

TestCompressToPNG() {
    local input_image_path=$1
    local operation_name=compress
    local image_extension=png
    # Sadly ffmpeg does not support PNG compression. It is achieveable using a palette and three commands, but it is not a fair comparison and loses too much quality.
    # Libvips does support PNG compression, but only with a palette, which is not a fair comparison either.

    commands=(
        "ffmpeg -i INPUT -y -hide_banner -loglevel error OUTPUT"
        "vips copy $input_image_path OUTPUT[Q=$IMAGE_QUALITY]"
        "convert INPUT -quality $IMAGE_QUALITY OUTPUT"
        "gm convert INPUT -quality $IMAGE_QUALITY OUTPUT"
    )

    RandomlyExecuteCommands "${commands[@]}"
}

TestCompressToWebP() {
    local input_image_path=$1
    local operation_name=compress
    local image_extension=webp

    commands=(
        "ffmpeg -i INPUT -c:v libwebp -lossless 0 -quality $IMAGE_QUALITY -y -hide_banner -loglevel error OUTPUT"
        "vips copy $input_image_path OUTPUT[Q=$IMAGE_QUALITY]"
        "convert INPUT -quality $IMAGE_QUALITY OUTPUT"
        "gm convert INPUT -quality $IMAGE_QUALITY OUTPUT"
    )

    RandomlyExecuteCommands "${commands[@]}"
}