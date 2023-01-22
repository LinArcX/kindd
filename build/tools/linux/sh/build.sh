#!/bin/sh

build_debug()
{
  echo ">>> Creating 'build/output/linux/debug' directory"
  mkdir -p build/output/cmake
  mkdir -p build/output/linux/debug

  echo ">>> Building app (Debug mode)"
  cd build/output/cmake
  cmake -DCMAKE_BUILD_TYPE=DEBUG ../../tools/cross_platform/cmake
  make
  cd ../../../
}

build_release()
{
  echo ">>> Creating 'build/output/linux/release' directory"
  mkdir -p build/output/cmake
  mkdir -p build/output/linux/release

  echo ">>> Building app (Release mode)"
  cd build/output/cmake
  cmake -DCMAKE_BUILD_TYPE=RELEASE ../../tools/cross_platform/cmake
  make
  cd ../../../
}

run_debug() {
  echo ">>> Running app (Debug mode)"
  ./build/output/linux/debug/kindd &
}

run_release() {
  echo ">>> Running app (Release mode)"
  ./build/output/linux/release/kindd &
}

clean_debug() {
  echo ">>> Cleaning debug directory"
  #rm -r build/output/cmake/
  rm -r build/output/linux/debug/
}

clean_release() {
  echo ">>> Cleaning release directory"
  #rm -r build/output/cmake/
  rm -r build/output/linux/release/
}

case "$1" in
  "") ;;
  build_debug) "$@"; exit;;
  build_release) "$@"; exit;;
  run_debug) "$@"; exit;;
  run_release) "$@"; exit;;
  clean_debug) "$@"; exit;;
  clean_release) "$@"; exit;;
  *) log_error "Unkown function: $1()"; exit 2;;
esac
