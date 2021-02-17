#!/bin/bash
# Converts video to .mp4 when written

# Quits if directory is not included in command line
if [ $# -eq 0 ]; then
    echo "Requires video path to search.  i.e. sudo $0 /path/to/vids"
    exit 1
fi

# folder to monitor
dir="$1"

# monitor directory for files that are write-enable closed
echo ""
echo "Monitoring $dir"
echo ""
inotifywait $dir -m -e close_write |
   while read path action file; do
      # remove extension from file name
      filename="${file%.*}"
      echo "" && echo "The file '$file' ($filename) appeared in directory '$path' via '$action'" && echo ""
      if [[ $file == *.mkv ]]; then
         # if written file is .mkv, convert to mp4 with ffmpeg (with filename sans extension)
         ffmpeg -i $dir/$file -vcodec copy -acodec copy $dir/$filename.mp4
         #rm $dir/$file
         echo ""
      fi
   done
