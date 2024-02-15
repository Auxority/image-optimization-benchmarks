TestResizeToJPG() {
    local input_image_path=$1
    local operation_name=resize
    local image_extension=jpg

    commands=(
        "ffmpeg -i INPUT -vf scale=iw/2:ih/2 -q:v 1 OUTPUT -y -hide_banner -loglevel error"
        "vips resize INPUT OUTPUT[Q=100] 0.5"
        "convert INPUT -resize 50% -quality 100 OUTPUT"
        "gm convert INPUT -resize 50% -quality 100 OUTPUT"
    )

    RandomlyExecuteCommands "${commands[@]}"
}

TestResizeToPNG() {
    local input_image_path=$1
    local operation_name=resize
    local image_extension=png

    commands=(
        "ffmpeg -i INPUT -vf scale=iw/2:ih/2 OUTPUT -y -hide_banner -loglevel error"
        "vips resize INPUT OUTPUT 0.5"
        "convert INPUT -resize 50% OUTPUT"
        "gm convert INPUT -resize 50% OUTPUT"
    )

    RandomlyExecuteCommands "${commands[@]}"
}

TestResizeToWebP() {
    local input_image_path=$1
    local operation_name=resize
    local image_extension=webp

    commands=(
        "ffmpeg -i INPUT -vf scale=iw/2:ih/2 -c:v libwebp -lossless 1 -y OUTPUT -hide_banner -loglevel error"
        "vips resize INPUT OUTPUT[Q=100] 0.5"
        "convert INPUT -resize 50% -quality 100 OUTPUT"
        "gm convert INPUT -resize 50% -quality 100 OUTPUT"
    )

    RandomlyExecuteCommands "${commands[@]}"
}

TestResizeToAvif() {
    local input_image_path=$1
    local operation_name=resize
    local image_extension=avif

    commands=(
        "ffmpeg -i INPUT -vf scale=iw/2:ih/2 -y OUTPUT -hide_banner -loglevel error"
        "vips resize INPUT OUTPUT[Q=100] 0.5"
        "convert INPUT -resize 50% -quality 100 OUTPUT"
        "gm convert INPUT -resize 50% -quality 100 OUTPUT"
    )

    RandomlyExecuteCommands "${commands[@]}"
}