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

proc addArgumentPromotionPass*(pm: PassManagerRef) {.
    importc: "LLVMAddArgumentPromotionPass", dynlib: LLVMLib.}
## * See llvm::createConstantMergePass function.

proc addConstantMergePass*(pm: PassManagerRef) {.
    importc: "LLVMAddConstantMergePass", dynlib: LLVMLib.}
## * See llvm::createDeadArgEliminationPass function.

proc addDeadArgEliminationPass*(pm: PassManagerRef) {.
    importc: "LLVMAddDeadArgEliminationPass", dynlib: LLVMLib.}
## * See llvm::createFunctionAttrsPass function.

proc addFunctionAttrsPass*(pm: PassManagerRef) {.
    importc: "LLVMAddFunctionAttrsPass", dynlib: LLVMLib.}
## * See llvm::createFunctionInliningPass function.

proc addFunctionInliningPass*(pm: PassManagerRef) {.
    importc: "LLVMAddFunctionInliningPass", dynlib: LLVMLib.}
## * See llvm::createAlwaysInlinerPass function.

proc addAlwaysInlinerPass*(pm: PassManagerRef) {.
    importc: "LLVMAddAlwaysInlinerPass", dynlib: LLVMLib.}
## * See llvm::createGlobalDCEPass function.

proc addGlobalDCEPass*(pm: PassManagerRef) {.importc: "LLVMAddGlobalDCEPass",
    dynlib: LLVMLib.}
## * See llvm::createGlobalOptimizerPass function.

proc addGlobalOptimizerPass*(pm: PassManagerRef) {.
    importc: "LLVMAddGlobalOptimizerPass", dynlib: LLVMLib.}
## * See llvm::createIPConstantPropagationPass function.

proc addIPConstantPropagationPass*(pm: PassManagerRef) {.
    importc: "LLVMAddIPConstantPropagationPass", dynlib: LLVMLib.}
## * See llvm::createPruneEHPass function.

proc addPruneEHPass*(pm: PassManagerRef) {.importc: "LLVMAddPruneEHPass",
                                        dynlib: LLVMLib.}
## * See llvm::createIPSCCPPass function.

proc addIPSCCPPass*(pm: PassManagerRef) {.importc: "LLVMAddIPSCCPPass",
                                       dynlib: LLVMLib.}
## * See llvm::createInternalizePass function.

proc addInternalizePass*(a2: PassManagerRef; allButMain: cuint) {.
    importc: "LLVMAddInternalizePass", dynlib: LLVMLib.}
## * See llvm::createStripDeadPrototypesPass function.

proc addStripDeadPrototypesPass*(pm: PassManagerRef) {.
    importc: "LLVMAddStripDeadPrototypesPass", dynlib: LLVMLib.}
## * See llvm::createStripSymbolsPass function.

proc addStripSymbolsPass*(pm: PassManagerRef) {.importc: "LLVMAddStripSymbolsPass",
    dynlib: LLVMLib.}
## *
##  @}
## 
