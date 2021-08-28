
# Utilities used by all wrappers:
import macros
from strutils import replace, toUpperAscii

macro declAll(types: varargs[untyped]): untyped =
  template declType(t: untyped): untyped =
    type t {. pure, final .} = object

  result = newNimNode(nnkStmtList, types)

  for ty in types:
    result.add(getAst(declType(ty)))

# Opaque handles to various things
declAll(
  OpaqueAttributeRef, OpaqueContext, OpaqueModule, OpaqueType, OpaqueValue, OpaqueBasicBlock, OpaqueBuilder,
  OpaqueModuleProvider, OpaquePassManager, OpaquePassRegistry, OpaqueUse, OpaqueDiagnosticInfo,
  OpaqueTargetMachine, OpaquePassManagerBuilder, OpaqueMetadata, target, OpaqueTargetData,
  OpaqueTargetLibraryInfotData, OpaqueMemoryBuffer, OpaqueDIBuilder, OpaqueGenericValue, OpaqueExecutionEngine,
  OpaqueMCJITMemoryManager,
  OpaqueModuleFlagEntry, OpaqueNamedMDNode, OpaqueValueMetadataEntry, OpaqueJITEventListener,
  RemarkOpaqueString, RemarkOpaqueDebugLog, RemarkOpaqueArg, RemarkOpaqueEntry, RemarkOpaqueParser
)


type
  # Funny type names that came out of c2nim
  uint64T = uint64
  uint8T = uint8
  uintptrT = uint

# Import the matching version:
const
  LLVMV* {. intdefine .} = 11
  LLVMLib* {. strdefine .} = "libLLVM-" & $LLVMV & ".so"
  canDumpType* = false

macro includeAll(version: static[string]): untyped =
  result = newNimNode(nnkStmtList)

  for file in ["Types", "Support", "Core", "Remarks", "Target", "TargetMachine", "ExecutionEngine", "BitReader", "BitWriter", "IRReader", "Linker",
               "Initialization", "Transforms"]:
    result.add newTree(nnkIncludeStmt, newIdentNode($version & "/" & file))

when LLVMV == 0:
  {.error: "No LLVM version was specified." .}


{.passC: gorge("llvm-config-" & $LLVMV & " --cflags") .}
{.passL: gorge("llvm-config-" & $LLVMV & " --ldflags --libs").replace("\n", "").}

when LLVMV < 11:
  {.compile: "wrapper.c".}

{.pragma: llvmc, importc: "LLVM$1", dynlib: LLVMLib.}

includeAll $LLVMV

converter LLVMBoolToNim*(b: Bool): bool =
  b == 1

converter NimBoolToLLVM*(b: bool): Bool =
  if b: 1 else: 0
