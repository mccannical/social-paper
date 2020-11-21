#!/bin/bash
video="list/videos"
date=`date +%Y%m%d%s`
dataRaw=data/$date/raw
dataProc=data/$date/proc
dataComments=data/$date/comments

echo "   [+] Welcome to the pipeline! We will read from the video list at data/videos:"
if [ -s "$video" ] 
then
	echo "   [+] $video has some data."
    echo "   [*] There are `cat $video | wc -l` videos to parse" 
        # do something as file has data
    echo "    [+] Making a new folder to store data"
    mkdir -p $dataRaw
    mkdir -p $dataProc
    mkdir -p $dataComments
else
	echo "$video is empty."
        exit
fi

echo "    [+] Now, we will pass these to the youtube comment downloader and save the output to disk:"
i=0
while read line; do
    ((i=i+1))
    echo "Downloading Video: ${i}"
    python youtube-comment-downloader/downloader.py -y=${line} -o $dataRaw/${i}-${line}.json
done <$video

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
echo "    [+] Lets tanslate json to csv"    

for video in $dataRaw/*.json; do
    # grabs basename of parsed file
    fname=`basename $video`
    # converts json to tsv
    cat $video | sed 's/\\[tn]//g' | jq -r '. | [.votes, .author, .text] | @tsv' > "$dataProc/$fname.tsv"
    # counts lines in file
    line=`(cat "$dataProc/$fname.tsv" | wc -l)`
    # adds count of comments to the file name
    comments=`(echo "$dataProc/$fname.tsv" | sed "s/data\///g" | sed "s/json/${line}-comments/g" )`
    # 
    cname=`basename $comments`
    echo "  [-] Comment filename: $cname"
    
    cp "$dataProc/$fname.tsv" "$dataComments/$cname"
done
