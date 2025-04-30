#!/usr/bin/env bash

logger "[sort_download] got args: $*"
echo "$(date): args=($*)" >> /tmp/sort-download.log

shopt -s nullglob
#insert the desired directory to sort here 
download_dir="$HOME/Downloads"

for file in "$download_dir"/*; do
    if [[ -f $file ]]; then
        #To ensure the download happens successfully
        sleep 3
        
        name="${file##*/}"          #only the file name with extension
        extension="${name##*.}"     #only the extension from the file name
        extension="${extension,,}"
        destination="Other"
        
        if [[ "$name" == .* ||  "$name" != *.* ]]; then
            destination="Other"
        elif [[ "$extension" = png || "$extension" = jpg || "$extension" = jpeg || "$extension" = webp >
            destination="Images"
        elif [[ "$extension" = bz2 || "$extension" = zip || "$extension" = rar || "$extension" = gz || >
            destination="Zips"
        elif [[ "$extension" = mp4 || "$extension" = mov || "$extension" = avi || "$extension" = mkv ||>
            destination="Videos"
        elif [[ "$extension" = m4a || "$extension" = mp3 || "$extension" = wav || "$extension" = ogg ||>
            destination="Audios"
        elif [[ "$extension" = pdf || "$extension" = docx || "$extension" = txt || "$extension" = doc |>
            destination="Documents"
        elif [[ "$extension" = pptx || "$extension" = ppt || "$extension" = odp ]]; then
            destination="Presentations"
        elif [[ "$extension" = cpp || "$extension" = py || "$extension" = js || "$extension" = java || >
            destination="Codes"
        fi

    target_dir="$download_dir/$destination"
        mkdir -p "$target_dir"
        #no naming collision logics as of now so skipping the move using -n flag
        mv -n -- "$file" "$target_dir/"
    fi
done
