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
##  LLVM uses a polymorphic type hierarchy which C cannot represent, therefore
##  parameters must be passed as base types. Despite the declared types, most
##  of the functions provided operate only on branches of the type hierarchy.
##  The declared parameter names are descriptive and specify which type is
##  required. Additionally, each type hierarchy is documented along with the
##  functions that operate upon it. For more detail, refer to LLVM's C++ code.
##  If in doubt, refer to Core.cpp, which performs parameter downcasts in the
##  form unwrap<RequiredType>(Param).
## 
##  Many exotic languages can interoperate with C code but have a harder time
##  with C++ due to name mangling. So in addition to C, this interface enables
##  tools written in such languages.
## 
##  @{
## 
## *
##  @defgroup LLVMCCoreTypes Types and Enumerations
## 
##  @{
## 
##  Opaque types.
## *
##  The top-level container for all LLVM global data. See the LLVMContext class.
## 

type
  ContextRef* = ptr OpaqueContext

## *
##  The top-level container for all other LLVM Intermediate Representation (IR)
##  objects.
## 
##  @see llvm::Module
## 

type
  ModuleRef* = ptr OpaqueModule

## *
##  Each value in the LLVM IR has a type, an LLVMTypeRef.
## 
##  @see llvm::Type
## 

type
  TypeRef* = ptr OpaqueType

## *
##  Represents an individual value in LLVM IR.
## 
##  This models llvm::Value.
## 

type
  ValueRef* = ptr OpaqueValue

## *
##  Represents a basic block of instructions in LLVM IR.
## 
##  This models llvm::BasicBlock.
## 

type
  BasicBlockRef* = ptr OpaqueBasicBlock

## *
##  Represents an LLVM basic block builder.
## 
##  This models llvm::IRBuilder.
## 

type
  BuilderRef* = ptr OpaqueBuilder

## *
##  Interface used to provide a module to JIT or interpreter.
##  This is now just a synonym for llvm::Module, but we have to keep using the
##  different type to keep binary compatibility.
## 

type
  ModuleProviderRef* = ptr OpaqueModuleProvider

## * @see llvm::PassManagerBase

type
  PassManagerRef* = ptr OpaquePassManager

## * @see llvm::PassRegistry

type
  PassRegistryRef* = ptr OpaquePassRegistry

## *
##  Used to get the users and usees of a Value.
## 
##  @see llvm::Use

type
  UseRef* = ptr OpaqueUse

## *
##  @see llvm::DiagnosticInfo
## 

type                          ##  Terminator Instructions
  DiagnosticInfoRef* = ptr OpaqueDiagnosticInfo
  Attribute* {.size: sizeof(cint).} = enum
    ZExtAttribute = 1 shl 0, SExtAttribute = 1 shl 1, NoReturnAttribute = 1 shl 2,
    InRegAttribute = 1 shl 3, StructRetAttribute = 1 shl 4, NoUnwindAttribute = 1 shl 5,
    NoAliasAttribute = 1 shl 6, ByValAttribute = 1 shl 7, NestAttribute = 1 shl 8,
    ReadNoneAttribute = 1 shl 9, ReadOnlyAttribute = 1 shl 10,
    NoInlineAttribute = 1 shl 11, AlwaysInlineAttribute = 1 shl 12,
    OptimizeForSizeAttribute = 1 shl 13, StackProtectAttribute = 1 shl 14,
    StackProtectReqAttribute = 1 shl 15, Alignment = 31 shl 16,
    NoCaptureAttribute = 1 shl 21, NoRedZoneAttribute = 1 shl 22,
    NoImplicitFloatAttribute = 1 shl 23, NakedAttribute = 1 shl 24,
    InlineHintAttribute = 1 shl 25, StackAlignment = 7 shl 26, ReturnsTwice = 1 shl 29,
    UWTable = 1 shl 30, NonLazyBind = 1 shl 31
  Opcode* {.size: sizeof(cint).} = enum
    Ret = 1, Br = 2, Switch = 3, IndirectBr = 4, Invoke = 5, ##  removed 6 due to API changes
    Unreachable = 7,            ##  Standard Binary Operators
    Add = 8, FAdd = 9, Sub = 10, FSub = 11, Mul = 12, FMul = 13, UDiv = 14, SDiv = 15, FDiv = 16,
    URem = 17, SRem = 18, FRem = 19,  ##  Logical Operators
    Shl = 20, LShr = 21, AShr = 22, And = 23, Or = 24, Xor = 25, ##  Memory Operators
    Alloca = 26, Load = 27, Store = 28, GetElementPtr = 29, ##  Cast Operators
    Trunc = 30, ZExt = 31, SExt = 32, FPToUI = 33, FPToSI = 34, UIToFP = 35, SIToFP = 36,
    FPTrunc = 37, FPExt = 38, PtrToInt = 39, IntToPtr = 40, BitCast = 41, ICmp = 42, FCmp = 43,
    PHI = 44, Call = 45, Select = 46, UserOp1 = 47, UserOp2 = 48, VAArg = 49, ExtractElement = 50,
    InsertElement = 51, ShuffleVector = 52, ExtractValue = 53, InsertValue = 54, ##  Atomic operators
    Fence = 55, AtomicCmpXchg = 56, AtomicRMW = 57, ##  Exception Handling Operators
    Resume = 58, LandingPad = 59, AddrSpaceCast = 60 ##  Other Operators
  TypeKind* {.size: sizeof(cint).} = enum
    VoidTypeKind,             ## *< type with no size
    HalfTypeKind,             ## *< 16 bit floating point type
    FloatTypeKind,            ## *< 32 bit floating point type
    DoubleTypeKind,           ## *< 64 bit floating point type
    X86FP80TypeKind,          ## *< 80 bit floating point type (X87)
    FP128TypeKind,            ## *< 128 bit floating point type (112-bit mantissa)
    PPC_FP128TypeKind,        ## *< 128 bit floating point type (two 64-bits)
    LabelTypeKind,            ## *< Labels
    IntegerTypeKind,          ## *< Arbitrary bit width integers
    FunctionTypeKind,         ## *< Functions
    StructTypeKind,           ## *< Structures
    ArrayTypeKind,            ## *< Arrays
    PointerTypeKind,          ## *< Pointers
    VectorTypeKind,           ## *< SIMD 'packed' format, or other vector type
    MetadataTypeKind,         ## *< Metadata
    X86MMXTypeKind            ## *< X86 MMX
  Linkage* {.size: sizeof(cint).} = enum
    ExternalLinkage,          ## *< Externally visible function
    AvailableExternallyLinkage, LinkOnceAnyLinkage, ## *< Keep one copy of function when linking (inline)
    LinkOnceODRLinkage,       ## *< Same, but only replaced by something
                       ##                             equivalent.
    LinkOnceODRAutoHideLinkage, ## *< Obsolete
    WeakAnyLinkage,           ## *< Keep one copy of function when linking (weak)
    WeakODRLinkage,           ## *< Same, but only replaced by something
                   ##                             equivalent.
    AppendingLinkage,         ## *< Special purpose, only applies to global arrays
    InternalLinkage,          ## *< Rename collisions when linking (static
                    ##                                functions)
    PrivateLinkage,           ## *< Like Internal, but omit from symbol table
    DLLImportLinkage,         ## *< Obsolete
    DLLExportLinkage,         ## *< Obsolete
    ExternalWeakLinkage,      ## *< ExternalWeak linkage description
    GhostLinkage,             ## *< Obsolete
    CommonLinkage,            ## *< Tentative definitions
    LinkerPrivateLinkage,     ## *< Like Private, but linker removes.
    LinkerPrivateWeakLinkage  ## *< Like LinkerPrivate, but is weak.
  Visibility* {.size: sizeof(cint).} = enum
    DefaultVisibility,        ## *< The GV is visible
    HiddenVisibility,         ## *< The GV is hidden
    ProtectedVisibility       ## *< The GV is protected
  DLLStorageClass* {.size: sizeof(cint).} = enum
    DefaultStorageClass = 0, DLLImportStorageClass = 1, ## *< Function to be imported from DLL.
    DLLExportStorageClass = 2
  CallConv* {.size: sizeof(cint).} = enum
    CCallConv = 0, FastCallConv = 8, ColdCallConv = 9, WebKitJSCallConv = 12,
    AnyRegCallConv = 13, X86StdcallCallConv = 64, X86FastcallCallConv = 65
  IntPredicate* {.size: sizeof(cint).} = enum
    IntEQ = 32,                 ## *< equal
    IntNE,                    ## *< not equal
    IntUGT,                   ## *< unsigned greater than
    IntUGE,                   ## *< unsigned greater or equal
    IntULT,                   ## *< unsigned less than
    IntULE,                   ## *< unsigned less or equal
    IntSGT,                   ## *< signed greater than
    IntSGE,                   ## *< signed greater or equal
    IntSLT,                   ## *< signed less than
    IntSLE                    ## *< signed less or equal
  RealPredicate* {.size: sizeof(cint).} = enum
    RealPredicateFalse,       ## *< Always false (always folded)
    RealOEQ,                  ## *< True if ordered and equal
    RealOGT,                  ## *< True if ordered and greater than
    RealOGE,                  ## *< True if ordered and greater than or equal
    RealOLT,                  ## *< True if ordered and less than
    RealOLE,                  ## *< True if ordered and less than or equal
    RealONE,                  ## *< True if ordered and operands are unequal
    RealORD,                  ## *< True if ordered (no nans)
    RealUNO,                  ## *< True if unordered: isnan(X) | isnan(Y)
    RealUEQ,                  ## *< True if unordered or equal
    RealUGT,                  ## *< True if unordered or greater than
    RealUGE,                  ## *< True if unordered, greater than, or equal
    RealULT,                  ## *< True if unordered or less than
    RealULE,                  ## *< True if unordered, less than, or equal
    RealUNE,                  ## *< True if unordered or not equal
    RealPredicateTrue         ## *< Always true (always folded)
  LandingPadClauseTy* {.size: sizeof(cint).} = enum
    LandingPadCatch,          ## *< A catch clause
    LandingPadFilter          ## *< A filter clause
  ThreadLocalMode* {.size: sizeof(cint).} = enum
    NotThreadLocal = 0, GeneralDynamicTLSModel, LocalDynamicTLSModel,
    InitialExecTLSModel, LocalExecTLSModel
  AtomicOrdering* {.size: sizeof(cint).} = enum
    AtomicOrderingNotAtomic = 0, ## *< A load or store which is not atomic
    AtomicOrderingUnordered = 1, ## *< Lowest level of atomicity, guarantees
                              ##                                      somewhat sane results, lock free.
    AtomicOrderingMonotonic = 2, ## *< guarantees that if you take all the
                              ##                                      operations affecting a specific address,
                              ##                                      a consistent ordering exists
    AtomicOrderingAcquire = 4, ## *< Acquire provides a barrier of the sort
                            ##                                    necessary to acquire a lock to access other
                            ##                                    memory with normal loads and stores.
    AtomicOrderingRelease = 5, ## *< Release is similar to Acquire, but with
                            ##                                    a barrier of the sort necessary to release
                            ##                                    a lock.
    AtomicOrderingAcquireRelease = 6, ## *< provides both an Acquire and a
                                   ##                                           Release barrier (for fences and
                                   ##                                           operations which both read and write
                                   ##                                            memory).
    AtomicOrderingSequentiallyConsistent = 7
  AtomicRMWBinOp* {.size: sizeof(cint).} = enum
    AtomicRMWBinOpXchg,       ## *< Set the new value and return the one old
    AtomicRMWBinOpAdd,        ## *< Add a value and return the old one
    AtomicRMWBinOpSub,        ## *< Subtract a value and return the old one
    AtomicRMWBinOpAnd,        ## *< And a value and return the old one
    AtomicRMWBinOpNand,       ## *< Not-And a value and return the old one
    AtomicRMWBinOpOr,         ## *< OR a value and return the old one
    AtomicRMWBinOpXor,        ## *< Xor a value and return the old one
    AtomicRMWBinOpMax, ## *< Sets the value if it's greater than the
                      ##                              original using a signed comparison and return
                      ##                              the old one
    AtomicRMWBinOpMin, ## *< Sets the value if it's Smaller than the
                      ##                              original using a signed comparison and return
                      ##                              the old one
    AtomicRMWBinOpUMax, ## *< Sets the value if it's greater than the
                       ##                              original using an unsigned comparison and return
                       ##                              the old one
    AtomicRMWBinOpUMin ## *< Sets the value if it's greater than the
                      ##                              original using an unsigned comparison  and return
                      ##                              the old one
  DiagnosticSeverity* {.size: sizeof(cint).} = enum
    DSError, DSWarning, DSRemark, DSNote















## *
##  @}
## 

proc initializeCore*(r: PassRegistryRef) {.importc: "LLVMInitializeCore",
                                        dynlib: LLVMLib.}
## * Deallocate and destroy all ManagedStatic variables.
##     @see llvm::llvm_shutdown
##     @see ManagedStatic

proc shutdown*() {.importc: "LLVMShutdown", dynlib: LLVMLib.}
## ===-- Error handling ----------------------------------------------------===

proc createMessage*(message: cstring): cstring {.importc: "LLVMCreateMessage",
    dynlib: LLVMLib.}
proc disposeMessage*(message: cstring) {.importc: "LLVMDisposeMessage",
                                      dynlib: LLVMLib.}
type
  FatalErrorHandler* = proc (reason: cstring)

## *
##  Install a fatal error handler. By default, if LLVM detects a fatal error, it
##  will call exit(1). This may not be appropriate in many contexts. For example,
##  doing exit(1) will bypass many crash reporting/tracing system tools. This
##  function allows you to install a callback that will be invoked prior to the
##  call to exit(1).
## 

proc installFatalErrorHandler*(handler: FatalErrorHandler) {.
    importc: "LLVMInstallFatalErrorHandler", dynlib: LLVMLib.}
## *
##  Reset the fatal error handler. This resets LLVM's fatal error handling
##  behavior to the default.
## 

proc resetFatalErrorHandler*() {.importc: "LLVMResetFatalErrorHandler",
                               dynlib: LLVMLib.}
## *
##  Enable LLVM's built-in stack trace code. This intercepts the OS's crash
##  signals and prints which component of LLVM you were in at the time if the
##  crash.
## 

proc enablePrettyStackTrace*() {.importc: "LLVMEnablePrettyStackTrace",
                               dynlib: LLVMLib.}
## *
##  @defgroup LLVMCCoreContext Contexts
## 
##  Contexts are execution states for the core LLVM IR system.
## 
##  Most types are tied to a context instance. Multiple contexts can
##  exist simultaneously. A single context is not thread safe. However,
##  different contexts can execute on different threads simultaneously.
## 
##  @{
## 

type
  DiagnosticHandler* = proc (a2: DiagnosticInfoRef; a3: pointer)
  YieldCallback* = proc (a2: ContextRef; a3: pointer)

## *
##  Create a new context.
## 
##  Every call to this function should be paired with a call to
##  LLVMContextDispose() or the context will leak memory.
## 

proc contextCreate*(): ContextRef {.importc: "LLVMContextCreate", dynlib: LLVMLib.}
## *
##  Obtain the global context instance.
## 

proc getGlobalContext*(): ContextRef {.importc: "LLVMGetGlobalContext",
                                    dynlib: LLVMLib.}
## *
##  Set the diagnostic handler for this context.
## 

proc contextSetDiagnosticHandler*(c: ContextRef; handler: DiagnosticHandler;
                                 diagnosticContext: pointer) {.
    importc: "LLVMContextSetDiagnosticHandler", dynlib: LLVMLib.}
## *
##  Set the yield callback function for this context.
## 
##  @see LLVMContext::setYieldCallback()
## 

proc contextSetYieldCallback*(c: ContextRef; callback: YieldCallback;
                             opaqueHandle: pointer) {.
    importc: "LLVMContextSetYieldCallback", dynlib: LLVMLib.}
## *
##  Destroy a context instance.
## 
##  This should be called for every call to LLVMContextCreate() or memory
##  will be leaked.
## 

proc contextDispose*(c: ContextRef) {.importc: "LLVMContextDispose", dynlib: LLVMLib.}
## *
##  Return a string representation of the DiagnosticInfo. Use
##  LLVMDisposeMessage to free the string.
## 
##  @see DiagnosticInfo::print()
## 

proc getDiagInfoDescription*(di: DiagnosticInfoRef): cstring {.
    importc: "LLVMGetDiagInfoDescription", dynlib: LLVMLib.}
## *
##  Return an enum LLVMDiagnosticSeverity.
## 
##  @see DiagnosticInfo::getSeverity()
## 

proc getDiagInfoSeverity*(di: DiagnosticInfoRef): DiagnosticSeverity {.
    importc: "LLVMGetDiagInfoSeverity", dynlib: LLVMLib.}
proc getMDKindIDInContext*(c: ContextRef; name: cstring; sLen: cuint): cuint {.
    importc: "LLVMGetMDKindIDInContext", dynlib: LLVMLib.}
proc getMDKindID*(name: cstring; sLen: cuint): cuint {.importc: "LLVMGetMDKindID",
    dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @defgroup LLVMCCoreModule Modules
## 
##  Modules represent the top-level structure in an LLVM program. An LLVM
##  module is effectively a translation unit or a collection of
##  translation units merged together.
## 
##  @{
## 
## *
##  Create a new, empty module in the global context.
## 
##  This is equivalent to calling LLVMModuleCreateWithNameInContext with
##  LLVMGetGlobalContext() as the context parameter.
## 
##  Every invocation should be paired with LLVMDisposeModule() or memory
##  will be leaked.
## 

proc moduleCreateWithName*(moduleID: cstring): ModuleRef {.
    importc: "LLVMModuleCreateWithName", dynlib: LLVMLib.}
## *
##  Create a new, empty module in a specific context.
## 
##  Every invocation should be paired with LLVMDisposeModule() or memory
##  will be leaked.
## 

proc moduleCreateWithNameInContext*(moduleID: cstring; c: ContextRef): ModuleRef {.
    importc: "LLVMModuleCreateWithNameInContext", dynlib: LLVMLib.}
## *
##  Return an exact copy of the specified module.
## 

proc cloneModule*(m: ModuleRef): ModuleRef {.importc: "LLVMCloneModule",
    dynlib: LLVMLib.}
## *
##  Destroy a module instance.
## 
##  This must be called for every created module or memory will be
##  leaked.
## 

proc disposeModule*(m: ModuleRef) {.importc: "LLVMDisposeModule", dynlib: LLVMLib.}
## *
##  Obtain the data layout for a module.
## 
##  @see Module::getDataLayout()
## 

proc getDataLayout*(m: ModuleRef): cstring {.importc: "LLVMGetDataLayout",
    dynlib: LLVMLib.}
## *
##  Set the data layout for a module.
## 
##  @see Module::setDataLayout()
## 

proc setDataLayout*(m: ModuleRef; triple: cstring) {.importc: "LLVMSetDataLayout",
    dynlib: LLVMLib.}
## *
##  Obtain the target triple for a module.
## 
##  @see Module::getTargetTriple()
## 

proc getTarget*(m: ModuleRef): cstring {.importc: "LLVMGetTarget", dynlib: LLVMLib.}
## *
##  Set the target triple for a module.
## 
##  @see Module::setTargetTriple()
## 

proc setTarget*(m: ModuleRef; triple: cstring) {.importc: "LLVMSetTarget",
    dynlib: LLVMLib.}
## *
##  Dump a representation of a module to stderr.
## 
##  @see Module::dump()
## 

proc dumpModule*(m: ModuleRef) {.importc: "LLVMDumpModule", dynlib: LLVMLib.}
## *
##  Print a representation of a module to a file. The ErrorMessage needs to be
##  disposed with LLVMDisposeMessage. Returns 0 on success, 1 otherwise.
## 
##  @see Module::print()
## 

proc printModuleToFile*(m: ModuleRef; filename: cstring; errorMessage: cstringArray): Bool {.
    importc: "LLVMPrintModuleToFile", dynlib: LLVMLib.}
## *
##  Return a string representation of the module. Use
##  LLVMDisposeMessage to free the string.
## 
##  @see Module::print()
## 

proc printModuleToString*(m: ModuleRef): cstring {.
    importc: "LLVMPrintModuleToString", dynlib: LLVMLib.}
## *
##  Set inline assembly for a module.
## 
##  @see Module::setModuleInlineAsm()
## 

proc setModuleInlineAsm*(m: ModuleRef; `asm`: cstring) {.
    importc: "LLVMSetModuleInlineAsm", dynlib: LLVMLib.}
## *
##  Obtain the context to which this module is associated.
## 
##  @see Module::getContext()
## 

proc getModuleContext*(m: ModuleRef): ContextRef {.importc: "LLVMGetModuleContext",
    dynlib: LLVMLib.}
## *
##  Obtain a Type from a module by its registered name.
## 

proc getTypeByName*(m: ModuleRef; name: cstring): TypeRef {.
    importc: "LLVMGetTypeByName", dynlib: LLVMLib.}
## *
##  Obtain the number of operands for named metadata in a module.
## 
##  @see llvm::Module::getNamedMetadata()
## 

proc getNamedMetadataNumOperands*(m: ModuleRef; name: cstring): cuint {.
    importc: "LLVMGetNamedMetadataNumOperands", dynlib: LLVMLib.}
## *
##  Obtain the named metadata operands for a module.
## 
##  The passed LLVMValueRef pointer should refer to an array of
##  LLVMValueRef at least LLVMGetNamedMetadataNumOperands long. This
##  array will be populated with the LLVMValueRef instances. Each
##  instance corresponds to a llvm::MDNode.
## 
##  @see llvm::Module::getNamedMetadata()
##  @see llvm::MDNode::getOperand()
## 

proc getNamedMetadataOperands*(m: ModuleRef; name: cstring; dest: ptr ValueRef) {.
    importc: "LLVMGetNamedMetadataOperands", dynlib: LLVMLib.}
## *
##  Add an operand to named metadata.
## 
##  @see llvm::Module::getNamedMetadata()
##  @see llvm::MDNode::addOperand()
## 

proc addNamedMetadataOperand*(m: ModuleRef; name: cstring; val: ValueRef) {.
    importc: "LLVMAddNamedMetadataOperand", dynlib: LLVMLib.}
## *
##  Add a function to a module under a specified name.
## 
##  @see llvm::Function::Create()
## 

proc addFunction*(m: ModuleRef; name: cstring; functionTy: TypeRef): ValueRef {.
    importc: "LLVMAddFunction", dynlib: LLVMLib.}
## *
##  Obtain a Function value from a Module by its name.
## 
##  The returned value corresponds to a llvm::Function value.
## 
##  @see llvm::Module::getFunction()
## 

proc getNamedFunction*(m: ModuleRef; name: cstring): ValueRef {.
    importc: "LLVMGetNamedFunction", dynlib: LLVMLib.}
## *
##  Obtain an iterator to the first Function in a Module.
## 
##  @see llvm::Module::begin()
## 

proc getFirstFunction*(m: ModuleRef): ValueRef {.importc: "LLVMGetFirstFunction",
    dynlib: LLVMLib.}
## *
##  Obtain an iterator to the last Function in a Module.
## 
##  @see llvm::Module::end()
## 

proc getLastFunction*(m: ModuleRef): ValueRef {.importc: "LLVMGetLastFunction",
    dynlib: LLVMLib.}
## *
##  Advance a Function iterator to the next Function.
## 
##  Returns NULL if the iterator was already at the end and there are no more
##  functions.
## 

proc getNextFunction*(fn: ValueRef): ValueRef {.importc: "LLVMGetNextFunction",
    dynlib: LLVMLib.}
## *
##  Decrement a Function iterator to the previous Function.
## 
##  Returns NULL if the iterator was already at the beginning and there are
##  no previous functions.
## 

proc getPreviousFunction*(fn: ValueRef): ValueRef {.
    importc: "LLVMGetPreviousFunction", dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @defgroup LLVMCCoreType Types
## 
##  Types represent the type of a value.
## 
##  Types are associated with a context instance. The context internally
##  deduplicates types so there is only 1 instance of a specific type
##  alive at a time. In other words, a unique type is shared among all
##  consumers within a context.
## 
##  A Type in the C API corresponds to llvm::Type.
## 
##  Types have the following hierarchy:
## 
##    types:
##      integer type
##      real type
##      function type
##      sequence types:
##        array type
##        pointer type
##        vector type
##      void type
##      label type
##      opaque type
## 
##  @{
## 
## *
##  Obtain the enumerated type of a Type instance.
## 
##  @see llvm::Type:getTypeID()
## 

proc getTypeKind*(ty: TypeRef): TypeKind {.importc: "LLVMGetTypeKind", dynlib: LLVMLib.}
## *
##  Whether the type has a known size.
## 
##  Things that don't have a size are abstract types, labels, and void.a
## 
##  @see llvm::Type::isSized()
## 

proc typeIsSized*(ty: TypeRef): Bool {.importc: "LLVMTypeIsSized", dynlib: LLVMLib.}
## *
##  Obtain the context to which this type instance is associated.
## 
##  @see llvm::Type::getContext()
## 

proc getTypeContext*(ty: TypeRef): ContextRef {.importc: "LLVMGetTypeContext",
    dynlib: LLVMLib.}
## *
##  Dump a representation of a type to stderr.
## 
##  @see llvm::Type::dump()
## 

proc dumpType*(val: TypeRef) {.importc: "LLVMDumpType", dynlib: LLVMLib.}
## *
##  Return a string representation of the type. Use
##  LLVMDisposeMessage to free the string.
## 
##  @see llvm::Type::print()
## 

proc printTypeToString*(val: TypeRef): cstring {.importc: "LLVMPrintTypeToString",
    dynlib: LLVMLib.}
## *
##  @defgroup LLVMCCoreTypeInt Integer Types
## 
##  Functions in this section operate on integer types.
## 
##  @{
## 
## *
##  Obtain an integer type from a context with specified bit width.
## 

proc int1TypeInContext*(c: ContextRef): TypeRef {.importc: "LLVMInt1TypeInContext",
    dynlib: LLVMLib.}
proc int8TypeInContext*(c: ContextRef): TypeRef {.importc: "LLVMInt8TypeInContext",
    dynlib: LLVMLib.}
proc int16TypeInContext*(c: ContextRef): TypeRef {.
    importc: "LLVMInt16TypeInContext", dynlib: LLVMLib.}
proc int32TypeInContext*(c: ContextRef): TypeRef {.
    importc: "LLVMInt32TypeInContext", dynlib: LLVMLib.}
proc int64TypeInContext*(c: ContextRef): TypeRef {.
    importc: "LLVMInt64TypeInContext", dynlib: LLVMLib.}
proc intTypeInContext*(c: ContextRef; numBits: cuint): TypeRef {.
    importc: "LLVMIntTypeInContext", dynlib: LLVMLib.}
## *
##  Obtain an integer type from the global context with a specified bit
##  width.
## 

proc int1Type*(): TypeRef {.importc: "LLVMInt1Type", dynlib: LLVMLib.}
proc int8Type*(): TypeRef {.importc: "LLVMInt8Type", dynlib: LLVMLib.}
proc int16Type*(): TypeRef {.importc: "LLVMInt16Type", dynlib: LLVMLib.}
proc int32Type*(): TypeRef {.importc: "LLVMInt32Type", dynlib: LLVMLib.}
proc int64Type*(): TypeRef {.importc: "LLVMInt64Type", dynlib: LLVMLib.}
proc intType*(numBits: cuint): TypeRef {.importc: "LLVMIntType", dynlib: LLVMLib.}
proc getIntTypeWidth*(integerTy: TypeRef): cuint {.importc: "LLVMGetIntTypeWidth",
    dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @defgroup LLVMCCoreTypeFloat Floating Point Types
## 
##  @{
## 
## *
##  Obtain a 16-bit floating point type from a context.
## 

proc halfTypeInContext*(c: ContextRef): TypeRef {.importc: "LLVMHalfTypeInContext",
    dynlib: LLVMLib.}
## *
##  Obtain a 32-bit floating point type from a context.
## 

proc floatTypeInContext*(c: ContextRef): TypeRef {.
    importc: "LLVMFloatTypeInContext", dynlib: LLVMLib.}
## *
##  Obtain a 64-bit floating point type from a context.
## 

proc doubleTypeInContext*(c: ContextRef): TypeRef {.
    importc: "LLVMDoubleTypeInContext", dynlib: LLVMLib.}
## *
##  Obtain a 80-bit floating point type (X87) from a context.
## 

proc x86FP80TypeInContext*(c: ContextRef): TypeRef {.
    importc: "LLVMX86FP80TypeInContext", dynlib: LLVMLib.}
## *
##  Obtain a 128-bit floating point type (112-bit mantissa) from a
##  context.
## 

proc fP128TypeInContext*(c: ContextRef): TypeRef {.
    importc: "LLVMFP128TypeInContext", dynlib: LLVMLib.}
## *
##  Obtain a 128-bit floating point type (two 64-bits) from a context.
## 

proc pPCFP128TypeInContext*(c: ContextRef): TypeRef {.
    importc: "LLVMPPCFP128TypeInContext", dynlib: LLVMLib.}
## *
##  Obtain a floating point type from the global context.
## 
##  These map to the functions in this group of the same name.
## 

proc halfType*(): TypeRef {.importc: "LLVMHalfType", dynlib: LLVMLib.}
proc floatType*(): TypeRef {.importc: "LLVMFloatType", dynlib: LLVMLib.}
proc doubleType*(): TypeRef {.importc: "LLVMDoubleType", dynlib: LLVMLib.}
proc x86FP80Type*(): TypeRef {.importc: "LLVMX86FP80Type", dynlib: LLVMLib.}
proc fP128Type*(): TypeRef {.importc: "LLVMFP128Type", dynlib: LLVMLib.}
proc pPCFP128Type*(): TypeRef {.importc: "LLVMPPCFP128Type", dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @defgroup LLVMCCoreTypeFunction Function Types
## 
##  @{
## 
## *
##  Obtain a function type consisting of a specified signature.
## 
##  The function is defined as a tuple of a return Type, a list of
##  parameter types, and whether the function is variadic.
## 

proc functionType*(returnType: TypeRef; paramTypes: ptr TypeRef; paramCount: cuint;
                  isVarArg: Bool): TypeRef {.importc: "LLVMFunctionType",
    dynlib: LLVMLib.}
## *
##  Returns whether a function type is variadic.
## 

proc isFunctionVarArg*(functionTy: TypeRef): Bool {.importc: "LLVMIsFunctionVarArg",
    dynlib: LLVMLib.}
## *
##  Obtain the Type this function Type returns.
## 

proc getReturnType*(functionTy: TypeRef): TypeRef {.importc: "LLVMGetReturnType",
    dynlib: LLVMLib.}
## *
##  Obtain the number of parameters this function accepts.
## 

proc countParamTypes*(functionTy: TypeRef): cuint {.importc: "LLVMCountParamTypes",
    dynlib: LLVMLib.}
## *
##  Obtain the types of a function's parameters.
## 
##  The Dest parameter should point to a pre-allocated array of
##  LLVMTypeRef at least LLVMCountParamTypes() large. On return, the
##  first LLVMCountParamTypes() entries in the array will be populated
##  with LLVMTypeRef instances.
## 
##  @param FunctionTy The function type to operate on.
##  @param Dest Memory address of an array to be filled with result.
## 

proc getParamTypes*(functionTy: TypeRef; dest: ptr TypeRef) {.
    importc: "LLVMGetParamTypes", dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @defgroup LLVMCCoreTypeStruct Structure Types
## 
##  These functions relate to LLVMTypeRef instances.
## 
##  @see llvm::StructType
## 
##  @{
## 
## *
##  Create a new structure type in a context.
## 
##  A structure is specified by a list of inner elements/types and
##  whether these can be packed together.
## 
##  @see llvm::StructType::create()
## 

proc structTypeInContext*(c: ContextRef; elementTypes: ptr TypeRef;
                         elementCount: cuint; packed: Bool): TypeRef {.
    importc: "LLVMStructTypeInContext", dynlib: LLVMLib.}
## *
##  Create a new structure type in the global context.
## 
##  @see llvm::StructType::create()
## 

proc structType*(elementTypes: ptr TypeRef; elementCount: cuint; packed: Bool): TypeRef {.
    importc: "LLVMStructType", dynlib: LLVMLib.}
## *
##  Create an empty structure in a context having a specified name.
## 
##  @see llvm::StructType::create()
## 

proc structCreateNamed*(c: ContextRef; name: cstring): TypeRef {.
    importc: "LLVMStructCreateNamed", dynlib: LLVMLib.}
## *
##  Obtain the name of a structure.
## 
##  @see llvm::StructType::getName()
## 

proc getStructName*(ty: TypeRef): cstring {.importc: "LLVMGetStructName",
                                        dynlib: LLVMLib.}
## *
##  Set the contents of a structure type.
## 
##  @see llvm::StructType::setBody()
## 

proc structSetBody*(structTy: TypeRef; elementTypes: ptr TypeRef; elementCount: cuint;
                   packed: Bool) {.importc: "LLVMStructSetBody", dynlib: LLVMLib.}
## *
##  Get the number of elements defined inside the structure.
## 
##  @see llvm::StructType::getNumElements()
## 

proc countStructElementTypes*(structTy: TypeRef): cuint {.
    importc: "LLVMCountStructElementTypes", dynlib: LLVMLib.}
## *
##  Get the elements within a structure.
## 
##  The function is passed the address of a pre-allocated array of
##  LLVMTypeRef at least LLVMCountStructElementTypes() long. After
##  invocation, this array will be populated with the structure's
##  elements. The objects in the destination array will have a lifetime
##  of the structure type itself, which is the lifetime of the context it
##  is contained in.
## 

proc getStructElementTypes*(structTy: TypeRef; dest: ptr TypeRef) {.
    importc: "LLVMGetStructElementTypes", dynlib: LLVMLib.}
## *
##  Get the type of the element at a given index in the structure.
## 
##  @see llvm::StructType::getTypeAtIndex()
## 

proc structGetTypeAtIndex*(structTy: TypeRef; i: cuint): TypeRef {.
    importc: "LLVMStructGetTypeAtIndex", dynlib: LLVMLib.}
## *
##  Determine whether a structure is packed.
## 
##  @see llvm::StructType::isPacked()
## 

proc isPackedStruct*(structTy: TypeRef): Bool {.importc: "LLVMIsPackedStruct",
    dynlib: LLVMLib.}
## *
##  Determine whether a structure is opaque.
## 
##  @see llvm::StructType::isOpaque()
## 

proc isOpaqueStruct*(structTy: TypeRef): Bool {.importc: "LLVMIsOpaqueStruct",
    dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @defgroup LLVMCCoreTypeSequential Sequential Types
## 
##  Sequential types represents "arrays" of types. This is a super class
##  for array, vector, and pointer types.
## 
##  @{
## 
## *
##  Obtain the type of elements within a sequential type.
## 
##  This works on array, vector, and pointer types.
## 
##  @see llvm::SequentialType::getElementType()
## 

proc getElementType*(ty: TypeRef): TypeRef {.importc: "LLVMGetElementType",
    dynlib: LLVMLib.}
## *
##  Create a fixed size array type that refers to a specific type.
## 
##  The created type will exist in the context that its element type
##  exists in.
## 
##  @see llvm::ArrayType::get()
## 

proc arrayType*(elementType: TypeRef; elementCount: cuint): TypeRef {.
    importc: "LLVMArrayType", dynlib: LLVMLib.}
## *
##  Obtain the length of an array type.
## 
##  This only works on types that represent arrays.
## 
##  @see llvm::ArrayType::getNumElements()
## 

proc getArrayLength*(arrayTy: TypeRef): cuint {.importc: "LLVMGetArrayLength",
    dynlib: LLVMLib.}
## *
##  Create a pointer type that points to a defined type.
## 
##  The created type will exist in the context that its pointee type
##  exists in.
## 
##  @see llvm::PointerType::get()
## 

proc pointerType*(elementType: TypeRef; addressSpace: cuint): TypeRef {.
    importc: "LLVMPointerType", dynlib: LLVMLib.}
## *
##  Obtain the address space of a pointer type.
## 
##  This only works on types that represent pointers.
## 
##  @see llvm::PointerType::getAddressSpace()
## 

proc getPointerAddressSpace*(pointerTy: TypeRef): cuint {.
    importc: "LLVMGetPointerAddressSpace", dynlib: LLVMLib.}
## *
##  Create a vector type that contains a defined type and has a specific
##  number of elements.
## 
##  The created type will exist in the context thats its element type
##  exists in.
## 
##  @see llvm::VectorType::get()
## 

proc vectorType*(elementType: TypeRef; elementCount: cuint): TypeRef {.
    importc: "LLVMVectorType", dynlib: LLVMLib.}
## *
##  Obtain the number of elements in a vector type.
## 
##  This only works on types that represent vectors.
## 
##  @see llvm::VectorType::getNumElements()
## 

proc getVectorSize*(vectorTy: TypeRef): cuint {.importc: "LLVMGetVectorSize",
    dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @defgroup LLVMCCoreTypeOther Other Types
## 
##  @{
## 
## *
##  Create a void type in a context.
## 

proc voidTypeInContext*(c: ContextRef): TypeRef {.importc: "LLVMVoidTypeInContext",
    dynlib: LLVMLib.}
## *
##  Create a label type in a context.
## 

proc labelTypeInContext*(c: ContextRef): TypeRef {.
    importc: "LLVMLabelTypeInContext", dynlib: LLVMLib.}
## *
##  Create a X86 MMX type in a context.
## 

proc x86MMXTypeInContext*(c: ContextRef): TypeRef {.
    importc: "LLVMX86MMXTypeInContext", dynlib: LLVMLib.}
## *
##  These are similar to the above functions except they operate on the
##  global context.
## 

proc voidType*(): TypeRef {.importc: "LLVMVoidType", dynlib: LLVMLib.}
proc labelType*(): TypeRef {.importc: "LLVMLabelType", dynlib: LLVMLib.}
proc x86MMXType*(): TypeRef {.importc: "LLVMX86MMXType", dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @}
## 
## *
##  @defgroup LLVMCCoreValues Values
## 
##  The bulk of LLVM's object model consists of values, which comprise a very
##  rich type hierarchy.
## 
##  LLVMValueRef essentially represents llvm::Value. There is a rich
##  hierarchy of classes within this type. Depending on the instance
##  obtained, not all APIs are available.
## 
##  Callers can determine the type of an LLVMValueRef by calling the
##  LLVMIsA* family of functions (e.g. LLVMIsAArgument()). These
##  functions are defined by a macro, so it isn't obvious which are
##  available by looking at the Doxygen source code. Instead, look at the
##  source definition of LLVM_FOR_EACH_VALUE_SUBCLASS and note the list
##  of value names given. These value names also correspond to classes in
##  the llvm::Value hierarchy.
## 
##  @{
## 

## *
##  @defgroup LLVMCCoreValueGeneral General APIs
## 
##  Functions in this section work on all LLVMValueRef instances,
##  regardless of their sub-type. They correspond to functions available
##  on llvm::Value.
## 
##  @{
## 
## *
##  Obtain the type of a value.
## 
##  @see llvm::Value::getType()
## 

proc typeOf*(val: ValueRef): TypeRef {.importc: "LLVMTypeOf", dynlib: LLVMLib.}
## *
##  Obtain the string name of a value.
## 
##  @see llvm::Value::getName()
## 

proc getValueName*(val: ValueRef): cstring {.importc: "LLVMGetValueName",
    dynlib: LLVMLib.}
## *
##  Set the string name of a value.
## 
##  @see llvm::Value::setName()
## 

proc setValueName*(val: ValueRef; name: cstring) {.importc: "LLVMSetValueName",
    dynlib: LLVMLib.}
## *
##  Dump a representation of a value to stderr.
## 
##  @see llvm::Value::dump()
## 

proc dumpValue*(val: ValueRef) {.importc: "LLVMDumpValue", dynlib: LLVMLib.}
## *
##  Return a string representation of the value. Use
##  LLVMDisposeMessage to free the string.
## 
##  @see llvm::Value::print()
## 

proc printValueToString*(val: ValueRef): cstring {.
    importc: "LLVMPrintValueToString", dynlib: LLVMLib.}
## *
##  Replace all uses of a value with another one.
## 
##  @see llvm::Value::replaceAllUsesWith()
## 

proc replaceAllUsesWith*(oldVal: ValueRef; newVal: ValueRef) {.
    importc: "LLVMReplaceAllUsesWith", dynlib: LLVMLib.}
## *
##  Determine whether the specified constant instance is constant.
## 

proc isConstant*(val: ValueRef): Bool {.importc: "LLVMIsConstant", dynlib: LLVMLib.}
## *
##  Determine whether a value instance is undefined.
## 

proc isUndef*(val: ValueRef): Bool {.importc: "LLVMIsUndef", dynlib: LLVMLib.}
## *
##  Convert value instances between types.
## 
##  Internally, an LLVMValueRef is "pinned" to a specific type. This
##  series of functions allows you to cast an instance to a specific
##  type.
## 
##  If the cast is not valid for the specified type, NULL is returned.
## 
##  @see llvm::dyn_cast_or_null<>
## 

proc isAMDNode*(val: ValueRef): ValueRef {.importc: "LLVMIsAMDNode", dynlib: LLVMLib.}
proc isAMDString*(val: ValueRef): ValueRef {.importc: "LLVMIsAMDString",
    dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @defgroup LLVMCCoreValueUses Usage
## 
##  This module defines functions that allow you to inspect the uses of a
##  LLVMValueRef.
## 
##  It is possible to obtain an LLVMUseRef for any LLVMValueRef instance.
##  Each LLVMUseRef (which corresponds to a llvm::Use instance) holds a
##  llvm::User and llvm::Value.
## 
##  @{
## 
## *
##  Obtain the first use of a value.
## 
##  Uses are obtained in an iterator fashion. First, call this function
##  to obtain a reference to the first use. Then, call LLVMGetNextUse()
##  on that instance and all subsequently obtained instances until
##  LLVMGetNextUse() returns NULL.
## 
##  @see llvm::Value::use_begin()
## 

proc getFirstUse*(val: ValueRef): UseRef {.importc: "LLVMGetFirstUse", dynlib: LLVMLib.}
## *
##  Obtain the next use of a value.
## 
##  This effectively advances the iterator. It returns NULL if you are on
##  the final use and no more are available.
## 

proc getNextUse*(u: UseRef): UseRef {.importc: "LLVMGetNextUse", dynlib: LLVMLib.}
## *
##  Obtain the user value for a user.
## 
##  The returned value corresponds to a llvm::User type.
## 
##  @see llvm::Use::getUser()
## 

proc getUser*(u: UseRef): ValueRef {.importc: "LLVMGetUser", dynlib: LLVMLib.}
## *
##  Obtain the value this use corresponds to.
## 
##  @see llvm::Use::get().
## 

proc getUsedValue*(u: UseRef): ValueRef {.importc: "LLVMGetUsedValue", dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @defgroup LLVMCCoreValueUser User value
## 
##  Function in this group pertain to LLVMValueRef instances that descent
##  from llvm::User. This includes constants, instructions, and
##  operators.
## 
##  @{
## 
## *
##  Obtain an operand at a specific index in a llvm::User value.
## 
##  @see llvm::User::getOperand()
## 

proc getOperand*(val: ValueRef; index: cuint): ValueRef {.importc: "LLVMGetOperand",
    dynlib: LLVMLib.}
## *
##  Obtain the use of an operand at a specific index in a llvm::User value.
## 
##  @see llvm::User::getOperandUse()
## 

proc getOperandUse*(val: ValueRef; index: cuint): UseRef {.
    importc: "LLVMGetOperandUse", dynlib: LLVMLib.}
## *
##  Set an operand at a specific index in a llvm::User value.
## 
##  @see llvm::User::setOperand()
## 

proc setOperand*(user: ValueRef; index: cuint; val: ValueRef) {.
    importc: "LLVMSetOperand", dynlib: LLVMLib.}
## *
##  Obtain the number of operands in a llvm::User value.
## 
##  @see llvm::User::getNumOperands()
## 

proc getNumOperands*(val: ValueRef): cint {.importc: "LLVMGetNumOperands",
                                        dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @defgroup LLVMCCoreValueConstant Constants
## 
##  This section contains APIs for interacting with LLVMValueRef that
##  correspond to llvm::Constant instances.
## 
##  These functions will work for any LLVMValueRef in the llvm::Constant
##  class hierarchy.
## 
##  @{
## 
## *
##  Obtain a constant value referring to the null instance of a type.
## 
##  @see llvm::Constant::getNullValue()
## 

proc constNull*(ty: TypeRef): ValueRef {.importc: "LLVMConstNull", dynlib: LLVMLib.}
##  all zeroes
## *
##  Obtain a constant value referring to the instance of a type
##  consisting of all ones.
## 
##  This is only valid for integer types.
## 
##  @see llvm::Constant::getAllOnesValue()
## 

proc constAllOnes*(ty: TypeRef): ValueRef {.importc: "LLVMConstAllOnes",
                                        dynlib: LLVMLib.}
## *
##  Obtain a constant value referring to an undefined value of a type.
## 
##  @see llvm::UndefValue::get()
## 

proc getUndef*(ty: TypeRef): ValueRef {.importc: "LLVMGetUndef", dynlib: LLVMLib.}
## *
##  Determine whether a value instance is null.
## 
##  @see llvm::Constant::isNullValue()
## 

proc isNull*(val: ValueRef): Bool {.importc: "LLVMIsNull", dynlib: LLVMLib.}
## *
##  Obtain a constant that is a constant pointer pointing to NULL for a
##  specified type.
## 

proc constPointerNull*(ty: TypeRef): ValueRef {.importc: "LLVMConstPointerNull",
    dynlib: LLVMLib.}
## *
##  @defgroup LLVMCCoreValueConstantScalar Scalar constants
## 
##  Functions in this group model LLVMValueRef instances that correspond
##  to constants referring to scalar types.
## 
##  For integer types, the LLVMTypeRef parameter should correspond to a
##  llvm::IntegerType instance and the returned LLVMValueRef will
##  correspond to a llvm::ConstantInt.
## 
##  For floating point types, the LLVMTypeRef returned corresponds to a
##  llvm::ConstantFP.
## 
##  @{
## 
## *
##  Obtain a constant value for an integer type.
## 
##  The returned value corresponds to a llvm::ConstantInt.
## 
##  @see llvm::ConstantInt::get()
## 
##  @param IntTy Integer type to obtain value of.
##  @param N The value the returned instance should refer to.
##  @param SignExtend Whether to sign extend the produced value.
## 

proc constInt*(intTy: TypeRef; n: culonglong; signExtend: Bool): ValueRef {.
    importc: "LLVMConstInt", dynlib: LLVMLib.}
## *
##  Obtain a constant value for an integer of arbitrary precision.
## 
##  @see llvm::ConstantInt::get()
## 

proc constIntOfArbitraryPrecision*(intTy: TypeRef; numWords: cuint;
                                  words: ptr uint64T): ValueRef {.
    importc: "LLVMConstIntOfArbitraryPrecision", dynlib: LLVMLib.}
## *
##  Obtain a constant value for an integer parsed from a string.
## 
##  A similar API, LLVMConstIntOfStringAndSize is also available. If the
##  string's length is available, it is preferred to call that function
##  instead.
## 
##  @see llvm::ConstantInt::get()
## 

proc constIntOfString*(intTy: TypeRef; text: cstring; radix: uint8T): ValueRef {.
    importc: "LLVMConstIntOfString", dynlib: LLVMLib.}
## *
##  Obtain a constant value for an integer parsed from a string with
##  specified length.
## 
##  @see llvm::ConstantInt::get()
## 

proc constIntOfStringAndSize*(intTy: TypeRef; text: cstring; sLen: cuint; radix: uint8T): ValueRef {.
    importc: "LLVMConstIntOfStringAndSize", dynlib: LLVMLib.}
## *
##  Obtain a constant value referring to a double floating point value.
## 

proc constReal*(realTy: TypeRef; n: cdouble): ValueRef {.importc: "LLVMConstReal",
    dynlib: LLVMLib.}
## *
##  Obtain a constant for a floating point value parsed from a string.
## 
##  A similar API, LLVMConstRealOfStringAndSize is also available. It
##  should be used if the input string's length is known.
## 

proc constRealOfString*(realTy: TypeRef; text: cstring): ValueRef {.
    importc: "LLVMConstRealOfString", dynlib: LLVMLib.}
## *
##  Obtain a constant for a floating point value parsed from a string.
## 

proc constRealOfStringAndSize*(realTy: TypeRef; text: cstring; sLen: cuint): ValueRef {.
    importc: "LLVMConstRealOfStringAndSize", dynlib: LLVMLib.}
## *
##  Obtain the zero extended value for an integer constant value.
## 
##  @see llvm::ConstantInt::getZExtValue()
## 

proc constIntGetZExtValue*(constantVal: ValueRef): culonglong {.
    importc: "LLVMConstIntGetZExtValue", dynlib: LLVMLib.}
## *
##  Obtain the sign extended value for an integer constant value.
## 
##  @see llvm::ConstantInt::getSExtValue()
## 

proc constIntGetSExtValue*(constantVal: ValueRef): clonglong {.
    importc: "LLVMConstIntGetSExtValue", dynlib: LLVMLib.}
## *
##  Obtain the double value for an floating point constant value.
##  losesInfo indicates if some precision was lost in the conversion.
## 
##  @see llvm::ConstantFP::getDoubleValue
## 

proc constRealGetDouble*(constantVal: ValueRef; losesInfo: ptr Bool): cdouble {.
    importc: "LLVMConstRealGetDouble", dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @defgroup LLVMCCoreValueConstantComposite Composite Constants
## 
##  Functions in this group operate on composite constants.
## 
##  @{
## 
## *
##  Create a ConstantDataSequential and initialize it with a string.
## 
##  @see llvm::ConstantDataArray::getString()
## 

proc constStringInContext*(c: ContextRef; str: cstring; length: cuint;
                          dontNullTerminate: Bool): ValueRef {.
    importc: "LLVMConstStringInContext", dynlib: LLVMLib.}
## *
##  Create a ConstantDataSequential with string content in the global context.
## 
##  This is the same as LLVMConstStringInContext except it operates on the
##  global context.
## 
##  @see LLVMConstStringInContext()
##  @see llvm::ConstantDataArray::getString()
## 

proc constString*(str: cstring; length: cuint; dontNullTerminate: Bool): ValueRef {.
    importc: "LLVMConstString", dynlib: LLVMLib.}
## *
##  Returns true if the specified constant is an array of i8.
## 
##  @see ConstantDataSequential::getAsString()
## 

proc isConstantString*(c: ValueRef): Bool {.importc: "LLVMIsConstantString",
                                        dynlib: LLVMLib.}
## *
##  Get the given constant data sequential as a string.
## 
##  @see ConstantDataSequential::getAsString()
## 

proc getAsString*(c: ValueRef; `out`: ptr csize): cstring {.importc: "LLVMGetAsString",
    dynlib: LLVMLib.}
## *
##  Create an anonymous ConstantStruct with the specified values.
## 
##  @see llvm::ConstantStruct::getAnon()
## 

proc constStructInContext*(c: ContextRef; constantVals: ptr ValueRef; count: cuint;
                          packed: Bool): ValueRef {.
    importc: "LLVMConstStructInContext", dynlib: LLVMLib.}
## *
##  Create a ConstantStruct in the global Context.
## 
##  This is the same as LLVMConstStructInContext except it operates on the
##  global Context.
## 
##  @see LLVMConstStructInContext()
## 

proc constStruct*(constantVals: ptr ValueRef; count: cuint; packed: Bool): ValueRef {.
    importc: "LLVMConstStruct", dynlib: LLVMLib.}
## *
##  Create a ConstantArray from values.
## 
##  @see llvm::ConstantArray::get()
## 

proc constArray*(elementTy: TypeRef; constantVals: ptr ValueRef; length: cuint): ValueRef {.
    importc: "LLVMConstArray", dynlib: LLVMLib.}
## *
##  Create a non-anonymous ConstantStruct from values.
## 
##  @see llvm::ConstantStruct::get()
## 

proc constNamedStruct*(structTy: TypeRef; constantVals: ptr ValueRef; count: cuint): ValueRef {.
    importc: "LLVMConstNamedStruct", dynlib: LLVMLib.}
## *
##  Get an element at specified index as a constant.
## 
##  @see ConstantDataSequential::getElementAsConstant()
## 

proc getElementAsConstant*(c: ValueRef; idx: cuint): ValueRef {.
    importc: "LLVMGetElementAsConstant", dynlib: LLVMLib.}
## *
##  Create a ConstantVector from values.
## 
##  @see llvm::ConstantVector::get()
## 

proc constVector*(scalarConstantVals: ptr ValueRef; size: cuint): ValueRef {.
    importc: "LLVMConstVector", dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @defgroup LLVMCCoreValueConstantExpressions Constant Expressions
## 
##  Functions in this group correspond to APIs on llvm::ConstantExpr.
## 
##  @see llvm::ConstantExpr.
## 
##  @{
## 

proc getConstOpcode*(constantVal: ValueRef): Opcode {.importc: "LLVMGetConstOpcode",
    dynlib: LLVMLib.}
proc alignOf*(ty: TypeRef): ValueRef {.importc: "LLVMAlignOf", dynlib: LLVMLib.}
proc sizeOf*(ty: TypeRef): ValueRef {.importc: "LLVMSizeOf", dynlib: LLVMLib.}
proc constNeg*(constantVal: ValueRef): ValueRef {.importc: "LLVMConstNeg",
    dynlib: LLVMLib.}
proc constNSWNeg*(constantVal: ValueRef): ValueRef {.importc: "LLVMConstNSWNeg",
    dynlib: LLVMLib.}
proc constNUWNeg*(constantVal: ValueRef): ValueRef {.importc: "LLVMConstNUWNeg",
    dynlib: LLVMLib.}
proc constFNeg*(constantVal: ValueRef): ValueRef {.importc: "LLVMConstFNeg",
    dynlib: LLVMLib.}
proc constNot*(constantVal: ValueRef): ValueRef {.importc: "LLVMConstNot",
    dynlib: LLVMLib.}
proc constAdd*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstAdd", dynlib: LLVMLib.}
proc constNSWAdd*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstNSWAdd", dynlib: LLVMLib.}
proc constNUWAdd*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstNUWAdd", dynlib: LLVMLib.}
proc constFAdd*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstFAdd", dynlib: LLVMLib.}
proc constSub*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstSub", dynlib: LLVMLib.}
proc constNSWSub*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstNSWSub", dynlib: LLVMLib.}
proc constNUWSub*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstNUWSub", dynlib: LLVMLib.}
proc constFSub*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstFSub", dynlib: LLVMLib.}
proc constMul*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstMul", dynlib: LLVMLib.}
proc constNSWMul*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstNSWMul", dynlib: LLVMLib.}
proc constNUWMul*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstNUWMul", dynlib: LLVMLib.}
proc constFMul*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstFMul", dynlib: LLVMLib.}
proc constUDiv*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstUDiv", dynlib: LLVMLib.}
proc constSDiv*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstSDiv", dynlib: LLVMLib.}
proc constExactSDiv*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstExactSDiv", dynlib: LLVMLib.}
proc constFDiv*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstFDiv", dynlib: LLVMLib.}
proc constURem*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstURem", dynlib: LLVMLib.}
proc constSRem*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstSRem", dynlib: LLVMLib.}
proc constFRem*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstFRem", dynlib: LLVMLib.}
proc constAnd*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstAnd", dynlib: LLVMLib.}
proc constOr*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstOr", dynlib: LLVMLib.}
proc constXor*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstXor", dynlib: LLVMLib.}
proc constICmp*(predicate: IntPredicate; lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstICmp", dynlib: LLVMLib.}
proc constFCmp*(predicate: RealPredicate; lHSConstant: ValueRef;
               rHSConstant: ValueRef): ValueRef {.importc: "LLVMConstFCmp",
    dynlib: LLVMLib.}
proc constShl*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstShl", dynlib: LLVMLib.}
proc constLShr*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstLShr", dynlib: LLVMLib.}
proc constAShr*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.
    importc: "LLVMConstAShr", dynlib: LLVMLib.}
proc constGEP*(constantVal: ValueRef; constantIndices: ptr ValueRef; numIndices: cuint): ValueRef {.
    importc: "LLVMConstGEP", dynlib: LLVMLib.}
proc constInBoundsGEP*(constantVal: ValueRef; constantIndices: ptr ValueRef;
                      numIndices: cuint): ValueRef {.
    importc: "LLVMConstInBoundsGEP", dynlib: LLVMLib.}
proc constTrunc*(constantVal: ValueRef; toType: TypeRef): ValueRef {.
    importc: "LLVMConstTrunc", dynlib: LLVMLib.}
proc constSExt*(constantVal: ValueRef; toType: TypeRef): ValueRef {.
    importc: "LLVMConstSExt", dynlib: LLVMLib.}
proc constZExt*(constantVal: ValueRef; toType: TypeRef): ValueRef {.
    importc: "LLVMConstZExt", dynlib: LLVMLib.}
proc constFPTrunc*(constantVal: ValueRef; toType: TypeRef): ValueRef {.
    importc: "LLVMConstFPTrunc", dynlib: LLVMLib.}
proc constFPExt*(constantVal: ValueRef; toType: TypeRef): ValueRef {.
    importc: "LLVMConstFPExt", dynlib: LLVMLib.}
proc constUIToFP*(constantVal: ValueRef; toType: TypeRef): ValueRef {.
    importc: "LLVMConstUIToFP", dynlib: LLVMLib.}
proc constSIToFP*(constantVal: ValueRef; toType: TypeRef): ValueRef {.
    importc: "LLVMConstSIToFP", dynlib: LLVMLib.}
proc constFPToUI*(constantVal: ValueRef; toType: TypeRef): ValueRef {.
    importc: "LLVMConstFPToUI", dynlib: LLVMLib.}
proc constFPToSI*(constantVal: ValueRef; toType: TypeRef): ValueRef {.
    importc: "LLVMConstFPToSI", dynlib: LLVMLib.}
proc constPtrToInt*(constantVal: ValueRef; toType: TypeRef): ValueRef {.
    importc: "LLVMConstPtrToInt", dynlib: LLVMLib.}
proc constIntToPtr*(constantVal: ValueRef; toType: TypeRef): ValueRef {.
    importc: "LLVMConstIntToPtr", dynlib: LLVMLib.}
proc constBitCast*(constantVal: ValueRef; toType: TypeRef): ValueRef {.
    importc: "LLVMConstBitCast", dynlib: LLVMLib.}
proc constAddrSpaceCast*(constantVal: ValueRef; toType: TypeRef): ValueRef {.
    importc: "LLVMConstAddrSpaceCast", dynlib: LLVMLib.}
proc constZExtOrBitCast*(constantVal: ValueRef; toType: TypeRef): ValueRef {.
    importc: "LLVMConstZExtOrBitCast", dynlib: LLVMLib.}
proc constSExtOrBitCast*(constantVal: ValueRef; toType: TypeRef): ValueRef {.
    importc: "LLVMConstSExtOrBitCast", dynlib: LLVMLib.}
proc constTruncOrBitCast*(constantVal: ValueRef; toType: TypeRef): ValueRef {.
    importc: "LLVMConstTruncOrBitCast", dynlib: LLVMLib.}
proc constPointerCast*(constantVal: ValueRef; toType: TypeRef): ValueRef {.
    importc: "LLVMConstPointerCast", dynlib: LLVMLib.}
proc constIntCast*(constantVal: ValueRef; toType: TypeRef; isSigned: Bool): ValueRef {.
    importc: "LLVMConstIntCast", dynlib: LLVMLib.}
proc constFPCast*(constantVal: ValueRef; toType: TypeRef): ValueRef {.
    importc: "LLVMConstFPCast", dynlib: LLVMLib.}
proc constSelect*(constantCondition: ValueRef; constantIfTrue: ValueRef;
                 constantIfFalse: ValueRef): ValueRef {.importc: "LLVMConstSelect",
    dynlib: LLVMLib.}
proc constExtractElement*(vectorConstant: ValueRef; indexConstant: ValueRef): ValueRef {.
    importc: "LLVMConstExtractElement", dynlib: LLVMLib.}
proc constInsertElement*(vectorConstant: ValueRef; elementValueConstant: ValueRef;
                        indexConstant: ValueRef): ValueRef {.
    importc: "LLVMConstInsertElement", dynlib: LLVMLib.}
proc constShuffleVector*(vectorAConstant: ValueRef; vectorBConstant: ValueRef;
                        maskConstant: ValueRef): ValueRef {.
    importc: "LLVMConstShuffleVector", dynlib: LLVMLib.}
proc constExtractValue*(aggConstant: ValueRef; idxList: ptr cuint; numIdx: cuint): ValueRef {.
    importc: "LLVMConstExtractValue", dynlib: LLVMLib.}
proc constInsertValue*(aggConstant: ValueRef; elementValueConstant: ValueRef;
                      idxList: ptr cuint; numIdx: cuint): ValueRef {.
    importc: "LLVMConstInsertValue", dynlib: LLVMLib.}
proc constInlineAsm*(ty: TypeRef; asmString: cstring; constraints: cstring;
                    hasSideEffects: Bool; isAlignStack: Bool): ValueRef {.
    importc: "LLVMConstInlineAsm", dynlib: LLVMLib.}
proc blockAddress*(f: ValueRef; bb: BasicBlockRef): ValueRef {.
    importc: "LLVMBlockAddress", dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @defgroup LLVMCCoreValueConstantGlobals Global Values
## 
##  This group contains functions that operate on global values. Functions in
##  this group relate to functions in the llvm::GlobalValue class tree.
## 
##  @see llvm::GlobalValue
## 
##  @{
## 

proc getGlobalParent*(global: ValueRef): ModuleRef {.importc: "LLVMGetGlobalParent",
    dynlib: LLVMLib.}
proc isDeclaration*(global: ValueRef): Bool {.importc: "LLVMIsDeclaration",
    dynlib: LLVMLib.}
proc getLinkage*(global: ValueRef): Linkage {.importc: "LLVMGetLinkage",
    dynlib: LLVMLib.}
proc setLinkage*(global: ValueRef; linkage: Linkage) {.importc: "LLVMSetLinkage",
    dynlib: LLVMLib.}
proc getSection*(global: ValueRef): cstring {.importc: "LLVMGetSection",
    dynlib: LLVMLib.}
proc setSection*(global: ValueRef; section: cstring) {.importc: "LLVMSetSection",
    dynlib: LLVMLib.}
proc getVisibility*(global: ValueRef): Visibility {.importc: "LLVMGetVisibility",
    dynlib: LLVMLib.}
proc setVisibility*(global: ValueRef; viz: Visibility) {.
    importc: "LLVMSetVisibility", dynlib: LLVMLib.}
proc getDLLStorageClass*(global: ValueRef): DLLStorageClass {.
    importc: "LLVMGetDLLStorageClass", dynlib: LLVMLib.}
proc setDLLStorageClass*(global: ValueRef; class: DLLStorageClass) {.
    importc: "LLVMSetDLLStorageClass", dynlib: LLVMLib.}
proc hasUnnamedAddr*(global: ValueRef): Bool {.importc: "LLVMHasUnnamedAddr",
    dynlib: LLVMLib.}
proc setUnnamedAddr*(global: ValueRef; hasUnnamedAddr: Bool) {.
    importc: "LLVMSetUnnamedAddr", dynlib: LLVMLib.}
## *
##  @defgroup LLVMCCoreValueWithAlignment Values with alignment
## 
##  Functions in this group only apply to values with alignment, i.e.
##  global variables, load and store instructions.
## 
## *
##  Obtain the preferred alignment of the value.
##  @see llvm::AllocaInst::getAlignment()
##  @see llvm::LoadInst::getAlignment()
##  @see llvm::StoreInst::getAlignment()
##  @see llvm::GlobalValue::getAlignment()
## 

proc getAlignment*(v: ValueRef): cuint {.importc: "LLVMGetAlignment", dynlib: LLVMLib.}
## *
##  Set the preferred alignment of the value.
##  @see llvm::AllocaInst::setAlignment()
##  @see llvm::LoadInst::setAlignment()
##  @see llvm::StoreInst::setAlignment()
##  @see llvm::GlobalValue::setAlignment()
## 

proc setAlignment*(v: ValueRef; bytes: cuint) {.importc: "LLVMSetAlignment",
    dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @defgroup LLVMCoreValueConstantGlobalVariable Global Variables
## 
##  This group contains functions that operate on global variable values.
## 
##  @see llvm::GlobalVariable
## 
##  @{
## 

proc addGlobal*(m: ModuleRef; ty: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMAddGlobal", dynlib: LLVMLib.}
proc addGlobalInAddressSpace*(m: ModuleRef; ty: TypeRef; name: cstring;
                             addressSpace: cuint): ValueRef {.
    importc: "LLVMAddGlobalInAddressSpace", dynlib: LLVMLib.}
proc getNamedGlobal*(m: ModuleRef; name: cstring): ValueRef {.
    importc: "LLVMGetNamedGlobal", dynlib: LLVMLib.}
proc getFirstGlobal*(m: ModuleRef): ValueRef {.importc: "LLVMGetFirstGlobal",
    dynlib: LLVMLib.}
proc getLastGlobal*(m: ModuleRef): ValueRef {.importc: "LLVMGetLastGlobal",
    dynlib: LLVMLib.}
proc getNextGlobal*(globalVar: ValueRef): ValueRef {.importc: "LLVMGetNextGlobal",
    dynlib: LLVMLib.}
proc getPreviousGlobal*(globalVar: ValueRef): ValueRef {.
    importc: "LLVMGetPreviousGlobal", dynlib: LLVMLib.}
proc deleteGlobal*(globalVar: ValueRef) {.importc: "LLVMDeleteGlobal",
                                       dynlib: LLVMLib.}
proc getInitializer*(globalVar: ValueRef): ValueRef {.importc: "LLVMGetInitializer",
    dynlib: LLVMLib.}
proc setInitializer*(globalVar: ValueRef; constantVal: ValueRef) {.
    importc: "LLVMSetInitializer", dynlib: LLVMLib.}
proc isThreadLocal*(globalVar: ValueRef): Bool {.importc: "LLVMIsThreadLocal",
    dynlib: LLVMLib.}
proc setThreadLocal*(globalVar: ValueRef; isThreadLocal: Bool) {.
    importc: "LLVMSetThreadLocal", dynlib: LLVMLib.}
proc isGlobalConstant*(globalVar: ValueRef): Bool {.importc: "LLVMIsGlobalConstant",
    dynlib: LLVMLib.}
proc setGlobalConstant*(globalVar: ValueRef; isConstant: Bool) {.
    importc: "LLVMSetGlobalConstant", dynlib: LLVMLib.}
proc getThreadLocalMode*(globalVar: ValueRef): ThreadLocalMode {.
    importc: "LLVMGetThreadLocalMode", dynlib: LLVMLib.}
proc setThreadLocalMode*(globalVar: ValueRef; mode: ThreadLocalMode) {.
    importc: "LLVMSetThreadLocalMode", dynlib: LLVMLib.}
proc isExternallyInitialized*(globalVar: ValueRef): Bool {.
    importc: "LLVMIsExternallyInitialized", dynlib: LLVMLib.}
proc setExternallyInitialized*(globalVar: ValueRef; isExtInit: Bool) {.
    importc: "LLVMSetExternallyInitialized", dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @defgroup LLVMCoreValueConstantGlobalAlias Global Aliases
## 
##  This group contains function that operate on global alias values.
## 
##  @see llvm::GlobalAlias
## 
##  @{
## 

proc addAlias*(m: ModuleRef; ty: TypeRef; aliasee: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMAddAlias", dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @defgroup LLVMCCoreValueFunction Function values
## 
##  Functions in this group operate on LLVMValueRef instances that
##  correspond to llvm::Function instances.
## 
##  @see llvm::Function
## 
##  @{
## 
## *
##  Remove a function from its containing module and deletes it.
## 
##  @see llvm::Function::eraseFromParent()
## 

proc deleteFunction*(fn: ValueRef) {.importc: "LLVMDeleteFunction", dynlib: LLVMLib.}
## *
##  Obtain the personality function attached to the function.
## 
##  @see llvm::Function::getPersonalityFn()
## 

proc getPersonalityFn*(fn: ValueRef): ValueRef {.importc: "LLVMGetPersonalityFn",
    dynlib: LLVMLib.}
## *
##  Set the personality function attached to the function.
## 
##  @see llvm::Function::setPersonalityFn()
## 

proc setPersonalityFn*(fn: ValueRef; personalityFn: ValueRef) {.
    importc: "LLVMSetPersonalityFn", dynlib: LLVMLib.}
## *
##  Obtain the ID number from a function instance.
## 
##  @see llvm::Function::getIntrinsicID()
## 

proc getIntrinsicID*(fn: ValueRef): cuint {.importc: "LLVMGetIntrinsicID",
                                        dynlib: LLVMLib.}
## *
##  Obtain the calling function of a function.
## 
##  The returned value corresponds to the LLVMCallConv enumeration.
## 
##  @see llvm::Function::getCallingConv()
## 

proc getFunctionCallConv*(fn: ValueRef): cuint {.importc: "LLVMGetFunctionCallConv",
    dynlib: LLVMLib.}
## *
##  Set the calling convention of a function.
## 
##  @see llvm::Function::setCallingConv()
## 
##  @param Fn Function to operate on
##  @param CC LLVMCallConv to set calling convention to
## 

proc setFunctionCallConv*(fn: ValueRef; cc: cuint) {.
    importc: "LLVMSetFunctionCallConv", dynlib: LLVMLib.}
## *
##  Obtain the name of the garbage collector to use during code
##  generation.
## 
##  @see llvm::Function::getGC()
## 

proc getGC*(fn: ValueRef): cstring {.importc: "LLVMGetGC", dynlib: LLVMLib.}
## *
##  Define the garbage collector to use during code generation.
## 
##  @see llvm::Function::setGC()
## 

proc setGC*(fn: ValueRef; name: cstring) {.importc: "LLVMSetGC", dynlib: LLVMLib.}
## *
##  Add an attribute to a function.
## 
##  @see llvm::Function::addAttribute()
## 

proc addFunctionAttr*(fn: ValueRef; pa: Attribute) {.importc: "LLVMAddFunctionAttr",
    dynlib: LLVMLib.}
## *
##  Add a target-dependent attribute to a fuction
##  @see llvm::AttrBuilder::addAttribute()
## 

proc addTargetDependentFunctionAttr*(fn: ValueRef; a: cstring; v: cstring) {.
    importc: "LLVMAddTargetDependentFunctionAttr", dynlib: LLVMLib.}
## *
##  Obtain an attribute from a function.
## 
##  @see llvm::Function::getAttributes()
## 

proc getFunctionAttr*(fn: ValueRef): Attribute {.importc: "LLVMGetFunctionAttr",
    dynlib: LLVMLib.}
## *
##  Remove an attribute from a function.
## 

proc removeFunctionAttr*(fn: ValueRef; pa: Attribute) {.
    importc: "LLVMRemoveFunctionAttr", dynlib: LLVMLib.}
## *
##  @defgroup LLVMCCoreValueFunctionParameters Function Parameters
## 
##  Functions in this group relate to arguments/parameters on functions.
## 
##  Functions in this group expect LLVMValueRef instances that correspond
##  to llvm::Function instances.
## 
##  @{
## 
## *
##  Obtain the number of parameters in a function.
## 
##  @see llvm::Function::arg_size()
## 

proc countParams*(fn: ValueRef): cuint {.importc: "LLVMCountParams", dynlib: LLVMLib.}
## *
##  Obtain the parameters in a function.
## 
##  The takes a pointer to a pre-allocated array of LLVMValueRef that is
##  at least LLVMCountParams() long. This array will be filled with
##  LLVMValueRef instances which correspond to the parameters the
##  function receives. Each LLVMValueRef corresponds to a llvm::Argument
##  instance.
## 
##  @see llvm::Function::arg_begin()
## 

proc getParams*(fn: ValueRef; params: ptr ValueRef) {.importc: "LLVMGetParams",
    dynlib: LLVMLib.}
## *
##  Obtain the parameter at the specified index.
## 
##  Parameters are indexed from 0.
## 
##  @see llvm::Function::arg_begin()
## 

proc getParam*(fn: ValueRef; index: cuint): ValueRef {.importc: "LLVMGetParam",
    dynlib: LLVMLib.}
## *
##  Obtain the function to which this argument belongs.
## 
##  Unlike other functions in this group, this one takes an LLVMValueRef
##  that corresponds to a llvm::Attribute.
## 
##  The returned LLVMValueRef is the llvm::Function to which this
##  argument belongs.
## 

proc getParamParent*(inst: ValueRef): ValueRef {.importc: "LLVMGetParamParent",
    dynlib: LLVMLib.}
## *
##  Obtain the first parameter to a function.
## 
##  @see llvm::Function::arg_begin()
## 

proc getFirstParam*(fn: ValueRef): ValueRef {.importc: "LLVMGetFirstParam",
    dynlib: LLVMLib.}
## *
##  Obtain the last parameter to a function.
## 
##  @see llvm::Function::arg_end()
## 

proc getLastParam*(fn: ValueRef): ValueRef {.importc: "LLVMGetLastParam",
    dynlib: LLVMLib.}
## *
##  Obtain the next parameter to a function.
## 
##  This takes an LLVMValueRef obtained from LLVMGetFirstParam() (which is
##  actually a wrapped iterator) and obtains the next parameter from the
##  underlying iterator.
## 

proc getNextParam*(arg: ValueRef): ValueRef {.importc: "LLVMGetNextParam",
    dynlib: LLVMLib.}
## *
##  Obtain the previous parameter to a function.
## 
##  This is the opposite of LLVMGetNextParam().
## 

proc getPreviousParam*(arg: ValueRef): ValueRef {.importc: "LLVMGetPreviousParam",
    dynlib: LLVMLib.}
## *
##  Add an attribute to a function argument.
## 
##  @see llvm::Argument::addAttr()
## 

proc addAttribute*(arg: ValueRef; pa: Attribute) {.importc: "LLVMAddAttribute",
    dynlib: LLVMLib.}
## *
##  Remove an attribute from a function argument.
## 
##  @see llvm::Argument::removeAttr()
## 

proc removeAttribute*(arg: ValueRef; pa: Attribute) {.importc: "LLVMRemoveAttribute",
    dynlib: LLVMLib.}
## *
##  Get an attribute from a function argument.
## 

proc getAttribute*(arg: ValueRef): Attribute {.importc: "LLVMGetAttribute",
    dynlib: LLVMLib.}
## *
##  Set the alignment for a function parameter.
## 
##  @see llvm::Argument::addAttr()
##  @see llvm::AttrBuilder::addAlignmentAttr()
## 

proc setParamAlignment*(arg: ValueRef; align: cuint) {.
    importc: "LLVMSetParamAlignment", dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @}
## 
## *
##  @}
## 
## *
##  @}
## 
## *
##  @defgroup LLVMCCoreValueMetadata Metadata
## 
##  @{
## 
## *
##  Obtain a MDString value from a context.
## 
##  The returned instance corresponds to the llvm::MDString class.
## 
##  The instance is specified by string data of a specified length. The
##  string content is copied, so the backing memory can be freed after
##  this function returns.
## 

proc mDStringInContext*(c: ContextRef; str: cstring; sLen: cuint): ValueRef {.
    importc: "LLVMMDStringInContext", dynlib: LLVMLib.}
## *
##  Obtain a MDString value from the global context.
## 

proc mDString*(str: cstring; sLen: cuint): ValueRef {.importc: "LLVMMDString",
    dynlib: LLVMLib.}
## *
##  Obtain a MDNode value from a context.
## 
##  The returned value corresponds to the llvm::MDNode class.
## 

proc mDNodeInContext*(c: ContextRef; vals: ptr ValueRef; count: cuint): ValueRef {.
    importc: "LLVMMDNodeInContext", dynlib: LLVMLib.}
## *
##  Obtain a MDNode value from the global context.
## 

proc mDNode*(vals: ptr ValueRef; count: cuint): ValueRef {.importc: "LLVMMDNode",
    dynlib: LLVMLib.}
## *
##  Obtain the underlying string from a MDString value.
## 
##  @param V Instance to obtain string from.
##  @param Len Memory address which will hold length of returned string.
##  @return String data in MDString.
## 

proc getMDString*(v: ValueRef; len: ptr cuint): cstring {.importc: "LLVMGetMDString",
    dynlib: LLVMLib.}
## *
##  Obtain the number of operands from an MDNode value.
## 
##  @param V MDNode to get number of operands from.
##  @return Number of operands of the MDNode.
## 

proc getMDNodeNumOperands*(v: ValueRef): cuint {.
    importc: "LLVMGetMDNodeNumOperands", dynlib: LLVMLib.}
## *
##  Obtain the given MDNode's operands.
## 
##  The passed LLVMValueRef pointer should point to enough memory to hold all of
##  the operands of the given MDNode (see LLVMGetMDNodeNumOperands) as
##  LLVMValueRefs. This memory will be populated with the LLVMValueRefs of the
##  MDNode's operands.
## 
##  @param V MDNode to get the operands from.
##  @param Dest Destination array for operands.
## 

proc getMDNodeOperands*(v: ValueRef; dest: ptr ValueRef) {.
    importc: "LLVMGetMDNodeOperands", dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @defgroup LLVMCCoreValueBasicBlock Basic Block
## 
##  A basic block represents a single entry single exit section of code.
##  Basic blocks contain a list of instructions which form the body of
##  the block.
## 
##  Basic blocks belong to functions. They have the type of label.
## 
##  Basic blocks are themselves values. However, the C API models them as
##  LLVMBasicBlockRef.
## 
##  @see llvm::BasicBlock
## 
##  @{
## 
## *
##  Convert a basic block instance to a value type.
## 

proc basicBlockAsValue*(bb: BasicBlockRef): ValueRef {.
    importc: "LLVMBasicBlockAsValue", dynlib: LLVMLib.}
## *
##  Determine whether an LLVMValueRef is itself a basic block.
## 

proc valueIsBasicBlock*(val: ValueRef): Bool {.importc: "LLVMValueIsBasicBlock",
    dynlib: LLVMLib.}
## *
##  Convert an LLVMValueRef to an LLVMBasicBlockRef instance.
## 

proc valueAsBasicBlock*(val: ValueRef): BasicBlockRef {.
    importc: "LLVMValueAsBasicBlock", dynlib: LLVMLib.}
## *
##  Obtain the function to which a basic block belongs.
## 
##  @see llvm::BasicBlock::getParent()
## 

proc getBasicBlockParent*(bb: BasicBlockRef): ValueRef {.
    importc: "LLVMGetBasicBlockParent", dynlib: LLVMLib.}
## *
##  Obtain the terminator instruction for a basic block.
## 
##  If the basic block does not have a terminator (it is not well-formed
##  if it doesn't), then NULL is returned.
## 
##  The returned LLVMValueRef corresponds to a llvm::TerminatorInst.
## 
##  @see llvm::BasicBlock::getTerminator()
## 

proc getBasicBlockTerminator*(bb: BasicBlockRef): ValueRef {.
    importc: "LLVMGetBasicBlockTerminator", dynlib: LLVMLib.}
## *
##  Obtain the number of basic blocks in a function.
## 
##  @param Fn Function value to operate on.
## 

proc countBasicBlocks*(fn: ValueRef): cuint {.importc: "LLVMCountBasicBlocks",
    dynlib: LLVMLib.}
## *
##  Obtain all of the basic blocks in a function.
## 
##  This operates on a function value. The BasicBlocks parameter is a
##  pointer to a pre-allocated array of LLVMBasicBlockRef of at least
##  LLVMCountBasicBlocks() in length. This array is populated with
##  LLVMBasicBlockRef instances.
## 

proc getBasicBlocks*(fn: ValueRef; basicBlocks: ptr BasicBlockRef) {.
    importc: "LLVMGetBasicBlocks", dynlib: LLVMLib.}
## *
##  Obtain the first basic block in a function.
## 
##  The returned basic block can be used as an iterator. You will likely
##  eventually call into LLVMGetNextBasicBlock() with it.
## 
##  @see llvm::Function::begin()
## 

proc getFirstBasicBlock*(fn: ValueRef): BasicBlockRef {.
    importc: "LLVMGetFirstBasicBlock", dynlib: LLVMLib.}
## *
##  Obtain the last basic block in a function.
## 
##  @see llvm::Function::end()
## 

proc getLastBasicBlock*(fn: ValueRef): BasicBlockRef {.
    importc: "LLVMGetLastBasicBlock", dynlib: LLVMLib.}
## *
##  Advance a basic block iterator.
## 

proc getNextBasicBlock*(bb: BasicBlockRef): BasicBlockRef {.
    importc: "LLVMGetNextBasicBlock", dynlib: LLVMLib.}
## *
##  Go backwards in a basic block iterator.
## 

proc getPreviousBasicBlock*(bb: BasicBlockRef): BasicBlockRef {.
    importc: "LLVMGetPreviousBasicBlock", dynlib: LLVMLib.}
## *
##  Obtain the basic block that corresponds to the entry point of a
##  function.
## 
##  @see llvm::Function::getEntryBlock()
## 

proc getEntryBasicBlock*(fn: ValueRef): BasicBlockRef {.
    importc: "LLVMGetEntryBasicBlock", dynlib: LLVMLib.}
## *
##  Append a basic block to the end of a function.
## 
##  @see llvm::BasicBlock::Create()
## 

proc appendBasicBlockInContext*(c: ContextRef; fn: ValueRef; name: cstring): BasicBlockRef {.
    importc: "LLVMAppendBasicBlockInContext", dynlib: LLVMLib.}
## *
##  Append a basic block to the end of a function using the global
##  context.
## 
##  @see llvm::BasicBlock::Create()
## 

proc appendBasicBlock*(fn: ValueRef; name: cstring): BasicBlockRef {.
    importc: "LLVMAppendBasicBlock", dynlib: LLVMLib.}
## *
##  Insert a basic block in a function before another basic block.
## 
##  The function to add to is determined by the function of the
##  passed basic block.
## 
##  @see llvm::BasicBlock::Create()
## 

proc insertBasicBlockInContext*(c: ContextRef; bb: BasicBlockRef; name: cstring): BasicBlockRef {.
    importc: "LLVMInsertBasicBlockInContext", dynlib: LLVMLib.}
## *
##  Insert a basic block in a function using the global context.
## 
##  @see llvm::BasicBlock::Create()
## 

proc insertBasicBlock*(insertBeforeBB: BasicBlockRef; name: cstring): BasicBlockRef {.
    importc: "LLVMInsertBasicBlock", dynlib: LLVMLib.}
## *
##  Remove a basic block from a function and delete it.
## 
##  This deletes the basic block from its containing function and deletes
##  the basic block itself.
## 
##  @see llvm::BasicBlock::eraseFromParent()
## 

proc deleteBasicBlock*(bb: BasicBlockRef) {.importc: "LLVMDeleteBasicBlock",
    dynlib: LLVMLib.}
## *
##  Remove a basic block from a function.
## 
##  This deletes the basic block from its containing function but keep
##  the basic block alive.
## 
##  @see llvm::BasicBlock::removeFromParent()
## 

proc removeBasicBlockFromParent*(bb: BasicBlockRef) {.
    importc: "LLVMRemoveBasicBlockFromParent", dynlib: LLVMLib.}
## *
##  Move a basic block to before another one.
## 
##  @see llvm::BasicBlock::moveBefore()
## 

proc moveBasicBlockBefore*(bb: BasicBlockRef; movePos: BasicBlockRef) {.
    importc: "LLVMMoveBasicBlockBefore", dynlib: LLVMLib.}
## *
##  Move a basic block to after another one.
## 
##  @see llvm::BasicBlock::moveAfter()
## 

proc moveBasicBlockAfter*(bb: BasicBlockRef; movePos: BasicBlockRef) {.
    importc: "LLVMMoveBasicBlockAfter", dynlib: LLVMLib.}
## *
##  Obtain the first instruction in a basic block.
## 
##  The returned LLVMValueRef corresponds to a llvm::Instruction
##  instance.
## 

proc getFirstInstruction*(bb: BasicBlockRef): ValueRef {.
    importc: "LLVMGetFirstInstruction", dynlib: LLVMLib.}
## *
##  Obtain the last instruction in a basic block.
## 
##  The returned LLVMValueRef corresponds to an LLVM:Instruction.
## 

proc getLastInstruction*(bb: BasicBlockRef): ValueRef {.
    importc: "LLVMGetLastInstruction", dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @defgroup LLVMCCoreValueInstruction Instructions
## 
##  Functions in this group relate to the inspection and manipulation of
##  individual instructions.
## 
##  In the C++ API, an instruction is modeled by llvm::Instruction. This
##  class has a large number of descendents. llvm::Instruction is a
##  llvm::Value and in the C API, instructions are modeled by
##  LLVMValueRef.
## 
##  This group also contains sub-groups which operate on specific
##  llvm::Instruction types, e.g. llvm::CallInst.
## 
##  @{
## 
## *
##  Determine whether an instruction has any metadata attached.
## 

proc hasMetadata*(val: ValueRef): cint {.importc: "LLVMHasMetadata", dynlib: LLVMLib.}
## *
##  Return metadata associated with an instruction value.
## 

proc getMetadata*(val: ValueRef; kindID: cuint): ValueRef {.
    importc: "LLVMGetMetadata", dynlib: LLVMLib.}
## *
##  Set metadata associated with an instruction value.
## 

proc setMetadata*(val: ValueRef; kindID: cuint; node: ValueRef) {.
    importc: "LLVMSetMetadata", dynlib: LLVMLib.}
## *
##  Obtain the basic block to which an instruction belongs.
## 
##  @see llvm::Instruction::getParent()
## 

proc getInstructionParent*(inst: ValueRef): BasicBlockRef {.
    importc: "LLVMGetInstructionParent", dynlib: LLVMLib.}
## *
##  Obtain the instruction that occurs after the one specified.
## 
##  The next instruction will be from the same basic block.
## 
##  If this is the last instruction in a basic block, NULL will be
##  returned.
## 

proc getNextInstruction*(inst: ValueRef): ValueRef {.
    importc: "LLVMGetNextInstruction", dynlib: LLVMLib.}
## *
##  Obtain the instruction that occurred before this one.
## 
##  If the instruction is the first instruction in a basic block, NULL
##  will be returned.
## 

proc getPreviousInstruction*(inst: ValueRef): ValueRef {.
    importc: "LLVMGetPreviousInstruction", dynlib: LLVMLib.}
## *
##  Remove and delete an instruction.
## 
##  The instruction specified is removed from its containing building
##  block and then deleted.
## 
##  @see llvm::Instruction::eraseFromParent()
## 

proc instructionEraseFromParent*(inst: ValueRef) {.
    importc: "LLVMInstructionEraseFromParent", dynlib: LLVMLib.}
## *
##  Obtain the code opcode for an individual instruction.
## 
##  @see llvm::Instruction::getOpCode()
## 

proc getInstructionOpcode*(inst: ValueRef): Opcode {.
    importc: "LLVMGetInstructionOpcode", dynlib: LLVMLib.}
## *
##  Obtain the predicate of an instruction.
## 
##  This is only valid for instructions that correspond to llvm::ICmpInst
##  or llvm::ConstantExpr whose opcode is llvm::Instruction::ICmp.
## 
##  @see llvm::ICmpInst::getPredicate()
## 

proc getICmpPredicate*(inst: ValueRef): IntPredicate {.
    importc: "LLVMGetICmpPredicate", dynlib: LLVMLib.}
## *
##  Obtain the float predicate of an instruction.
## 
##  This is only valid for instructions that correspond to llvm::FCmpInst
##  or llvm::ConstantExpr whose opcode is llvm::Instruction::FCmp.
## 
##  @see llvm::FCmpInst::getPredicate()
## 

proc getFCmpPredicate*(inst: ValueRef): RealPredicate {.
    importc: "LLVMGetFCmpPredicate", dynlib: LLVMLib.}
## *
##  Create a copy of 'this' instruction that is identical in all ways
##  except the following:
##    * The instruction has no parent
##    * The instruction has no name
## 
##  @see llvm::Instruction::clone()
## 

proc instructionClone*(inst: ValueRef): ValueRef {.importc: "LLVMInstructionClone",
    dynlib: LLVMLib.}
## *
##  @defgroup LLVMCCoreValueInstructionCall Call Sites and Invocations
## 
##  Functions in this group apply to instructions that refer to call
##  sites and invocations. These correspond to C++ types in the
##  llvm::CallInst class tree.
## 
##  @{
## 
## *
##  Set the calling convention for a call instruction.
## 
##  This expects an LLVMValueRef that corresponds to a llvm::CallInst or
##  llvm::InvokeInst.
## 
##  @see llvm::CallInst::setCallingConv()
##  @see llvm::InvokeInst::setCallingConv()
## 

proc setInstructionCallConv*(instr: ValueRef; cc: cuint) {.
    importc: "LLVMSetInstructionCallConv", dynlib: LLVMLib.}
## *
##  Obtain the calling convention for a call instruction.
## 
##  This is the opposite of LLVMSetInstructionCallConv(). Reads its
##  usage.
## 
##  @see LLVMSetInstructionCallConv()
## 

proc getInstructionCallConv*(instr: ValueRef): cuint {.
    importc: "LLVMGetInstructionCallConv", dynlib: LLVMLib.}
proc addInstrAttribute*(instr: ValueRef; index: cuint; a4: Attribute) {.
    importc: "LLVMAddInstrAttribute", dynlib: LLVMLib.}
proc removeInstrAttribute*(instr: ValueRef; index: cuint; a4: Attribute) {.
    importc: "LLVMRemoveInstrAttribute", dynlib: LLVMLib.}
proc setInstrParamAlignment*(instr: ValueRef; index: cuint; align: cuint) {.
    importc: "LLVMSetInstrParamAlignment", dynlib: LLVMLib.}
## *
##  Obtain whether a call instruction is a tail call.
## 
##  This only works on llvm::CallInst instructions.
## 
##  @see llvm::CallInst::isTailCall()
## 

proc isTailCall*(callInst: ValueRef): Bool {.importc: "LLVMIsTailCall",
    dynlib: LLVMLib.}
## *
##  Set whether a call instruction is a tail call.
## 
##  This only works on llvm::CallInst instructions.
## 
##  @see llvm::CallInst::setTailCall()
## 

proc setTailCall*(callInst: ValueRef; isTailCall: Bool) {.importc: "LLVMSetTailCall",
    dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @defgroup LLVMCCoreValueInstructionTerminator Terminators
## 
##  Functions in this group only apply to instructions that map to
##  llvm::TerminatorInst instances.
## 
##  @{
## 
## *
##  Return the number of successors that this terminator has.
## 
##  @see llvm::TerminatorInst::getNumSuccessors
## 

proc getNumSuccessors*(term: ValueRef): cuint {.importc: "LLVMGetNumSuccessors",
    dynlib: LLVMLib.}
## *
##  Return the specified successor.
## 
##  @see llvm::TerminatorInst::getSuccessor
## 

proc getSuccessor*(term: ValueRef; i: cuint): BasicBlockRef {.
    importc: "LLVMGetSuccessor", dynlib: LLVMLib.}
## *
##  Update the specified successor to point at the provided block.
## 
##  @see llvm::TerminatorInst::setSuccessor
## 

proc setSuccessor*(term: ValueRef; i: cuint; `block`: BasicBlockRef) {.
    importc: "LLVMSetSuccessor", dynlib: LLVMLib.}
## *
##  Return if a branch is conditional.
## 
##  This only works on llvm::BranchInst instructions.
## 
##  @see llvm::BranchInst::isConditional
## 

proc isConditional*(branch: ValueRef): Bool {.importc: "LLVMIsConditional",
    dynlib: LLVMLib.}
## *
##  Return the condition of a branch instruction.
## 
##  This only works on llvm::BranchInst instructions.
## 
##  @see llvm::BranchInst::getCondition
## 

proc getCondition*(branch: ValueRef): ValueRef {.importc: "LLVMGetCondition",
    dynlib: LLVMLib.}
## *
##  Set the condition of a branch instruction.
## 
##  This only works on llvm::BranchInst instructions.
## 
##  @see llvm::BranchInst::setCondition
## 

proc setCondition*(branch: ValueRef; cond: ValueRef) {.importc: "LLVMSetCondition",
    dynlib: LLVMLib.}
## *
##  Obtain the default destination basic block of a switch instruction.
## 
##  This only works on llvm::SwitchInst instructions.
## 
##  @see llvm::SwitchInst::getDefaultDest()
## 

proc getSwitchDefaultDest*(switchInstr: ValueRef): BasicBlockRef {.
    importc: "LLVMGetSwitchDefaultDest", dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @defgroup LLVMCCoreValueInstructionPHINode PHI Nodes
## 
##  Functions in this group only apply to instructions that map to
##  llvm::PHINode instances.
## 
##  @{
## 
## *
##  Add an incoming value to the end of a PHI list.
## 

proc addIncoming*(phiNode: ValueRef; incomingValues: ptr ValueRef;
                 incomingBlocks: ptr BasicBlockRef; count: cuint) {.
    importc: "LLVMAddIncoming", dynlib: LLVMLib.}
## *
##  Obtain the number of incoming basic blocks to a PHI node.
## 

proc countIncoming*(phiNode: ValueRef): cuint {.importc: "LLVMCountIncoming",
    dynlib: LLVMLib.}
## *
##  Obtain an incoming value to a PHI node as an LLVMValueRef.
## 

proc getIncomingValue*(phiNode: ValueRef; index: cuint): ValueRef {.
    importc: "LLVMGetIncomingValue", dynlib: LLVMLib.}
## *
##  Obtain an incoming value to a PHI node as an LLVMBasicBlockRef.
## 

proc getIncomingBlock*(phiNode: ValueRef; index: cuint): BasicBlockRef {.
    importc: "LLVMGetIncomingBlock", dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @}
## 
## *
##  @}
## 
## *
##  @defgroup LLVMCCoreInstructionBuilder Instruction Builders
## 
##  An instruction builder represents a point within a basic block and is
##  the exclusive means of building instructions using the C interface.
## 
##  @{
## 

proc createBuilderInContext*(c: ContextRef): BuilderRef {.
    importc: "LLVMCreateBuilderInContext", dynlib: LLVMLib.}
proc createBuilder*(): BuilderRef {.importc: "LLVMCreateBuilder", dynlib: LLVMLib.}
proc positionBuilder*(builder: BuilderRef; `block`: BasicBlockRef; instr: ValueRef) {.
    importc: "LLVMPositionBuilder", dynlib: LLVMLib.}
proc positionBuilderBefore*(builder: BuilderRef; instr: ValueRef) {.
    importc: "LLVMPositionBuilderBefore", dynlib: LLVMLib.}
proc positionBuilderAtEnd*(builder: BuilderRef; `block`: BasicBlockRef) {.
    importc: "LLVMPositionBuilderAtEnd", dynlib: LLVMLib.}
proc getInsertBlock*(builder: BuilderRef): BasicBlockRef {.
    importc: "LLVMGetInsertBlock", dynlib: LLVMLib.}
proc clearInsertionPosition*(builder: BuilderRef) {.
    importc: "LLVMClearInsertionPosition", dynlib: LLVMLib.}
proc insertIntoBuilder*(builder: BuilderRef; instr: ValueRef) {.
    importc: "LLVMInsertIntoBuilder", dynlib: LLVMLib.}
proc insertIntoBuilderWithName*(builder: BuilderRef; instr: ValueRef; name: cstring) {.
    importc: "LLVMInsertIntoBuilderWithName", dynlib: LLVMLib.}
proc disposeBuilder*(builder: BuilderRef) {.importc: "LLVMDisposeBuilder",
    dynlib: LLVMLib.}
##  Metadata

proc setCurrentDebugLocation*(builder: BuilderRef; L: ValueRef) {.
    importc: "LLVMSetCurrentDebugLocation", dynlib: LLVMLib.}
proc getCurrentDebugLocation*(builder: BuilderRef): ValueRef {.
    importc: "LLVMGetCurrentDebugLocation", dynlib: LLVMLib.}
proc setInstDebugLocation*(builder: BuilderRef; inst: ValueRef) {.
    importc: "LLVMSetInstDebugLocation", dynlib: LLVMLib.}
##  Terminators

proc buildRetVoid*(a2: BuilderRef): ValueRef {.importc: "LLVMBuildRetVoid",
    dynlib: LLVMLib.}
proc buildRet*(a2: BuilderRef; v: ValueRef): ValueRef {.importc: "LLVMBuildRet",
    dynlib: LLVMLib.}
proc buildAggregateRet*(a2: BuilderRef; retVals: ptr ValueRef; n: cuint): ValueRef {.
    importc: "LLVMBuildAggregateRet", dynlib: LLVMLib.}
proc buildBr*(a2: BuilderRef; dest: BasicBlockRef): ValueRef {.importc: "LLVMBuildBr",
    dynlib: LLVMLib.}
proc buildCondBr*(a2: BuilderRef; `if`: ValueRef; then: BasicBlockRef;
                 `else`: BasicBlockRef): ValueRef {.importc: "LLVMBuildCondBr",
    dynlib: LLVMLib.}
proc buildSwitch*(a2: BuilderRef; v: ValueRef; `else`: BasicBlockRef; numCases: cuint): ValueRef {.
    importc: "LLVMBuildSwitch", dynlib: LLVMLib.}
proc buildIndirectBr*(b: BuilderRef; `addr`: ValueRef; numDests: cuint): ValueRef {.
    importc: "LLVMBuildIndirectBr", dynlib: LLVMLib.}
proc buildInvoke*(a2: BuilderRef; fn: ValueRef; args: ptr ValueRef; numArgs: cuint;
                 then: BasicBlockRef; catch: BasicBlockRef; name: cstring): ValueRef {.
    importc: "LLVMBuildInvoke", dynlib: LLVMLib.}
proc buildLandingPad*(b: BuilderRef; ty: TypeRef; persFn: ValueRef; numClauses: cuint;
                     name: cstring): ValueRef {.importc: "LLVMBuildLandingPad",
    dynlib: LLVMLib.}
proc buildResume*(b: BuilderRef; exn: ValueRef): ValueRef {.
    importc: "LLVMBuildResume", dynlib: LLVMLib.}
proc buildUnreachable*(a2: BuilderRef): ValueRef {.importc: "LLVMBuildUnreachable",
    dynlib: LLVMLib.}
##  Add a case to the switch instruction

proc addCase*(switch: ValueRef; onVal: ValueRef; dest: BasicBlockRef) {.
    importc: "LLVMAddCase", dynlib: LLVMLib.}
##  Add a destination to the indirectbr instruction

proc addDestination*(indirectBr: ValueRef; dest: BasicBlockRef) {.
    importc: "LLVMAddDestination", dynlib: LLVMLib.}
##  Add a catch or filter clause to the landingpad instruction

proc addClause*(landingPad: ValueRef; clauseVal: ValueRef) {.
    importc: "LLVMAddClause", dynlib: LLVMLib.}
##  Set the 'cleanup' flag in the landingpad instruction

proc setCleanup*(landingPad: ValueRef; val: Bool) {.importc: "LLVMSetCleanup",
    dynlib: LLVMLib.}
##  Arithmetic

proc buildAdd*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildAdd", dynlib: LLVMLib.}
proc buildNSWAdd*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildNSWAdd", dynlib: LLVMLib.}
proc buildNUWAdd*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildNUWAdd", dynlib: LLVMLib.}
proc buildFAdd*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildFAdd", dynlib: LLVMLib.}
proc buildSub*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildSub", dynlib: LLVMLib.}
proc buildNSWSub*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildNSWSub", dynlib: LLVMLib.}
proc buildNUWSub*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildNUWSub", dynlib: LLVMLib.}
proc buildFSub*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildFSub", dynlib: LLVMLib.}
proc buildMul*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildMul", dynlib: LLVMLib.}
proc buildNSWMul*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildNSWMul", dynlib: LLVMLib.}
proc buildNUWMul*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildNUWMul", dynlib: LLVMLib.}
proc buildFMul*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildFMul", dynlib: LLVMLib.}
proc buildUDiv*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildUDiv", dynlib: LLVMLib.}
proc buildSDiv*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildSDiv", dynlib: LLVMLib.}
proc buildExactSDiv*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildExactSDiv", dynlib: LLVMLib.}
proc buildFDiv*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildFDiv", dynlib: LLVMLib.}
proc buildURem*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildURem", dynlib: LLVMLib.}
proc buildSRem*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildSRem", dynlib: LLVMLib.}
proc buildFRem*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildFRem", dynlib: LLVMLib.}
proc buildShl*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildShl", dynlib: LLVMLib.}
proc buildLShr*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildLShr", dynlib: LLVMLib.}
proc buildAShr*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildAShr", dynlib: LLVMLib.}
proc buildAnd*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildAnd", dynlib: LLVMLib.}
proc buildOr*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildOr", dynlib: LLVMLib.}
proc buildXor*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildXor", dynlib: LLVMLib.}
proc buildBinOp*(b: BuilderRef; op: Opcode; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildBinOp", dynlib: LLVMLib.}
proc buildNeg*(a2: BuilderRef; v: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildNeg", dynlib: LLVMLib.}
proc buildNSWNeg*(b: BuilderRef; v: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildNSWNeg", dynlib: LLVMLib.}
proc buildNUWNeg*(b: BuilderRef; v: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildNUWNeg", dynlib: LLVMLib.}
proc buildFNeg*(a2: BuilderRef; v: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildFNeg", dynlib: LLVMLib.}
proc buildNot*(a2: BuilderRef; v: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildNot", dynlib: LLVMLib.}
##  Memory

proc buildMalloc*(a2: BuilderRef; ty: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildMalloc", dynlib: LLVMLib.}
proc buildArrayMalloc*(a2: BuilderRef; ty: TypeRef; val: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildArrayMalloc", dynlib: LLVMLib.}
proc buildAlloca*(a2: BuilderRef; ty: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildAlloca", dynlib: LLVMLib.}
proc buildArrayAlloca*(a2: BuilderRef; ty: TypeRef; val: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildArrayAlloca", dynlib: LLVMLib.}
proc buildFree*(a2: BuilderRef; pointerVal: ValueRef): ValueRef {.
    importc: "LLVMBuildFree", dynlib: LLVMLib.}
proc buildLoad*(a2: BuilderRef; pointerVal: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildLoad", dynlib: LLVMLib.}
proc buildStore*(a2: BuilderRef; val: ValueRef; `ptr`: ValueRef): ValueRef {.
    importc: "LLVMBuildStore", dynlib: LLVMLib.}
proc buildGEP*(b: BuilderRef; pointer: ValueRef; indices: ptr ValueRef;
              numIndices: cuint; name: cstring): ValueRef {.importc: "LLVMBuildGEP",
    dynlib: LLVMLib.}
proc buildInBoundsGEP*(b: BuilderRef; pointer: ValueRef; indices: ptr ValueRef;
                      numIndices: cuint; name: cstring): ValueRef {.
    importc: "LLVMBuildInBoundsGEP", dynlib: LLVMLib.}
proc buildStructGEP*(b: BuilderRef; pointer: ValueRef; idx: cuint; name: cstring): ValueRef {.
    importc: "LLVMBuildStructGEP", dynlib: LLVMLib.}
proc buildGlobalString*(b: BuilderRef; str: cstring; name: cstring): ValueRef {.
    importc: "LLVMBuildGlobalString", dynlib: LLVMLib.}
proc buildGlobalStringPtr*(b: BuilderRef; str: cstring; name: cstring): ValueRef {.
    importc: "LLVMBuildGlobalStringPtr", dynlib: LLVMLib.}
proc getVolatile*(memoryAccessInst: ValueRef): Bool {.importc: "LLVMGetVolatile",
    dynlib: LLVMLib.}
proc setVolatile*(memoryAccessInst: ValueRef; isVolatile: Bool) {.
    importc: "LLVMSetVolatile", dynlib: LLVMLib.}
##  Casts

proc buildTrunc*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildTrunc", dynlib: LLVMLib.}
proc buildZExt*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildZExt", dynlib: LLVMLib.}
proc buildSExt*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildSExt", dynlib: LLVMLib.}
proc buildFPToUI*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildFPToUI", dynlib: LLVMLib.}
proc buildFPToSI*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildFPToSI", dynlib: LLVMLib.}
proc buildUIToFP*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildUIToFP", dynlib: LLVMLib.}
proc buildSIToFP*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildSIToFP", dynlib: LLVMLib.}
proc buildFPTrunc*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildFPTrunc", dynlib: LLVMLib.}
proc buildFPExt*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildFPExt", dynlib: LLVMLib.}
proc buildPtrToInt*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildPtrToInt", dynlib: LLVMLib.}
proc buildIntToPtr*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildIntToPtr", dynlib: LLVMLib.}
proc buildBitCast*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildBitCast", dynlib: LLVMLib.}
proc buildAddrSpaceCast*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildAddrSpaceCast", dynlib: LLVMLib.}
proc buildZExtOrBitCast*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildZExtOrBitCast", dynlib: LLVMLib.}
proc buildSExtOrBitCast*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildSExtOrBitCast", dynlib: LLVMLib.}
proc buildTruncOrBitCast*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildTruncOrBitCast", dynlib: LLVMLib.}
proc buildCast*(b: BuilderRef; op: Opcode; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildCast", dynlib: LLVMLib.}
proc buildPointerCast*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildPointerCast", dynlib: LLVMLib.}
proc buildIntCast*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildIntCast", dynlib: LLVMLib.}
  ## Signed cast!
proc buildFPCast*(a2: BuilderRef; val: ValueRef; destTy: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildFPCast", dynlib: LLVMLib.}
##  Comparisons

proc buildICmp*(a2: BuilderRef; op: IntPredicate; lhs: ValueRef; rhs: ValueRef;
               name: cstring): ValueRef {.importc: "LLVMBuildICmp", dynlib: LLVMLib.}
proc buildFCmp*(a2: BuilderRef; op: RealPredicate; lhs: ValueRef; rhs: ValueRef;
               name: cstring): ValueRef {.importc: "LLVMBuildFCmp", dynlib: LLVMLib.}
##  Miscellaneous instructions

proc buildPhi*(a2: BuilderRef; ty: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildPhi", dynlib: LLVMLib.}
proc buildCall*(a2: BuilderRef; fn: ValueRef; args: ptr ValueRef; numArgs: cuint;
               name: cstring): ValueRef {.importc: "LLVMBuildCall", dynlib: LLVMLib.}
proc buildSelect*(a2: BuilderRef; `if`: ValueRef; then: ValueRef; `else`: ValueRef;
                 name: cstring): ValueRef {.importc: "LLVMBuildSelect",
    dynlib: LLVMLib.}
proc buildVAArg*(a2: BuilderRef; list: ValueRef; ty: TypeRef; name: cstring): ValueRef {.
    importc: "LLVMBuildVAArg", dynlib: LLVMLib.}
proc buildExtractElement*(a2: BuilderRef; vecVal: ValueRef; index: ValueRef;
                         name: cstring): ValueRef {.
    importc: "LLVMBuildExtractElement", dynlib: LLVMLib.}
proc buildInsertElement*(a2: BuilderRef; vecVal: ValueRef; eltVal: ValueRef;
                        index: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildInsertElement", dynlib: LLVMLib.}
proc buildShuffleVector*(a2: BuilderRef; v1: ValueRef; v2: ValueRef; mask: ValueRef;
                        name: cstring): ValueRef {.
    importc: "LLVMBuildShuffleVector", dynlib: LLVMLib.}
proc buildExtractValue*(a2: BuilderRef; aggVal: ValueRef; index: cuint; name: cstring): ValueRef {.
    importc: "LLVMBuildExtractValue", dynlib: LLVMLib.}
proc buildInsertValue*(a2: BuilderRef; aggVal: ValueRef; eltVal: ValueRef;
                      index: cuint; name: cstring): ValueRef {.
    importc: "LLVMBuildInsertValue", dynlib: LLVMLib.}
proc buildIsNull*(a2: BuilderRef; val: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildIsNull", dynlib: LLVMLib.}
proc buildIsNotNull*(a2: BuilderRef; val: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildIsNotNull", dynlib: LLVMLib.}
proc buildPtrDiff*(a2: BuilderRef; lhs: ValueRef; rhs: ValueRef; name: cstring): ValueRef {.
    importc: "LLVMBuildPtrDiff", dynlib: LLVMLib.}
proc buildFence*(b: BuilderRef; ordering: AtomicOrdering; singleThread: Bool;
                name: cstring): ValueRef {.importc: "LLVMBuildFence", dynlib: LLVMLib.}
proc buildAtomicRMW*(b: BuilderRef; op: AtomicRMWBinOp; `ptr`: ValueRef; val: ValueRef;
                    ordering: AtomicOrdering; singleThread: Bool): ValueRef {.
    importc: "LLVMBuildAtomicRMW", dynlib: LLVMLib.}
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

proc createModuleProviderForExistingModule*(m: ModuleRef): ModuleProviderRef {.
    importc: "LLVMCreateModuleProviderForExistingModule", dynlib: LLVMLib.}
## *
##  Destroys the module M.
## 

proc disposeModuleProvider*(m: ModuleProviderRef) {.
    importc: "LLVMDisposeModuleProvider", dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @defgroup LLVMCCoreMemoryBuffers Memory Buffers
## 
##  @{
## 

proc createMemoryBufferWithContentsOfFile*(path: cstring;
    outMemBuf: ptr MemoryBufferRef; outMessage: cstringArray): Bool {.
    importc: "LLVMCreateMemoryBufferWithContentsOfFile", dynlib: LLVMLib.}
proc createMemoryBufferWithSTDIN*(outMemBuf: ptr MemoryBufferRef;
                                 outMessage: cstringArray): Bool {.
    importc: "LLVMCreateMemoryBufferWithSTDIN", dynlib: LLVMLib.}
proc createMemoryBufferWithMemoryRange*(inputData: cstring; inputDataLength: csize;
                                       bufferName: cstring;
                                       requiresNullTerminator: Bool): MemoryBufferRef {.
    importc: "LLVMCreateMemoryBufferWithMemoryRange", dynlib: LLVMLib.}
proc createMemoryBufferWithMemoryRangeCopy*(inputData: cstring;
    inputDataLength: csize; bufferName: cstring): MemoryBufferRef {.
    importc: "LLVMCreateMemoryBufferWithMemoryRangeCopy", dynlib: LLVMLib.}
proc getBufferStart*(memBuf: MemoryBufferRef): cstring {.
    importc: "LLVMGetBufferStart", dynlib: LLVMLib.}
proc getBufferSize*(memBuf: MemoryBufferRef): csize {.importc: "LLVMGetBufferSize",
    dynlib: LLVMLib.}
proc disposeMemoryBuffer*(memBuf: MemoryBufferRef) {.
    importc: "LLVMDisposeMemoryBuffer", dynlib: LLVMLib.}
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

proc getGlobalPassRegistry*(): PassRegistryRef {.
    importc: "LLVMGetGlobalPassRegistry", dynlib: LLVMLib.}
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

proc createPassManager*(): PassManagerRef {.importc: "LLVMCreatePassManager",
    dynlib: LLVMLib.}
## * Constructs a new function-by-function pass pipeline over the module
##     provider. It does not take ownership of the module provider. This type of
##     pipeline is suitable for code generation and JIT compilation tasks.
##     @see llvm::FunctionPassManager::FunctionPassManager

proc createFunctionPassManagerForModule*(m: ModuleRef): PassManagerRef {.
    importc: "LLVMCreateFunctionPassManagerForModule", dynlib: LLVMLib.}
## * Deprecated: Use LLVMCreateFunctionPassManagerForModule instead.

proc createFunctionPassManager*(mp: ModuleProviderRef): PassManagerRef {.
    importc: "LLVMCreateFunctionPassManager", dynlib: LLVMLib.}
## * Initializes, executes on the provided module, and finalizes all of the
##     passes scheduled in the pass manager. Returns 1 if any of the passes
##     modified the module, 0 otherwise.
##     @see llvm::PassManager::run(Module&)

proc runPassManager*(pm: PassManagerRef; m: ModuleRef): Bool {.
    importc: "LLVMRunPassManager", dynlib: LLVMLib.}
## * Initializes all of the function passes scheduled in the function pass
##     manager. Returns 1 if any of the passes modified the module, 0 otherwise.
##     @see llvm::FunctionPassManager::doInitialization

proc initializeFunctionPassManager*(fpm: PassManagerRef): Bool {.
    importc: "LLVMInitializeFunctionPassManager", dynlib: LLVMLib.}
## * Executes all of the function passes scheduled in the function pass manager
##     on the provided function. Returns 1 if any of the passes modified the
##     function, false otherwise.
##     @see llvm::FunctionPassManager::run(Function&)

proc runFunctionPassManager*(fpm: PassManagerRef; f: ValueRef): Bool {.
    importc: "LLVMRunFunctionPassManager", dynlib: LLVMLib.}
## * Finalizes all of the function passes scheduled in in the function pass
##     manager. Returns 1 if any of the passes modified the module, 0 otherwise.
##     @see llvm::FunctionPassManager::doFinalization

proc finalizeFunctionPassManager*(fpm: PassManagerRef): Bool {.
    importc: "LLVMFinalizeFunctionPassManager", dynlib: LLVMLib.}
## * Frees the memory of a pass pipeline. For function pipelines, does not free
##     the module provider.
##     @see llvm::PassManagerBase::~PassManagerBase.

proc disposePassManager*(pm: PassManagerRef) {.importc: "LLVMDisposePassManager",
    dynlib: LLVMLib.}
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

proc startMultithreaded*(): Bool {.importc: "LLVMStartMultithreaded", dynlib: LLVMLib.}
## * Deprecated: Multi-threading can only be enabled/disabled with the compile
##     time define LLVM_ENABLE_THREADS.

proc stopMultithreaded*() {.importc: "LLVMStopMultithreaded", dynlib: LLVMLib.}
## * Check whether LLVM is executing in thread-safe mode or not.
##     @see llvm::llvm_is_multithreaded

proc isMultithreaded*(): Bool {.importc: "LLVMIsMultithreaded", dynlib: LLVMLib.}
## *
##  @}
## 
## *
##  @}
## 
## *
##  @}
## 
