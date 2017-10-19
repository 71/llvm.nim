## ===-- llvm-c/lto.h - LTO Public C Interface ---------------------*- C -*-===*\
## |*                                                                            *|
## |*                     The LLVM Compiler Infrastructure                       *|
## |*                                                                            *|
## |* This file is distributed under the University of Illinois Open Source      *|
## |* License. See LICENSE.TXT for details.                                      *|
## |*                                                                            *|
## |*===----------------------------------------------------------------------===*|
## |*                                                                            *|
## |* This header provides public interface to an abstract link time optimization*|
## |* library.  LLVM provides an implementation of this interface for use with   *|
## |* llvm bitcode files.                                                        *|
## |*                                                                            *|
## \*===----------------------------------------------------------------------===

when not defined(__cplusplus):
  when not defined(msc_Ver):
    type
      LtoBoolT* = bool
  else:
    ##  MSVC in particular does not have anything like _Bool or bool in C, but we can
    ##    at least make sure the type is the same size.  The implementation side will
    ##    use C++ bool.
    type
      LtoBoolT* = cuchar
else:
  type
    LtoBoolT* = bool
## *
##  @defgroup LLVMCLTO LTO
##  @ingroup LLVMC
## 
##  @{
## 

const
  LTO_API_VERSION* = 17

## *
##  \since prior to LTO_API_VERSION=3
## 

type
  LtoSymbolAttributes* {.size: sizeof(cint).} = enum
    LTO_SYMBOL_ALIGNMENT_MASK = 0x0000001F, ##  log2 of alignment
    LTO_SYMBOL_PERMISSIONS_RODATA = 0x00000080,
    LTO_SYMBOL_PERMISSIONS_CODE = 0x000000A0,
    LTO_SYMBOL_PERMISSIONS_DATA = 0x000000C0,
    LTO_SYMBOL_PERMISSIONS_MASK = 0x000000E0,
    LTO_SYMBOL_DEFINITION_REGULAR = 0x00000100,
    LTO_SYMBOL_DEFINITION_TENTATIVE = 0x00000200,
    LTO_SYMBOL_DEFINITION_WEAK = 0x00000300,
    LTO_SYMBOL_DEFINITION_UNDEFINED = 0x00000400,
    LTO_SYMBOL_DEFINITION_WEAKUNDEF = 0x00000500,
    LTO_SYMBOL_DEFINITION_MASK = 0x00000700,
    LTO_SYMBOL_SCOPE_INTERNAL = 0x00000800, LTO_SYMBOL_SCOPE_HIDDEN = 0x00001000,
    LTO_SYMBOL_SCOPE_DEFAULT = 0x00001800, LTO_SYMBOL_SCOPE_PROTECTED = 0x00002000,
    LTO_SYMBOL_SCOPE_DEFAULT_CAN_BE_HIDDEN = 0x00002800,
    LTO_SYMBOL_SCOPE_MASK = 0x00003800, LTO_SYMBOL_COMDAT = 0x00004000,
    LTO_SYMBOL_ALIAS = 0x00008000


## *
##  \since prior to LTO_API_VERSION=3
## 

type
  LtoDebugModel* {.size: sizeof(cint).} = enum
    LTO_DEBUG_MODEL_NONE = 0, LTO_DEBUG_MODEL_DWARF = 1


## *
##  \since prior to LTO_API_VERSION=3
## 

type
  LtoCodegenModel* {.size: sizeof(cint).} = enum
    LTO_CODEGEN_PIC_MODEL_STATIC = 0, LTO_CODEGEN_PIC_MODEL_DYNAMIC = 1,
    LTO_CODEGEN_PIC_MODEL_DYNAMIC_NO_PIC = 2, LTO_CODEGEN_PIC_MODEL_DEFAULT = 3


## * opaque reference to a loaded object module

type
  LtoModuleT* = ptr OpaqueLTOModule

## * opaque reference to a code generator

type
  LtoCodeGenT* = ptr OpaqueLTOCodeGenerator

## *
##  Returns a printable string.
## 
##  \since prior to LTO_API_VERSION=3
## 

proc ltoGetVersion*(): cstring {.importc: "lto_get_version", dynlib: LLVMLib.}
## *
##  Returns the last error string or NULL if last operation was successful.
## 
##  \since prior to LTO_API_VERSION=3
## 

proc ltoGetErrorMessage*(): cstring {.importc: "lto_get_error_message",
                                   dynlib: LLVMLib.}
## *
##  Checks if a file is a loadable object file.
## 
##  \since prior to LTO_API_VERSION=3
## 

proc ltoModuleIsObjectFile*(path: cstring): LtoBoolT {.
    importc: "lto_module_is_object_file", dynlib: LLVMLib.}
## *
##  Checks if a file is a loadable object compiled for requested target.
## 
##  \since prior to LTO_API_VERSION=3
## 

proc ltoModuleIsObjectFileForTarget*(path: cstring; targetTriplePrefix: cstring): LtoBoolT {.
    importc: "lto_module_is_object_file_for_target", dynlib: LLVMLib.}
## *
##  Checks if a buffer is a loadable object file.
## 
##  \since prior to LTO_API_VERSION=3
## 

proc ltoModuleIsObjectFileInMemory*(mem: pointer; length: csize): LtoBoolT {.
    importc: "lto_module_is_object_file_in_memory", dynlib: LLVMLib.}
## *
##  Checks if a buffer is a loadable object compiled for requested target.
## 
##  \since prior to LTO_API_VERSION=3
## 

proc ltoModuleIsObjectFileInMemoryForTarget*(mem: pointer; length: csize;
    targetTriplePrefix: cstring): LtoBoolT {.
    importc: "lto_module_is_object_file_in_memory_for_target", dynlib: LLVMLib.}
## *
##  Loads an object file from disk.
##  Returns NULL on error (check lto_get_error_message() for details).
## 
##  \since prior to LTO_API_VERSION=3
## 

proc ltoModuleCreate*(path: cstring): LtoModuleT {.importc: "lto_module_create",
    dynlib: LLVMLib.}
## *
##  Loads an object file from memory.
##  Returns NULL on error (check lto_get_error_message() for details).
## 
##  \since prior to LTO_API_VERSION=3
## 

proc ltoModuleCreateFromMemory*(mem: pointer; length: csize): LtoModuleT {.
    importc: "lto_module_create_from_memory", dynlib: LLVMLib.}
## *
##  Loads an object file from memory with an extra path argument.
##  Returns NULL on error (check lto_get_error_message() for details).
## 
##  \since LTO_API_VERSION=9
## 

proc ltoModuleCreateFromMemoryWithPath*(mem: pointer; length: csize; path: cstring): LtoModuleT {.
    importc: "lto_module_create_from_memory_with_path", dynlib: LLVMLib.}
## *
##  \brief Loads an object file in its own context.
## 
##  Loads an object file in its own LLVMContext.  This function call is
##  thread-safe.  However, modules created this way should not be merged into an
##  lto_code_gen_t using \a lto_codegen_add_module().
## 
##  Returns NULL on error (check lto_get_error_message() for details).
## 
##  \since LTO_API_VERSION=11
## 

proc ltoModuleCreateInLocalContext*(mem: pointer; length: csize; path: cstring): LtoModuleT {.
    importc: "lto_module_create_in_local_context", dynlib: LLVMLib.}
## *
##  \brief Loads an object file in the codegen context.
## 
##  Loads an object file into the same context as \c cg.  The module is safe to
##  add using \a lto_codegen_add_module().
## 
##  Returns NULL on error (check lto_get_error_message() for details).
## 
##  \since LTO_API_VERSION=11
## 

proc ltoModuleCreateInCodegenContext*(mem: pointer; length: csize; path: cstring;
                                     cg: LtoCodeGenT): LtoModuleT {.
    importc: "lto_module_create_in_codegen_context", dynlib: LLVMLib.}
## *
##  Loads an object file from disk. The seek point of fd is not preserved.
##  Returns NULL on error (check lto_get_error_message() for details).
## 
##  \since LTO_API_VERSION=5
## 

proc ltoModuleCreateFromFd*(fd: cint; path: cstring; fileSize: csize): LtoModuleT {.
    importc: "lto_module_create_from_fd", dynlib: LLVMLib.}
## *
##  Loads an object file from disk. The seek point of fd is not preserved.
##  Returns NULL on error (check lto_get_error_message() for details).
## 
##  \since LTO_API_VERSION=5
## 

proc ltoModuleCreateFromFdAtOffset*(fd: cint; path: cstring; fileSize: csize;
                                   mapSize: csize; offset: OffT): LtoModuleT {.
    importc: "lto_module_create_from_fd_at_offset", dynlib: LLVMLib.}
## *
##  Frees all memory internally allocated by the module.
##  Upon return the lto_module_t is no longer valid.
## 
##  \since prior to LTO_API_VERSION=3
## 

proc ltoModuleDispose*(`mod`: LtoModuleT) {.importc: "lto_module_dispose",
    dynlib: LLVMLib.}
## *
##  Returns triple string which the object module was compiled under.
## 
##  \since prior to LTO_API_VERSION=3
## 

proc ltoModuleGetTargetTriple*(`mod`: LtoModuleT): cstring {.
    importc: "lto_module_get_target_triple", dynlib: LLVMLib.}
## *
##  Sets triple string with which the object will be codegened.
## 
##  \since LTO_API_VERSION=4
## 

proc ltoModuleSetTargetTriple*(`mod`: LtoModuleT; triple: cstring) {.
    importc: "lto_module_set_target_triple", dynlib: LLVMLib.}
## *
##  Returns the number of symbols in the object module.
## 
##  \since prior to LTO_API_VERSION=3
## 

proc ltoModuleGetNumSymbols*(`mod`: LtoModuleT): cuint {.
    importc: "lto_module_get_num_symbols", dynlib: LLVMLib.}
## *
##  Returns the name of the ith symbol in the object module.
## 
##  \since prior to LTO_API_VERSION=3
## 

proc ltoModuleGetSymbolName*(`mod`: LtoModuleT; index: cuint): cstring {.
    importc: "lto_module_get_symbol_name", dynlib: LLVMLib.}
## *
##  Returns the attributes of the ith symbol in the object module.
## 
##  \since prior to LTO_API_VERSION=3
## 

proc ltoModuleGetSymbolAttribute*(`mod`: LtoModuleT; index: cuint): LtoSymbolAttributes {.
    importc: "lto_module_get_symbol_attribute", dynlib: LLVMLib.}
## *
##  Returns the module's linker options.
## 
##  The linker options may consist of multiple flags. It is the linker's
##  responsibility to split the flags using a platform-specific mechanism.
## 
##  \since LTO_API_VERSION=16
## 

proc ltoModuleGetLinkeropts*(`mod`: LtoModuleT): cstring {.
    importc: "lto_module_get_linkeropts", dynlib: LLVMLib.}
## *
##  Diagnostic severity.
## 
##  \since LTO_API_VERSION=7
## 

type
  LtoCodegenDiagnosticSeverityT* {.size: sizeof(cint).} = enum
    LTO_DS_ERROR = 0, LTO_DS_WARNING = 1, LTO_DS_NOTE = 2, LTO_DS_REMARK = 3 ##  Added in LTO_API_VERSION=10.


## *
##  Diagnostic handler type.
##  \p severity defines the severity.
##  \p diag is the actual diagnostic.
##  The diagnostic is not prefixed by any of severity keyword, e.g., 'error: '.
##  \p ctxt is used to pass the context set with the diagnostic handler.
## 
##  \since LTO_API_VERSION=7
## 

type
  LtoDiagnosticHandlerT* = proc (severity: LtoCodegenDiagnosticSeverityT;
                              diag: cstring; ctxt: pointer)

## *
##  Set a diagnostic handler and the related context (void *).
##  This is more general than lto_get_error_message, as the diagnostic handler
##  can be called at anytime within lto.
## 
##  \since LTO_API_VERSION=7
## 

proc ltoCodegenSetDiagnosticHandler*(a2: LtoCodeGenT; a3: LtoDiagnosticHandlerT;
                                    a4: pointer) {.
    importc: "lto_codegen_set_diagnostic_handler", dynlib: LLVMLib.}
## *
##  Instantiates a code generator.
##  Returns NULL on error (check lto_get_error_message() for details).
## 
##  All modules added using \a lto_codegen_add_module() must have been created
##  in the same context as the codegen.
## 
##  \since prior to LTO_API_VERSION=3
## 

proc ltoCodegenCreate*(): LtoCodeGenT {.importc: "lto_codegen_create",
                                     dynlib: LLVMLib.}
## *
##  \brief Instantiate a code generator in its own context.
## 
##  Instantiates a code generator in its own context.  Modules added via \a
##  lto_codegen_add_module() must have all been created in the same context,
##  using \a lto_module_create_in_codegen_context().
## 
##  \since LTO_API_VERSION=11
## 

proc ltoCodegenCreateInLocalContext*(): LtoCodeGenT {.
    importc: "lto_codegen_create_in_local_context", dynlib: LLVMLib.}
## *
##  Frees all code generator and all memory it internally allocated.
##  Upon return the lto_code_gen_t is no longer valid.
## 
##  \since prior to LTO_API_VERSION=3
## 

proc ltoCodegenDispose*(a2: LtoCodeGenT) {.importc: "lto_codegen_dispose",
                                        dynlib: LLVMLib.}
## *
##  Add an object module to the set of modules for which code will be generated.
##  Returns true on error (check lto_get_error_message() for details).
## 
##  \c cg and \c mod must both be in the same context.  See \a
##  lto_codegen_create_in_local_context() and \a
##  lto_module_create_in_codegen_context().
## 
##  \since prior to LTO_API_VERSION=3
## 

proc ltoCodegenAddModule*(cg: LtoCodeGenT; `mod`: LtoModuleT): LtoBoolT {.
    importc: "lto_codegen_add_module", dynlib: LLVMLib.}
## *
##  Sets the object module for code generation. This will transfer the ownship of
##  the module to code generator.
## 
##  \c cg and \c mod must both be in the same context.
## 
##  \since LTO_API_VERSION=13
## 

proc ltoCodegenSetModule*(cg: LtoCodeGenT; `mod`: LtoModuleT) {.
    importc: "lto_codegen_set_module", dynlib: LLVMLib.}
## *
##  Sets if debug info should be generated.
##  Returns true on error (check lto_get_error_message() for details).
## 
##  \since prior to LTO_API_VERSION=3
## 

proc ltoCodegenSetDebugModel*(cg: LtoCodeGenT; a3: LtoDebugModel): LtoBoolT {.
    importc: "lto_codegen_set_debug_model", dynlib: LLVMLib.}
## *
##  Sets which PIC code model to generated.
##  Returns true on error (check lto_get_error_message() for details).
## 
##  \since prior to LTO_API_VERSION=3
## 

proc ltoCodegenSetPicModel*(cg: LtoCodeGenT; a3: LtoCodegenModel): LtoBoolT {.
    importc: "lto_codegen_set_pic_model", dynlib: LLVMLib.}
## *
##  Sets the cpu to generate code for.
## 
##  \since LTO_API_VERSION=4
## 

proc ltoCodegenSetCpu*(cg: LtoCodeGenT; cpu: cstring) {.
    importc: "lto_codegen_set_cpu", dynlib: LLVMLib.}
## *
##  Sets the location of the assembler tool to run. If not set, libLTO
##  will use gcc to invoke the assembler.
## 
##  \since LTO_API_VERSION=3
## 

proc ltoCodegenSetAssemblerPath*(cg: LtoCodeGenT; path: cstring) {.
    importc: "lto_codegen_set_assembler_path", dynlib: LLVMLib.}
## *
##  Sets extra arguments that libLTO should pass to the assembler.
## 
##  \since LTO_API_VERSION=4
## 

proc ltoCodegenSetAssemblerArgs*(cg: LtoCodeGenT; args: cstringArray; nargs: cint) {.
    importc: "lto_codegen_set_assembler_args", dynlib: LLVMLib.}
## *
##  Adds to a list of all global symbols that must exist in the final generated
##  code. If a function is not listed there, it might be inlined into every usage
##  and optimized away.
## 
##  \since prior to LTO_API_VERSION=3
## 

proc ltoCodegenAddMustPreserveSymbol*(cg: LtoCodeGenT; symbol: cstring) {.
    importc: "lto_codegen_add_must_preserve_symbol", dynlib: LLVMLib.}
## *
##  Writes a new object file at the specified path that contains the
##  merged contents of all modules added so far.
##  Returns true on error (check lto_get_error_message() for details).
## 
##  \since LTO_API_VERSION=5
## 

proc ltoCodegenWriteMergedModules*(cg: LtoCodeGenT; path: cstring): LtoBoolT {.
    importc: "lto_codegen_write_merged_modules", dynlib: LLVMLib.}
## *
##  Generates code for all added modules into one native object file.
##  This calls lto_codegen_optimize then lto_codegen_compile_optimized.
## 
##  On success returns a pointer to a generated mach-o/ELF buffer and
##  length set to the buffer size.  The buffer is owned by the
##  lto_code_gen_t and will be freed when lto_codegen_dispose()
##  is called, or lto_codegen_compile() is called again.
##  On failure, returns NULL (check lto_get_error_message() for details).
## 
##  \since prior to LTO_API_VERSION=3
## 

proc ltoCodegenCompile*(cg: LtoCodeGenT; length: ptr csize): pointer {.
    importc: "lto_codegen_compile", dynlib: LLVMLib.}
## *
##  Generates code for all added modules into one native object file.
##  This calls lto_codegen_optimize then lto_codegen_compile_optimized (instead
##  of returning a generated mach-o/ELF buffer, it writes to a file).
## 
##  The name of the file is written to name. Returns true on error.
## 
##  \since LTO_API_VERSION=5
## 

proc ltoCodegenCompileToFile*(cg: LtoCodeGenT; name: cstringArray): LtoBoolT {.
    importc: "lto_codegen_compile_to_file", dynlib: LLVMLib.}
## *
##  Runs optimization for the merged module. Returns true on error.
## 
##  \since LTO_API_VERSION=12
## 

proc ltoCodegenOptimize*(cg: LtoCodeGenT): LtoBoolT {.
    importc: "lto_codegen_optimize", dynlib: LLVMLib.}
## *
##  Generates code for the optimized merged module into one native object file.
##  It will not run any IR optimizations on the merged module.
## 
##  On success returns a pointer to a generated mach-o/ELF buffer and length set
##  to the buffer size.  The buffer is owned by the lto_code_gen_t and will be
##  freed when lto_codegen_dispose() is called, or
##  lto_codegen_compile_optimized() is called again. On failure, returns NULL
##  (check lto_get_error_message() for details).
## 
##  \since LTO_API_VERSION=12
## 

proc ltoCodegenCompileOptimized*(cg: LtoCodeGenT; length: ptr csize): pointer {.
    importc: "lto_codegen_compile_optimized", dynlib: LLVMLib.}
## *
##  Returns the runtime API version.
## 
##  \since LTO_API_VERSION=12
## 

proc ltoApiVersion*(): cuint {.importc: "lto_api_version", dynlib: LLVMLib.}
## *
##  Sets options to help debug codegen bugs.
## 
##  \since prior to LTO_API_VERSION=3
## 

proc ltoCodegenDebugOptions*(cg: LtoCodeGenT; a3: cstring) {.
    importc: "lto_codegen_debug_options", dynlib: LLVMLib.}
## *
##  Initializes LLVM disassemblers.
##  FIXME: This doesn't really belong here.
## 
##  \since LTO_API_VERSION=5
## 

proc ltoInitializeDisassembler*() {.importc: "lto_initialize_disassembler",
                                  dynlib: LLVMLib.}
## *
##  Sets if we should run internalize pass during optimization and code
##  generation.
## 
##  \since LTO_API_VERSION=14
## 

proc ltoCodegenSetShouldInternalize*(cg: LtoCodeGenT; shouldInternalize: LtoBoolT) {.
    importc: "lto_codegen_set_should_internalize", dynlib: LLVMLib.}
## *
##  \brief Set whether to embed uselists in bitcode.
## 
##  Sets whether \a lto_codegen_write_merged_modules() should embed uselists in
##  output bitcode.  This should be turned on for all -save-temps output.
## 
##  \since LTO_API_VERSION=15
## 

proc ltoCodegenSetShouldEmbedUselists*(cg: LtoCodeGenT;
                                      shouldEmbedUselists: LtoBoolT) {.
    importc: "lto_codegen_set_should_embed_uselists", dynlib: LLVMLib.}
## *
##  @}
## 
