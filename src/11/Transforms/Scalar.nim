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

proc AddAggressiveDCEPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createBitTrackingDCEPass function.

## See llvm::createDeadCodeEliminationPass function
proc AddDCEPass*(pm: PassManagerRef) {.llvmc.}

proc AddBitTrackingDCEPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createAlignmentFromAssumptionsPass function.

proc AddAlignmentFromAssumptionsPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createCFGSimplificationPass function.

proc AddCFGSimplificationPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createLateCFGSimplificationPass function.

proc AddDeadStoreEliminationPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createScalarizerPass function.

proc AddScalarizerPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createMergedLoadStoreMotionPass function.

proc AddMergedLoadStoreMotionPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createGVNPass function.

proc AddGVNPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createGVNPass function.

proc AddNewGVNPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createIndVarSimplifyPass function.

proc AddIndVarSimplifyPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createInstructionCombiningPass function.

proc AddInstructionCombiningPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createJumpThreadingPass function.

proc AddJumpThreadingPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createLICMPass function.

proc AddLICMPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createLoopDeletionPass function.

proc AddLoopDeletionPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createLoopIdiomPass function

proc AddLoopIdiomPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createLoopRotatePass function.

proc AddLoopRotatePass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createLoopRerollPass function.

proc AddLoopRerollPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createLoopUnrollPass function.

proc AddLoopUnrollPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createLoopUnrollAndJamPass function.

proc AddLoopUnrollAndJamPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createLoopUnswitchPass function.

proc AddLoopUnswitchPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createLowerAtomicPass function.

proc AddLowerAtomicPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createMemCpyOptPass function.

proc AddMemCpyOptPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createPartiallyInlineLibCallsPass function.

proc AddPartiallyInlineLibCallsPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createReassociatePass function.

proc AddReassociatePass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createSCCPPass function.

proc AddSCCPPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createSROAPass function.

proc AddScalarReplAggregatesPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createSROAPass function.

proc AddScalarReplAggregatesPassSSA*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createSROAPass function.

proc AddScalarReplAggregatesPassWithThreshold*(pm: PassManagerRef; threshold: cint) {.llvmc.}
## * See llvm::createSimplifyLibCallsPass function.

proc AddSimplifyLibCallsPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createTailCallEliminationPass function.

proc AddTailCallEliminationPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createConstantPropagationPass function.

proc AddConstantPropagationPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::demotePromoteMemoryToRegisterPass function.

proc AddDemoteMemoryToRegisterPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createVerifierPass function.

proc AddVerifierPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createCorrelatedValuePropagationPass function

proc AddCorrelatedValuePropagationPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createEarlyCSEPass function

proc AddEarlyCSEPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createEarlyCSEPass function

proc AddEarlyCSEMemSSAPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createLowerExpectIntrinsicPass function

proc AddLowerExpectIntrinsicPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createLowerConstantIntrinsicsPass function

proc AddLowerConstantIntrinsicsPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createTypeBasedAliasAnalysisPass function

proc AddTypeBasedAliasAnalysisPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createScopedNoAliasAAPass function

proc AddScopedNoAliasAAPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createBasicAliasAnalysisPass function

proc AddBasicAliasAnalysisPass*(pm: PassManagerRef) {.llvmc.}
## * See llvm::createUnifyFunctionExitNodesPass function

proc AddUnifyFunctionExitNodesPass*(pm: PassManagerRef) {.llvmc.}
## *
##  @}
##
