#!/usr/bin/env bash

logger "[sort_download] got args: $*"
echo "$(date): args=($*)" >> /tmp/sort-download.log

shopt -s nullglob
download_dir="$HOME/Downloads"

for file in "$download_dir"/*; do
    if [[ -f "$file" ]]; then

        name="${file##*/}"
        extension="${name##*.}"
        extension="${extension,,}"
        destination="Other"
        
        if [[ "$name" == .* || "$name" != *.* ]]; then
            destination="Other"
        elif [[ "$extension" = part || "$extension" = crdownload || "$extension" = tmp || "$extension" = temp  || "$extension" = download || "$extension" = filepart ]]; then
            continue
        elif lsof -t "$file" &> /dev/null; then
            continue
        elif [[ "$name" == "~$"* ]]; then
            continue
        elif [[ "$extension" = png || "$extension" = jpg || "$extension" = jpeg || "$extension" = webp ]]; then
            destination="Images"
        elif [[ "$extension" = bz2 || "$extension" = zip || "$extension" = rar || "$extension" = gz ]]; then
            destination="Zips"
        elif [[ "$extension" = mp4 || "$extension" = mov || "$extension" = avi || "$extension" = mkv ]]; then
            destination="Videos"
        elif [[ "$extension" = m4a || "$extension" = mp3 || "$extension" = wav || "$extension" = ogg ]]; then
            destination="Audios"
        elif [[ "$extension" = pdf || "$extension" = docx || "$extension" = txt || "$extension" = doc ]]; then
            destination="Documents"
        elif [[ "$extension" = pptx || "$extension" = ppt || "$extension" = odp ]]; then
            destination="Presentations"
        elif [[ "$extension" = cpp || "$extension" = py || "$extension" = js || "$extension" = java ]]; then
            destination="Codes"
        fi

        # Optional, but will make sure no downloads fail        
        # size1=$(stat -c %s "$file")
        # sleep 1
        # size2=$(stat -c %s "$file")
        
        # if [[ "$size1" != "$size2" ]]; then
        #     logger "[sort_download] Skipping unstable file: $file"
        #     continue
        # fi

        target_dir="$download_dir/$destination"
        mkdir -p "$target_dir"
        mv -n -- "$file" "$target_dir/"
    fi
done

