#!/bin/sh

cd $GITHUB_WORKSPACE/fv-source
./build_aed-fv.sh
mkdir -p $GITHUB_WORKSPACE/binaries/ubuntu/20.04
cp -r $GITHUB_WORKSPACE/fv-source/binaries/ubuntu/20.04/* $GITHUB_WORKSPACE/binaries/ubuntu/20.04/.

# git config --global user.name "github-actions[bot]"
# git config --global user.email "41898282+github-actions[bot]@users.noreply.github.com"
# git pull
# git add -A
# git commit -m "Update Ubuntu 20.04 binaries"
# git push
