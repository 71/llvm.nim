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

proc InitializeTransformUtils*(r: PassRegistryRef) {.llvmc.}
proc InitializeScalarOpts*(r: PassRegistryRef) {.llvmc.}
proc InitializeObjCARCOpts*(r: PassRegistryRef) {.llvmc.}
proc InitializeVectorization*(r: PassRegistryRef) {.llvmc.}
proc InitializeInstCombine*(r: PassRegistryRef) {.llvmc.}
proc InitializeAggressiveInstCombiner*(r: PassRegistryRef) {.llvmc.}
proc InitializeIPO*(r: PassRegistryRef) {.llvmc.}
proc InitializeInstrumentation*(r: PassRegistryRef) {.llvmc.}
proc InitializeAnalysis*(r: PassRegistryRef) {.llvmc.}
proc InitializeIPA*(r: PassRegistryRef) {.llvmc.}
proc InitializeCodeGen*(r: PassRegistryRef) {.llvmc.}
proc InitializeTarget*(r: PassRegistryRef) {.llvmc.}
## *
##  @}
##
