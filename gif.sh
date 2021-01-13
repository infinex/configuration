#!/bin/bash
TMPFILE="$(mktemp -t screencast-XXXXXXX).mkv"
VIMWIKI_IMAGES_FOLDER="${HOME}/vimwiki/images"
XSEL_ARGS="--clipboard --input"

input=$(echo "" | rofi -dmenu -p "save filename as");
if [ "${input}" ]; then
    output_dir=$(echo "" | rofi -dmenu -p "save directory(vimwiki/images)");
    if [ "${output_dir}" ]; then
        echo $output_dir
    else
        output=$VIMWIKI_IMAGES_FOLDER/$input

        read -r X Y W H G ID < <(slop -f "%x %y %w %h %g %i")
        notify-send 'capturing gif'
        ffmpeg -f x11grab -s "$W"x"$H" -i :0.0+$X,$Y "$TMPFILE"

        notify-send 'generating palette'
        ffmpeg -y -i "$TMPFILE"  -vf fps=10,palettegen /tmp/palette.png
        notify-send 'generating gif'
        ffmpeg -y -i "$TMPFILE" -i /tmp/palette.png -filter_complex "paletteuse" $output.gif
        #mv $TMPFILE $output.mkv

        notify-send "size $(du -h $output.gif | awk '{print $1}')"

        trap "rm -f '$TMPFILE'" 0
        echo -n "![${input}](${output}.gif)" | xsel ${XSEL_ARGS}
    fi
fi
