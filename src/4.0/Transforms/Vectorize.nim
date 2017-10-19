## ===---------------------------Vectorize.h --------------------- -*- C -*-===*\
## |*===----------- Vectorization Transformation Library C Interface ---------===*|
## |*                                                                            *|
## |*                     The LLVM Compiler Infrastructure                       *|
## |*                                                                            *|
## |* This file is distributed under the University of Illinois Open Source      *|
## |* License. See LICENSE.TXT for details.                                      *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*|
## |*                                                                            *|
## |* This header declares the C interface to libLLVMVectorize.a, which          *|
## |* implements various vectorization transformations of the LLVM IR.           *|
## |*                                                                            *|
## |* Many exotic languages can interoperate with C code but have a harder time  *|
## |* with C++ due to name mangling. So in addition to C, this interface enables *|
## |* tools written in such languages.                                           *|
## |*                                                                            *|
## \*===----------------------------------------------------------------------===

## *
##  @defgroup LLVMCTransformsVectorize Vectorization transformations
##  @ingroup LLVMCTransforms
## 
##  @{
## 
## * See llvm::createBBVectorizePass function.

proc addBBVectorizePass*(pm: PassManagerRef) {.importc: "LLVMAddBBVectorizePass",
    dynlib: LLVMLib.}
## * See llvm::createLoopVectorizePass function.

proc addLoopVectorizePass*(pm: PassManagerRef) {.
    importc: "LLVMAddLoopVectorizePass", dynlib: LLVMLib.}
## * See llvm::createSLPVectorizerPass function.

proc addSLPVectorizePass*(pm: PassManagerRef) {.importc: "LLVMAddSLPVectorizePass",
    dynlib: LLVMLib.}
## *
##  @}
## 
