## ===-- llvm-c/Target.h - Target Lib C Iface --------------------*- C++ -*-===
##
##                      The LLVM Compiler Infrastructure
##
##  This file is distributed under the University of Illinois Open Source
##  License. See LICENSE.TXT for details.
##
## ===----------------------------------------------------------------------===
##
##  This header declares the C interface to libLLVMTarget.a, which
##  implements target information.
##
##  Many exotic languages can interoperate with C code but have a harder time
##  with C++ due to name mangling. So in addition to C, this interface enables
##  tools written in such languages.
##
## ===----------------------------------------------------------------------===

when defined(msc_Ver) and not defined(inline):
  const
    inline* = inline
## *
##  @defgroup LLVMCTarget Target information
##  @ingroup LLVMC
##
##  @{
##

type
  ByteOrdering* {.size: sizeof(cint).} = enum
    BigEndian, LittleEndian


type
  TargetDataRef* = ptr OpaqueTargetData
  TargetLibraryInfoRef* = ptr OpaqueTargetLibraryInfotData

## LLVMInitializeAllTargetInfos - The main program should call this function if it wants access to all available targets that LLVM is configured to support
proc InitializeAllTargetInfos*() {.llvmc, header: "llvm-c/Target.h".}

## LLVMInitializeAllTargets - The main program should call this function if it wants to link in all available targets that LLVM is configured to support. More...
proc InitializeAllTargets*() {.llvmc, header: "llvm-c/Target.h".}

## LLVMInitializeAllTargetMCs - The main program should call this function if it wants access to all available target MC that LLVM is configured to support. More...
proc InitializeAllTargetMCs*() {.llvmc, header: "llvm-c/Target.h".}

## LLVMInitializeAllAsmPrinters - The main program should call this function if it wants all asm printers that LLVM is configured to support, to make them available via the TargetRegistry. More...
proc InitializeAllAsmPrinters*() {.llvmc, header: "llvm-c/Target.h".}

## LLVMInitializeAllAsmParsers - The main program should call this function if it wants all asm parsers that LLVM is configured to support, to make them available via the TargetRegistry. More...
proc InitializeAllAsmParsers*() {.llvmc, header: "llvm-c/Target.h".}

## LLVMInitializeAllDisassemblers - The main program should call this function if it wants all disassemblers that LLVM is configured to support, to make them available via the TargetRegistry. More...
proc InitializeAllDisassemblers*() {.llvmc, header: "llvm-c/Target.h".}

## * LLVMInitializeNativeTarget - The main program should call this function to
##     initialize the native target corresponding to the host.  This is useful
##     for JIT applications to ensure that the target gets linked in correctly.

proc InitializeNativeTarget*(): Bool {.llvmc, header: "llvm-c/Target.h", discardable.}
## * LLVMInitializeNativeTargetAsmParser - The main program should call this
##     function to initialize the parser for the native target corresponding to the
##     host.

proc InitializeNativeAsmParser*(): Bool {.llvmc, header: "llvm-c/Target.h", discardable.}
## * LLVMInitializeNativeTargetAsmPrinter - The main program should call this
##     function to initialize the printer for the native target corresponding to
##     the host.

proc InitializeNativeAsmPrinter*(): Bool {.llvmc, header: "llvm-c/Target.h", discardable.}
## * LLVMInitializeNativeTargetDisassembler - The main program should call this
##     function to initialize the disassembler for the native target corresponding
##     to the host.

proc InitializeNativeDisassembler*(): Bool {.llvmc, header: "llvm-c/Target.h", discardable.}
## ===-- Target Data -------------------------------------------------------===
## *
##  Obtain the data layout for a module.
##
##  @see Module::getDataLayout()
##

proc GetModuleDataLayout*(m: ModuleRef): TargetDataRef {.llvmc.}
## *
##  Set the data layout for a module.
##
##  @see Module::setDataLayout()
##

proc SetModuleDataLayout*(m: ModuleRef; dl: TargetDataRef) {.llvmc.}
## * Creates target data from a target layout string.
##     See the constructor llvm::DataLayout::DataLayout.

proc CreateTargetData*(stringRep: cstring): TargetDataRef {.llvmc.}
## * Deallocates a TargetData.
##     See the destructor llvm::DataLayout::~DataLayout.

proc DisposeTargetData*(td: TargetDataRef) {.llvmc.}
## * Adds target library information to a pass manager. This does not take
##     ownership of the target library info.
##     See the method llvm::PassManagerBase::add.

proc AddTargetLibraryInfo*(tli: TargetLibraryInfoRef; pm: PassManagerRef) {.llvmc.}
## * Converts target data to a target layout string. The string must be disposed
##     with LLVMDisposeMessage.
##     See the constructor llvm::DataLayout::DataLayout.

proc CopyStringRepOfTargetData*(td: TargetDataRef): cstring {.llvmc.}
## * Returns the byte order of a target, either LLVMBigEndian or
##     LLVMLittleEndian.
##     See the method llvm::DataLayout::isLittleEndian.

proc ByteOrder*(td: TargetDataRef): ByteOrdering {.llvmc.}
## * Returns the pointer size in bytes for a target.
##     See the method llvm::DataLayout::getPointerSize.

proc PointerSize*(td: TargetDataRef): cuint {.llvmc.}
## * Returns the pointer size in bytes for a target for a specified
##     address space.
##     See the method llvm::DataLayout::getPointerSize.

proc PointerSizeForAS*(td: TargetDataRef; `as`: cuint): cuint {.llvmc.}
## * Returns the integer type that is the same size as a pointer on a target.
##     See the method llvm::DataLayout::getIntPtrType.

proc IntPtrType*(td: TargetDataRef): TypeRef {.llvmc.}
## * Returns the integer type that is the same size as a pointer on a target.
##     This version allows the address space to be specified.
##     See the method llvm::DataLayout::getIntPtrType.

proc IntPtrTypeForAS*(td: TargetDataRef; `as`: cuint): TypeRef {.llvmc.}
## * Returns the integer type that is the same size as a pointer on a target.
##     See the method llvm::DataLayout::getIntPtrType.

proc IntPtrTypeInContext*(c: ContextRef; td: TargetDataRef): TypeRef {.llvmc.}
## * Returns the integer type that is the same size as a pointer on a target.
##     This version allows the address space to be specified.
##     See the method llvm::DataLayout::getIntPtrType.

proc IntPtrTypeForASInContext*(c: ContextRef; td: TargetDataRef; `as`: cuint): TypeRef {.llvmc.}
## * Computes the size of a type in bytes for a target.
##     See the method llvm::DataLayout::getTypeSizeInBits.

proc SizeOfTypeInBits*(td: TargetDataRef; ty: TypeRef): culonglong {.llvmc.}
## * Computes the storage size of a type in bytes for a target.
##     See the method llvm::DataLayout::getTypeStoreSize.

proc StoreSizeOfType*(td: TargetDataRef; ty: TypeRef): culonglong {.llvmc.}
## * Computes the ABI size of a type in bytes for a target.
##     See the method llvm::DataLayout::getTypeAllocsize_t.

proc ABISizeOfType*(td: TargetDataRef; ty: TypeRef): culonglong {.llvmc.}
## * Computes the ABI alignment of a type in bytes for a target.
##     See the method llvm::DataLayout::getTypeABISize.

proc ABIAlignmentOfType*(td: TargetDataRef; ty: TypeRef): cuint {.llvmc.}
## * Computes the call frame alignment of a type in bytes for a target.
##     See the method llvm::DataLayout::getTypeABISize.

proc CallFrameAlignmentOfType*(td: TargetDataRef; ty: TypeRef): cuint {.llvmc.}
## * Computes the preferred alignment of a type in bytes for a target.
##     See the method llvm::DataLayout::getTypeABISize.

proc PreferredAlignmentOfType*(td: TargetDataRef; ty: TypeRef): cuint {.llvmc.}
## * Computes the preferred alignment of a global variable in bytes for a target.
##     See the method llvm::DataLayout::getPreferredAlignment.

proc PreferredAlignmentOfGlobal*(td: TargetDataRef; globalVar: ValueRef): cuint {.llvmc.}
## * Computes the structure element that contains the byte offset for a target.
##     See the method llvm::StructLayout::getElementContainingOffset.

proc ElementAtOffset*(td: TargetDataRef; structTy: TypeRef; offset: culonglong): cuint {.llvmc.}
## * Computes the byte offset of the indexed struct element for a target.
##     See the method llvm::StructLayout::getElementContainingOffset.

proc OffsetOfElement*(td: TargetDataRef; structTy: TypeRef; element: cuint): culonglong {.llvmc.}
## *
##  @}
##
