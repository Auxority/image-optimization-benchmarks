IMAGE_QUALITY=100

TestConvertTo() {
    local input_image_path=$1
    local image_extension=$2
    local operation_name="convert"

    local commands=(
        "ffmpeg -i INPUT -y -hide_banner -loglevel error OUTPUT"
        "vips copy INPUT OUTPUT[Q=$IMAGE_QUALITY]"
        "convert INPUT -quality $IMAGE_QUALITY OUTPUT"
        "gm convert INPUT -quality $IMAGE_QUALITY OUTPUT"
    )

    RandomlyExecuteCommands "${commands[@]}"
}

TestConvertToJPG() {
    TestConvertTo $1 "jpg"
}

TestConvertToPNG() {
    TestConvertTo $1 "png"
}

TestConvertToWebP() {
    TestConvertTo $1 "webp"
}