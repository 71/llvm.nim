
import llvm

proc allocCStringArray*(a: openArray[string]): cstringArray =
  ## creates a NULL terminated cstringArray from `a`. The result has to
  ## be freed with `deallocCStringArray` after it's not needed anymore.
  result = cast[cstringArray](alloc0((a.len+1) * sizeof(cstring)))
  for i in 0 .. a.high:
    # XXX get rid of this string copy here:
    var x = a[i]
    result[i] = cast[cstring](alloc0(x.len+1))
    copyMem(result[i], addr(x[0]), x.len)

proc deallocCStringArray*(a: cstringArray) =
  ## frees a NULL terminated cstringArray.
  var i = 0
  while a[i] != nil:
    dealloc(a[i])
    inc(i)
    dealloc(a)

{.emit: """
LLVM_InitializeNativeTarget();
LLVM_InitializeNativeAsmPrinter();
LLVM_InitializeNativeAsmParser();
LLVM_InitializeNativeDisassembler();
""" .}

# initializeNativeTarget()

let ctx = contextCreate()
let module = moduleCreateWithNameInContext("world", ctx)
let builder = createBuilderInContext(ctx)

let err = allocCStringArray(["a", "b", "c"])

converter toPtr[I, T](x: array[I, T]): ptr T = cast[ptr T](addr x)

let i64t = intTypeInContext(ctx, 64)
var args = [i64t, i64t, i64t]
let fnt  = functionType(i64t, addr args[0], 3, false)

let fn = addFunction(module, "hello", fnt)
let bb = appendBasicBlockInContext(ctx, fn, "entry")

positionBuilderAtEnd(builder, bb)

let x = getParam(fn, 0)
let y = getParam(fn, 1)
let z = getParam(fn, 2)

let xysum  = buildAdd(builder, x, y, "sum_xy")
let xyzsum = buildAdd(builder, xysum, z, "sum_xyz")

discard buildRet(builder, xyzsum)

var ee: ExecutionEngineRef

if not createJITCompilerForModule(addr ee, module, 0, err):
  echo "Error..."

# echo "fn: " & $printValueToString(fn)
# let fnAddr = getFunctionAddress(ee, "hello")
var aargs = [
  createGenericValueOfInt(i64t, 1, true),
  createGenericValueOfInt(i64t, 2, true),
  createGenericValueOfInt(i64t, 3, true)
]

let res = runFunction(ee, fn, 3, addr aargs[0])

echo "result: " & $genericValueToInt(res, true)

# echo "fnAddr: " & $fnAddr

# let sum  = cast[ptr proc(x,y,z: int64): int64](fnAddr)

# echo "Sum: " & $sum[](1, 2, 3)
echo "Hello world"
