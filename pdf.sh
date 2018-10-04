#!/usr/bin/env bash
for file in $(cat ./content/prince-list.txt); do
  echo "Converting to pdf: $file";
  prince $file --baseurl https://nde-devportal-docs.niketech.com;
done
