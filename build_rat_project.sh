#!/bin/bash
# helper script to build any of the several rat projects

# # Unofficial bash strict mode (http://redsymbol.net/articles/unofficial-bash-strict-mode)
set -euo pipefail

if [[ $# != 1 ]]; then
  echo "please provide a project URL" >&2
  exit 1
fi

PROJ_NAME="$1"

git clone "https://gitlab.com/Project-Rat/${PROJ_NAME}.git"
cd "${PROJ_NAME}"
git fetch
git checkout dev
mkdir build
cmake -S . -B build -DBLA_VENDOR=Intel10_64lp_seq
cmake --build build -- -j8
pushd build && make test && make install && popd
