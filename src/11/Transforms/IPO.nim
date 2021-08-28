## ===-- IPO.h - Interprocedural Transformations C Interface -----*- C++ -*-===*\
## |*                                                                            *|
## |*                     The LLVM Compiler Infrastructure                       *|
## |*                                                                            *|
## |* This file is distributed under the University of Illinois Open Source      *|
## |* License. See LICENSE.TXT for details.                                      *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*|
## |*                                                                            *|
## |* This header declares the C interface to libLLVMIPO.a, which implements     *|
## |* various interprocedural transformations of the LLVM IR.                    *|
## |*                                                                            *|
## \*===----------------------------------------------------------------------===

## *
##  @defgroup LLVMCTransformsIPO Interprocedural transformations
##  @ingroup LLVMCTransforms
##
##  @{
##
## * See llvm::createArgumentPromotionPass function.

proc AddArgumentPromotionPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createConstantMergePass function.

proc AddConstantMergePass*(pm: PassManagerRef) {.llvmc.}


## See llvm::createMergeFunctionsPass function
proc AddMergeFunctionsPass*(pm: PassManagerRef) {.llvmc.}

## See llvm::createCalledValuePropagationPass function
proc AddCalledValuePropagationPass*(pm: PassManagerRef) {.llvmc.}

## * See llvm::createDeadArgEliminationPass function.
##
proc AddDeadArgEliminationPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createFunctionAttrsPass function.

proc AddFunctionAttrsPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createFunctionInliningPass function.

proc AddFunctionInliningPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createAlwaysInlinerPass function.

proc AddAlwaysInlinerPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createGlobalDCEPass function.

proc AddGlobalDCEPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createGlobalOptimizerPass function.

proc AddGlobalOptimizerPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createIPConstantPropagationPass function.

proc AddIPConstantPropagationPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createPruneEHPass function.

proc AddPruneEHPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createIPSCCPPass function.

proc AddIPSCCPPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createInternalizePass function.

proc AddInternalizePass*(a2: PassManagerRef; allButMain: cuint) {.llvmc.}
## * See llvm::createStripDeadPrototypesPass function.


## Create and add the internalize pass to the given pass manager with the provided preservation callback
proc AddInternalizePassWithMustPreservePredicate*(pm: PassManagerRef ctx: pointer, mustPreserve: proc (ValueRef, pointer): Bool) {.llvmc.}

proc AddStripDeadPrototypesPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createStripSymbolsPass function.

proc AddStripSymbolsPass*(pm: PassManagerRef) {.llvmc.}
## *
##  @}
##
