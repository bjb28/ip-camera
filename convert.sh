#/bin/bash

for FILE in "/srv/data"/*
do
    ffmpeg -i $FILE -c:v libx264 -crf 19 -strict experimental $(echo $FILE | sed 's/flv/mp4/')
done
