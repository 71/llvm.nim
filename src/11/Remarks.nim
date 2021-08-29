const
  REMARKS_API_VERSION* = 1

type
  RemarkStringRef* = ptr RemarkOpaqueString
  RemarkDebugLocRef* = ptr RemarkOpaqueDebugLog
  RemarkArgRef* = ptr RemarkOpaqueArg
  RemarkEntryRef* = ptr RemarkOpaqueEntry
  RemarkParserRef* = ptr RemarkOpaqueParser

  RemarkType* = enum
    RemarkTypeUnknown
    RemarkTypePassed
    RemarkTypeMissed
    RemarkTypeAnalysis,
    RemarkTypeAnalysisFPCommute
    RemarkTypeAnalysisAliasing
    RemarkTypeFailure


## Returns the buffer holding the string.
proc RemarkStringGetData*(str: RemarkStringRef): cstring {.llvmc.}

## Returns the size of the string.
proc RemarkStringGetLen*(str: RemarkStringRef): uint32 {.llvmc.}

## Return the path to the source file for a debug location.
proc RemarkDebugLocGetSourceFilePath*(dl: RemarkDebugLocRef): RemarkStringRef {.llvmc.}

## Return the line in the source file for a debug location.
proc RemarkDebugLocGetSourceLine*(dl: RemarkDebugLocRef): uint32 {.llvmc.}

## Return the column in the source file for a debug location.
proc RemarkDebugLocGetSourceColumn*(dl: RemarkDebugLocRef): uint32 {.llvmc.}

## Returns the key of an argument.
proc RemarkArgGetKey*(arg: RemarkArgRef): RemarkStringRef {.llvmc.}

## Returns the value of an argument.
proc RemarkArgGetValue*(arg: RemarkArgRef): RemarkStringRef {.llvmc.}

## Returns the debug location that is attached to the value of this argument.
proc RemarkArgGetDebugLoc*(arg: RemarkArgRef): RemarkDebugLocRef {.llvmc.}

## Free the resources used by the remark entry.
proc RemarkEntryDispose*(remark: RemarkEntryRef) {.llvmc.}

## The type of the remark.
proc RemarkEntryGetType*(remark: RemarkEntryRef): RemarkType {.llvmc.}

## Get the name of the pass that emitted this remark.
proc RemarkEntryGetPassName*(remark: RemarkEntryRef): RemarkStringRef {.llvmc.}

##  Get an identifier of the remark.
proc RemarkEntryGetRemarkName*(remark: RemarkEntryRef): RemarkStringRef {.llvmc.}

## Get the name of the function being processed when the remark was emitted.
proc RemarkEntryGetFunctionName*(remark: RemarkEntryRef): RemarkStringRef {.llvmc.}

## Returns the debug location that is attached to this remark.
proc RemarkEntryGetDebugLoc*(remark: RemarkEntryRef): RemarkDebugLocRef {.llvmc.}

## Return the hotness of the remark.
proc RemarkEntryGetHotness*(remark: RemarkEntryRef): uint64 {.llvmc.}

## The number of arguments the remark holds.
proc RemarkEntryGetNumArgs*(remark: RemarkEntryRef): uint32 {.llvmc.}

## Get a new iterator to iterate over a remark's argument.
proc RemarkEntryGetFirstArg*(remark: RemarkEntryRef): RemarkArgRef {.llvmc.}

## Get the next argument in Remark from the position of It.
proc RemarkEntryGetNextArg*(it: RemarkArgRef, remark: RemarkEntryRef): RemarkArgRef {.llvmc.}

## Creates a remark parser that can be used to parse the buffer located in Buf of size Size bytes.
proc RemarkParserCreateYAML*(buf: cstring, size: uint64): RemarkParserRef {.llvmc.}

## Creates a remark parser that can be used to parse the buffer located in Buf of size Size bytes.
proc RemarkParserCreateBitstream*(buf: cstring, size: uint64): RemarkParserRef {.llvmc.}

## Returns the next remark in the file.
proc RemarkParserGetNext*(parser: RemarkParserRef): RemarkEntryRef {.llvmc.}

## Returns 1 if the parser encountered an error while parsing the buffer.
proc RemarkParserHasError*(parser: RemarkParserRef): Bool {.llvmc.}

## Returns a null-terminated string containing an error message.
proc RemarkParserGetErrorMessage*(parser: RemarkParserRef): cstring {.llvmc.}

## Releases all the resources used by Parser.
proc RemarkParserDispose*(parser: RemarkParserRef) {.llvmc.}

## Returns the version of the remarks library.
proc RemarkVersion*(): uint32 {.llvmc.}