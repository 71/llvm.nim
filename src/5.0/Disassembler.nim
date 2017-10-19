## ===-- llvm-c/Disassembler.h - Disassembler Public C Interface ---*- C -*-===*\
## |*                                                                            *|
## |*                     The LLVM Compiler Infrastructure                       *|
## |*                                                                            *|
## |* This file is distributed under the University of Illinois Open Source      *|
## |* License. See LICENSE.TXT for details.                                      *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*|
## |*                                                                            *|
## |* This header provides a public interface to a disassembler library.         *|
## |* LLVM provides an implementation of this interface.                         *|
## |*                                                                            *|
## \*===----------------------------------------------------------------------===

## *
##  @defgroup LLVMCDisassembler Disassembler
##  @ingroup LLVMC
## 
##  @{
## 
## *
##  An opaque reference to a disassembler context.
## 

type
  DisasmContextRef* = pointer

## *
##  The type for the operand information call back function.  This is called to
##  get the symbolic information for an operand of an instruction.  Typically
##  this is from the relocation information, symbol table, etc.  That block of
##  information is saved when the disassembler context is created and passed to
##  the call back in the DisInfo parameter.  The instruction containing operand
##  is at the PC parameter.  For some instruction sets, there can be more than
##  one operand with symbolic information.  To determine the symbolic operand
##  information for each operand, the bytes for the specific operand in the
##  instruction are specified by the Offset parameter and its byte widith is the
##  size parameter.  For instructions sets with fixed widths and one symbolic
##  operand per instruction, the Offset parameter will be zero and Size parameter
##  will be the instruction width.  The information is returned in TagBuf and is
##  Triple specific with its specific information defined by the value of
##  TagType for that Triple.  If symbolic information is returned the function
##  returns 1, otherwise it returns 0.
## 

type
  OpInfoCallback* = proc (disInfo: pointer; pc: uint64T; offset: uint64T; size: uint64T;
                       tagType: cint; tagBuf: pointer): cint

## *
##  The initial support in LLVM MC for the most general form of a relocatable
##  expression is "AddSymbol - SubtractSymbol + Offset".  For some Darwin targets
##  this full form is encoded in the relocation information so that AddSymbol and
##  SubtractSymbol can be link edited independent of each other.  Many other
##  platforms only allow a relocatable expression of the form AddSymbol + Offset
##  to be encoded.
## 
##  The LLVMOpInfoCallback() for the TagType value of 1 uses the struct
##  LLVMOpInfo1.  The value of the relocatable expression for the operand,
##  including any PC adjustment, is passed in to the call back in the Value
##  field.  The symbolic information about the operand is returned using all
##  the fields of the structure with the Offset of the relocatable expression
##  returned in the Value field.  It is possible that some symbols in the
##  relocatable expression were assembly temporary symbols, for example
##  "Ldata - LpicBase + constant", and only the Values of the symbols without
##  symbol names are present in the relocation information.  The VariantKind
##  type is one of the Target specific #defines below and is used to print
##  operands like "_foo@GOT", ":lower16:_foo", etc.
## 

type
  OpInfoSymbol1* {.bycopy.} = object
    present*: uint64T          ##  1 if this symbol is present
    name*: cstring             ##  symbol name if not NULL
    value*: uint64T            ##  symbol value if name is NULL
  
  OpInfo1* {.bycopy.} = object
    addSymbol*: OpInfoSymbol1
    subtractSymbol*: OpInfoSymbol1
    value*: uint64T
    variantKind*: uint64T


## *
##  The operand VariantKinds for symbolic disassembly.
## 

const
  DisassemblerVariantKindNone* = 0

## *
##  The ARM target VariantKinds.
## 

const
  DisassemblerVariantKindARM_HI16* = 1
  DisassemblerVariantKindARM_LO16* = 2

## *
##  The ARM64 target VariantKinds.
## 

const
  DisassemblerVariantKindARM64PAGE* = 1
  DisassemblerVariantKindARM64PAGEOFF* = 2
  DisassemblerVariantKindARM64GOTPAGE* = 3
  DisassemblerVariantKindARM64GOTPAGEOFF* = 4
  DisassemblerVariantKindARM64TLVP* = 5
  DisassemblerVariantKindARM64TLVOFF* = 6

## *
##  The type for the symbol lookup function.  This may be called by the
##  disassembler for things like adding a comment for a PC plus a constant
##  offset load instruction to use a symbol name instead of a load address value.
##  It is passed the block information is saved when the disassembler context is
##  created and the ReferenceValue to look up as a symbol.  If no symbol is found
##  for the ReferenceValue NULL is returned.  The ReferenceType of the
##  instruction is passed indirectly as is the PC of the instruction in
##  ReferencePC.  If the output reference can be determined its type is returned
##  indirectly in ReferenceType along with ReferenceName if any, or that is set
##  to NULL.
## 

type
  SymbolLookupCallback* = proc (disInfo: pointer; referenceValue: uint64T;
                             referenceType: ptr uint64T; referencePC: uint64T;
                             referenceName: cstringArray): cstring

## *
##  The reference types on input and output.
## 
##  No input reference type or no output reference type.

const
  DisassemblerReferenceTypeInOutNone* = 0

##  The input reference is from a branch instruction.

const
  DisassemblerReferenceTypeInBranch* = 1

##  The input reference is from a PC relative load instruction.

const
  DisassemblerReferenceTypeInPCrelLoad* = 2

##  The input reference is from an ARM64::ADRP instruction.

const
  DisassemblerReferenceTypeInARM64ADRP* = 0x0000000100000001'i64

##  The input reference is from an ARM64::ADDXri instruction.

const
  DisassemblerReferenceTypeInARM64ADDXri* = 0x0000000100000002'i64

##  The input reference is from an ARM64::LDRXui instruction.

const
  DisassemblerReferenceTypeInARM64LDRXui* = 0x0000000100000003'i64

##  The input reference is from an ARM64::LDRXl instruction.

const
  DisassemblerReferenceTypeInARM64LDRXl* = 0x0000000100000004'i64

##  The input reference is from an ARM64::ADR instruction.

const
  DisassemblerReferenceTypeInARM64ADR* = 0x0000000100000005'i64

##  The output reference is to as symbol stub.

const
  DisassemblerReferenceTypeOutSymbolStub* = 1

##  The output reference is to a symbol address in a literal pool.

const
  DisassemblerReferenceTypeOutLitPoolSymAddr* = 2

##  The output reference is to a cstring address in a literal pool.

const
  DisassemblerReferenceTypeOutLitPoolCstrAddr* = 3

##  The output reference is to a Objective-C CoreFoundation string.

const
  DisassemblerReferenceTypeOutObjcCFStringRef* = 4

##  The output reference is to a Objective-C message.

const
  DisassemblerReferenceTypeOutObjcMessage* = 5

##  The output reference is to a Objective-C message ref.

const
  DisassemblerReferenceTypeOutObjcMessageRef* = 6

##  The output reference is to a Objective-C selector ref.

const
  DisassemblerReferenceTypeOutObjcSelectorRef* = 7

##  The output reference is to a Objective-C class ref.

const
  DisassemblerReferenceTypeOutObjcClassRef* = 8

##  The output reference is to a C++ symbol name.

const
  DisassemblerReferenceTypeDeMangledName* = 9

## *
##  Create a disassembler for the TripleName.  Symbolic disassembly is supported
##  by passing a block of information in the DisInfo parameter and specifying the
##  TagType and callback functions as described above.  These can all be passed
##  as NULL.  If successful, this returns a disassembler context.  If not, it
##  returns NULL. This function is equivalent to calling
##  LLVMCreateDisasmCPUFeatures() with an empty CPU name and feature set.
## 

proc createDisasm*(tripleName: cstring; disInfo: pointer; tagType: cint;
                  getOpInfo: OpInfoCallback; symbolLookUp: SymbolLookupCallback): DisasmContextRef {.
    importc: "LLVMCreateDisasm", dynlib: LLVMLib.}
## *
##  Create a disassembler for the TripleName and a specific CPU.  Symbolic
##  disassembly is supported by passing a block of information in the DisInfo
##  parameter and specifying the TagType and callback functions as described
##  above.  These can all be passed * as NULL.  If successful, this returns a
##  disassembler context.  If not, it returns NULL. This function is equivalent
##  to calling LLVMCreateDisasmCPUFeatures() with an empty feature set.
## 

proc createDisasmCPU*(triple: cstring; cpu: cstring; disInfo: pointer; tagType: cint;
                     getOpInfo: OpInfoCallback; symbolLookUp: SymbolLookupCallback): DisasmContextRef {.
    importc: "LLVMCreateDisasmCPU", dynlib: LLVMLib.}
## *
##  Create a disassembler for the TripleName, a specific CPU and specific feature
##  string.  Symbolic disassembly is supported by passing a block of information
##  in the DisInfo parameter and specifying the TagType and callback functions as
##  described above.  These can all be passed * as NULL.  If successful, this
##  returns a disassembler context.  If not, it returns NULL.
## 

proc createDisasmCPUFeatures*(triple: cstring; cpu: cstring; features: cstring;
                             disInfo: pointer; tagType: cint;
                             getOpInfo: OpInfoCallback;
                             symbolLookUp: SymbolLookupCallback): DisasmContextRef {.
    importc: "LLVMCreateDisasmCPUFeatures", dynlib: LLVMLib.}
## *
##  Set the disassembler's options.  Returns 1 if it can set the Options and 0
##  otherwise.
## 

proc setDisasmOptions*(dc: DisasmContextRef; options: uint64T): cint {.
    importc: "LLVMSetDisasmOptions", dynlib: LLVMLib.}
##  The option to produce marked up assembly.

const
  DisassemblerOptionUseMarkup* = 1

##  The option to print immediates as hex.

const
  DisassemblerOptionPrintImmHex* = 2

##  The option use the other assembler printer variant

const
  DisassemblerOptionAsmPrinterVariant* = 4

##  The option to set comment on instructions

const
  DisassemblerOptionSetInstrComments* = 8

##  The option to print latency information alongside instructions

const
  DisassemblerOptionPrintLatency* = 16

## *
##  Dispose of a disassembler context.
## 

proc disasmDispose*(dc: DisasmContextRef) {.importc: "LLVMDisasmDispose",
    dynlib: LLVMLib.}
## *
##  Disassemble a single instruction using the disassembler context specified in
##  the parameter DC.  The bytes of the instruction are specified in the
##  parameter Bytes, and contains at least BytesSize number of bytes.  The
##  instruction is at the address specified by the PC parameter.  If a valid
##  instruction can be disassembled, its string is returned indirectly in
##  OutString whose size is specified in the parameter OutStringSize.  This
##  function returns the number of bytes in the instruction or zero if there was
##  no valid instruction.
## 

proc disasmInstruction*(dc: DisasmContextRef; bytes: ptr uint8T; bytesSize: uint64T;
                       pc: uint64T; outString: cstring; outStringSize: csize): csize {.
    importc: "LLVMDisasmInstruction", dynlib: LLVMLib.}
## *
##  @}
## 
