#!/bin/bash

export DFPATH=$(dirname "$0")

symlink() {
    echo "SYNC $1 $2"
    pushd $1 > /dev/null
    for f in $(find . ! -path . | sed "s|^\./||"); do
        if [ -d $f ]; then
            mkdir -p $2$f
        else
            echo "Installing $(pwd)/$f to $2$f"
            rm $2$f
            ln -s $(pwd)/$f $2$f
        fi
    done;
    popd > /dev/null
}

if [ $# -gt 0 ]; then
    echo "LINK $1 ${DFPATH}"
    [ -d ${DFPATH}/$1/ ] && symlink ${DFPATH}/$1 ~/
else
    echo "usage: install-zsh.sh DIRECTORY"
fi