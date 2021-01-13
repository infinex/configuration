XSEL_ARGS="--clipboard --input"
TMP_IMAGE="/tmp/ss.png"
VIMWIKI_IMAGES_FOLDER="${HOME}/screenshots"

maim -s --format png TMP_IMAGE
input_name=$(echo "" | rofi -dmenu -p "save filename as");
input=${input_name}.png
if [ "${input}" ]; then
    output_dir=$(echo "" | rofi -dmenu -p "save directory(images)");
    if [ "${output_dir}" ]; then
        echo $output_dir
    else
        output=$VIMWIKI_IMAGES_FOLDER/$input
        mv TMP_IMAGE $output
        echo -n "![${input_name}](${output})" | xsel ${XSEL_ARGS}
    fi
fi

