#!/usr/bin/env bash

# Run this script simply as ./perf.sh from the root directory.

set -e

# TEST_REPO=https://github.com/avsm/platform
# TEST_COMMIT=01a6b7e01d0082c44553692648aad3d81820dfa2

TEST_REPO=https://github.com/ocaml/dune
TEST_COMMIT=67f55ad882dc349c248d1962b0f6c8c354f1183f

dune() {
  TIMEFORMAT=$'real %Rs\nuser %Us\nsys  %Ss\n'; time ../_build/default/bin/main.exe "$@" --root=. > /dev/null
}

setup_test() {
  mkdir -p _perf

  cd _perf
  if [ ! -f README.md ]; then
    echo "Cloning $TEST_REPO..."
    wget $TEST_REPO/archive/$TEST_COMMIT.tar.gz
    tar -xzf $TEST_COMMIT.tar.gz --strip-components=1
  fi
  cd ..
}

pad () {
  while IFS='' read -r x; do printf "%-$1s\n" "$x"; done
}

run_test() {
  echo "Building Dune..."
  make > /dev/null

  cd _perf
  rm -rf _build

  echo "Running full build..."
  dune build @install 2>> $1

  echo "Running zero build..."
  dune build @install 2>> $1

  echo "Computing rules..."
  dune rules -r _build/default/bin/main.exe 2>> $1

  cd ..
}

setup_test
CURRENT_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

rm -f _perf/rows _perf/current _perf/master

echo "            " >> _perf/rows
echo "            " >> _perf/rows
echo "           |" >> _perf/rows
echo "Full build |" >> _perf/rows
echo "           |" >> _perf/rows
echo "            " >> _perf/rows
echo "           |" >> _perf/rows
echo "Zero build |" >> _perf/rows
echo "           |" >> _perf/rows
echo "            " >> _perf/rows
echo "           |" >> _perf/rows
echo "Find rules |" >> _perf/rows
echo "           |" >> _perf/rows

echo "Current branch" >> _perf/current
echo "==============" >> _perf/current
echo "Testing the current branch ($CURRENT_BRANCH)"
run_test current

echo "Master branch" >> _perf/master
echo "=============" >> _perf/master
git checkout master
echo "Testing master"
run_test master

git checkout $CURRENT_BRANCH

echo ""

paste -d ' ' <(pad 10 < _perf/rows) <(pad 14 < _perf/current) _perf/master
