
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

InitializeNativeTarget()
InitializeNativeAsmPrinter()
InitializeNativeAsmParser()
InitializeNativeDisassembler()

let ctx = ContextCreate()
let module = ModuleCreateWithNameInContext("world", ctx)
let builder = CreateBuilderInContext(ctx)

if module == nil or builder == nil:
  quit "Error creatre module or builder"

let err = allocCStringArray(["a", "b", "c"])

converter toPtr[I, T](x: array[I, T]): ptr T = cast[ptr T](addr x)

let i64t = IntTypeInContext(ctx, 64)
var args = [i64t, i64t, i64t]
let fnt  = FunctionType(i64t, addr args[0], 3, false)

let fn = AddFunction(module, "hello", fnt)
let bb = AppendBasicBlockInContext(ctx, fn, "entry")

PositionBuilderAtEnd(builder, bb)

let x = GetParam(fn, 0)
let y = GetParam(fn, 1)
let z = GetParam(fn, 2)

let xysum  = BuildAdd(builder, x, y, "sum_xy")
let xyzsum = BuildAdd(builder, xysum, z, "sum_xyz")

discard BuildRet(builder, xyzsum)

var ee: ExecutionEngineRef

if not CreateJITCompilerForModule(addr ee, module, 0, err):
  quit "Error..."

deallocCStringArray(err)

#[
Due to restriction of MCJIT execution egine, RunFunction doesnt work in this case
More detail: https://stackoverflow.com/q/63438899

var aargs = [
  CreateGenericValueOfInt(i64t, 1, true),
  CreateGenericValueOfInt(i64t, 2, true),
  CreateGenericValueOfInt(i64t, 3, true)
]

let res = RunFunction(ee, fn, 3, addr aargs[0])
# echo "result: " & $GenericValueToInt(res, true)
]#

let sum = cast[proc(a,b,c: int64): int64 {.noconv.}](GetFunctionAddress(ee, "hello"))

echo "Sum: ",  $sum(1, 2, 3)

echo "Hello world"

echo  PrintModuleToString(module)
