#!/bin/bash

file="index.html"

currentDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    chromePath="google-chrome"
    userDir="$(mktemp)"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    chromePath="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    userDir="$(mktemp)"
elif [[ "$OSTYPE" == "msys" ]]; then
    chromePath="C:/Program Files (x86)/Google/Chrome/Application/chrome.exe"
    userDir="$(mktemp)"
else
    echo "System not supported!"
    exit -1
fi


function openChrome()
{
    # Start Chrome without CORS
    if [[ "$OSTYPE" == "linux-gnu" ]] || [[ "$OSTYPE" == "msys" ]]; then
        "$chromePath" --new-window --disable-web-security \
                      -–allow-file-access-from-files \
                      "${currentDir}/${file}"

    elif [[ "$OSTYPE" == "darwin"* ]]; then
        open -n -a "$chromePath" --args --new-window --disable-web-security \
                    -–allow-file-access-from-files \
                    "${currentDir}/${file}"
    else
        echo "System not supported!"
        exit -1
    fi
}

function checkPath()
{
    while ! type "${chromePath}" > /dev/null 2>&1 ;
    do
        echo >&2 "I require 'Google Chrome' but path '${chromePath}' is not existing!"; 
        read -p "Enter the path to Google Chrome: " chromePath
    done
    echo "Found Google Chrome @ '${chromePath}'"
}

checkPath
openChrome