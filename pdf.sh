#!/usr/bin/env bash

# run from root of project, "sh pdf.sh"

for file in $(cat ./content/prince-list.txt); do
  echo "Converting to pdf: $file";
output=$(echo $file | sed -e 's/content/src/g' | sed -e 's/.html//g');
prince $file --javascript --script=content/js/toc.js -o $output.pdf --fileroot content -s content/css/pdf.css;
done