#!/bin/bash
echo "Waiting on convert UML API"
while ! nc -z convert 3000; do
  sleep 0.1;
done
echo "convert UML API is up"
mkdir -p ../assetcs/uml-svg;
rm ../assetcs/uml-svg/*
shopt -s nullglob;
for f in *.md
do
  echo "Processing $f file...";
  FNAME=$(echo $f | sed s/\.md//g);
  # take action on each file. $f store current file name
curl --request POST \
    --url http://convert:8000/convert/markdown \
    --header 'Content-Type: multipart/form-data' \
    --form files=@index.html \
    --form files=@$f \
    -o ../pdf/$FNAME.pdf;
curlexit=$?
if [ $curlexit -ne 0 ]
then 
exit $curlexit
fi
done
rm index.html