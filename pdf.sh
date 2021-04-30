#!/usr/bin/env bash

# run from root of project, "sh pdf.sh"

for file in $(cat ./_site/prince-list.txt); do
  echo "Converting to pdf: $file";
output=$(echo $file | sed -e 's/doc/g' | sed -e 's/.html//g');
prince $file --javascript --script=_site/js/toc.js -o $output.pdf --fileroot _site -s _site/css/pdf.css;
done