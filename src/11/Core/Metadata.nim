## *
##  @defgroup LLVMCCoreValueMetadata Metadata
##
##  @{
##


## Create an MDString value from a given string value
proc MDStringInContext2*(c: ContextRef, str: cstring, sLen: csize_t): MetadataRef {.llvmc.}

## Create an MDNode value with the given array of operands
proc MDNodeInContext2*(c: ContextRef, mds: ptr MetadataRef, count: csize_t): MetadataRef {.llvmc.}

## *
##  Obtain a Metadata as a Value.
##

proc MetadataAsValue*(c: ContextRef; md: MetadataRef): ValueRef {.llvmc.}
## *
##  Obtain a Value as a Metadata.
##

proc ValueAsMetadata*(val: ValueRef): MetadataRef {.llvmc.}
## *
##  Obtain the underlying string from a MDString value.
##
##  @param V Instance to obtain string from.
##  @param Length Memory address which will hold length of returned string.
##  @return String data in MDString.
##

proc GetMDString*(v: ValueRef; length: ptr cuint): cstring {.llvmc.}
## *
##  Obtain the number of operands from an MDNode value.
##
##  @param V MDNode to get number of operands from.
##  @return Number of operands of the MDNode.
##

proc GetMDNodeNumOperands*(v: ValueRef): cuint {.llvmc.}
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

proc GetMDNodeOperands*(v: ValueRef; dest: ptr ValueRef) {.llvmc.}

## *
##  Obtain a MDString value from a context.
##
##  The returned instance corresponds to the llvm::MDString class.
##
##  The instance is specified by string data of a specified length. The
##  string content is copied, so the backing memory can be freed after
##  this function returns.
##

proc MDStringInContext*(c: ContextRef; str: cstring; sLen: cuint): ValueRef {.llvmc, deprecated.}
## *
##  Obtain a MDString value from the global context.
##

proc MDString*(str: cstring; sLen: cuint): ValueRef {.llvmc, deprecated.}
## *
##  Obtain a MDNode value from a context.
##
##  The returned value corresponds to the llvm::MDNode class.
##

proc MDNodeInContext*(c: ContextRef; vals: ptr ValueRef; count: cuint): ValueRef {.llvmc, deprecated.}
## *
##  Obtain a MDNode value from the global context.
##

proc MDNode*(vals: ptr ValueRef; count: cuint): ValueRef {.llvmc, deprecated.}