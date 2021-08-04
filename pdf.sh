#!/usr/bin/env bash
# Script to generate all PDFs in techdocs.site
# Loops through /_site/prince-list-txt to get filenames, then executes Prince command to generate PDF in /doc
# To generate PDFs, run "sh pdf.sh" from root of this project

for file in $(cat ./_site/prince-list.txt); do
  echo "Converting to pdf: $file";
output=$(echo $file | sed -e 's/_site//g' | sed -e 's/.html//g');
prince $file --script=js/toc.js --style=_site/css/pdf.css -o .$output.pdf --fileroot=_site --no-warn-css;
done