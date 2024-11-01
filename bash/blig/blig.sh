#!/bin/bash
set -e

# BLiG
# Version 0.0.3
# Right now this is probably not ready for production. 
# It is just a first writing done in less than 30min.
# I'll try to keep developing it further but now it is highly
# integrated with mdbook. My future objective is to make it 
# based on pandoc. 

editor="code"
ano=$(date +%Y)
mes=$(date +%m)


function new_post {
    read -pr "   --- Enter post title: " post_title
    file_name=$(echo "$post_title" | tr '[:upper:]' '[:lower:]')
    file_name=${file_name// /-}
    full_name="$ano/$mes-$file_name.md"
    echo "[$post_title]($ano/$mes-$file_name.md)" | cat - src/SUMMARY.md > temp && mv temp src/SUMMARY.md
    touch "src/$full_name"
    echo "# $post_title" > "src/$full_name"
    $editor "src/$full_name"
}

function edit {
    PS3=" ^-- BLiG file to edit: "
    select opt in src/$ano/*.md
    do
        echo "$opt"
        $editor "$opt"
        PS3=" ^-- BLiG choose option: "
        break
    done
}

function render {
    mdbook build
    mdbook serve
}

function init {
    mdbook init
}

function menu {
    PS3=" ^-- BLiG choose option: "
    select opt in new edit render init quit
    do
        case $REPLY in
            1) new_post;;
            2) edit;;
            3) render;;
            4) init;;
            5) exit;;
        esac
    done
}

menu
