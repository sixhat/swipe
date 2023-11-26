#!/bin/sh

gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=clean-"$1" -c .setpdfwrite -f "$1"
