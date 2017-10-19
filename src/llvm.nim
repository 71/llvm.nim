
# Utilities used by all wrappers:
import macros

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
  OpaqueMCJITMemoryManager
)


type
  # Funny type names that came out of c2nim
  uint64T = uint64
  uint8T = uint8
  uintptrT = uint

# Import the matching version:
const
  LLVMV* {. strdefine .} = "5.0"
  LLVMLib* {. strdefine .} = "libLLVM-" & LLVMV & ".so"
  canDumpType* = false

macro includeAll(version: static[string]): untyped =
  result = newNimNode(nnkStmtList)

  for file in ["Types", "Support", "Core", "Target", "TargetMachine", "ExecutionEngine", "BitReader", "BitWriter", "IRReader", "Linker",
               "Initialization", "Transforms/PassManagerBuilder"]:
    result.add newTree(nnkIncludeStmt, newIdentNode($version & "/" & file))

when LLVMV == "Unknown":
  {.warning: "No LLVM version was specified." .}

{.passC: gorge("llvm-config-" & LLVMV & " --cflags") .}
{.passL: gorge("llvm-config-" & LLVMV & " --cflags --ldflags --libs all") .}

{.compile: "wrapper.c".}

includeAll LLVMV

converter LLVMBoolToNim*(b: Bool): bool =
  b == 1

converter NimBoolToLLVM*(b: bool): Bool =
  if b: 1 else: 0
