#!/bin/bash
mkdir -p ../pdf;
shopt -s nullglob;
for f in *.md
do
  echo "Processing $f file...";
  FNAME=$(echo $f | sed s/\.md//g);
  # take action on each file. $f store current file name
  echo "<!doctype html>
 <html lang="en">
  <head>
    <meta charset="utf-8">
    <title>$FNAME</title>
  </head>
  <body>
    {{ toHTML .DirPath \"$f\" }}
  </body>
 </html>" > index.html;
echo "-u $USERNAME:$PASSWORD" | curl -K- --request POST \
    --url https://file.dev.mdics.me/convert/markdown \
    --header 'Content-Type: multipart/form-data' \
    --form files=@index.html \
    --form files=@$f \
    -o ../pdf/$FNAME.pdf;
done
rm index.html
