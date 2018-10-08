#!/usr/bin/env bash
for file in $(cat ./content/prince-list.txt); do
  echo "Converting to pdf: $file";
output=$(echo $file | sed -e 's/content/src/g' | sed -e 's/.html//g');
prince $file --baseurl https://nde-devportal-docs.niketech.com -o $output.pdf;
done