## ===-- llvm-c/Core.h - Core Library C Interface ------------------*- C -*-===*\
## |*                                                                            *|
## |*                     The LLVM Compiler Infrastructure                       *|
## |*                                                                            *|
## |* This file is distributed under the University of Illinois Open Source      *|
## |* License. See LICENSE.TXT for details.                                      *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*|
## |*                                                                            *|
## |* This header declares the C interface to libLLVMCore.a, which implements    *|
## |* the LLVM intermediate representation.                                      *|
## |*                                                                            *|
## \*===----------------------------------------------------------------------===

## *
##  @defgroup LLVMC LLVM-C: C interface to LLVM
##
##  This module exposes parts of the LLVM library as a C API.
##
##  @{
##
## *
##  @defgroup LLVMCTransforms Transforms
##
## *
##  @defgroup LLVMCCore Core
##
##  This modules provide an interface to libLLVMCore, which implements
##  the LLVM intermediate representation as well as other related types
##  and utilities.
##
##  Many exotic languages can interoperate with C code but have a harder time
##  with C++ due to name mangling. So in addition to C, this interface enables
##  tools written in such languages.
##

proc InitializeCore*(r: PassRegistryRef) {.llvmc.}

## * Deallocate and destroy all ManagedStatic variables.
##     @see llvm::llvm_shutdown
##     @see ManagedStatic

proc Shutdown*() {.llvmc.}

## ===-- Error handling ----------------------------------------------------===

proc CreateMessage*(message: cstring): cstring {.llvmc.}
proc DisposeMessage*(message: cstring) {.llvmc.}

## *
##  @}
##

include Core/[Enums, Contexts, Modules, Types, Values, Metadata, BasicBlock, Instructions]


## *
##  @defgroup LLVMCCoreInstructionBuilder Instruction Builders
##
##  An instruction builder represents a point within a basic block and is
##  the exclusive means of building instructions using the C interface.
##
##  @{
##

proc CreateBuilderInContext*(c: ContextRef): BuilderRef {.llvmc.}
proc CreateBuilder*(): BuilderRef {.llvmc.}
proc PositionBuilder*(builder: BuilderRef; `block`: BasicBlockRef; instr: ValueRef) {.llvmc.}
proc PositionBuilderBefore*(builder: BuilderRef; instr: ValueRef) {.llvmc.}
proc PositionBuilderAtEnd*(builder: BuilderRef; `block`: BasicBlockRef) {.llvmc.}
proc GetInsertBlock*(builder: BuilderRef): BasicBlockRef {.llvmc.}
proc ClearInsertionPosition*(builder: BuilderRef) {.llvmc.}
proc InsertIntoBuilder*(builder: BuilderRef; instr: ValueRef) {.llvmc.}
proc InsertIntoBuilderWithName*(builder: BuilderRef; instr: ValueRef; name: cstring) {.llvmc.}
proc DisposeBuilder*(builder: BuilderRef) {.llvmc.}

proc GetCurrentDebugLocation2*(builder: BuilderRef): MetadataRef {.llvmc.}
proc SetCurrentDebugLocation2*(builder: BuilderRef, loc: MetadataRef) {.llvmc.}
proc SetInstDebugLocation*(builder: BuilderRef; inst: ValueRef) {.llvmc.}
## Get the dafult floating-point math metadata for a given builder
proc BuilderGetDefaultFPMathTag*(builder: BuilderRef): MetadataRef {.llvmc.}
## Set the default floating-point math metadata for the given builder
proc BuilderSetDefaultFPMathTag*(builder: BuilderRef, fpMathTag: MetadataRef) {.llvmc.}
proc SetCurrentDebugLocation*(builder: BuilderRef; L: ValueRef) {.llvmc, deprecated.}
proc GetCurrentDebugLocation*(builder: BuilderRef): ValueRef {.llvmc, deprecated.}

proc BuildRetVoid*(a2: BuilderRef): ValueRef {.llvmc.}
proc BuildRet*(a2: BuilderRef; v: ValueRef): ValueRef {.llvmc.}
proc BuildAggregateRet*(a2: BuilderRef; retVals: ptr ValueRef; n: cuint): ValueRef {.llvmc.}
proc BuildBr*(a2: BuilderRef; dest: BasicBlockRef): ValueRef {.llvmc.}
proc BuildCondBr*(a2: BuilderRef; `if`: ValueRef; then: BasicBlockRef;
                 `else`: BasicBlockRef): ValueRef {.llvmc.}
proc BuildSwitch*(a2: BuilderRef; v: ValueRef; `else`: BasicBlockRef; numCases: cuint): ValueRef {.llvmc.}
proc BuildIndirectBr*(b: BuilderRef; `addr`: ValueRef; numDests: cuint): ValueRef {.llvmc.}
proc BuildInvoke*(a2: BuilderRef; fn: ValueRef; args: ptr ValueRef; numArgs: cuint;
                 then: BasicBlockRef; catch: BasicBlockRef; name: cstring): ValueRef {.llvmc.}
proc BuildInvoke2*(builder: BuilderRef, ty: TypeRef, fn: ValueRef, args: ptr ValueRef, numArgs: cuint, then: BasicBlockRef, catch: BasicBlockRef, name: cstring): ValueRef {.llvmc.}
proc BuildUnreachable*(a2: BuilderRef): ValueRef {.llvmc.}
proc BuildResume*(b: BuilderRef; exn: ValueRef): ValueRef {.llvmc.}
proc BuildLandingPad*(b: BuilderRef; ty: TypeRef; persFn: ValueRef; numClauses: cuint;
                     name: cstring): ValueRef {.llvmc.}

proc BuildCleanupRet*(b: BuilderRef, catchPad: ValueRef, bb: BasicBlockRef): ValueRef {.llvmc.}
proc BuildCatchRet*(b: BuilderRef, catchPad: ValueRef, bb: BasicBlockRef): ValueRef {.llvmc.}
proc BuildCatchPad*(b: BuilderRef, parentPad: ValueRef, args: ptr ValueRef, numArgs: cuint, name: cstring): ValueRef {.llvmc.}
proc BuildCleanupPad*(b: BuilderRef, parentPad: ValueRef, args: ptr ValueRef, numArgs: cuint, name: cstring): ValueRef {.llvmc.}
proc BuildCatchSwitch*(b: BuilderRef, parentPad: ValueRef, unwindBB: BasicBlockRef, numHandlers: cuint, name: cstring): ValueRef {.llvmc.}

##  Add a case to the switch instruction

proc AddCase*(switch: ValueRef; onVal: ValueRef; dest: BasicBlockRef) {.llvmc.}
##  Add a destination to the indirectbr instruction

proc AddDestination*(indirectBr: ValueRef; dest: BasicBlockRef) {.llvmc.}
##  Get the number of clauses on the landingpad instruction

proc GetNumClauses*(landingPad: ValueRef): cuint {.llvmc.}
##  Get the value of the clause at idnex Idx on the landingpad instruction

proc GetClause*(landingPad: ValueRef; idx: cuint): ValueRef {.llvmc.}
##  Add a catch or filter clause to the landingpad instruction

proc AddClause*(landingPad: ValueRef; clauseVal: ValueRef) {.llvmc.}
##  Get the 'cleanup' flag in the landingpad instruction

proc IsCleanup*(landingPad: ValueRef): Bool {.llvmc.}

##  Set the 'cleanup' flag in the landingpad instruction
proc SetCleanup*(landingPad: ValueRef; val: Bool) {.llvmc.}

proc AdddHandler*(catchSwitch: ValueRef, dest: BasicBlockRef) {.llvmc.}
proc GetNumHandlers*(catchSwitch: ValueRef): cuint {.llvmc.}

## Obtain the basic blocks acting as handlers for a catchswitch instruction
proc GetHandlers*(catchSwitch: ValueRef, handlers: ptr BasicBlockRef) {.llvmc.}

proc GetArgOperand*(funclet: ValueRef, i: cuint): ValueRef {.llvmc.}

proc SetArgOperand*(funclet: ValueRef, i: cuint, value: ValueRef) {.llvmc.}

## Get the parent catchswitch instruction of a catchpad instruction
proc GetParentCatchSwitch*(catchPad: ValueRef): ValueRef {.llvmc.}

## Set the parent catchswitch instruction of a catchpad instruction
proc SetParentCatchSwitch*(catchPad: ValueRef, catchSwitch: ValueRef) {.llvmc.}

##  Arithmetic

proc BuildAdd*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildNSWAdd*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildNUWAdd*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildFAdd*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildSub*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildNSWSub*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildNUWSub*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildFSub*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildMul*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildNSWMul*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildNUWMul*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildFMul*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildUDiv*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildExactUDiv*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildSDiv*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildExactSDiv*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildFDiv*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildURem*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildSRem*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildFRem*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildShl*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildLShr*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildAShr*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildAnd*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildOr*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildXor*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildBinOp*(b: BuilderRef; op: Opcode; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildNeg*(a2: BuilderRef; v: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildNSWNeg*(b: BuilderRef; v: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildNUWNeg*(b: BuilderRef; v: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildFNeg*(a2: BuilderRef; v: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildNot*(a2: BuilderRef; v: ValueRef; name: cstring): ValueRef {.llvmc.}
##  Memory

proc BuildMalloc*(a2: BuilderRef; ty: TypeRef; name: cstring): ValueRef {.llvmc.}
proc BuildArrayMalloc*(a2: BuilderRef; ty: TypeRef; val: ValueRef; name: cstring): ValueRef {.llvmc.}
## Creates and inserts a memset to the specified pointer and the specified value
proc BuildMemSet*(b: BuilderRef, p: ValueRef, val: ValueRef, length: ValueRef, align: cuint): ValueRef {.llvmc.}
## Creates and inserts a memcpy between the specified pointers
proc BuildMemCpy*(b: BuilderRef, dst: ValueRef, dstAlign: cuint, src: ValueRef, srcAlign: cuint, size: ValueRef): ValueRef {.llvmc.}
## Creates and inserts a memmove between the specified pointers
proc BuildMemMove*(b: BuilderRef, dst: ValueRef, dstAlign: cuint, src: ValueRef, srcAlign: cuint, size: ValueRef): ValueRef {.llvmc.}
proc BuildAlloca*(a2: BuilderRef; ty: TypeRef; name: cstring): ValueRef {.llvmc.}
proc BuildArrayAlloca*(a2: BuilderRef; ty: TypeRef; val: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildFree*(a2: BuilderRef; pointerVal: ValueRef): ValueRef {.llvmc.}
proc BuildLoad*(a2: BuilderRef; pointerVal: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildLoad2*(a2: BuilderRef, ty: TypeRef, pointerVal: ValueRef, name: cstring): ValueRef {.llvmc.}
proc BuildStore*(a2: BuilderRef; val: ValueRef; `ptr`: ValueRef): ValueRef {.llvmc.}
proc BuildGEP*(b: BuilderRef; pointer: ValueRef; indices: ptr ValueRef;
              numIndices: cuint; name: cstring): ValueRef {.llvmc.}
proc BuildInBoundsGEP*(b: BuilderRef; pointer: ValueRef; indices: ptr ValueRef;
                      numIndices: cuint; name: cstring): ValueRef {.llvmc.}
proc BuildStructGEP*(b: BuilderRef; pointer: ValueRef; idx: cuint; name: cstring): ValueRef {.llvmc.}
proc BuildGEP2*(b: BuilderRef, ty: TypeRef, p: ValueRef, indices: ptr ValueRef, numIndices: cuint, name: cstring): ValueRef {.llvmc.}
proc BuildInBoundsGEP2*(b: BuilderRef, ty: TypeRef, p: ValueRef, indices: ptr ValueRef, numIndices: cuint, name: cstring): ValueRef {.llvmc.}
proc BuildStructGEP2*(b: BuilderRef, ty: TypeRef, p: ValueRef, idx: cuint, name: cstring): ValueRef {.llvmc.}
proc BuildGlobalString*(b: BuilderRef; str: cstring; name: cstring): ValueRef {.llvmc.}
proc BuildGlobalStringPtr*(b: BuilderRef; str: cstring; name: cstring): ValueRef {.llvmc.}
proc GetVolatile*(memoryAccessInst: ValueRef): Bool {.llvmc.}
proc SetVolatile*(memoryAccessInst: ValueRef; isVolatile: Bool) {.llvmc.}
proc GetWeak*(cmpXchgInst: ValueRef): Bool {.llvmc.}
proc SetWeak*(cmpXchgInst: ValueRef; isWeak: Bool) {.llvmc.}
proc GetOrdering*(memoryAccessInst: ValueRef): AtomicOrdering {.llvmc.}
proc SetOrdering*(memoryAccessInst: ValueRef; ordering: AtomicOrdering) {.llvmc.}
proc GetAtomicRMWbinOp*(atomicRmWInst: ValueRef): AtomicRMWBinOp {.llvmc.}
proc SetAtomicRMWbinOp*(atomicRmWInst: ValueRef; binOp: AtomicRMWBinOp) {.llvmc.}
##  Casts

proc BuildTrunc*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.llvmc.}
proc BuildZExt*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.llvmc.}
proc BuildSExt*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.llvmc.}
proc BuildFPToUI*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.llvmc.}
proc BuildFPToSI*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.llvmc.}
proc BuildUIToFP*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.llvmc.}
proc BuildSIToFP*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.llvmc.}
proc BuildFPTrunc*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.llvmc.}
proc BuildFPExt*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.llvmc.}
proc BuildPtrToInt*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.llvmc.}
proc BuildIntToPtr*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.llvmc.}
proc BuildBitCast*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.llvmc.}
proc BuildAddrSpaceCast*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.llvmc.}
proc BuildZExtOrBitCast*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.llvmc.}
proc BuildSExtOrBitCast*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.llvmc.}
proc BuildTruncOrBitCast*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.llvmc.}
proc BuildCast*(b: BuilderRef; op: Opcode; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.llvmc.}
proc BuildPointerCast*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.llvmc.}
proc BuildIntCast2*(a2: BuilderRef, val: ValueRef, destTy: TypeRef, isSigned: Bool, name: cstring): ValueRef {.llvmc.}
proc BuildFPCast*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.llvmc.}
proc BuildIntCast*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.llvmc, deprecated.}
  ## Signed cast!

##  Comparisons

proc BuildICmp*(a2: BuilderRef; op: IntPredicate; lhs: ValueRef; rhs: ValueRef;
               name: cstring): ValueRef {.llvmc.}
proc BuildFCmp*(a2: BuilderRef; op: RealPredicate; lhs: ValueRef; rhs: ValueRef;
               name: cstring): ValueRef {.llvmc.}
##  Miscellaneous instructions

proc BuildPhi*(a2: BuilderRef; ty: TypeRef; name: cstring): ValueRef {.llvmc.}
proc BuildCall*(a2: BuilderRef; fn: ValueRef; args: ptr ValueRef; numArgs: cuint;
               name: cstring): ValueRef {.llvmc.}
proc BuildCall2*(a2: BuilderRef, ty: TypeRef, fn: ValueRef, args: ptr ValueRef, numArgs: cuint, name: cstring): ValueRef {.llvmc.}
proc BuildSelect*(a2: BuilderRef; `if`: ValueRef; then: ValueRef; `else`: ValueRef;
                 name: cstring): ValueRef {.llvmc.}
proc BuildVAArg*(a2: BuilderRef; list: ValueRef; ty: TypeRef; name: cstring): ValueRef {.llvmc.}
proc BuildExtractElement*(a2: BuilderRef; vecVal: ValueRef; index: ValueRef;
                         name: cstring): ValueRef {.llvmc.}
proc BuildInsertElement*(a2: BuilderRef; vecVal: ValueRef; eltVal: ValueRef;
                        index: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildShuffleVector*(a2: BuilderRef; v1: ValueRef; v2: ValueRef; mask: ValueRef;
                        name: cstring): ValueRef {.llvmc.}
proc BuildExtractValue*(a2: BuilderRef; aggVal: ValueRef; index: cuint; name: cstring): ValueRef {.llvmc.}
proc BuildInsertValue*(a2: BuilderRef; aggVal: ValueRef; eltVal: ValueRef;
                      index: cuint; name: cstring): ValueRef {.llvmc.}
proc BuildFreeze*(a2: BuilderRef, val: ValueRef, name: cstring): ValueRef {.llvmc.}
proc BuildIsNull*(a2: BuilderRef; val: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildIsNotNull*(a2: BuilderRef; val: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildPtrDiff*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.llvmc.}
proc BuildFence*(b: BuilderRef; ordering: AtomicOrdering; singleThread: Bool;
                name: cstring): ValueRef {.llvmc.}
proc BuildAtomicRMW*(b: BuilderRef; op: AtomicRMWBinOp; `ptr`: ValueRef; val: ValueRef;
                    ordering: AtomicOrdering; singleThread: Bool): ValueRef {.llvmc.}
proc BuildAtomicCmpXchg*(b: BuilderRef; `ptr`: ValueRef; cmp: ValueRef; new: ValueRef;
                        successOrdering: AtomicOrdering;
                        failureOrdering: AtomicOrdering; singleThread: Bool): ValueRef {.llvmc.}

## Get the number of elements in the mask of a ShuffleVector instruction
proc GetNumMaskElements*(shuffleVectorInst: ValueRef): cuint {.llvmc.}
proc GetUndefMaskElem*(): cint {.llvmc.}

## Get the mask value at position Elt in the mask of a ShuffleVector instruction
proc GetMaskValue*(shuffleVectorInst: ValueRef, elt: cuint): int {.llvmc.}

proc IsAtomicSingleThread*(atomicInst: ValueRef): Bool {.llvmc.}
proc SetAtomicSingleThread*(atomicInst: ValueRef; singleThread: Bool) {.llvmc.}
proc GetCmpXchgSuccessOrdering*(cmpXchgInst: ValueRef): AtomicOrdering {.llvmc.}
proc SetCmpXchgSuccessOrdering*(cmpXchgInst: ValueRef; ordering: AtomicOrdering) {.llvmc.}
proc GetCmpXchgFailureOrdering*(cmpXchgInst: ValueRef): AtomicOrdering {.llvmc.}
proc SetCmpXchgFailureOrdering*(cmpXchgInst: ValueRef; ordering: AtomicOrdering) {.llvmc.}
## *
##  @}
##
## *
##  @defgroup LLVMCCoreModuleProvider Module Providers
##
##  @{
##
## *
##  Changes the type of M so it can be passed to FunctionPassManagers and the
##  JIT.  They take ModuleProviders for historical reasons.
##

proc CreateModuleProviderForExistingModule*(m: ModuleRef): ModuleProviderRef {.llvmc.}
## *
##  Destroys the module M.
##

proc DisposeModuleProvider*(m: ModuleProviderRef) {.llvmc.}
## *
##  @}
##
## *
##  @defgroup LLVMCCoreMemoryBuffers Memory Buffers
##
##  @{
##

proc CreateMemoryBufferWithContentsOfFile*(path: cstring;
    outMemBuf: ptr MemoryBufferRef; outMessage: cstringArray): Bool {.llvmc.}
proc CreateMemoryBufferWithSTDIN*(outMemBuf: ptr MemoryBufferRef;
                                 outMessage: cstringArray): Bool {.llvmc.}
proc CreateMemoryBufferWithMemoryRange*(inputData: cstring; inputDataLength: csize_t;
                                       bufferName: cstring;
                                       requiresNullTerminator: Bool): MemoryBufferRef {.llvmc.}
proc CreateMemoryBufferWithMemoryRangeCopy*(inputData: cstring;
    inputDataLength: csize_t; bufferName: cstring): MemoryBufferRef {.llvmc.}
proc GetBufferStart*(memBuf: MemoryBufferRef): cstring {.llvmc.}
proc GetBufferSize*(memBuf: MemoryBufferRef): csize_t {.llvmc.}
proc DisposeMemoryBuffer*(memBuf: MemoryBufferRef) {.llvmc.}
## *
##  @}
##
## *
##  @defgroup LLVMCCorePassRegistry Pass Registry
##
##  @{
##
## * Return the global pass registry, for use with initialization functions.
##     @see llvm::PassRegistry::getPassRegistry

proc GetGlobalPassRegistry*(): PassRegistryRef {.llvmc.}
## *
##  @}
##
## *
##  @defgroup LLVMCCorePassManagers Pass Managers
##
##  @{
##
## * Constructs a new whole-module pass pipeline. This type of pipeline is
##     suitable for link-time optimization and whole-module transformations.
##     @see llvm::PassManager::PassManager

proc CreatePassManager*(): PassManagerRef {.llvmc.}
## * Constructs a new function-by-function pass pipeline over the module
##     provider. It does not take ownership of the module provider. This type of
##     pipeline is suitable for code generation and JIT compilation tasks.
##     @see llvm::FunctionPassManager::FunctionPassManager

proc CreateFunctionPassManagerForModule*(m: ModuleRef): PassManagerRef {.llvmc.}
## * Deprecated: Use LLVMCreateFunctionPassManagerForModule instead.

proc CreateFunctionPassManager*(mp: ModuleProviderRef): PassManagerRef {.llvmc.}
## * Initializes, executes on the provided module, and finalizes all of the
##     passes scheduled in the pass manager. Returns 1 if any of the passes
##     modified the module, 0 otherwise.
##     @see llvm::PassManager::run(Module&)

proc RunPassManager*(pm: PassManagerRef; m: ModuleRef): Bool {.llvmc.}
## * Initializes all of the function passes scheduled in the function pass
##     manager. Returns 1 if any of the passes modified the module, 0 otherwise.
##     @see llvm::FunctionPassManager::doInitialization

proc InitializeFunctionPassManager*(fpm: PassManagerRef): Bool {.llvmc.}
## * Executes all of the function passes scheduled in the function pass manager
##     on the provided function. Returns 1 if any of the passes modified the
##     function, false otherwise.
##     @see llvm::FunctionPassManager::run(Function&)

proc RunFunctionPassManager*(fpm: PassManagerRef; f: ValueRef): Bool {.llvmc.}
## * Finalizes all of the function passes scheduled in in the function pass
##     manager. Returns 1 if any of the passes modified the module, 0 otherwise.
##     @see llvm::FunctionPassManager::doFinalization

proc FinalizeFunctionPassManager*(fpm: PassManagerRef): Bool {.llvmc.}
## * Frees the memory of a pass pipeline. For function pipelines, does not free
##     the module provider.
##     @see llvm::PassManagerBase::~PassManagerBase.

proc DisposePassManager*(pm: PassManagerRef) {.llvmc.}
## *
##  @}
##
## *
##  @defgroup LLVMCCoreThreading Threading
##
##  Handle the structures needed to make LLVM safe for multithreading.
##
##  @{
##
## * Deprecated: Multi-threading can only be enabled/disabled with the compile
##     time define LLVM_ENABLE_THREADS.  This function always returns
##     LLVMIsMultithreaded().

proc StartMultithreaded*(): Bool {.llvmc.}
## * Deprecated: Multi-threading can only be enabled/disabled with the compile
##     time define LLVM_ENABLE_THREADS.

proc StopMultithreaded*() {.llvmc.}
## * Check whether LLVM is executing in thread-safe mode or not.
##     @see llvm::llvm_is_multithreaded

proc IsMultithreaded*(): Bool {.llvmc.}
