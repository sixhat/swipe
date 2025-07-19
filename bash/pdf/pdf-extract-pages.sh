#!/usr/bin/env bash

set -xe

function runExtract(){
  fileout=$(basename "$3")
  fileout="${fileout%.*}"
  
  echo gs -q -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dFirstPage="$1" -dLastPage="$2" -sOutputFile="$fileout"_pp_"$1"-"$2".pdf "$3"
  gs -q -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dFirstPage="$1" -dLastPage="$2" -sOutputFile="$fileout"_pp_"$1"-"$2".pdf "$3"
  exit
}

function help(){
  echo "pdf-extract-pages, version 1"
  echo
  echo "Please USE:"
  echo
  echo "pdf-extract-pages [startPage] [endPage] <fileName>"
  echo "pdf-extract-pages [pageToExtract] <fileName>"
  echo "pdf-extract-pages <fileName>"
  exit
}

re='^[0-9]+$'

# 1 parameter - We want to extract all pages
if [[ $# -eq 1 && -r $1 ]]; then
  pages=$(pdfinfo "$1" | grep Pages | awk '{print $2}')
  echo "-- trying to extract the full document (pp. 1–$pages)"
  runExtract 1 "$pages" "$1"
fi

# 2 parameters - We want to extract single page
if [[ $# -eq 2 && -r $2 && $1 =~ $re ]]; then
  echo "-- Trying to extract page $1"
  runExtract "$1" "$1" "$2"
fi

# 3 parameters - We want to extract all pages
if [[ $# -eq 3 && -r $3 && $2 =~ $re && $1 =~ $re ]]; then
  echo "-- trying to extract pp. $1–$2"
  runExtract "$1" "$2" "$3"
fi

help
