# Some important constant values
INPUT_DIR="./images/input"
OUTPUT_DIR="./images/output"

RunTest() {
    local command=$1
    local operation_name=$2
    local performance_file=$3

    filenames=()
    for input_image_path in $INPUT_DIR/*.{jpg,jpeg,png,webp}; do
        if [ -f "$input_image_path" ]; then
            filename=$(basename "$input_image_path")
            base="${filename%.*}"
            if [[ ! " ${filenames[@]} " =~ " ${base} " ]]; then
                filenames+=("$base")
            fi
        fi
    done

    for filename in "${filenames[@]}"; do
        for extension in jpg jpeg png webp; do
            input_image_path="$INPUT_DIR/$filename.$extension"
            if [ -f "$input_image_path" ]; then
                local output_extension=$extension
                if [ "$operation_name" == "convert" ]; then
                    output_extension="webp"
                fi

                output_image_path="$OUTPUT_DIR/${filename}-$operation_name.$output_extension"
                command_to_run=$(echo $command | sed "s|INPUT|$input_image_path|g" | sed "s|OUTPUT|$output_image_path|g")                

                # Calculate the duration of the command using the time command, filter the output to get the real time, and convert the minutes to seconds
                duration=$( { time $command_to_run; } 2>&1 | grep "real" | awk '{print $2}' | awk -F'm' '{print $1*60 + substr($2, 1, length($2)-1)}')

                original_file_size=$(stat -f%z $input_image_path)
                file_size=$(stat -f%z $output_image_path)

                # Showcase the current operation and results
                echo "$operation_name $filename.$extension | Duration: $duration seconds, File Size: $file_size bytes"

                echo "$operation_name,$duration,$file_size,$original_file_size" >> $performance_file
            fi
        done
    done
}
