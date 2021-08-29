## ===-- llvm-c/BitReader.h - BitReader Library C Interface ------*- C++ -*-===*\
## |*                                                                            *|
## |*                     The LLVM Compiler Infrastructure                       *|
## |*                                                                            *|
## |* This file is distributed under the University of Illinois Open Source      *|
## |* License. See LICENSE.TXT for details.                                      *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*|
## |*                                                                            *|
## |* This header declares the C interface to libLLVMBitReader.a, which          *|
## |* implements input of the LLVM bitcode format.                               *|
## |*                                                                            *|
## |* Many exotic languages can interoperate with C code but have a harder time  *|
## |* with C++ due to name mangling. So in addition to C, this interface enables *|
## |* tools written in such languages.                                           *|
## |*                                                                            *|
## \*===----------------------------------------------------------------------===

## *
##  @defgroup LLVMCBitReader Bit Reader
##  @ingroup LLVMC
##
##  @{
##
##  Builds a module from the bitcode in the specified memory buffer, returning a
##    reference to the module via the OutModule parameter. Returns 0 on success.
##    Optionally returns a human-readable error message via OutMessage.
##
##    This is deprecated. Use LLVMParseBitcode2.

proc ParseBitcode*(memBuf: MemoryBufferRef; outModule: ptr ModuleRef;
                  outMessage: cstringArray): Bool  {.llvmc.}
##  Builds a module from the bitcode in the specified memory buffer, returning a
##    reference to the module via the OutModule parameter. Returns 0 on success.

proc ParseBitcode2*(memBuf: MemoryBufferRef; outModule: ptr ModuleRef): Bool  {.llvmc.}
##  This is deprecated. Use LLVMParseBitcodeInContext2.

proc ParseBitcodeInContext*(contextRef: ContextRef; memBuf: MemoryBufferRef;
                           outModule: ptr ModuleRef; outMessage: cstringArray): Bool  {.llvmc.}
proc ParseBitcodeInContext2*(contextRef: ContextRef; memBuf: MemoryBufferRef;
                            outModule: ptr ModuleRef): Bool  {.llvmc.}
## * Reads a module from the specified path, returning via the OutMP parameter
##     a module provider which performs lazy deserialization. Returns 0 on success.
##     Optionally returns a human-readable error message via OutMessage.
##     This is deprecated. Use LLVMGetBitcodeModuleInContext2.

proc GetBitcodeModuleInContext*(contextRef: ContextRef; memBuf: MemoryBufferRef;
                               outM: ptr ModuleRef; outMessage: cstringArray): Bool  {.llvmc.}
## * Reads a module from the specified path, returning via the OutMP parameter a
##  module provider which performs lazy deserialization. Returns 0 on success.

proc GetBitcodeModuleInContext2*(contextRef: ContextRef; memBuf: MemoryBufferRef;
                                outM: ptr ModuleRef): Bool  {.llvmc.}
##  This is deprecated. Use LLVMGetBitcodeModule2.

proc GetBitcodeModule*(memBuf: MemoryBufferRef; outM: ptr ModuleRef;
                      outMessage: cstringArray): Bool  {.llvmc.}
proc GetBitcodeModule2*(memBuf: MemoryBufferRef; outM: ptr ModuleRef): Bool  {.llvmc.}
## *
##  @}
##
