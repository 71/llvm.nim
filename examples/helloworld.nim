import llvm, osproc

let
  context = ContextCreate()
  module = ModuleCreateWithNameInContext("hello", context)
  builder = CreateBuilderInContext(context)

  i8t = Int8TypeInContext(context)
  i8p = PointerType(i8t, 0)
  i32t = Int32TypeInContext(context)

  puts_function_args_type = [i8p]
  puts_function_type = FunctionType(i32t, unsafeAddr puts_function_args_type[0], 1, false)
  puts_function = AddFunction(module, "puts", puts_function_type)

  main_function_type = FunctionType(i32t, nil, 0, false)
  main_function = AddFunction(module, "main", main_function_type)

  entry = AppendBasicBlockInContext(context, main_function, "entry")

PositionBuilderAtEnd(builder, entry)

var puts_function_args = [
  BuildPointerCast(builder, BuildGlobalString(builder, "Hello world!", "hello"), i8p, "0")
]

discard BuildCall(builder, puts_function, addr puts_function_args[0], 1, "i")
discard BuildRet(builder, ConstInt(i32t, 0, false))


var err = allocCStringArray([""])
if PrintModuleToFile(module, "helloworld.ll", err):
  quit "Error writing file: " & cstringArrayToSeq(err)[0]

deallocCStringArray(err)

DisposeBuilder(builder)
DisposeModule(module)
ContextDispose(context)

# Compile w/ clang
discard execCmd("clang helloworld.ll -o helloworld")
discard execCmd("./helloworld")



