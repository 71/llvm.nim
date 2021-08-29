
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

proc GetTypeKind*(ty: TypeRef): TypeKind {.llvmc.}
## *
##  Whether the type has a known size.
##
##  Things that don't have a size are abstract types, labels, and void.a
##
##  @see llvm::Type::isSized()
##

proc TypeIsSized*(ty: TypeRef): Bool {.llvmc.}
## *
##  Obtain the context to which this type instance is associated.
##
##  @see llvm::Type::getContext()
##

proc GetTypeContext*(ty: TypeRef): ContextRef {.llvmc.}
## *
##  Dump a representation of a type to stderr.
##
##  @see llvm::Type::dump()
##

when canDumpType:
  proc DumpType*(val: TypeRef) {.llvmc.}
  ## *
  ##  Return a string representation of the type. Use
  ##  LLVMDisposeMessage to free the string.
  ##
  ##  @see llvm::Type::print()
  ##

proc PrintTypeToString*(val: TypeRef): cstring {.llvmc.}
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

proc Int1TypeInContext*(c: ContextRef): TypeRef {.llvmc.}
proc Int8TypeInContext*(c: ContextRef): TypeRef {.llvmc.}
proc Int16TypeInContext*(c: ContextRef): TypeRef {.llvmc.}
proc Int32TypeInContext*(c: ContextRef): TypeRef {.llvmc.}
proc Int64TypeInContext*(c: ContextRef): TypeRef {.llvmc.}
proc Int128TypeInContext*(c: ContextRef): TypeRef {.llvmc.}
proc IntTypeInContext*(c: ContextRef; numBits: cuint): TypeRef {.llvmc.}
## *
##  Obtain an integer type from the global context with a specified bit
##  width.
##

proc Int1Type*(): TypeRef {.llvmc.}
proc Int8Type*(): TypeRef {.llvmc.}
proc Int16Type*(): TypeRef {.llvmc.}
proc Int32Type*(): TypeRef {.llvmc.}
proc Int64Type*(): TypeRef {.llvmc.}
proc Int128Type*(): TypeRef {.llvmc.}
proc IntType*(numBits: cuint): TypeRef {.llvmc.}
proc GetIntTypeWidth*(integerTy: TypeRef): cuint {.llvmc.}
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

proc HalfTypeInContext*(c: ContextRef): TypeRef {.llvmc.}

proc BFloatTypeInContext*(c: ContextRef): TypeRef {.llvmc.}

## *
##  Obtain a 32-bit floating point type from a context.
##

proc FloatTypeInContext*(c: ContextRef): TypeRef {.llvmc.}
## *
##  Obtain a 64-bit floating point type from a context.
##

proc DoubleTypeInContext*(c: ContextRef): TypeRef {.llvmc.}
## *
##  Obtain a 80-bit floating point type (X87) from a context.
##

proc X86FP80TypeInContext*(c: ContextRef): TypeRef {.llvmc.}
## *
##  Obtain a 128-bit floating point type (112-bit mantissa) from a
##  context.
##

proc FP128TypeInContext*(c: ContextRef): TypeRef {.llvmc.}
## *
##  Obtain a 128-bit floating point type (two 64-bits) from a context.
##

proc PPCFP128TypeInContext*(c: ContextRef): TypeRef {.llvmc.}
## *
##  Obtain a floating point type from the global context.
##
##  These map to the functions in this group of the same name.
##

proc HalfType*(): TypeRef {.llvmc.}
proc BFloatType*(): TypeRef {.llvmc.}
proc FloatType*(): TypeRef {.llvmc.}
proc DoubleType*(): TypeRef {.llvmc.}
proc X86FP80Type*(): TypeRef {.llvmc.}
proc FP128Type*(): TypeRef {.llvmc.}
proc PPCFP128Type*(): TypeRef {.llvmc.}
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

proc FunctionType*(returnType: TypeRef; paramTypes: ptr TypeRef; paramCount: cuint;
                  isVarArg: Bool): TypeRef {.llvmc.}
## *
##  Returns whether a function type is variadic.
##

proc IsFunctionVarArg*(functionTy: TypeRef): Bool {.llvmc.}
## *
##  Obtain the Type this function Type returns.
##

proc GetReturnType*(functionTy: TypeRef): TypeRef {.llvmc.}
## *
##  Obtain the number of parameters this function accepts.
##

proc CountParamTypes*(functionTy: TypeRef): cuint {.llvmc.}
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

proc GetParamTypes*(functionTy: TypeRef; dest: ptr TypeRef) {.llvmc.}
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

proc StructTypeInContext*(c: ContextRef; elementTypes: ptr TypeRef;
                         elementCount: cuint; packed: Bool): TypeRef {.llvmc.}
## *
##  Create a new structure type in the global context.
##
##  @see llvm::StructType::create()
##

proc StructType*(elementTypes: ptr TypeRef; elementCount: cuint; packed: Bool): TypeRef {.llvmc.}
## *
##  Create an empty structure in a context having a specified name.
##
##  @see llvm::StructType::create()
##

proc StructCreateNamed*(c: ContextRef; name: cstring): TypeRef {.llvmc.}
## *
##  Obtain the name of a structure.
##
##  @see llvm::StructType::getName()
##

proc GetStructName*(ty: TypeRef): cstring {.llvmc.}
## *
##  Set the contents of a structure type.
##
##  @see llvm::StructType::setBody()
##

proc StructSetBody*(structTy: TypeRef; elementTypes: ptr TypeRef; elementCount: cuint;
                   packed: Bool) {.llvmc.}
## *
##  Get the number of elements defined inside the structure.
##
##  @see llvm::StructType::getNumElements()
##

proc CountStructElementTypes*(structTy: TypeRef): cuint {.llvmc.}
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

proc GetStructElementTypes*(structTy: TypeRef; dest: ptr TypeRef) {.llvmc.}
## *
##  Get the type of the element at a given index in the structure.
##
##  @see llvm::StructType::getTypeAtIndex()
##

proc StructGetTypeAtIndex*(structTy: TypeRef; i: cuint): TypeRef {.llvmc.}
## *
##  Determine whether a structure is packed.
##
##  @see llvm::StructType::isPacked()
##

proc IsPackedStruct*(structTy: TypeRef): Bool {.llvmc.}
## *
##  Determine whether a structure is opaque.
##
##  @see llvm::StructType::isOpaque()
##

proc IsOpaqueStruct*(structTy: TypeRef): Bool {.llvmc.}

## Determine whether a structure is literal.
proc IsLiteralStruct*(structTy: TypeRef): Bool {.llvmc.}
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

proc GetElementType*(ty: TypeRef): TypeRef {.llvmc.}
## *
##  Returns type's subtypes
##
##  @see llvm::Type::subtypes()
##

proc GetSubtypes*(tp: TypeRef; arr: ptr TypeRef) {.llvmc.}
## *
##   Return the number of types in the derived type.
##
##  @see llvm::Type::getNumContainedTypes()
##

proc GetNumContainedTypes*(tp: TypeRef): cuint {.llvmc.}
## *
##  Create a fixed size array type that refers to a specific type.
##
##  The created type will exist in the context that its element type
##  exists in.
##
##  @see llvm::ArrayType::get()
##

proc ArrayType*(elementType: TypeRef; elementCount: cuint): TypeRef {.llvmc.}
## *
##  Obtain the length of an array type.
##
##  This only works on types that represent arrays.
##
##  @see llvm::ArrayType::getNumElements()
##

proc GetArrayLength*(arrayTy: TypeRef): cuint {.llvmc.}
## *
##  Create a pointer type that points to a defined type.
##
##  The created type will exist in the context that its pointee type
##  exists in.
##
##  @see llvm::PointerType::get()
##

proc PointerType*(elementType: TypeRef; addressSpace: cuint): TypeRef {.llvmc.}
## *
##  Obtain the address space of a pointer type.
##
##  This only works on types that represent pointers.
##
##  @see llvm::PointerType::getAddressSpace()
##

proc GetPointerAddressSpace*(pointerTy: TypeRef): cuint {.llvmc.}
## *
##  Create a vector type that contains a defined type and has a specific
##  number of elements.
##
##  The created type will exist in the context thats its element type
##  exists in.
##
##  @see llvm::VectorType::get()
##

proc VectorType*(elementType: TypeRef; elementCount: cuint): TypeRef {.llvmc.}

## Create a vector type that contains a defined type and has a scalable number of elements.
proc ScalableVectorType*(elementType: TypeRef, elementCount: cuint): TypeRef {.llvmc.}

## *
##  Obtain the number of elements in a vector type.
##
##  This only works on types that represent vectors.
##
##  @see llvm::VectorType::getNumElements()
##

proc GetVectorSize*(vectorTy: TypeRef): cuint {.llvmc.}
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

proc VoidTypeInContext*(c: ContextRef): TypeRef {.llvmc.}
## *
##  Create a label type in a context.
##

proc LabelTypeInContext*(c: ContextRef): TypeRef {.llvmc.}
## *
##  Create a X86 MMX type in a context.
##

proc X86MMXTypeInContext*(c: ContextRef): TypeRef {.llvmc.}

## Create a token type in a context
proc TokenTypeInContext*(c: ContextRef): TypeRef {.llvmc.}

## Create a metadata type in a context
proc MetadataTypeInContext*(c: ContextRef): TypeRef {.llvmc.}


## *
##  These are similar to the above functions except they operate on the
##  global context.
##

proc VoidType*(): TypeRef {.llvmc.}
proc LabelType*(): TypeRef {.llvmc.}
proc X86MMXType*(): TypeRef {.llvmc.}
proc X86AMXType*(): TypeRef {.llvmc.}
## *
##  @}
##