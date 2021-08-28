## ===-- llvm-c/Object.h - Object Lib C Iface --------------------*- C++ -*-===
##
##                      The LLVM Compiler Infrastructure
##
##  This file is distributed under the University of Illinois Open Source
##  License. See LICENSE.TXT for details.
##
## ===----------------------------------------------------------------------===
##
##  This header declares the C interface to libLLVMObject.a, which
##  implements object file reading and writing.
##
##  Many exotic languages can interoperate with C code but have a harder time
##  with C++ due to name mangling. So in addition to C, this interface enables
##  tools written in such languages.
##
## ===----------------------------------------------------------------------===

## *
##  @defgroup LLVMCObject Object file reading and writing
##  @ingroup LLVMC
##
##  @{
##
##  Opaque type wrappers

type
  ObjectFileRef* = ptr OpaqueObjectFile
  SectionIteratorRef* = ptr OpaqueSectionIterator
  SymbolIteratorRef* = ptr OpaqueSymbolIterator
  RelocationIteratorRef* = ptr OpaqueRelocationIterator

## Create a binary file from the given memory buffer
proc CreateBinary*(memBuf: MemoryBufferRef, ctx: ContextRef, errorMessage: cstringArray): BinaryRef {.llvmc.}
## Dispose of a binary file
proc DisposeBinary(br: BinaryRef) {.llvmc.}

## Retrieves a copy of the memory buffer associated with this object file
proc BinaryCopyMemoryBuffer*(br: BinaryRef): MemoryBufferRef {.llvmc.}

## Retrieve the specific type of a binary
proc BinaryGetType*(br: BinaryRef): BinaryType {.llvmc.}
proc MachOUniversalBinaryCopyObjectForArch (br: BinaryRef, arch: cstring, archLen: csize_t, errorMessage: cstringArray): BinaryRef {.llvmc.}

## Retrieve a copy of the section iterator for this object file
proc ObjectFileCopySectionIterator*(br: BinaryRef): SectionIteratorRef{.llvmc.}

## Returns whether the given section iterator is at the end
proc ObjectFileIsSectionIteratorAtEnd*(br: BinaryRef, si: SectionIteratorRef): Bool {.llvmc.}

## Retrieve a copy of the symbol iterator for this object file
proc ObjectFileCopySymbolIterator*(br: BinaryRef): SymbolIteratorRef {.llvmc.}

## Returns whether the given symbol iterator is at the end
proc ObjectFileIsSymbolIteratorAtEnd (br: BinaryRef, si: SymbolIteratorRef): Bool {.llvmc.}

##  ObjectFile creation

proc CreateObjectFile*(memBuf: MemoryBufferRef): ObjectFileRef {.llvmc.}
proc DisposeObjectFile*(objectFile: ObjectFileRef) {.llvmc.}
##  ObjectFile Section iterators

proc GetSections*(objectFile: ObjectFileRef): SectionIteratorRef {.llvmc.}
proc DisposeSectionIterator*(si: SectionIteratorRef) {.llvmc.}
proc IsSectionIteratorAtEnd*(objectFile: ObjectFileRef; si: SectionIteratorRef): Bool {.llvmc.}
proc MoveToNextSection*(si: SectionIteratorRef) {.llvmc.}
proc MoveToContainingSection*(sect: SectionIteratorRef; sym: SymbolIteratorRef) {.llvmc.}
##  ObjectFile Symbol iterators

proc GetSymbols*(objectFile: ObjectFileRef): SymbolIteratorRef {.llvmc.}
proc DisposeSymbolIterator*(si: SymbolIteratorRef) {.llvmc.}
proc IsSymbolIteratorAtEnd*(objectFile: ObjectFileRef; si: SymbolIteratorRef): Bool {.llvmc.}
proc MoveToNextSymbol*(si: SymbolIteratorRef) {.llvmc.}
##  SectionRef accessors

proc GetSectionName*(si: SectionIteratorRef): cstring {.llvmc.}
proc GetSectionSize*(si: SectionIteratorRef): uint64 {.llvmc.}
proc GetSectionContents*(si: SectionIteratorRef): cstring {.llvmc.}
proc GetSectionAddress*(si: SectionIteratorRef): uint64 {.llvmc.}
proc GetSectionContainsSymbol*(si: SectionIteratorRef; sym: SymbolIteratorRef): Bool {.llvmc.}
##  Section Relocation iterators

proc GetRelocations*(section: SectionIteratorRef): RelocationIteratorRef {.llvmc.}
proc DisposeRelocationIterator*(ri: RelocationIteratorRef) {.llvmc.}
proc IsRelocationIteratorAtEnd*(section: SectionIteratorRef;
                               ri: RelocationIteratorRef): Bool {.llvmc.}
proc MoveToNextRelocation*(ri: RelocationIteratorRef) {.llvmc.}
##  SymbolRef accessors

proc GetSymbolName*(si: SymbolIteratorRef): cstring {.llvmc.}
proc GetSymbolAddress*(si: SymbolIteratorRef): uint64 {.llvmc.}
proc GetSymbolSize*(si: SymbolIteratorRef): uint64 {.llvmc.}
##  RelocationRef accessors

proc GetRelocationOffset*(ri: RelocationIteratorRef): uint64 {.llvmc.}
proc GetRelocationSymbol*(ri: RelocationIteratorRef): SymbolIteratorRef {.llvmc.}
proc GetRelocationType*(ri: RelocationIteratorRef): uint64 {.llvmc.}
##  NOTE: Caller takes ownership of returned string of the two
##  following functions.

proc GetRelocationTypeName*(ri: RelocationIteratorRef): cstring {.llvmc.}
proc GetRelocationValueString*(ri: RelocationIteratorRef): cstring {.llvmc.}
## *
##  @}
##
