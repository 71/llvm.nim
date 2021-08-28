## ===----------- llvm-c/OrcBindings.h - Orc Lib C Iface ---------*- C++ -*-===*\
## |*                                                                            *|
## |*                     The LLVM Compiler Infrastructure                       *|
## |*                                                                            *|
## |* This file is distributed under the University of Illinois Open Source      *|
## |* License. See LICENSE.TXT for details.                                      *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*|
## |*                                                                            *|
## |* This header declares the C interface to libLLVMOrcJIT.a, which implements  *|
## |* JIT compilation of LLVM IR.                                                *|
## |*                                                                            *|
## |* Many exotic languages can interoperate with C code but have a harder time  *|
## |* with C++ due to name mangling. So in addition to C, this interface enables *|
## |* tools written in such languages.                                           *|
## |*                                                                            *|
## |* Note: This interface is experimental. It is *NOT* stable, and may be       *|
## |*       changed without warning.                                             *|
## |*                                                                            *|
## \*===----------------------------------------------------------------------===

type
  SharedModuleRef* = ptr OpaqueSharedModule
  SharedObjectBufferRef* = ptr OpaqueSharedObjectBuffer
  OrcJITStackRef* = ptr orcOpaqueJITStack
  OrcModuleHandle* = uint32T
  OrcTargetAddress* = uint64
  OrcSymbolResolverFn* = proc (name: cstring; lookupCtx: pointer): uint64
  OrcLazyCompileCallbackFn* = proc (jITStack: OrcJITStackRef; callbackCtx: pointer): uint64
  OrcErrorCode* {.size: sizeof(cint).} = enum
    OrcErrSuccess = 0, OrcErrGeneric


## *
##  Turn an LLVMModuleRef into an LLVMSharedModuleRef.
## 
##  The JIT uses shared ownership for LLVM modules, since it is generally
##  difficult to know when the JIT will be finished with a module (and the JIT
##  has no way of knowing when a user may be finished with one).
## 
##  Calling this method with an LLVMModuleRef creates a shared-pointer to the
##  module, and returns a reference to this shared pointer.
## 
##  The shared module should be disposed when finished with by calling
##  LLVMOrcDisposeSharedModule (not LLVMDisposeModule). The Module will be
##  deleted when the last shared pointer owner relinquishes it.
## 

proc OrcMakeSharedModule*(`mod`: ModuleRef): SharedModuleRef {.llvmc.}
## *
##  Dispose of a shared module.
## 
##  The module should not be accessed after this call. The module will be
##  deleted once all clients (including the JIT itself) have released their
##  shared pointers.
## 

proc OrcDisposeSharedModuleRef*(sharedMod: SharedModuleRef) {.llvmc.}
## *
##  Get an LLVMSharedObjectBufferRef from an LLVMMemoryBufferRef.
## 

proc OrcMakeSharedObjectBuffer*(objBuffer: MemoryBufferRef): SharedObjectBufferRef {.llvmc.}
## *
##  Dispose of a shared object buffer.
## 

proc OrcDisposeSharedObjectBufferRef*(sharedObjBuffer: SharedObjectBufferRef) {.llvmc.}
## *
##  Create an ORC JIT stack.
## 
##  The client owns the resulting stack, and must call OrcDisposeInstance(...)
##  to destroy it and free its memory. The JIT stack will take ownership of the
##  TargetMachine, which will be destroyed when the stack is destroyed. The
##  client should not attempt to dispose of the Target Machine, or it will result
##  in a double-free.
## 

proc OrcCreateInstance*(tm: TargetMachineRef): OrcJITStackRef {.llvmc.}
## *
##  Get the error message for the most recent error (if any).
## 
##  This message is owned by the ORC JIT Stack and will be freed when the stack
##  is disposed of by LLVMOrcDisposeInstance.
## 

proc OrcGetErrorMsg*(jITStack: OrcJITStackRef): cstring {.llvmc.}
## *
##  Mangle the given symbol.
##  Memory will be allocated for MangledSymbol to hold the result. The client
## 

proc OrcGetMangledSymbol*(jITStack: OrcJITStackRef; mangledSymbol: cstringArray;
                         symbol: cstring) {.llvmc.}
## *
##  Dispose of a mangled symbol.
## 

proc OrcDisposeMangledSymbol*(mangledSymbol: cstring) {.llvmc.}
## *
##  Create a lazy compile callback.
## 

proc OrcCreateLazyCompileCallback*(jITStack: OrcJITStackRef;
                                  retAddr: ptr OrcTargetAddress;
                                  callback: OrcLazyCompileCallbackFn;
                                  callbackCtx: pointer): OrcErrorCode {.llvmc.}
## *
##  Create a named indirect call stub.
## 

proc OrcCreateIndirectStub*(jITStack: OrcJITStackRef; stubName: cstring;
                           initAddr: OrcTargetAddress): OrcErrorCode {.llvmc.}
## *
##  Set the pointer for the given indirect stub.
## 

proc OrcSetIndirectStubPointer*(jITStack: OrcJITStackRef; stubName: cstring;
                               newAddr: OrcTargetAddress): OrcErrorCode {.llvmc.}
## *
##  Add module to be eagerly compiled.
## 

proc OrcAddEagerlyCompiledIR*(jITStack: OrcJITStackRef;
                             retHandle: ptr OrcModuleHandle;
                             `mod`: SharedModuleRef;
                             symbolResolver: OrcSymbolResolverFn;
                             symbolResolverCtx: pointer): OrcErrorCode {.llvmc.}
## *
##  Add module to be lazily compiled one function at a time.
## 

proc OrcAddLazilyCompiledIR*(jITStack: OrcJITStackRef;
                            retHandle: ptr OrcModuleHandle; `mod`: SharedModuleRef;
                            symbolResolver: OrcSymbolResolverFn;
                            symbolResolverCtx: pointer): OrcErrorCode {.llvmc.}
## *
##  Add an object file.
## 

proc OrcAddObjectFile*(jITStack: OrcJITStackRef; retHandle: ptr OrcModuleHandle;
                      obj: SharedObjectBufferRef;
                      symbolResolver: OrcSymbolResolverFn;
                      symbolResolverCtx: pointer): OrcErrorCode {.llvmc.}
## *
##  Remove a module set from the JIT.
## 
##  This works for all modules that can be added via OrcAdd*, including object
##  files.
## 

proc OrcRemoveModule*(jITStack: OrcJITStackRef; h: OrcModuleHandle): OrcErrorCode {.llvmc.}
## *
##  Get symbol address from JIT instance.
## 

proc OrcGetSymbolAddress*(jITStack: OrcJITStackRef; retAddr: ptr OrcTargetAddress;
                         symbolName: cstring): OrcErrorCode {.llvmc.}
## *
##  Dispose of an ORC JIT stack.
## 

proc OrcDisposeInstance*(jITStack: OrcJITStackRef): OrcErrorCode {.llvmc.}