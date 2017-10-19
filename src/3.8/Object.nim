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

##  ObjectFile creation

proc createObjectFile*(memBuf: MemoryBufferRef): ObjectFileRef {.
    importc: "LLVMCreateObjectFile", dynlib: LLVMLib.}
proc disposeObjectFile*(objectFile: ObjectFileRef) {.
    importc: "LLVMDisposeObjectFile", dynlib: LLVMLib.}
##  ObjectFile Section iterators

proc getSections*(objectFile: ObjectFileRef): SectionIteratorRef {.
    importc: "LLVMGetSections", dynlib: LLVMLib.}
proc disposeSectionIterator*(si: SectionIteratorRef) {.
    importc: "LLVMDisposeSectionIterator", dynlib: LLVMLib.}
proc isSectionIteratorAtEnd*(objectFile: ObjectFileRef; si: SectionIteratorRef): Bool {.
    importc: "LLVMIsSectionIteratorAtEnd", dynlib: LLVMLib.}
proc moveToNextSection*(si: SectionIteratorRef) {.importc: "LLVMMoveToNextSection",
    dynlib: LLVMLib.}
proc moveToContainingSection*(sect: SectionIteratorRef; sym: SymbolIteratorRef) {.
    importc: "LLVMMoveToContainingSection", dynlib: LLVMLib.}
##  ObjectFile Symbol iterators

proc getSymbols*(objectFile: ObjectFileRef): SymbolIteratorRef {.
    importc: "LLVMGetSymbols", dynlib: LLVMLib.}
proc disposeSymbolIterator*(si: SymbolIteratorRef) {.
    importc: "LLVMDisposeSymbolIterator", dynlib: LLVMLib.}
proc isSymbolIteratorAtEnd*(objectFile: ObjectFileRef; si: SymbolIteratorRef): Bool {.
    importc: "LLVMIsSymbolIteratorAtEnd", dynlib: LLVMLib.}
proc moveToNextSymbol*(si: SymbolIteratorRef) {.importc: "LLVMMoveToNextSymbol",
    dynlib: LLVMLib.}
##  SectionRef accessors

proc getSectionName*(si: SectionIteratorRef): cstring {.
    importc: "LLVMGetSectionName", dynlib: LLVMLib.}
proc getSectionSize*(si: SectionIteratorRef): uint64T {.
    importc: "LLVMGetSectionSize", dynlib: LLVMLib.}
proc getSectionContents*(si: SectionIteratorRef): cstring {.
    importc: "LLVMGetSectionContents", dynlib: LLVMLib.}
proc getSectionAddress*(si: SectionIteratorRef): uint64T {.
    importc: "LLVMGetSectionAddress", dynlib: LLVMLib.}
proc getSectionContainsSymbol*(si: SectionIteratorRef; sym: SymbolIteratorRef): Bool {.
    importc: "LLVMGetSectionContainsSymbol", dynlib: LLVMLib.}
##  Section Relocation iterators

proc getRelocations*(section: SectionIteratorRef): RelocationIteratorRef {.
    importc: "LLVMGetRelocations", dynlib: LLVMLib.}
proc disposeRelocationIterator*(ri: RelocationIteratorRef) {.
    importc: "LLVMDisposeRelocationIterator", dynlib: LLVMLib.}
proc isRelocationIteratorAtEnd*(section: SectionIteratorRef;
                               ri: RelocationIteratorRef): Bool {.
    importc: "LLVMIsRelocationIteratorAtEnd", dynlib: LLVMLib.}
proc moveToNextRelocation*(ri: RelocationIteratorRef) {.
    importc: "LLVMMoveToNextRelocation", dynlib: LLVMLib.}
##  SymbolRef accessors

proc getSymbolName*(si: SymbolIteratorRef): cstring {.importc: "LLVMGetSymbolName",
    dynlib: LLVMLib.}
proc getSymbolAddress*(si: SymbolIteratorRef): uint64T {.
    importc: "LLVMGetSymbolAddress", dynlib: LLVMLib.}
proc getSymbolSize*(si: SymbolIteratorRef): uint64T {.importc: "LLVMGetSymbolSize",
    dynlib: LLVMLib.}
##  RelocationRef accessors

proc getRelocationOffset*(ri: RelocationIteratorRef): uint64T {.
    importc: "LLVMGetRelocationOffset", dynlib: LLVMLib.}
proc getRelocationSymbol*(ri: RelocationIteratorRef): SymbolIteratorRef {.
    importc: "LLVMGetRelocationSymbol", dynlib: LLVMLib.}
proc getRelocationType*(ri: RelocationIteratorRef): uint64T {.
    importc: "LLVMGetRelocationType", dynlib: LLVMLib.}
##  NOTE: Caller takes ownership of returned string of the two
##  following functions.

proc getRelocationTypeName*(ri: RelocationIteratorRef): cstring {.
    importc: "LLVMGetRelocationTypeName", dynlib: LLVMLib.}
proc getRelocationValueString*(ri: RelocationIteratorRef): cstring {.
    importc: "LLVMGetRelocationValueString", dynlib: LLVMLib.}
## *
##  @}
## 
