#!/bin/bash
echo "   [+] Welcome to the pipeline! We will read from the video list at data/videos:"
#python sheets/read_spreadsheet.py > data/videos
cat data/videos
echo "    [+] Now, we will pass these to the youtube comment downloader and save the output to disk:"
i=0

while read line; do
    ((i=i+1))
    echo "Downloading Video: ${i}"
    python youtube-comment-downloader/downloader.py -y " ${line}" -o data/"${i}-${line}".json
done <data/videos

echo
echo
echo "      [+] ______   _______  _______  _______  __  ";
echo "      [+]|      | |   _   ||       ||   _   ||  | ";
echo "      [+]|  _    ||  |_|  ||_     _||  |_|  ||  | ";
echo "      [+]| | |   ||       |  |   |  |       ||  | ";
echo "      [+]| |_|   ||       |  |   |  |       ||__| ";
echo "      [+]|       ||   _   |  |   |  |   _   | __  ";
echo "      [+]|______| |__| |__|  |___|  |__| |__||__| ";
echo
echo
echo
echo "    [+] Excellent! Now we have data!";

echo "     [+] Lets tanslate json to csv"
for video in data/*.json; do
    cat "$video"  | sed 's/\\[tn]//g' | jq -r '. | [.votes, .author, .text] | @tsv' > "$video".tsv
    line=`(cat "$video.tsv" | wc -l)`
    comments=`(echo "${video}.tsv" | sed "s/data\///g" | sed "s/json/${line}-comments/g" )`
    echo line: $line
    echo comments $comments
    cp "$video".tsv data/"$comments"
done
