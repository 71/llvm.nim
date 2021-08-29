## ===-- llvm-c/ExecutionEngine.h - ExecutionEngine Lib C Iface --*- C++ -*-===*\
## |*                                                                            *|
## |*                     The LLVM Compiler Infrastructure                       *|
## |*                                                                            *|
## |* This file is distributed under the University of Illinois Open Source      *|
## |* License. See LICENSE.TXT for details.                                      *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*|
## |*                                                                            *|
## |* This header declares the C interface to libLLVMExecutionEngine.o, which    *|
## |* implements various analyses of the LLVM IR.                                *|
## |*                                                                            *|
## |* Many exotic languages can interoperate with C code but have a harder time  *|
## |* with C++ due to name mangling. So in addition to C, this interface enables *|
## |* tools written in such languages.                                           *|
## |*                                                                            *|
## \*===----------------------------------------------------------------------===

## *
##  @defgroup LLVMCExecutionEngine Execution Engine
##  @ingroup LLVMC
##
##  @{
##

proc LinkInMCJIT*() {.llvmc.}
proc LinkInInterpreter*() {.llvmc.}
type
  GenericValueRef* = ptr OpaqueGenericValue
  ExecutionEngineRef* = ptr OpaqueExecutionEngine
  MCJITMemoryManagerRef* = ptr OpaqueMCJITMemoryManager
  MCJITCompilerOptions* {.bycopy.} = object
    optLevel*: cuint
    codeModel*: CodeModel
    noFramePointerElim*: Bool
    enableFastISel*: Bool
    mcjmm*: MCJITMemoryManagerRef


## ===-- Operations on generic values --------------------------------------===

proc CreateGenericValueOfInt*(ty: TypeRef; n: culonglong; isSigned: Bool): GenericValueRef {.llvmc.}
proc CreateGenericValueOfPointer*(p: pointer): GenericValueRef {.llvmc.}
proc CreateGenericValueOfFloat*(ty: TypeRef; n: cdouble): GenericValueRef {.llvmc.}
proc GenericValueIntWidth*(genValRef: GenericValueRef): cuint {.llvmc.}
proc GenericValueToInt*(genVal: GenericValueRef; isSigned: Bool): culonglong {.llvmc.}
proc GenericValueToPointer*(genVal: GenericValueRef): pointer {.llvmc.}
proc GenericValueToFloat*(tyRef: TypeRef; genVal: GenericValueRef): cdouble {.llvmc.}
proc DisposeGenericValue*(genVal: GenericValueRef) {.llvmc.}
## ===-- Operations on execution engines -----------------------------------===

proc CreateExecutionEngineForModule*(outEE: ptr ExecutionEngineRef; m: ModuleRef;
                                    outError: cstringArray): Bool {.llvmc.}
proc CreateInterpreterForModule*(outInterp: ptr ExecutionEngineRef; m: ModuleRef;
                                outError: cstringArray): Bool {.llvmc.}
proc CreateJITCompilerForModule*(outJIT: ptr ExecutionEngineRef; m: ModuleRef;
                                optLevel: cuint; outError: cstringArray): Bool {.llvmc.}
proc InitializeMCJITCompilerOptions*(options: ptr MCJITCompilerOptions;
                                    sizeOfOptions: csize_t) {.llvmc.}
## *
##  Create an MCJIT execution engine for a module, with the given options. It is
##  the responsibility of the caller to ensure that all fields in Options up to
##  the given SizeOfOptions are initialized. It is correct to pass a smaller
##  value of SizeOfOptions that omits some fields. The canonical way of using
##  this is:
##
##  LLVMMCJITCompilerOptions options;
##  LLVMInitializeMCJITCompilerOptions(&options, sizeof(options));
##  ... fill in those options you care about
##  LLVMCreateMCJITCompilerForModule(&jit, mod, &options, sizeof(options),
##                                   &error);
##
##  Note that this is also correct, though possibly suboptimal:
##
##  LLVMCreateMCJITCompilerForModule(&jit, mod, 0, 0, &error);
##

proc CreateMCJITCompilerForModule*(outJIT: ptr ExecutionEngineRef; m: ModuleRef;
                                  options: ptr MCJITCompilerOptions;
                                  sizeOfOptions: csize_t; outError: cstringArray): Bool {.llvmc.}
proc DisposeExecutionEngine*(ee: ExecutionEngineRef) {.llvmc.}
proc RunStaticConstructors*(ee: ExecutionEngineRef) {.llvmc.}
proc RunStaticDestructors*(ee: ExecutionEngineRef) {.llvmc.}
proc RunFunctionAsMain*(ee: ExecutionEngineRef; f: ValueRef; argC: cuint;
                       argV: cstringArray; envP: cstringArray): cint {.llvmc.}
proc RunFunction*(ee: ExecutionEngineRef; f: ValueRef; numArgs: cuint;
                 args: ptr GenericValueRef): GenericValueRef {.llvmc.}
proc FreeMachineCodeForFunction*(ee: ExecutionEngineRef; f: ValueRef) {.llvmc.}
proc AddModule*(ee: ExecutionEngineRef; m: ModuleRef) {.llvmc.}
proc RemoveModule*(ee: ExecutionEngineRef; m: ModuleRef; outMod: ptr ModuleRef;
                  outError: cstringArray): Bool {.llvmc.}
proc FindFunction*(ee: ExecutionEngineRef; name: cstring; outFn: ptr ValueRef): Bool {.llvmc.}
proc RecompileAndRelinkFunction*(ee: ExecutionEngineRef; fn: ValueRef): pointer {.llvmc.}
proc GetExecutionEngineTargetData*(ee: ExecutionEngineRef): TargetDataRef {.llvmc.}
proc GetExecutionEngineTargetMachine*(ee: ExecutionEngineRef): TargetMachineRef {.llvmc.}
proc AddGlobalMapping*(ee: ExecutionEngineRef; global: ValueRef; `addr`: pointer) {.llvmc.}
proc GetPointerToGlobal*(ee: ExecutionEngineRef; global: ValueRef): pointer {.llvmc.}
proc GetGlobalValueAddress*(ee: ExecutionEngineRef; name: cstring): pointer {.llvmc.}
proc GetFunctionAddress*(ee: ExecutionEngineRef; name: cstring): pointer {.llvmc.}

## Returns true on error, false on success
proc ExecutionEngineGetErrMsg*(ee: ExecutionEngineRef, outError: cstringArray): Bool {.llvmc.}

## ===-- Operations on memory managers -------------------------------------===

type
  MemoryManagerAllocateCodeSectionCallback* = proc (opaque: pointer; size: uintptrT;
      alignment: cuint; sectionID: cuint; sectionName: cstring): ptr uint8T
  MemoryManagerAllocateDataSectionCallback* = proc (opaque: pointer; size: uintptrT;
      alignment: cuint; sectionID: cuint; sectionName: cstring; isReadOnly: Bool): ptr uint8T
  MemoryManagerFinalizeMemoryCallback* = proc (opaque: pointer; errMsg: cstringArray): Bool
  MemoryManagerDestroyCallback* = proc (opaque: pointer)

## *
##  Create a simple custom MCJIT memory manager. This memory manager can
##  intercept allocations in a module-oblivious way. This will return NULL
##  if any of the passed functions are NULL.
##
##  @param Opaque An opaque client object to pass back to the callbacks.
##  @param AllocateCodeSection Allocate a block of memory for executable code.
##  @param AllocateDataSection Allocate a block of memory for data.
##  @param FinalizeMemory Set page permissions and flush cache. Return 0 on
##    success, 1 on error.
##

proc CreateSimpleMCJITMemoryManager*(opaque: pointer; allocateCodeSection: MemoryManagerAllocateCodeSectionCallback;
    allocateDataSection: MemoryManagerAllocateDataSectionCallback; finalizeMemory: MemoryManagerFinalizeMemoryCallback;
                                    destroy: MemoryManagerDestroyCallback): MCJITMemoryManagerRef {.llvmc.}
proc DisposeMCJITMemoryManager*(mm: MCJITMemoryManagerRef) {.llvmc.}

proc CreateGDBRegistrationListener*(): JITEventListenerRef {.llvmc.}
proc CreateIntelJITEventListener*(): JITEventListenerRef {.llvmc.}
proc CreateOProfileJITEventListener*(): JITEventListenerRef {.llvmc.}
proc CreatePerfJITEventListener*(): JITEventListenerRef {.llvmc.}

## *
##  @}
##
