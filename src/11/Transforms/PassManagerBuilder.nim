## ===-- llvm-c/Transform/PassManagerBuilder.h - PMB C Interface ---*- C -*-===*\
## |*                                                                            *|
## |*                     The LLVM Compiler Infrastructure                       *|
## |*                                                                            *|
## |* This file is distributed under the University of Illinois Open Source      *|
## |* License. See LICENSE.TXT for details.                                      *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*|
## |*                                                                            *|
## |* This header declares the C interface to the PassManagerBuilder class.      *|
## |*                                                                            *|
## \*===----------------------------------------------------------------------===

type
  PassManagerBuilderRef* = ptr OpaquePassManagerBuilder

## *
##  @defgroup LLVMCTransformsPassManagerBuilder Pass manager builder
##  @ingroup LLVMCTransforms
## 
##  @{
## 
## * See llvm::PassManagerBuilder.

proc PassManagerBuilderCreate*(): PassManagerBuilderRef {.llvmc.}
proc PassManagerBuilderDispose*(pmb: PassManagerBuilderRef) {.llvmc.}
## * See llvm::PassManagerBuilder::OptLevel.

proc PassManagerBuilderSetOptLevel*(pmb: PassManagerBuilderRef; optLevel: cuint) {.llvmc.}
## * See llvm::PassManagerBuilder::SizeLevel.

proc PassManagerBuilderSetSizeLevel*(pmb: PassManagerBuilderRef; sizeLevel: cuint) {.llvmc.}
## * See llvm::PassManagerBuilder::DisableUnitAtATime.

proc PassManagerBuilderSetDisableUnitAtATime*(pmb: PassManagerBuilderRef;
    value: Bool) {.llvmc.}
## * See llvm::PassManagerBuilder::DisableUnrollLoops.

proc PassManagerBuilderSetDisableUnrollLoops*(pmb: PassManagerBuilderRef;
    value: Bool) {.llvmc.}
## * See llvm::PassManagerBuilder::DisableSimplifyLibCalls

proc PassManagerBuilderSetDisableSimplifyLibCalls*(pmb: PassManagerBuilderRef;
    value: Bool) {.llvmc.}
## * See llvm::PassManagerBuilder::Inliner.

proc PassManagerBuilderUseInlinerWithThreshold*(pmb: PassManagerBuilderRef;
    threshold: cuint) {.llvmc.}
## * See llvm::PassManagerBuilder::populateFunctionPassManager.

proc PassManagerBuilderPopulateFunctionPassManager*(pmb: PassManagerBuilderRef;
    pm: PassManagerRef) {.llvmc.}
## * See llvm::PassManagerBuilder::populateModulePassManager.

proc PassManagerBuilderPopulateModulePassManager*(pmb: PassManagerBuilderRef;
    pm: PassManagerRef) {.llvmc.}
## * See llvm::PassManagerBuilder::populateLTOPassManager.

proc PassManagerBuilderPopulateLTOPassManager*(pmb: PassManagerBuilderRef;
    pm: PassManagerRef; internalize: Bool; runInliner: Bool) {.llvmc.}
## *
##  @}
## 
