PIXELS_FROM_LEFT=0
PIXELS_FROM_TOP=0
CROP_WIDTH=128
CROP_HEIGHT=128
IMAGE_QUALITY=100
FFMPEG_QUALITY=1

TestCrop() {
    local input_image_path=$1
    local image_extension=$2
    local operation_name="crop"

    local commands=(
        "ffmpeg -i INPUT -vf crop=$CROP_WIDTH:$CROP_HEIGHT:$PIXELS_FROM_LEFT:$PIXELS_FROM_TOP -q:v $FFMPEG_QUALITY -y -hide_banner -loglevel error OUTPUT"
        "vips crop INPUT OUTPUT[Q=$IMAGE_QUALITY] $PIXELS_FROM_LEFT $PIXELS_FROM_TOP $CROP_WIDTH $CROP_HEIGHT"
        "convert INPUT -crop ${CROP_WIDTH}x${CROP_HEIGHT}+$PIXELS_FROM_LEFT+$PIXELS_FROM_TOP -quality $IMAGE_QUALITY OUTPUT"
        "gm convert INPUT -crop ${CROP_WIDTH}x${CROP_HEIGHT}+$PIXELS_FROM_LEFT+$PIXELS_FROM_TOP -quality $IMAGE_QUALITY OUTPUT"
    )

    RandomlyExecuteCommands "${commands[@]}"
}

TestCropToJPG() {
    TestCrop $1 "jpg"
}

TestCropToPNG() {
    TestCrop $1 "png"
}

TestCropToWebP() {
    TestCrop $1 "webp"
}

TestCropToAvif() {
    local input_image_path=$1
    local image_extension="avif"
    local operation_name="crop"

    local commands=(
        "ffmpeg -i INPUT -crf 0 -vf crop=$CROP_WIDTH:$CROP_HEIGHT:$PIXELS_FROM_LEFT:$PIXELS_FROM_TOP -y -hide_banner -loglevel error OUTPUT"
        "vips crop INPUT OUTPUT[Q=$IMAGE_QUALITY] $PIXELS_FROM_LEFT $PIXELS_FROM_TOP $CROP_WIDTH $CROP_HEIGHT"
        "convert INPUT -crop ${CROP_WIDTH}x${CROP_HEIGHT}+$PIXELS_FROM_LEFT+$PIXELS_FROM_TOP -quality $IMAGE_QUALITY OUTPUT"
        "gm convert INPUT -crop ${CROP_WIDTH}x${CROP_HEIGHT}+$PIXELS_FROM_LEFT+$PIXELS_FROM_TOP -quality $IMAGE_QUALITY OUTPUT"
    )

    RandomlyExecuteCommands "${commands[@]}"
}