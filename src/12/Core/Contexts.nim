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

proc ContextCreate*(): ContextRef {.llvmc.}
## *
##  Obtain the global context instance.
##

proc GetGlobalContext*(): ContextRef {.llvmc.}
## *
##  Set the diagnostic handler for this context.
##

proc ContextSetDiagnosticHandler*(c: ContextRef; handler: DiagnosticHandler;
                                 diagnosticContext: pointer) {.llvmc.}
## *
##  Get the diagnostic handler of this context.
##

proc ContextGetDiagnosticHandler*(c: ContextRef): DiagnosticHandler {.llvmc.}
## *
##  Get the diagnostic context of this context.
##

proc ContextGetDiagnosticContext*(c: ContextRef): pointer {.llvmc.}
## *
##  Set the yield callback function for this context.
##
##  @see LLVMContext::setYieldCallback()
##

proc ContextSetYieldCallback*(c: ContextRef; callback: YieldCallback;
                             opaqueHandle: pointer) {.llvmc.}

## Retrieve whether the given context is set to discard all value names.
proc ContextShouldDiscardValueNames*(c: ContextRef): Bool {.llvmc.}

## Set whether the given context discards all value names.
##
## If true, only the names of GlobalValue objects will be available in the IR.
## This can be used to save memory and runtime, especially in release mode.
proc ContextSetDiscardValueNames*(c: ContextRef, isDiscard: Bool) {.llvmc.}
## *
##  Destroy a context instance.
##
##  This should be called for every call to LLVMContextCreate() or memory
##  will be leaked.
##

proc ContextDispose*(c: ContextRef) {.llvmc.}
## *
##  Return a string representation of the DiagnosticInfo. Use
##  LLVMDisposeMessage to free the string.
##
##  @see DiagnosticInfo::print()
##

proc GetDiagInfoDescription*(di: DiagnosticInfoRef): cstring {.llvmc.}
## *
##  Return an enum LLVMDiagnosticSeverity.
##
##  @see DiagnosticInfo::getSeverity()
##

proc GetDiagInfoSeverity*(di: DiagnosticInfoRef): DiagnosticSeverity {.llvmc.}
proc GetMDKindIDInContext*(c: ContextRef; name: cstring; sLen: cuint): cuint {.llvmc.}
proc GetMDKindID*(name: cstring; sLen: cuint): cuint {.llvmc.}
## *
##  Return an unique id given the name of a enum attribute,
##  or 0 if no attribute by that name exists.
##
##  See http://llvm.org/docs/LangRef.html#parameter-attributes
##  and http://llvm.org/docs/LangRef.html#function-attributes
##  for the list of available attributes.
##
##  NB: Attribute names and/or id are subject to change without
##  going through the C API deprecation cycle.
##

proc GetEnumAttributeKindForName*(name: cstring; sLen: csize_t): cuint {.llvmc.}
proc GetLastEnumAttributeKind*(): cuint {.llvmc.}
## *
##  Create an enum attribute.
##

proc CreateEnumAttribute*(c: ContextRef; kindID: cuint; val: uint64): AttributeRef {.llvmc.}
## *
##  Get the unique id corresponding to the enum attribute
##  passed as argument.
##

proc GetEnumAttributeKind*(a: AttributeRef): cuint {.llvmc.}
## *
##  Get the enum attribute's value. 0 is returned if none exists.
##

proc GetEnumAttributeValue*(a: AttributeRef): uint64 {.llvmc.}
## *
##  Create a string attribute.
##

proc CreateStringAttribute*(c: ContextRef; k: cstring; kLength: cuint; v: cstring;
                           vLength: cuint): AttributeRef {.llvmc.}
## *
##  Get the string attribute's kind.
##

proc GetStringAttributeKind*(a: AttributeRef; length: ptr cuint): cstring {.llvmc.}
## *
##  Get the string attribute's value.
##

proc GetStringAttributeValue*(a: AttributeRef; length: ptr cuint): cstring {.llvmc.}
## *
##  Check for the different types of attributes.
##

proc IsEnumAttribute*(a: AttributeRef): Bool {.llvmc.}
proc IsStringAttribute*(a: AttributeRef): Bool {.llvmc.}

proc IsTypeAttribute*(a:AttributeRef): Bool {.llvmc.}

## Obtain a Type from a context by its registered name
proc GetTypeByName2*(c: ContextRef, name: cstring): TypeRef {.llvmc.}
## *
##  @}
##