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

proc linkInMCJIT*() {.importc: "LLVMLinkInMCJIT", dynlib: LLVMLib.}
proc linkInInterpreter*() {.importc: "LLVMLinkInInterpreter", dynlib: LLVMLib.}
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

proc createGenericValueOfInt*(ty: TypeRef; n: culonglong; isSigned: Bool): GenericValueRef {.
    importc: "LLVMCreateGenericValueOfInt", dynlib: LLVMLib.}
proc createGenericValueOfPointer*(p: pointer): GenericValueRef {.
    importc: "LLVMCreateGenericValueOfPointer", dynlib: LLVMLib.}
proc createGenericValueOfFloat*(ty: TypeRef; n: cdouble): GenericValueRef {.
    importc: "LLVMCreateGenericValueOfFloat", dynlib: LLVMLib.}
proc genericValueIntWidth*(genValRef: GenericValueRef): cuint {.
    importc: "LLVMGenericValueIntWidth", dynlib: LLVMLib.}
proc genericValueToInt*(genVal: GenericValueRef; isSigned: Bool): culonglong {.
    importc: "LLVMGenericValueToInt", dynlib: LLVMLib.}
proc genericValueToPointer*(genVal: GenericValueRef): pointer {.
    importc: "LLVMGenericValueToPointer", dynlib: LLVMLib.}
proc genericValueToFloat*(tyRef: TypeRef; genVal: GenericValueRef): cdouble {.
    importc: "LLVMGenericValueToFloat", dynlib: LLVMLib.}
proc disposeGenericValue*(genVal: GenericValueRef) {.
    importc: "LLVMDisposeGenericValue", dynlib: LLVMLib.}
## ===-- Operations on execution engines -----------------------------------===

proc createExecutionEngineForModule*(outEE: ptr ExecutionEngineRef; m: ModuleRef;
                                    outError: cstringArray): Bool {.
    importc: "LLVMCreateExecutionEngineForModule", dynlib: LLVMLib.}
proc createInterpreterForModule*(outInterp: ptr ExecutionEngineRef; m: ModuleRef;
                                outError: cstringArray): Bool {.
    importc: "LLVMCreateInterpreterForModule", dynlib: LLVMLib.}
proc createJITCompilerForModule*(outJIT: ptr ExecutionEngineRef; m: ModuleRef;
                                optLevel: cuint; outError: cstringArray): Bool {.
    importc: "LLVMCreateJITCompilerForModule", dynlib: LLVMLib.}
proc initializeMCJITCompilerOptions*(options: ptr MCJITCompilerOptions;
                                    sizeOfOptions: csize) {.
    importc: "LLVMInitializeMCJITCompilerOptions", dynlib: LLVMLib.}
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

proc createMCJITCompilerForModule*(outJIT: ptr ExecutionEngineRef; m: ModuleRef;
                                  options: ptr MCJITCompilerOptions;
                                  sizeOfOptions: csize; outError: cstringArray): Bool {.
    importc: "LLVMCreateMCJITCompilerForModule", dynlib: LLVMLib.}
## * Deprecated: Use LLVMCreateExecutionEngineForModule instead.

proc createExecutionEngine*(outEE: ptr ExecutionEngineRef; mp: ModuleProviderRef;
                           outError: cstringArray): Bool {.
    importc: "LLVMCreateExecutionEngine", dynlib: LLVMLib.}
## * Deprecated: Use LLVMCreateInterpreterForModule instead.

proc createInterpreter*(outInterp: ptr ExecutionEngineRef; mp: ModuleProviderRef;
                       outError: cstringArray): Bool {.
    importc: "LLVMCreateInterpreter", dynlib: LLVMLib.}
## * Deprecated: Use LLVMCreateJITCompilerForModule instead.

proc createJITCompiler*(outJIT: ptr ExecutionEngineRef; mp: ModuleProviderRef;
                       optLevel: cuint; outError: cstringArray): Bool {.
    importc: "LLVMCreateJITCompiler", dynlib: LLVMLib.}
proc disposeExecutionEngine*(ee: ExecutionEngineRef) {.
    importc: "LLVMDisposeExecutionEngine", dynlib: LLVMLib.}
proc runStaticConstructors*(ee: ExecutionEngineRef) {.
    importc: "LLVMRunStaticConstructors", dynlib: LLVMLib.}
proc runStaticDestructors*(ee: ExecutionEngineRef) {.
    importc: "LLVMRunStaticDestructors", dynlib: LLVMLib.}
proc runFunctionAsMain*(ee: ExecutionEngineRef; f: ValueRef; argC: cuint;
                       argV: cstringArray; envP: cstringArray): cint {.
    importc: "LLVMRunFunctionAsMain", dynlib: LLVMLib.}
proc runFunction*(ee: ExecutionEngineRef; f: ValueRef; numArgs: cuint;
                 args: ptr GenericValueRef): GenericValueRef {.
    importc: "LLVMRunFunction", dynlib: LLVMLib.}
proc freeMachineCodeForFunction*(ee: ExecutionEngineRef; f: ValueRef) {.
    importc: "LLVMFreeMachineCodeForFunction", dynlib: LLVMLib.}
proc addModule*(ee: ExecutionEngineRef; m: ModuleRef) {.importc: "LLVMAddModule",
    dynlib: LLVMLib.}
## * Deprecated: Use LLVMAddModule instead.

proc addModuleProvider*(ee: ExecutionEngineRef; mp: ModuleProviderRef) {.
    importc: "LLVMAddModuleProvider", dynlib: LLVMLib.}
proc removeModule*(ee: ExecutionEngineRef; m: ModuleRef; outMod: ptr ModuleRef;
                  outError: cstringArray): Bool {.importc: "LLVMRemoveModule",
    dynlib: LLVMLib.}
## * Deprecated: Use LLVMRemoveModule instead.

proc removeModuleProvider*(ee: ExecutionEngineRef; mp: ModuleProviderRef;
                          outMod: ptr ModuleRef; outError: cstringArray): Bool {.
    importc: "LLVMRemoveModuleProvider", dynlib: LLVMLib.}
proc findFunction*(ee: ExecutionEngineRef; name: cstring; outFn: ptr ValueRef): Bool {.
    importc: "LLVMFindFunction", dynlib: LLVMLib.}
proc recompileAndRelinkFunction*(ee: ExecutionEngineRef; fn: ValueRef): pointer {.
    importc: "LLVMRecompileAndRelinkFunction", dynlib: LLVMLib.}
proc getExecutionEngineTargetData*(ee: ExecutionEngineRef): TargetDataRef {.
    importc: "LLVMGetExecutionEngineTargetData", dynlib: LLVMLib.}
proc getExecutionEngineTargetMachine*(ee: ExecutionEngineRef): TargetMachineRef {.
    importc: "LLVMGetExecutionEngineTargetMachine", dynlib: LLVMLib.}
proc addGlobalMapping*(ee: ExecutionEngineRef; global: ValueRef; `addr`: pointer) {.
    importc: "LLVMAddGlobalMapping", dynlib: LLVMLib.}
proc getPointerToGlobal*(ee: ExecutionEngineRef; global: ValueRef): pointer {.
    importc: "LLVMGetPointerToGlobal", dynlib: LLVMLib.}
proc getGlobalValueAddress*(ee: ExecutionEngineRef; name: cstring): uint64T {.
    importc: "LLVMGetGlobalValueAddress", dynlib: LLVMLib.}
proc getFunctionAddress*(ee: ExecutionEngineRef; name: cstring): uint64T {.
    importc: "LLVMGetFunctionAddress", dynlib: LLVMLib.}
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

proc createSimpleMCJITMemoryManager*(opaque: pointer; allocateCodeSection: MemoryManagerAllocateCodeSectionCallback;
    allocateDataSection: MemoryManagerAllocateDataSectionCallback; finalizeMemory: MemoryManagerFinalizeMemoryCallback;
                                    destroy: MemoryManagerDestroyCallback): MCJITMemoryManagerRef {.
    importc: "LLVMCreateSimpleMCJITMemoryManager", dynlib: LLVMLib.}
proc disposeMCJITMemoryManager*(mm: MCJITMemoryManagerRef) {.
    importc: "LLVMDisposeMCJITMemoryManager", dynlib: LLVMLib.}
## *
##  @}
## 
