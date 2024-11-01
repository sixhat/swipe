#!/bin/bash
set -e

# Será interessante colocar isto num só ficheiro que faça tudo
# new post
# build
# edit
# delete
# list

function new_post {
    read -p "   --- Enter post title: " post_title
    echo "$post_title"
    ano=$(date +%Y)
    mes=$(date +%m)
    file_name=$(echo "$post_title" | tr '[:upper:]' '[:lower:]')
    file_name=${file_name// /-}
    full_name="$ano/$mes-$file_name.md"
    echo "$full_name"
    echo "[$post_title]($ano/$mes-$file_name.md)" | cat - src/SUMMARY.md > temp && mv temp src/SUMMARY.md
    touch "src/$full_name"
    echo "# $post_title" > "src/$full_name"
    vim "src/$full_name"
}

function edit {
    ano=$(date +%Y)
    mes=$(date +%m)
    PS3=" ^-- BLiG file to edit: "
    select opt in src/$ano/*.md
    do
        echo $opt
        vim $opt
        PS3=" ^-- BLiG choose option: "
        break
    done
}

function render {
    mdbook build
    mdbook serve
}


function menu {
    PS3=" ^-- BLiG choose option: "
    select opt in new edit render init quit
    do
        case $REPLY in
            1) new_post;;
            2) edit;;
            3) render;;
            5) exit;;
        esac
    done
}

menu
