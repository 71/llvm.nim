## ===-- llvm-c/Initialization.h - Initialization C Interface ------*- C -*-===*\
## |*                                                                            *|
## |*                     The LLVM Compiler Infrastructure                       *|
## |*                                                                            *|
## |* This file is distributed under the University of Illinois Open Source      *|
## |* License. See LICENSE.TXT for details.                                      *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*|
## |*                                                                            *|
## |* This header declares the C interface to LLVM initialization routines,      *|
## |* which must be called before you can use the functionality provided by      *|
## |* the corresponding LLVM library.                                            *|
## |*                                                                            *|
## \*===----------------------------------------------------------------------===

## *
##  @defgroup LLVMCInitialization Initialization Routines
##  @ingroup LLVMC
## 
##  This module contains routines used to initialize the LLVM system.
## 
##  @{
## 

when false:
  proc initializeCore*(r: PassRegistryRef) {.importc: "LLVMInitializeCore",
                                        dynlib: LLVMLib.}
proc initializeTransformUtils*(r: PassRegistryRef) {.
    importc: "LLVMInitializeTransformUtils", dynlib: LLVMLib.}
proc initializeScalarOpts*(r: PassRegistryRef) {.
    importc: "LLVMInitializeScalarOpts", dynlib: LLVMLib.}
proc initializeObjCARCOpts*(r: PassRegistryRef) {.
    importc: "LLVMInitializeObjCARCOpts", dynlib: LLVMLib.}
proc initializeVectorization*(r: PassRegistryRef) {.
    importc: "LLVMInitializeVectorization", dynlib: LLVMLib.}
proc initializeInstCombine*(r: PassRegistryRef) {.
    importc: "LLVMInitializeInstCombine", dynlib: LLVMLib.}
proc initializeIPO*(r: PassRegistryRef) {.importc: "LLVMInitializeIPO",
                                       dynlib: LLVMLib.}
proc initializeInstrumentation*(r: PassRegistryRef) {.
    importc: "LLVMInitializeInstrumentation", dynlib: LLVMLib.}
proc initializeAnalysis*(r: PassRegistryRef) {.importc: "LLVMInitializeAnalysis",
    dynlib: LLVMLib.}
proc initializeIPA*(r: PassRegistryRef) {.importc: "LLVMInitializeIPA",
                                       dynlib: LLVMLib.}
proc initializeCodeGen*(r: PassRegistryRef) {.importc: "LLVMInitializeCodeGen",
    dynlib: LLVMLib.}
proc initializeTarget*(r: PassRegistryRef) {.importc: "LLVMInitializeTarget",
    dynlib: LLVMLib.}
## *
##  @}
## 
