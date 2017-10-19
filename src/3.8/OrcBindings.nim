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
  OrcJITStackRef* = ptr orcOpaqueJITStack
  OrcModuleHandle* = uint32T
  OrcTargetAddress* = uint64T
  OrcSymbolResolverFn* = proc (name: cstring; lookupCtx: pointer): uint64T
  OrcLazyCompileCallbackFn* = proc (jITStack: OrcJITStackRef; callbackCtx: pointer): uint64T

## *
##  Create an ORC JIT stack.
## 
##  The client owns the resulting stack, and must call OrcDisposeInstance(...)
##  to destroy it and free its memory. The JIT stack will take ownership of the
##  TargetMachine, which will be destroyed when the stack is destroyed. The
##  client should not attempt to dispose of the Target Machine, or it will result
##  in a double-free.
## 

proc orcCreateInstance*(tm: TargetMachineRef): OrcJITStackRef {.
    importc: "LLVMOrcCreateInstance", dynlib: LLVMLib.}
## *
##  Mangle the given symbol.
##  Memory will be allocated for MangledSymbol to hold the result. The client
## 

proc orcGetMangledSymbol*(jITStack: OrcJITStackRef; mangledSymbol: cstringArray;
                         symbol: cstring) {.importc: "LLVMOrcGetMangledSymbol",
    dynlib: LLVMLib.}
## *
##  Dispose of a mangled symbol.
## 

proc orcDisposeMangledSymbol*(mangledSymbol: cstring) {.
    importc: "LLVMOrcDisposeMangledSymbol", dynlib: LLVMLib.}
## *
##  Create a lazy compile callback.
## 

proc orcCreateLazyCompileCallback*(jITStack: OrcJITStackRef;
                                  callback: OrcLazyCompileCallbackFn;
                                  callbackCtx: pointer): OrcTargetAddress {.
    importc: "LLVMOrcCreateLazyCompileCallback", dynlib: LLVMLib.}
## *
##  Create a named indirect call stub.
## 

proc orcCreateIndirectStub*(jITStack: OrcJITStackRef; stubName: cstring;
                           initAddr: OrcTargetAddress) {.
    importc: "LLVMOrcCreateIndirectStub", dynlib: LLVMLib.}
## *
##  Set the pointer for the given indirect stub.
## 

proc orcSetIndirectStubPointer*(jITStack: OrcJITStackRef; stubName: cstring;
                               newAddr: OrcTargetAddress) {.
    importc: "LLVMOrcSetIndirectStubPointer", dynlib: LLVMLib.}
## *
##  Add module to be eagerly compiled.
## 

proc orcAddEagerlyCompiledIR*(jITStack: OrcJITStackRef; `mod`: ModuleRef;
                             symbolResolver: OrcSymbolResolverFn;
                             symbolResolverCtx: pointer): OrcModuleHandle {.
    importc: "LLVMOrcAddEagerlyCompiledIR", dynlib: LLVMLib.}
## *
##  Add module to be lazily compiled one function at a time.
## 

proc orcAddLazilyCompiledIR*(jITStack: OrcJITStackRef; `mod`: ModuleRef;
                            symbolResolver: OrcSymbolResolverFn;
                            symbolResolverCtx: pointer): OrcModuleHandle {.
    importc: "LLVMOrcAddLazilyCompiledIR", dynlib: LLVMLib.}
## *
##  Add an object file.
## 

proc orcAddObjectFile*(jITStack: OrcJITStackRef; obj: ObjectFileRef;
                      symbolResolver: OrcSymbolResolverFn;
                      symbolResolverCtx: pointer): OrcModuleHandle {.
    importc: "LLVMOrcAddObjectFile", dynlib: LLVMLib.}
## *
##  Remove a module set from the JIT.
## 
##  This works for all modules that can be added via OrcAdd*, including object
##  files.
## 

proc orcRemoveModule*(jITStack: OrcJITStackRef; h: OrcModuleHandle) {.
    importc: "LLVMOrcRemoveModule", dynlib: LLVMLib.}
## *
##  Get symbol address from JIT instance.
## 

proc orcGetSymbolAddress*(jITStack: OrcJITStackRef; symbolName: cstring): OrcTargetAddress {.
    importc: "LLVMOrcGetSymbolAddress", dynlib: LLVMLib.}
## *
##  Dispose of an ORC JIT stack.
## 

proc orcDisposeInstance*(jITStack: OrcJITStackRef) {.
    importc: "LLVMOrcDisposeInstance", dynlib: LLVMLib.}