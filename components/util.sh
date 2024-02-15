GetPixelFormat() {
    local bit_depth=$1
    local pixel_format=yuv420p

    case $bit_depth in
        8)
            pixel_format=yuv420p
            ;;
        10)
            pixel_format=yuv420p10le
            ;;
        12)
            pixel_format=yuv420p12le
            ;;
        16)
            pixel_format=yuv420p16le
            ;;
        *)
            echo "Unsupported bit depth: $bit_depth"
            return 1
            ;;
    esac

    echo $pixel_format
}