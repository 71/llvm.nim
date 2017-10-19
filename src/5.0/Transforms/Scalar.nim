## ===-- Scalar.h - Scalar Transformation Library C Interface ----*- C++ -*-===*\
## |*                                                                            *|
## |*                     The LLVM Compiler Infrastructure                       *|
## |*                                                                            *|
## |* This file is distributed under the University of Illinois Open Source      *|
## |* License. See LICENSE.TXT for details.                                      *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*|
## |*                                                                            *|
## |* This header declares the C interface to libLLVMScalarOpts.a, which         *|
## |* implements various scalar transformations of the LLVM IR.                  *|
## |*                                                                            *|
## |* Many exotic languages can interoperate with C code but have a harder time  *|
## |* with C++ due to name mangling. So in addition to C, this interface enables *|
## |* tools written in such languages.                                           *|
## |*                                                                            *|
## \*===----------------------------------------------------------------------===

## *
##  @defgroup LLVMCTransformsScalar Scalar transformations
##  @ingroup LLVMCTransforms
## 
##  @{
## 
## * See llvm::createAggressiveDCEPass function.

proc addAggressiveDCEPass*(pm: PassManagerRef) {.
    importc: "LLVMAddAggressiveDCEPass", dynlib: LLVMLib.}
## * See llvm::createBitTrackingDCEPass function.

proc addBitTrackingDCEPass*(pm: PassManagerRef) {.
    importc: "LLVMAddBitTrackingDCEPass", dynlib: LLVMLib.}
## * See llvm::createAlignmentFromAssumptionsPass function.

proc addAlignmentFromAssumptionsPass*(pm: PassManagerRef) {.
    importc: "LLVMAddAlignmentFromAssumptionsPass", dynlib: LLVMLib.}
## * See llvm::createCFGSimplificationPass function.

proc addCFGSimplificationPass*(pm: PassManagerRef) {.
    importc: "LLVMAddCFGSimplificationPass", dynlib: LLVMLib.}
## * See llvm::createLateCFGSimplificationPass function.

proc addLateCFGSimplificationPass*(pm: PassManagerRef) {.
    importc: "LLVMAddLateCFGSimplificationPass", dynlib: LLVMLib.}
## * See llvm::createDeadStoreEliminationPass function.

proc addDeadStoreEliminationPass*(pm: PassManagerRef) {.
    importc: "LLVMAddDeadStoreEliminationPass", dynlib: LLVMLib.}
## * See llvm::createScalarizerPass function.

proc addScalarizerPass*(pm: PassManagerRef) {.importc: "LLVMAddScalarizerPass",
    dynlib: LLVMLib.}
## * See llvm::createMergedLoadStoreMotionPass function.

proc addMergedLoadStoreMotionPass*(pm: PassManagerRef) {.
    importc: "LLVMAddMergedLoadStoreMotionPass", dynlib: LLVMLib.}
## * See llvm::createGVNPass function.

proc addGVNPass*(pm: PassManagerRef) {.importc: "LLVMAddGVNPass", dynlib: LLVMLib.}
## * See llvm::createGVNPass function.

proc addNewGVNPass*(pm: PassManagerRef) {.importc: "LLVMAddNewGVNPass",
                                       dynlib: LLVMLib.}
## * See llvm::createIndVarSimplifyPass function.

proc addIndVarSimplifyPass*(pm: PassManagerRef) {.
    importc: "LLVMAddIndVarSimplifyPass", dynlib: LLVMLib.}
## * See llvm::createInstructionCombiningPass function.

proc addInstructionCombiningPass*(pm: PassManagerRef) {.
    importc: "LLVMAddInstructionCombiningPass", dynlib: LLVMLib.}
## * See llvm::createJumpThreadingPass function.

proc addJumpThreadingPass*(pm: PassManagerRef) {.
    importc: "LLVMAddJumpThreadingPass", dynlib: LLVMLib.}
## * See llvm::createLICMPass function.

proc addLICMPass*(pm: PassManagerRef) {.importc: "LLVMAddLICMPass", dynlib: LLVMLib.}
## * See llvm::createLoopDeletionPass function.

proc addLoopDeletionPass*(pm: PassManagerRef) {.importc: "LLVMAddLoopDeletionPass",
    dynlib: LLVMLib.}
## * See llvm::createLoopIdiomPass function

proc addLoopIdiomPass*(pm: PassManagerRef) {.importc: "LLVMAddLoopIdiomPass",
    dynlib: LLVMLib.}
## * See llvm::createLoopRotatePass function.

proc addLoopRotatePass*(pm: PassManagerRef) {.importc: "LLVMAddLoopRotatePass",
    dynlib: LLVMLib.}
## * See llvm::createLoopRerollPass function.

proc addLoopRerollPass*(pm: PassManagerRef) {.importc: "LLVMAddLoopRerollPass",
    dynlib: LLVMLib.}
## * See llvm::createLoopUnrollPass function.

proc addLoopUnrollPass*(pm: PassManagerRef) {.importc: "LLVMAddLoopUnrollPass",
    dynlib: LLVMLib.}
## * See llvm::createLoopUnswitchPass function.

proc addLoopUnswitchPass*(pm: PassManagerRef) {.importc: "LLVMAddLoopUnswitchPass",
    dynlib: LLVMLib.}
## * See llvm::createMemCpyOptPass function.

proc addMemCpyOptPass*(pm: PassManagerRef) {.importc: "LLVMAddMemCpyOptPass",
    dynlib: LLVMLib.}
## * See llvm::createPartiallyInlineLibCallsPass function.

proc addPartiallyInlineLibCallsPass*(pm: PassManagerRef) {.
    importc: "LLVMAddPartiallyInlineLibCallsPass", dynlib: LLVMLib.}
## * See llvm::createLowerSwitchPass function.

proc addLowerSwitchPass*(pm: PassManagerRef) {.importc: "LLVMAddLowerSwitchPass",
    dynlib: LLVMLib.}
## * See llvm::createPromoteMemoryToRegisterPass function.

proc addPromoteMemoryToRegisterPass*(pm: PassManagerRef) {.
    importc: "LLVMAddPromoteMemoryToRegisterPass", dynlib: LLVMLib.}
## * See llvm::createReassociatePass function.

proc addReassociatePass*(pm: PassManagerRef) {.importc: "LLVMAddReassociatePass",
    dynlib: LLVMLib.}
## * See llvm::createSCCPPass function.

proc addSCCPPass*(pm: PassManagerRef) {.importc: "LLVMAddSCCPPass", dynlib: LLVMLib.}
## * See llvm::createSROAPass function.

proc addScalarReplAggregatesPass*(pm: PassManagerRef) {.
    importc: "LLVMAddScalarReplAggregatesPass", dynlib: LLVMLib.}
## * See llvm::createSROAPass function.

proc addScalarReplAggregatesPassSSA*(pm: PassManagerRef) {.
    importc: "LLVMAddScalarReplAggregatesPassSSA", dynlib: LLVMLib.}
## * See llvm::createSROAPass function.

proc addScalarReplAggregatesPassWithThreshold*(pm: PassManagerRef; threshold: cint) {.
    importc: "LLVMAddScalarReplAggregatesPassWithThreshold", dynlib: LLVMLib.}
## * See llvm::createSimplifyLibCallsPass function.

proc addSimplifyLibCallsPass*(pm: PassManagerRef) {.
    importc: "LLVMAddSimplifyLibCallsPass", dynlib: LLVMLib.}
## * See llvm::createTailCallEliminationPass function.

proc addTailCallEliminationPass*(pm: PassManagerRef) {.
    importc: "LLVMAddTailCallEliminationPass", dynlib: LLVMLib.}
## * See llvm::createConstantPropagationPass function.

proc addConstantPropagationPass*(pm: PassManagerRef) {.
    importc: "LLVMAddConstantPropagationPass", dynlib: LLVMLib.}
## * See llvm::demotePromoteMemoryToRegisterPass function.

proc addDemoteMemoryToRegisterPass*(pm: PassManagerRef) {.
    importc: "LLVMAddDemoteMemoryToRegisterPass", dynlib: LLVMLib.}
## * See llvm::createVerifierPass function.

proc addVerifierPass*(pm: PassManagerRef) {.importc: "LLVMAddVerifierPass",
    dynlib: LLVMLib.}
## * See llvm::createCorrelatedValuePropagationPass function

proc addCorrelatedValuePropagationPass*(pm: PassManagerRef) {.
    importc: "LLVMAddCorrelatedValuePropagationPass", dynlib: LLVMLib.}
## * See llvm::createEarlyCSEPass function

proc addEarlyCSEPass*(pm: PassManagerRef) {.importc: "LLVMAddEarlyCSEPass",
    dynlib: LLVMLib.}
## * See llvm::createEarlyCSEPass function

proc addEarlyCSEMemSSAPass*(pm: PassManagerRef) {.
    importc: "LLVMAddEarlyCSEMemSSAPass", dynlib: LLVMLib.}
## * See llvm::createLowerExpectIntrinsicPass function

proc addLowerExpectIntrinsicPass*(pm: PassManagerRef) {.
    importc: "LLVMAddLowerExpectIntrinsicPass", dynlib: LLVMLib.}
## * See llvm::createTypeBasedAliasAnalysisPass function

proc addTypeBasedAliasAnalysisPass*(pm: PassManagerRef) {.
    importc: "LLVMAddTypeBasedAliasAnalysisPass", dynlib: LLVMLib.}
## * See llvm::createScopedNoAliasAAPass function

proc addScopedNoAliasAAPass*(pm: PassManagerRef) {.
    importc: "LLVMAddScopedNoAliasAAPass", dynlib: LLVMLib.}
## * See llvm::createBasicAliasAnalysisPass function

proc addBasicAliasAnalysisPass*(pm: PassManagerRef) {.
    importc: "LLVMAddBasicAliasAnalysisPass", dynlib: LLVMLib.}
## *
##  @}
## 
