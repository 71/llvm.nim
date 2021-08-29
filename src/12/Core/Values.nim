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

proc TypeOf*(val: ValueRef): TypeRef {.llvmc.}
## *
##  Obtain the enumerated type of a Value instance.
##
##  @see llvm::Value::getValueID()
##

proc GetValueKind*(val: ValueRef): ValueKind {.llvmc.}
## *
##  Obtain the string name of a value.
##
##  @see llvm::Value::getName()
##

proc GetValueName2*(val: ValueRef, length: csize_t): cstring {.llvmc.}
## *
##  Set the string name of a value.
##
##  @see llvm::Value::setName()
##

proc SetValueName2*(val: ValueRef; name: cstring, nameLen: csize_t) {.llvmc.}
## *
##  Dump a representation of a value to stderr.
##
##  @see llvm::Value::dump()
##

proc DumpValue*(val: ValueRef) {.llvmc.}
## *
##  Return a string representation of the value. Use
##  LLVMDisposeMessage to free the string.
##
##  @see llvm::Value::print()
##

proc PrintValueToString*(val: ValueRef): cstring {.llvmc.}
## *
##  Replace all uses of a value with another one.
##
##  @see llvm::Value::replaceAllUsesWith()
##

proc ReplaceAllUsesWith*(oldVal: ValueRef; newVal: ValueRef) {.llvmc.}
## *
##  Determine whether the specified value instance is constant.
##

proc IsConstant*(val: ValueRef): Bool {.llvmc.}
## *
##  Determine whether a value instance is undefined.
##

proc IsUndef*(val: ValueRef): Bool {.llvmc.}
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

proc IsAMDNode*(val: ValueRef): ValueRef {.llvmc.}
proc IsAMDString*(val: ValueRef): ValueRef {.llvmc.}

proc GetValueName*(val: ValueRef): cstring {.llvmc, deprecated.}
proc SetValueName*(val: ValueRef, name: cstring) {.llvmc, deprecated.}

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

proc GetFirstUse*(val: ValueRef): UseRef {.llvmc.}
## *
##  Obtain the next use of a value.
##
##  This effectively advances the iterator. It returns NULL if you are on
##  the final use and no more are available.
##

proc GetNextUse*(u: UseRef): UseRef {.llvmc.}
## *
##  Obtain the user value for a user.
##
##  The returned value corresponds to a llvm::User type.
##
##  @see llvm::Use::getUser()
##

proc GetUser*(u: UseRef): ValueRef {.llvmc.}
## *
##  Obtain the value this use corresponds to.
##
##  @see llvm::Use::get().
##

proc GetUsedValue*(u: UseRef): ValueRef {.llvmc.}
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

proc GetOperand*(val: ValueRef; index: cuint): ValueRef {.llvmc.}
## *
##  Obtain the use of an operand at a specific index in a llvm::User value.
##
##  @see llvm::User::getOperandUse()
##

proc GetOperandUse*(val: ValueRef; index: cuint): UseRef {.llvmc.}
## *
##  Set an operand at a specific index in a llvm::User value.
##
##  @see llvm::User::setOperand()
##

proc SetOperand*(user: ValueRef; index: cuint; val: ValueRef) {.llvmc.}
## *
##  Obtain the number of operands in a llvm::User value.
##
##  @see llvm::User::getNumOperands()
##

proc GetNumOperands*(val: ValueRef): cint {.llvmc.}
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

proc ConstNull*(ty: TypeRef): ValueRef {.llvmc.}
##  all zeroes
## *
##  Obtain a constant value referring to the instance of a type
##  consisting of all ones.
##
##  This is only valid for integer types.
##
##  @see llvm::Constant::getAllOnesValue()
##

proc ConstAllOnes*(ty: TypeRef): ValueRef {.llvmc.}
## *
##  Obtain a constant value referring to an undefined value of a type.
##
##  @see llvm::UndefValue::get()
##

proc GetUndef*(ty: TypeRef): ValueRef {.llvmc.}

## Obtain a constant value referring to a poison value of a type
proc GetPosion*(ty: TypeRef): ValueRef {.llvmc.}

##  Determine whether a value instance is null.
##
##  @see llvm::Constant::isNullValue()
##

proc IsNull*(val: ValueRef): Bool {.llvmc.}
## *
##  Obtain a constant that is a constant pointer pointing to NULL for a
##  specified type.
##

proc ConstPointerNull*(ty: TypeRef): ValueRef {.llvmc.}
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

proc ConstInt*(intTy: TypeRef; n: culonglong; signExtend: Bool): ValueRef {.llvmc.}
## *
##  Obtain a constant value for an integer of arbitrary precision.
##
##  @see llvm::ConstantInt::get()
##

proc ConstIntOfArbitraryPrecision*(intTy: TypeRef; numWords: cuint;
                                  words: ptr uint64): ValueRef {.llvmc.}
## *
##  Obtain a constant value for an integer parsed from a string.
##
##  A similar API, LLVMConstIntOfStringAndSize is also available. If the
##  string's length is available, it is preferred to call that function
##  instead.
##
##  @see llvm::ConstantInt::get()
##

proc ConstIntOfString*(intTy: TypeRef; text: cstring; radix: uint8T): ValueRef {.llvmc.}
## *
##  Obtain a constant value for an integer parsed from a string with
##  specified length.
##
##  @see llvm::ConstantInt::get()
##

proc ConstIntOfStringAndSize*(intTy: TypeRef; text: cstring; sLen: cuint; radix: uint8T): ValueRef {.llvmc.}
## *
##  Obtain a constant value referring to a double floating point value.
##

proc ConstReal*(realTy: TypeRef; n: cdouble): ValueRef {.llvmc.}
## *
##  Obtain a constant for a floating point value parsed from a string.
##
##  A similar API, LLVMConstRealOfStringAndSize is also available. It
##  should be used if the input string's length is known.
##

proc ConstRealOfString*(realTy: TypeRef; text: cstring): ValueRef {.llvmc.}
## *
##  Obtain a constant for a floating point value parsed from a string.
##

proc ConstRealOfStringAndSize*(realTy: TypeRef; text: cstring; sLen: cuint): ValueRef {.llvmc.}
## *
##  Obtain the zero extended value for an integer constant value.
##
##  @see llvm::ConstantInt::getZExtValue()
##

proc ConstIntGetZExtValue*(constantVal: ValueRef): culonglong {.llvmc.}
## *
##  Obtain the sign extended value for an integer constant value.
##
##  @see llvm::ConstantInt::getSExtValue()
##

proc ConstIntGetSExtValue*(constantVal: ValueRef): clonglong {.llvmc.}
## *
##  Obtain the double value for an floating point constant value.
##  losesInfo indicates if some precision was lost in the conversion.
##
##  @see llvm::ConstantFP::getDoubleValue
##

proc ConstRealGetDouble*(constantVal: ValueRef; losesInfo: ptr Bool): cdouble {.llvmc.}
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

proc ConstStringInContext*(c: ContextRef; str: cstring; length: cuint;
                          dontNullTerminate: Bool): ValueRef {.llvmc.}
## *
##  Create a ConstantDataSequential with string content in the global context.
##
##  This is the same as LLVMConstStringInContext except it operates on the
##  global context.
##
##  @see LLVMConstStringInContext()
##  @see llvm::ConstantDataArray::getString()
##

proc ConstString*(str: cstring; length: cuint; dontNullTerminate: Bool): ValueRef {.llvmc.}
## *
##  Returns true if the specified constant is an array of i8.
##
##  @see ConstantDataSequential::getAsString()
##

proc IsConstantString*(c: ValueRef): Bool {.llvmc.}
## *
##  Get the given constant data sequential as a string.
##
##  @see ConstantDataSequential::getAsString()
##

proc GetAsString*(c: ValueRef; length: ptr csize_t): cstring {.llvmc.}
## *
##  Create an anonymous ConstantStruct with the specified values.
##
##  @see llvm::ConstantStruct::getAnon()
##

proc ConstStructInContext*(c: ContextRef; constantVals: ptr ValueRef; count: cuint;
                          packed: Bool): ValueRef {.llvmc.}
## *
##  Create a ConstantStruct in the global Context.
##
##  This is the same as LLVMConstStructInContext except it operates on the
##  global Context.
##
##  @see LLVMConstStructInContext()
##

proc ConstStruct*(constantVals: ptr ValueRef; count: cuint; packed: Bool): ValueRef {.llvmc.}
## *
##  Create a ConstantArray from values.
##
##  @see llvm::ConstantArray::get()
##

proc ConstArray*(elementTy: TypeRef; constantVals: ptr ValueRef; length: cuint): ValueRef {.llvmc.}
## *
##  Create a non-anonymous ConstantStruct from values.
##
##  @see llvm::ConstantStruct::get()
##

proc ConstNamedStruct*(structTy: TypeRef; constantVals: ptr ValueRef; count: cuint): ValueRef {.llvmc.}
## *
##  Get an element at specified index as a constant.
##
##  @see ConstantDataSequential::getElementAsConstant()
##

proc GetElementAsConstant*(c: ValueRef; idx: cuint): ValueRef {.llvmc.}
## *
##  Create a ConstantVector from values.
##
##  @see llvm::ConstantVector::get()
##

proc ConstVector*(scalarConstantVals: ptr ValueRef; size: cuint): ValueRef {.llvmc.}
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

proc GetConstOpcode*(constantVal: ValueRef): Opcode {.llvmc.}
proc AlignOf*(ty: TypeRef): ValueRef {.llvmc.}
proc SizeOf*(ty: TypeRef): ValueRef {.llvmc.}
proc ConstNeg*(constantVal: ValueRef): ValueRef {.llvmc.}
proc ConstNSWNeg*(constantVal: ValueRef): ValueRef {.llvmc.}
proc ConstNUWNeg*(constantVal: ValueRef): ValueRef {.llvmc.}
proc ConstFNeg*(constantVal: ValueRef): ValueRef {.llvmc.}
proc ConstNot*(constantVal: ValueRef): ValueRef {.llvmc.}
proc ConstAdd*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstNSWAdd*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstNUWAdd*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstFAdd*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstSub*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstNSWSub*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstNUWSub*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstFSub*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstMul*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstNSWMul*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstNUWMul*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstFMul*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstUDiv*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstExactUDiv*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstSDiv*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstExactSDiv*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstFDiv*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstURem*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstSRem*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstFRem*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstAnd*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstOr*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstXor*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstICmp*(predicate: IntPredicate; lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstFCmp*(predicate: RealPredicate; lHSConstant: ValueRef;
               rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstShl*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstLShr*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstAShr*(lHSConstant: ValueRef; rHSConstant: ValueRef): ValueRef {.llvmc.}
proc ConstGEP*(constantVal: ValueRef; constantIndices: ptr ValueRef; numIndices: cuint): ValueRef {.llvmc.}
proc ConstGEp2*(ty: TypeRef, constantVal: ValueRef; constantIndices: ptr ValueRef; numIndices: cuint): ValueRef {.llvmc.}
proc ConstInBoundsGEP*(constantVal: ValueRef; constantIndices: ptr ValueRef;
                      numIndices: cuint): ValueRef {.llvmc.}
proc ConstInBoundsGEP2*(ty: TypeRef, constantVal: ValueRef; constantIndices: ptr ValueRef;
                      numIndices: cuint): ValueRef {.llvmc.}
proc ConstTrunc*(constantVal: ValueRef; toType: TypeRef): ValueRef {.llvmc.}
proc ConstSExt*(constantVal: ValueRef; toType: TypeRef): ValueRef {.llvmc.}
proc ConstZExt*(constantVal: ValueRef; toType: TypeRef): ValueRef {.llvmc.}
proc ConstFPTrunc*(constantVal: ValueRef; toType: TypeRef): ValueRef {.llvmc.}
proc ConstFPExt*(constantVal: ValueRef; toType: TypeRef): ValueRef {.llvmc.}
proc ConstUIToFP*(constantVal: ValueRef; toType: TypeRef): ValueRef {.llvmc.}
proc ConstSIToFP*(constantVal: ValueRef; toType: TypeRef): ValueRef {.llvmc.}
proc ConstFPToUI*(constantVal: ValueRef; toType: TypeRef): ValueRef {.llvmc.}
proc ConstFPToSI*(constantVal: ValueRef; toType: TypeRef): ValueRef {.llvmc.}
proc ConstPtrToInt*(constantVal: ValueRef; toType: TypeRef): ValueRef {.llvmc.}
proc ConstIntToPtr*(constantVal: ValueRef; toType: TypeRef): ValueRef {.llvmc.}
proc ConstBitCast*(constantVal: ValueRef; toType: TypeRef): ValueRef {.llvmc.}
proc ConstAddrSpaceCast*(constantVal: ValueRef; toType: TypeRef): ValueRef {.llvmc.}
proc ConstZExtOrBitCast*(constantVal: ValueRef; toType: TypeRef): ValueRef {.llvmc.}
proc ConstSExtOrBitCast*(constantVal: ValueRef; toType: TypeRef): ValueRef {.llvmc.}
proc ConstTruncOrBitCast*(constantVal: ValueRef; toType: TypeRef): ValueRef {.llvmc.}
proc ConstPointerCast*(constantVal: ValueRef; toType: TypeRef): ValueRef {.llvmc.}
proc ConstIntCast*(constantVal: ValueRef; toType: TypeRef; isSigned: Bool): ValueRef {.llvmc.}
proc ConstFPCast*(constantVal: ValueRef; toType: TypeRef): ValueRef {.llvmc.}
proc ConstSelect*(constantCondition: ValueRef; constantIfTrue: ValueRef;
                 constantIfFalse: ValueRef): ValueRef {.llvmc.}
proc ConstExtractElement*(vectorConstant: ValueRef; indexConstant: ValueRef): ValueRef {.llvmc.}
proc ConstInsertElement*(vectorConstant: ValueRef; elementValueConstant: ValueRef;
                        indexConstant: ValueRef): ValueRef {.llvmc.}
proc ConstShuffleVector*(vectorAConstant: ValueRef; vectorBConstant: ValueRef;
                        maskConstant: ValueRef): ValueRef {.llvmc.}
proc ConstExtractValue*(aggConstant: ValueRef; idxList: ptr cuint; numIdx: cuint): ValueRef {.llvmc.}
proc ConstInsertValue*(aggConstant: ValueRef; elementValueConstant: ValueRef;
                      idxList: ptr cuint; numIdx: cuint): ValueRef {.llvmc.}
proc BlockAddress*(f: ValueRef; bb: BasicBlockRef): ValueRef {.llvmc.}
proc ConstInlineAsm*(ty: TypeRef; asmString: cstring; constraints: cstring;
                    hasSideEffects: Bool; isAlignStack: Bool): ValueRef {.llvmc, deprecated.}
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

proc GetGlobalParent*(global: ValueRef): ModuleRef {.llvmc.}
proc IsDeclaration*(global: ValueRef): Bool {.llvmc.}
proc GetLinkage*(global: ValueRef): Linkage {.llvmc.}
proc SetLinkage*(global: ValueRef; linkage: Linkage) {.llvmc.}
proc GetSection*(global: ValueRef): cstring {.llvmc.}
proc SetSection*(global: ValueRef; section: cstring) {.llvmc.}
proc GetVisibility*(global: ValueRef): Visibility {.llvmc.}
proc SetVisibility*(global: ValueRef; viz: Visibility) {.llvmc.}
proc GetDLLStorageClass*(global: ValueRef): DLLStorageClass {.llvmc.}
proc SetDLLStorageClass*(global: ValueRef; class: DLLStorageClass) {.llvmc.}
proc GetUnnamedAddress*(global: ValueRef): UnnamedAddr {.llvmc.}
proc SetUnnamedAddress*(global: ValueRef, unnamedAddr: UnnamedAddr) {.llvmc.}
## Returns the "value type" of a global value
proc GlobalGetValueType*(global: ValueRef): TypeRef {.llvmc.}
proc HasUnnamedAddr*(global: ValueRef): Bool {.llvmc, deprecated.}
proc SetUnnamedAddr*(global: ValueRef; hasUnnamedAddr: Bool) {.llvmc, deprecated.}
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

proc GetAlignment*(v: ValueRef): cuint {.llvmc.}
## *
##  Set the preferred alignment of the value.
##  @see llvm::AllocaInst::setAlignment()
##  @see llvm::LoadInst::setAlignment()
##  @see llvm::StoreInst::setAlignment()
##  @see llvm::GlobalValue::setAlignment()
##

proc SetAlignment*(v: ValueRef; bytes: cuint) {.llvmc.}

## Sets a metadata attachment, erasing the existing metadata attachment if it already exists for the given kind
proc GlobalSetMetadata*(global: ValueRef, kind: cuint, md: MetadataRef) {.llvmc.}

## Erases a metadata attachment of the given kind if it exists
proc GlobalEraseMetadata*(global: ValueRef, kind: cuint) {.llvmc.}

## Removes all metadata attachments from this value
proc GlobalClearMetadata*(global: ValueRef) {.llvmc.}

## Retrieves an array of metadata entries representing the metadata attached to this value
proc GlobalCopyAllMetadata*(value: ValueRef, numEntries: ptr csize_t): ptr ValueMetadataEntry {.llvmc.}

## Destroys value metadata entries
proc DisposeValueMetadataEntries*(entries: ptr ValueMetadataEntry) {.llvmc.}

## Returns the kind of a value metadata entry at a specific index
proc ValueMetadataEntriesGetKind*(entries: ptr ValueMetadataEntry, index: cuint): cuint {.llvmc.}

## Returns the underlying metadata node of a value metadata entry at a specific index
proc ValueMetadataEntriesGetMetadata*(entries: ptr ValueMetadataEntry, index: cuint): MetadataRef {.llvmc.}

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

proc AddGlobal*(m: ModuleRef; ty: TypeRef; name: cstring): ValueRef {.llvmc.}
proc AddGlobalInAddressSpace*(m: ModuleRef; ty: TypeRef; name: cstring;
                             addressSpace: cuint): ValueRef {.llvmc.}
proc GetNamedGlobal*(m: ModuleRef; name: cstring): ValueRef {.llvmc.}
proc GetFirstGlobal*(m: ModuleRef): ValueRef {.llvmc.}
proc GetLastGlobal*(m: ModuleRef): ValueRef {.llvmc.}
proc GetNextGlobal*(globalVar: ValueRef): ValueRef {.llvmc.}
proc GetPreviousGlobal*(globalVar: ValueRef): ValueRef {.llvmc.}
proc DeleteGlobal*(globalVar: ValueRef) {.llvmc.}
proc GetInitializer*(globalVar: ValueRef): ValueRef {.llvmc.}
proc SetInitializer*(globalVar: ValueRef; constantVal: ValueRef) {.llvmc.}
proc IsThreadLocal*(globalVar: ValueRef): Bool {.llvmc.}
proc SetThreadLocal*(globalVar: ValueRef; isThreadLocal: Bool) {.llvmc.}
proc IsGlobalConstant*(globalVar: ValueRef): Bool {.llvmc.}
proc SetGlobalConstant*(globalVar: ValueRef; isConstant: Bool) {.llvmc.}
proc GetThreadLocalMode*(globalVar: ValueRef): ThreadLocalMode {.llvmc.}
proc SetThreadLocalMode*(globalVar: ValueRef; mode: ThreadLocalMode) {.llvmc.}
proc IsExternallyInitialized*(globalVar: ValueRef): Bool {.llvmc.}
proc SetExternallyInitialized*(globalVar: ValueRef; isExtInit: Bool) {.llvmc.}
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

proc AddAlias*(m: ModuleRef; ty: TypeRef; aliasee: ValueRef; name: cstring): ValueRef {.llvmc.}

## Obtain a GlobalAlias value from a Module by its name
proc GetNamedGLobalAlias*(m: ModuleRef, name: cstring, nameLen: csize_t): ValueRef {.llvmc.}

## Obtain an iterator to the first GlobalAlias in a Module
proc GetFirstGlobalAlias*(m: ModuleRef): ValueRef {.llvmc.}

## Obtain an iterator to the last GlobalAlias in a Module
proc GetLastGlobalAlias*(m: ModuleRef): ValueRef {.llvmc.}

## Advance a GlobalAlias iterator to the next GlobalAlias
proc GetNextGlobalAlias*(m: ModuleRef): ValueRef {.llvmc.}

## Decrement a GlobalAlias iterator to the previous GlobalAlias
proc GetPreviousGlobalAlias*(m: ModuleRef): ValueRef {.llvmc.}

## Retrieve the target value of an alias
proc AliasGetAliasee*(alias: ValueRef): ValueRef {.llvmc.}

## Set the target value of an alias
proc AliasSetAliasee*(alias: ValueRef, aliasee: ValueRef) {.llvmc.}

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

proc DeleteFunction*(fn: ValueRef) {.llvmc.}
## *
##  Check whether the given function has a personality function.
##
##  @see llvm::Function::hasPersonalityFn()
##

proc HasPersonalityFn*(fn: ValueRef): Bool {.llvmc.}
## *
##  Obtain the personality function attached to the function.
##
##  @see llvm::Function::getPersonalityFn()
##

proc GetPersonalityFn*(fn: ValueRef): ValueRef {.llvmc.}
## *
##  Set the personality function attached to the function.
##
##  @see llvm::Function::setPersonalityFn()
##

proc SetPersonalityFn*(fn: ValueRef; personalityFn: ValueRef) {.llvmc.}
## *
##  Obtain the ID number from a function instance.
##
##  @see llvm::Function::getIntrinsicID()
##

proc GetIntrinsicID*(fn: ValueRef): cuint {.llvmc.}


##	Create or insert the declaration of an intrinsic
proc GetIntrinsicDeclaration*(m: ModuleRef, id: cuint, paramTypes: ptr TypeRef, paramCount: csize_t): ValueRef {.llvmc.}

## Retrieves the type of an intrinsic
proc IntrinsicGetType*(ctx: ContextRef, id: cuint, paramTypes: ptr TypeRef, paramCount: csize_t): TypeRef {.llvmc.}

## Retrieves the name of an intrinsic
proc IntrinsicGetName*(id: cuint, nameLength: ptr csize_t): cstring {.llvmc.}

proc IntrinsicCopyOverloadedName*(id: cuint, paramTypes: ptr TypeRef, paramCount: csize_t, nameLength: ptr csize_t): cstring {.llvmc.}
## Copies the name of an overloaded intrinsic identified by a given list of parameter types

## Obtain if the intrinsic identified by the given ID is overloaded
proc IntrinsicIsOverloaded*(id: cuint): Bool {.llvmc.}

## *
##  Obtain the calling function of a function.
##
##  The returned value corresponds to the LLVMCallConv enumeration.
##
##  @see llvm::Function::getCallingConv()
##

proc GetFunctionCallConv*(fn: ValueRef): cuint {.llvmc.}
## *
##  Set the calling convention of a function.
##
##  @see llvm::Function::setCallingConv()
##
##  @param Fn Function to operate on
##  @param CC LLVMCallConv to set calling convention to
##

proc SetFunctionCallConv*(fn: ValueRef; cc: cuint) {.llvmc.}
## *
##  Obtain the name of the garbage collector to use during code
##  generation.
##
##  @see llvm::Function::getGC()
##

proc GetGC*(fn: ValueRef): cstring {.llvmc.}
## *
##  Define the garbage collector to use during code generation.
##
##  @see llvm::Function::setGC()
##

proc SetGC*(fn: ValueRef; name: cstring) {.llvmc.}
## *
##  Add an attribute to a function.
##
##  @see llvm::Function::addAttribute()
##

proc AddAttributeAtIndex*(f: ValueRef; idx: AttributeIndex; a: AttributeRef) {.llvmc.}
proc GetAttributeCountAtIndex*(f: ValueRef; idx: AttributeIndex): cuint {.llvmc.}
proc GetAttributesAtIndex*(f: ValueRef; idx: AttributeIndex; attrs: ptr AttributeRef) {.llvmc.}
proc GetEnumAttributeAtIndex*(f: ValueRef; idx: AttributeIndex; kindID: cuint): AttributeRef {.llvmc.}
proc GetStringAttributeAtIndex*(f: ValueRef; idx: AttributeIndex; k: cstring;
                               kLen: cuint): AttributeRef {.llvmc.}
proc RemoveEnumAttributeAtIndex*(f: ValueRef; idx: AttributeIndex; kindID: cuint) {.llvmc.}
proc RemoveStringAttributeAtIndex*(f: ValueRef; idx: AttributeIndex; k: cstring;
                                  kLen: cuint) {.llvmc.}
## *
##  Add a target-dependent attribute to a function
##  @see llvm::AttrBuilder::addAttribute()
##

proc AddTargetDependentFunctionAttr*(fn: ValueRef; a: cstring; v: cstring) {.llvmc.}
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

proc CountParams*(fn: ValueRef): cuint {.llvmc.}
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

proc GetParams*(fn: ValueRef; params: ptr ValueRef) {.llvmc.}
## *
##  Obtain the parameter at the specified index.
##
##  Parameters are indexed from 0.
##
##  @see llvm::Function::arg_begin()
##

proc GetParam*(fn: ValueRef; index: cuint): ValueRef {.llvmc.}
## *
##  Obtain the function to which this argument belongs.
##
##  Unlike other functions in this group, this one takes an LLVMValueRef
##  that corresponds to a llvm::Attribute.
##
##  The returned LLVMValueRef is the llvm::Function to which this
##  argument belongs.
##

proc GetParamParent*(inst: ValueRef): ValueRef {.llvmc.}
## *
##  Obtain the first parameter to a function.
##
##  @see llvm::Function::arg_begin()
##

proc GetFirstParam*(fn: ValueRef): ValueRef {.llvmc.}
## *
##  Obtain the last parameter to a function.
##
##  @see llvm::Function::arg_end()
##

proc GetLastParam*(fn: ValueRef): ValueRef {.llvmc.}
## *
##  Obtain the next parameter to a function.
##
##  This takes an LLVMValueRef obtained from LLVMGetFirstParam() (which is
##  actually a wrapped iterator) and obtains the next parameter from the
##  underlying iterator.
##

proc GetNextParam*(arg: ValueRef): ValueRef {.llvmc.}
## *
##  Obtain the previous parameter to a function.
##
##  This is the opposite of LLVMGetNextParam().
##

proc GetPreviousParam*(arg: ValueRef): ValueRef {.llvmc.}
## *
##  Set the alignment for a function parameter.
##
##  @see llvm::Argument::addAttr()
##  @see llvm::AttrBuilder::addAlignmentAttr()
##

proc SetParamAlignment*(arg: ValueRef; align: cuint) {.llvmc.}


# *
##  @defgroup LLVMCCoreValueFunctionParameters Function Parameters
##
##  Functions in this group relate to indirect functions.
##

## Add a global indirect function to a module under a specified name.
proc AddGlobalIFunc*(m: ModuleRef, name: cstring, nameLen: csize_t, ty: TypeRef, addrSpace: cuint, resolver: ValueRef): ValueRef {.llvmc.}

## Obtain a GlobalIFunc value from a Module by its name.
proc GetNamedGlobalIFunc*(m: ModuleRef, name: cstring, nameLen: csize_t): ValueRef {.llvmc.}

## Obtain an iterator to the first GlobalIFunc in a Module.
proc GetFirstGlobalIFunc*(m: ModuleRef): ValueRef {.llvmc.}

## Obtain an iterator to the last GlobalIFunc in a Module.
proc GetLastGlobalIFunc*(m: ModuleRef): ValueRef {.llvmc.}

## Advance a GlobalIFunc iterator to the next GlobalIFunc.
proc GetNextGlobalIFunc*(ifunc: ValueRef): ValueRef {.llvmc.}

## Decrement a GlobalIFunc iterator to the previous GlobalIFunc.
proc GetPreviousGlobalIFunc*(ifunc: ValueRef): ValueRef {.llvmc.}

## Retrieves the resolver function associated with this indirect function, or NULL if it doesn't not exist.
proc GetGlobalIFuncResolver*(ifunc: ValueRef): ValueRef {.llvmc.}

## Sets the resolver function associated with this indirect function.
proc SetGlobalIFuncResolver*(ifunc: ValueRef, resolver: ValueRef): ValueRef {.llvmc.}

## Remove a global indirect function from its parent module and delete it.
proc EraseGlobalIFunc*(ifunc: ValueRef) {.llvmc.}

## Remove a global indirect function from its parent module.
proc RemoveGlobalIFunc*(ifunc: ValueRef) {.llvmc.}
