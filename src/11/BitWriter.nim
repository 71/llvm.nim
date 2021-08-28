## ===-- llvm-c/BitWriter.h - BitWriter Library C Interface ------*- C++ -*-===*\
## |*                                                                            *|
## |*                     The LLVM Compiler Infrastructure                       *|
## |*                                                                            *|
## |* This file is distributed under the University of Illinois Open Source      *|
## |* License. See LICENSE.TXT for details.                                      *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*|
## |*                                                                            *|
## |* This header declares the C interface to libLLVMBitWriter.a, which          *|
## |* implements output of the LLVM bitcode format.                              *|
## |*                                                                            *|
## |* Many exotic languages can interoperate with C code but have a harder time  *|
## |* with C++ due to name mangling. So in addition to C, this interface enables *|
## |* tools written in such languages.                                           *|
## |*                                                                            *|
## \*===----------------------------------------------------------------------===

## *
##  @defgroup LLVMCBitWriter Bit Writer
##  @ingroup LLVMC
##
##  @{
##
## ===-- Operations on modules ---------------------------------------------===
## * Writes a module to the specified path. Returns 0 on success.

proc WriteBitcodeToFile*(m: ModuleRef; path: cstring): cint  {.llvmc.}
## * Writes a module to an open file descriptor. Returns 0 on success.

proc WriteBitcodeToFD*(m: ModuleRef; fd: cint; shouldClose: cint; unbuffered: cint): cint  {.llvmc.}
## * Deprecated for LLVMWriteBitcodeToFD. Writes a module to an open file
##     descriptor. Returns 0 on success. Closes the Handle.

proc WriteBitcodeToFileHandle*(m: ModuleRef; handle: cint): cint  {.llvmc.}
## * Writes a module to a new memory buffer and returns it.

proc WriteBitcodeToMemoryBuffer*(m: ModuleRef): MemoryBufferRef  {.llvmc.}
## *
##  @}
##
