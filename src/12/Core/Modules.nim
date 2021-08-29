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

proc ModuleCreateWithName*(moduleID: cstring): ModuleRef {.llvmc.}
## *
##  Create a new, empty module in a specific context.
##
##  Every invocation should be paired with LLVMDisposeModule() or memory
##  will be leaked.
##

proc ModuleCreateWithNameInContext*(moduleID: cstring; c: ContextRef): ModuleRef {.llvmc.}
## *
##  Return an exact copy of the specified module.
##

proc CloneModule*(m: ModuleRef): ModuleRef {.llvmc.}
## *
##  Destroy a module instance.
##
##  This must be called for every created module or memory will be
##  leaked.
##

proc DisposeModule*(m: ModuleRef) {.llvmc.}
## *
##  Obtain the identifier of a module.
##
##  @param M Module to obtain identifier of
##  @param Len Out parameter which holds the length of the returned string.
##  @return The identifier of M.
##  @see Module::getModuleIdentifier()
##

proc GetModuleIdentifier*(m: ModuleRef; len: ptr csize_t): cstring {.llvmc.}
## *
##  Set the identifier of a module to a string Ident with length Len.
##
##  @param M The module to set identifier
##  @param Ident The string to set M's identifier to
##  @param Len Length of Ident
##  @see Module::setModuleIdentifier()
##

proc SetModuleIdentifier*(m: ModuleRef; ident: cstring; len: csize_t) {.llvmc.}

## Obtain the module's original source file name
proc GetSourceFileName*(m: ModuleRef, len: csize_t): cstring {.llvmc.}

## Set the original source file name of a module to a string Name with length Len
proc SetSourceFileName*(m: ModuleRef, name: cstring, len: csize_t) {.llvmc.}

## *
##  Obtain the data layout for a module.
##
##  @see Module::getDataLayoutStr()
##
##  LLVMGetDataLayout is DEPRECATED, as the name is not only incorrect,
##  but match the name of another method on the module. Prefer the use
##  of LLVMGetDataLayoutStr, which is not ambiguous.
##

proc GetDataLayoutStr*(m: ModuleRef): cstring {.llvmc.}
proc GetDataLayout*(m: ModuleRef): cstring {.llvmc.}
## *
##  Set the data layout for a module.
##
##  @see Module::setDataLayout()
##

proc SetDataLayout*(m: ModuleRef; dataLayoutStr: cstring) {.llvmc.}
## *
##  Obtain the target triple for a module.
##
##  @see Module::getTargetTriple()
##

proc GetTarget*(m: ModuleRef): cstring {.llvmc.}
## *
##  Set the target triple for a module.
##
##  @see Module::setTargetTriple()
##

proc SetTarget*(m: ModuleRef; triple: cstring) {.llvmc.}
## *
##  Dump a representation of a module to stderr.
##
##  @see Module::dump()
##

## Returns the module flags as an array of flag-key-value triples
proc CopyModuleFlagsMetadata*(m: ModuleRef, len: csize_t): ModuleFlagEntry {.llvmc.}


## Destroys module flags metadata entries
proc DisposeModuleFlagsMetadata*(entries: ModuleFlagEntry) {.llvmc.}

## Returns the flag behavior for a module flag entry at a specific index
proc ModuleFlagEntriesGetFlagBehavior*(entries: ModuleFlagEntry, index: cuint): ModuleFlagBehavior {.llvmc.}

## Returns the key for a module flag entry at a specific index
proc ModuleFlagEntriesGetKey*(entries: ModuleFlagEntry, index: cuint, len:  csize_t): cstring {.llvmc.}

## Returns the metadata for a module flag entry at a specific index
proc ModuleFlagEntriesGetMetadata*(entries: ModuleFlagEntry, index: cuint): MetadataRef {.llvmc.}

## Add a module-level flag to the module-level flags metadata if it doesn't already exist
proc GetModuleFlag*(m: ModuleRef, key: cstring, keyLen: csize_t): MetadataRef {.llvmc.}

## Add a module-level flag to the module-level flags metadata if it doesn't already exist
proc AddModuleFlag*(m: ModuleRef, behavior: ModuleFlagBehavior, key: cstring, keyLen: csize_t, val: MetadataRef) {.llvmc.}

proc DumpModule*(m: ModuleRef) {.llvmc.}
## *
##  Print a representation of a module to a file. The ErrorMessage needs to be
##  disposed with LLVMDisposeMessage. Returns 0 on success, 1 otherwise.
##
##  @see Module::print()
##

proc PrintModuleToFile*(m: ModuleRef; filename: cstring; errorMessage: cstringArray): Bool {.llvmc.}
## *
##  Return a string representation of the module. Use
##  LLVMDisposeMessage to free the string.
##
##  @see Module::print()
##

proc PrintModuleToString*(m: ModuleRef): cstring {.llvmc.}
## *
##  Set inline assembly for a module.
##
##  @see Module::setModuleInlineAsm()
##

## Get inline assembly for a module
proc GetModuleInlineAsm*(m: ModuleRef, len: csize_t): cstring {.llvmc.}

## Set inline assembly for a module
proc SetModuleInlineAsm2*(m: ModuleRef; code: cstring, len: csize_t) {.llvmc.}

## Append inline assembly to a module
proc AppendModuleInlineAsm*(m: ModuleRef, code: cstring, len: csize_t) {.llvmc.}

## Create the specified uniqued inline asm string
proc GetInlineAsm*(ty: TypeRef, asmString: cstring, asmStringSize: csize_t, constraints: cstring,
    constraintsSize: csize_t, hasSideEffects: Bool, isAlignStack: Bool, dialect: InlineAsmDialect): ValueRef {.llvmc.}

## *
##  Obtain the context to which this module is associated.
##
##  @see Module::getContext()
##

proc GetModuleContext*(m: ModuleRef): ContextRef {.llvmc.}
## *
##  Obtain a Type from a module by its registered name.
##

proc GetTypeByName*(m: ModuleRef; name: cstring): TypeRef {.llvmc.}
## *
##  Obtain the number of operands for named metadata in a module.
##
##  @see llvm::Module::getNamedMetadata()
##

## Obtain an iterator to the first NamedMDNode in a Module
proc GetFirstNamedMetadata*(m: ModuleRef): NamedMDNodeRef {.llvmc.}

## Obtain an iterator to the last NamedMDNode in a Module
proc GetLastNamedMetadata*(m: ModuleRef): NamedMDNodeRef {.llvmc.}

## Advance a NamedMDNode iterator to the next NamedMDNode
proc GetNextNamedMetadata*(namedMDNode: NamedMDNodeRef): NamedMDNodeRef {.llvmc.}

## Decrement a NamedMDNode iterator to the previous NamedMDNode
proc GetPreviousNamedMetadataa*(namedMDNode: NamedMDNodeRef ): NamedMDNodeRef {.llvmc.}

## Retrieve a NamedMDNode with the given name, returning NULL if no such node exists
proc GetNamedMetadata*(m: ModuleRef, name: cstring, nameLen: csize_t): NamedMDNodeRef {.llvmc.}

## Retrieve a NamedMDNode with the given name, creating a new node if no such node exists
proc GetOrInsertNamedMetadata*(m: ModuleRef, name: cstring, nameLen: csize_t): NamedMDNodeRef {.llvmc.}

## Retrieve the name of a NamedMDNode
proc GetNamedMetadataName*(namedMD: NamedMDNodeRef, nameLen: csize_t): cstring {.llvmc.}

proc GetNamedMetadataNumOperands*(m: ModuleRef; name: cstring): cuint {.llvmc.}
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

proc GetNamedMetadataOperands*(m: ModuleRef; name: cstring; dest: ptr ValueRef) {.llvmc.}
## *
##  Add an operand to named metadata.
##
##  @see llvm::Module::getNamedMetadata()
##  @see llvm::MDNode::addOperand()
##

proc AddNamedMetadataOperand*(m: ModuleRef; name: cstring; val: ValueRef) {.llvmc.}
## *
##  Add a function to a module under a specified name.
##
##  @see llvm::Function::Create()
##

## Return the directory of the debug location for this value, which must be an llvm::Instruction, llvm::GlobalVariable, or llvm::Function
proc GetDebugLocDirectory*(val: ValueRef, length: cuint): cstring {.llvmc.}

## Return the filename of the debug location for this value, which must be an llvm::Instruction, llvm::GlobalVariable, or llvm::Function
proc GetDebugLocFilename*(val: ValueRef, length: cuint): cstring {.llvmc.}

## Return the line number of the debug location for this value, which must be an llvm::Instruction, llvm::GlobalVariable, or llvm::Function
proc GetDebugLocLine*(val: ValueRef): cuint {.llvmc.}

## Return the column number of the debug location for this value, which must be an llvm::Instruction
proc GetDebugLocColumn*(val: ValueRef): cuint {.llvmc.}

proc AddFunction*(m: ModuleRef; name: cstring; functionTy: TypeRef): ValueRef {.llvmc.}
## *
##  Obtain a Function value from a Module by its name.
##
##  The returned value corresponds to a llvm::Function value.
##
##  @see llvm::Module::getFunction()
##

proc GetNamedFunction*(m: ModuleRef; name: cstring): ValueRef {.llvmc.}
## *
##  Obtain an iterator to the first Function in a Module.
##
##  @see llvm::Module::begin()
##

proc GetFirstFunction*(m: ModuleRef): ValueRef {.llvmc.}
## *
##  Obtain an iterator to the last Function in a Module.
##
##  @see llvm::Module::end()
##

proc GetLastFunction*(m: ModuleRef): ValueRef {.llvmc.}
## *
##  Advance a Function iterator to the next Function.
##
##  Returns NULL if the iterator was already at the end and there are no more
##  functions.
##

proc GetNextFunction*(fn: ValueRef): ValueRef {.llvmc.}
## *
##  Decrement a Function iterator to the previous Function.
##
##  Returns NULL if the iterator was already at the beginning and there are
##  no previous functions.
##

proc GetPreviousFunction*(fn: ValueRef): ValueRef {.llvmc.}

## Use LLVMSetModuleInlineAsm2 instead
proc SetModuleInlineAsm*(m: ModuleRef, code: cstring) {.llvmc, deprecated.}