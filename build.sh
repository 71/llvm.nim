#!/bin/bash

# Note: c2nim currently does not support some C++ definitions in LLVM header files.
#       As such, the unsupported code has been wrapped in '#ifndef NIM' ... '#endif' blocks,
#       which leads c2nim to skip those parts.

: ${LLVM_INCLUDE_DIR:=/usr/lib/llvm-5.0/include}
: ${LLVM_VERSION:=5.0}

shopt -s globstar
mkdir -p ./src/$LLVM_VERSION/Transforms

for file in $LLVM_INCLUDE_DIR/llvm-c/**; do
  [ "${file: -2}" == ".h" ] || continue

  # Convert all .h files to .nim
  OUT=$(echo ${file%.*}.nim | sed -e "s=$LLVM_INCLUDE_DIR/llvm-c/==")
  c2nim --nep1 --skipinclude --assumedef:NIM --prefix:LLVM --dynlib:LLVMLib $file -o:./src/$LLVM_VERSION/$OUT

  # Fix some bugs caused by c2nim
  sed -i -e 's/ptr opaque/ptr Opaque/' $OUT
  sed -i -e 's/sizeOf/sizeOfX/' $OUT

  # Convert inline functions to imported functions
  perl -0777 -pi -e 's/proc ((\w+).+) \{.+=\s*\n[\s\S]+?\n\s*\n/proc $1 {.importc: "$2", dynlib: LLVMLib.}\n/g' $OUT

done
