#!/bin/bash

action=${1:-}

set -eu
root_dir=$(cd $(dirname "$(ls -l $0 | awk '{ print $NF }')")/.. && pwd)

download_path=${root_dir}/.downloads
mkdir -p $download_path
pushd $download_path

downloads=$(find ${root_dir}/src -name "op-local-releases.yml" -exec cat {} \; | awk '/# https?:\/\//{ print $2 }')
for u in $downloads; do 
  if [[ $action == show ]]; then
    echo "Download: $u"
  else
    curl -JLO $u
  fi
done

popd