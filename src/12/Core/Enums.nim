##  @{
##
## *
##  @defgroup LLVMCCoreTypes Types and Enumerations
##
##  @{
##
type                          ##  Terminator Instructions
  Opcode* {.size: sizeof(cint).} = enum
    Ret = 1, Br = 2, Switch = 3, IndirectBr = 4, Invoke = 5, ## Terminator Instructions
    ##  removed 6 due to API changes
    Unreachable = 7,            ##  Standard Binary Operators
    Add = 8, FAdd = 9, Sub = 10, FSub = 11, Mul = 12, FMul = 13, UDiv = 14, SDiv = 15, FDiv = 16,
    URem = 17, SRem = 18, FRem = 19,  ##  Logical Operators
    Shl = 20, LShr = 21, AShr = 22, And = 23, Or = 24, Xor = 25, ##  Memory Operators
    Alloca = 26, Load = 27, Store = 28, GetElementPtr = 29, ##  Cast Operators
    Trunc = 30, ZExt = 31, SExt = 32, FPToUI = 33, FPToSI = 34, UIToFP = 35, SIToFP = 36,
    FPTrunc = 37, FPExt = 38, PtrToInt = 39, IntToPtr = 40, BitCast = 41, ICmp = 42, FCmp = 43,
    PHI = 44, Call = 45, Select = 46, UserOp1 = 47, UserOp2 = 48, VAArg = 49, ExtractElement = 50,
    InsertElement = 51, ShuffleVector = 52, ExtractValue = 53, InsertValue = 54, ##  Atomic operators
    Fence = 55, AtomicCmpXchg = 56, AtomicRMW = 57, ##  Exception Handling Operators
    Resume = 58, LandingPad = 59, AddrSpaceCast = 60, ##  Other Operators
    CleanupRet = 61, CatchRet = 62, CatchPad = 63, CleanupPad = 64, CatchSwitch = 65,
    FNeg = 66, ## Standard Unary Operators
    CallBr = 67, Freeze = 68

  TypeKind* {.size: sizeof(cint).} = enum
    VoidTypeKind,             ## *< type with no size
    HalfTypeKind,             ## *< 16 bit floating point type
    FloatTypeKind,            ## *< 32 bit floating point type
    DoubleTypeKind,           ## *< 64 bit floating point type
    X86FP80TypeKind,          ## *< 80 bit floating point type (X87)
    FP128TypeKind,            ## *< 128 bit floating point type (112-bit mantissa)
    PPC_FP128TypeKind,        ## *< 128 bit floating point type (two 64-bits)
    LabelTypeKind,            ## *< Labels
    IntegerTypeKind,          ## *< Arbitrary bit width integers
    FunctionTypeKind,         ## *< Functions
    StructTypeKind,           ## *< Structures
    ArrayTypeKind,            ## *< Arrays
    PointerTypeKind,          ## *< Pointers
    VectorTypeKind,           ## *< SIMD 'packed' format, or other vector type
    MetadataTypeKind,         ## *< Metadata
    X86MMXTypeKind,           ## *< X86 MMX
    TokenTypeKind,            ## *< Tokens
    ScalebleVectorTypeKind,   ## *< Scalable SIMD vector type
    BFloatTypeKind,           ## *< 16 bit brain floating point type
    X86AMXTypeKind            ## *< X86 AMX.
  Linkage* {.size: sizeof(cint).} = enum
    ExternalLinkage,          ## *< Externally visible function
    AvailableExternallyLinkage,
    LinkOnceAnyLinkage,       ## *< Keep one copy of function when linking (inline)
    LinkOnceODRLinkage,       ## *< Same, but only replaced by something
                       ##                             equivalent.
    LinkOnceODRAutoHideLinkage, ## *< Obsolete
    WeakAnyLinkage,           ## *< Keep one copy of function when linking (weak)
    WeakODRLinkage,           ## *< Same, but only replaced by something
                   ##                             equivalent.
    AppendingLinkage,         ## *< Special purpose, only applies to global arrays
    InternalLinkage,          ## *< Rename collisions when linking (static
                    ##                                functions)
    PrivateLinkage,           ## *< Like Internal, but omit from symbol table
    DLLImportLinkage,         ## *< Obsolete
    DLLExportLinkage,         ## *< Obsolete
    ExternalWeakLinkage,      ## *< ExternalWeak linkage description
    GhostLinkage,             ## *< Obsolete
    CommonLinkage,            ## *< Tentative definitions
    LinkerPrivateLinkage,     ## *< Like Private, but linker removes.
    LinkerPrivateWeakLinkage  ## *< Like LinkerPrivate, but is weak.
  Visibility* {.size: sizeof(cint).} = enum
    DefaultVisibility,        ## *< The GV is visible
    HiddenVisibility,         ## *< The GV is hidden
    ProtectedVisibility       ## *< The GV is protected
  UnnamedAddr {.size: sizeof(cint).} = enum
    NoUnnamedAddr,            ## *< Address of the GV is significant.
    LocalUnnamedAddr,         ## *< Address of the GV is locally insignificant.
    GlobalUnnamedAddr         ## *< Address of the GV is globally insignificant.
  DLLStorageClass* {.size: sizeof(cint).} = enum
    DefaultStorageClass = 0, DLLImportStorageClass = 1, ## *< Function to be imported from DLL.
    DLLExportStorageClass = 2
  CallConv* {.size: sizeof(cint).} = enum
    CCallConv = 0,
    FastCallConv = 8,
    ColdCallConv = 9,
    GHCCallConv = 10,
    HiPECallConv = 11,
    WebKitJSCallConv = 12,
    AnyRegCallConv = 13,
    PreserveMostCallConv = 14,
    PreserveAllCallConv = 15,
    SwiftCallConv = 16,
    CXXFASTTLSCallConv = 17,
    X86StdcallCallConv = 64,
    X86FastcallCallConv = 65,
    ARMAPCSCallConv = 66,
    ARMAAPCSCallConv = 67,
    ARMAAPCSVFPCallConv = 68,
    MSP430INTRCallConv = 69,
    X86ThisCallCallConv = 70,
    PTXKernelCallConv = 71,
    PTXDeviceCallConv = 72,
    SPIRFUNCCallConv = 75,
    SPIRKERNELCallConv = 76,
    IntelOCLBICallConv = 77,
    X8664SysVCallConv = 78,
    Win64CallConv = 79,
    X86VectorCallCallConv = 80,
    HHVMCallConv = 81,
    HHVMCCallConv = 82,
    X86INTRCallConv = 83,
    AVRINTRCallConv = 84,
    AVRSIGNALCallConv = 85,
    AVRBUILTINCallConv = 86,
    AMDGPUVSCallConv = 87,
    AMDGPUGSCallConv = 88,
    AMDGPUPSCallConv = 89,
    AMDGPUCSCallConv = 90,
    AMDGPUKERNELCallConv = 91,
    X86RegCallCallConv = 92,
    AMDGPUHSCallConv = 93,
    MSP430BUILTINCallConv = 94,
    AMDGPULSCallConv = 95,
    AMDGPUESCallConv = 96
  ValueKind* {.size: sizeof(cint).} = enum
    ArgumentValueKind, BasicBlockValueKind, MemoryUseValueKind, MemoryDefValueKind,
    MemoryPhiValueKind, FunctionValueKind, GlobalAliasValueKind, GlobalIFuncValueKind,
    GlobalVariableValueKind, BlockAddressValueKind, ConstantExprValueKind, ConstantArrayValueKind,
    ConstantStructValueKind, ConstantVectorValueKind, UndefValueValueKind, ConstantAggregateZeroValueKind,
    ConstantDataArrayValueKind, ConstantDataVectorValueKind, ConstantIntValueKind, ConstantFPValueKind,
    ConstantPointerNullValueKind, ConstantTokenNoneValueKind, MetadataAsValueValueKind, InlineAsmValueKind,
    InstructionValueKind, PoisonValueValueKind
  IntPredicate* {.size: sizeof(cint).} = enum
    IntEQ = 32,                 ## *< equal
    IntNE,                    ## *< not equal
    IntUGT,                   ## *< unsigned greater than
    IntUGE,                   ## *< unsigned greater or equal
    IntULT,                   ## *< unsigned less than
    IntULE,                   ## *< unsigned less or equal
    IntSGT,                   ## *< signed greater than
    IntSGE,                   ## *< signed greater or equal
    IntSLT,                   ## *< signed less than
    IntSLE                    ## *< signed less or equal
  RealPredicate* {.size: sizeof(cint).} = enum
    RealPredicateFalse,       ## *< Always false (always folded)
    RealOEQ,                  ## *< True if ordered and equal
    RealOGT,                  ## *< True if ordered and greater than
    RealOGE,                  ## *< True if ordered and greater than or equal
    RealOLT,                  ## *< True if ordered and less than
    RealOLE,                  ## *< True if ordered and less than or equal
    RealONE,                  ## *< True if ordered and operands are unequal
    RealORD,                  ## *< True if ordered (no nans)
    RealUNO,                  ## *< True if unordered: isnan(X) | isnan(Y)
    RealUEQ,                  ## *< True if unordered or equal
    RealUGT,                  ## *< True if unordered or greater than
    RealUGE,                  ## *< True if unordered, greater than, or equal
    RealULT,                  ## *< True if unordered or less than
    RealULE,                  ## *< True if unordered, less than, or equal
    RealUNE,                  ## *< True if unordered or not equal
    RealPredicateTrue         ## *< Always true (always folded)
  LandingPadClauseTy* {.size: sizeof(cint).} = enum
    LandingPadCatch,          ## *< A catch clause
    LandingPadFilter          ## *< A filter clause
  ThreadLocalMode* {.size: sizeof(cint).} = enum
    NotThreadLocal = 0, GeneralDynamicTLSModel, LocalDynamicTLSModel,
    InitialExecTLSModel, LocalExecTLSModel
  AtomicOrdering* {.size: sizeof(cint).} = enum
    AtomicOrderingNotAtomic = 0, ## *< A load or store which is not atomic
    AtomicOrderingUnordered = 1, ## *< Lowest level of atomicity, guarantees
                              ##                                      somewhat sane results, lock free.
    AtomicOrderingMonotonic = 2, ## *< guarantees that if you take all the
                              ##                                      operations affecting a specific address,
                              ##                                      a consistent ordering exists
    AtomicOrderingAcquire = 4, ## *< Acquire provides a barrier of the sort
                            ##                                    necessary to acquire a lock to access other
                            ##                                    memory with normal loads and stores.
    AtomicOrderingRelease = 5, ## *< Release is similar to Acquire, but with
                            ##                                    a barrier of the sort necessary to release
                            ##                                    a lock.
    AtomicOrderingAcquireRelease = 6, ## *< provides both an Acquire and a
                                   ##                                           Release barrier (for fences and
                                   ##                                           operations which both read and write
                                   ##                                            memory).
    AtomicOrderingSequentiallyConsistent = 7
  AtomicRMWBinOp* {.size: sizeof(cint).} = enum
    AtomicRMWBinOpXchg,       ## *< Set the new value and return the one old
    AtomicRMWBinOpAdd,        ## *< Add a value and return the old one
    AtomicRMWBinOpSub,        ## *< Subtract a value and return the old one
    AtomicRMWBinOpAnd,        ## *< And a value and return the old one
    AtomicRMWBinOpNand,       ## *< Not-And a value and return the old one
    AtomicRMWBinOpOr,         ## *< OR a value and return the old one
    AtomicRMWBinOpXor,        ## *< Xor a value and return the old one
    AtomicRMWBinOpMax, ## *< Sets the value if it's greater than the
                      ##                              original using a signed comparison and return
                      ##                              the old one
    AtomicRMWBinOpMin, ## *< Sets the value if it's Smaller than the
                      ##                              original using a signed comparison and return
                      ##                              the old one
    AtomicRMWBinOpUMax, ## *< Sets the value if it's greater than the
                       ##                              original using an unsigned comparison and return
                       ##                              the old one
    AtomicRMWBinOpUMin, ## *< Sets the value if it's greater than the
                      ##                              original using an unsigned comparison  and return
                      ##                              the old one
    AtomicRMWBinOpFAdd, ## *< Add a floating point value and return the old one
    AtomicRMWBinOpFSub ##*< Subtract a floating point value and return the old one
  DiagnosticSeverity* {.size: sizeof(cint).} = enum
    DSError, DSWarning, DSRemark, DSNote

  InlineAsmDialect* {.size: sizeof(cint).} = enum
    InlineAsmDialectATT,
    InlineAsmDialectIntel

  ModuleFlagBehavior* {.size: sizeof(cint).} = enum
    ModuleFlagBehaviorError,
    ModuleFlagBehaviorWarning,
    ModuleFlagBehaviorRequire,
    ModuleFlagBehaviorOverride,
    ModuleFlagBehaviorAppend,
    ModuleFlagBehaviorAppendUnique

## *
##  Attribute index are either LLVMAttributeReturnIndex,
##  LLVMAttributeFunctionIndex or a parameter number from 1 to N.
##

const
  AttributeReturnIndex* = 0 ##  ISO C restricts enumerator values to range of 'int'
                         ##  (4294967295 is too large)
                         ##  LLVMAttributeFunctionIndex = ~0U,
  AttributeFunctionIndex* = - 1

type
  AttributeIndex* = cuint


## *
##  @}
##