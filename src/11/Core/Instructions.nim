## *
##  @defgroup LLVMCCoreValueInstruction Instructions
##
##  Functions in this group relate to the inspection and manipulation of
##  individual instructions.
##
##  In the C++ API, an instruction is modeled by llvm::Instruction. This
##  class has a large number of descendents. llvm::Instruction is a
##  llvm::Value and in the C API, instructions are modeled by
##  LLVMValueRef.
##
##  This group also contains sub-groups which operate on specific
##  llvm::Instruction types, e.g. llvm::CallInst.
##
##  @{
##
## *
##  Determine whether an instruction has any metadata attached.
##

proc HasMetadata*(val: ValueRef): cint {.llvmc.}
## *
##  Return metadata associated with an instruction value.
##

proc GetMetadata*(val: ValueRef; kindID: cuint): ValueRef {.llvmc.}
## *
##  Set metadata associated with an instruction value.
##

proc SetMetadata*(val: ValueRef; kindID: cuint; node: ValueRef) {.llvmc.}
## *
##  Obtain the basic block to which an instruction belongs.
##
##  @see llvm::Instruction::getParent()
##

proc GetInstructionParent*(inst: ValueRef): BasicBlockRef {.llvmc.}
## *
##  Obtain the instruction that occurs after the one specified.
##
##  The next instruction will be from the same basic block.
##
##  If this is the last instruction in a basic block, NULL will be
##  returned.
##

proc GetNextInstruction*(inst: ValueRef): ValueRef {.llvmc.}
## *
##  Obtain the instruction that occurred before this one.
##
##  If the instruction is the first instruction in a basic block, NULL
##  will be returned.
##

proc GetPreviousInstruction*(inst: ValueRef): ValueRef {.llvmc.}
## *
##  Remove and delete an instruction.
##
##  The instruction specified is removed from its containing building
##  block but is kept alive.
##
##  @see llvm::Instruction::removeFromParent()
##

proc InstructionRemoveFromParent*(inst: ValueRef) {.llvmc.}
## *
##  Remove and delete an instruction.
##
##  The instruction specified is removed from its containing building
##  block and then deleted.
##
##  @see llvm::Instruction::eraseFromParent()
##

proc InstructionEraseFromParent*(inst: ValueRef) {.llvmc.}
## *
##  Obtain the code opcode for an individual instruction.
##
##  @see llvm::Instruction::getOpCode()
##

proc GetInstructionOpcode*(inst: ValueRef): Opcode {.llvmc.}
## *
##  Obtain the predicate of an instruction.
##
##  This is only valid for instructions that correspond to llvm::ICmpInst
##  or llvm::ConstantExpr whose opcode is llvm::Instruction::ICmp.
##
##  @see llvm::ICmpInst::getPredicate()
##

proc GetICmpPredicate*(inst: ValueRef): IntPredicate {.llvmc.}
## *
##  Obtain the float predicate of an instruction.
##
##  This is only valid for instructions that correspond to llvm::FCmpInst
##  or llvm::ConstantExpr whose opcode is llvm::Instruction::FCmp.
##
##  @see llvm::FCmpInst::getPredicate()
##

proc GetFCmpPredicate*(inst: ValueRef): RealPredicate {.llvmc.}
## *
##  Create a copy of 'this' instruction that is identical in all ways
##  except the following:
##    * The instruction has no parent
##    * The instruction has no name
##
##  @see llvm::Instruction::clone()
##

proc InstructionClone*(inst: ValueRef): ValueRef {.llvmc.}

## Determine whether an instruction is a terminator
proc IsATerminatorInst*(inst: ValueRef): ValueRef {.llvmc.}

## *
##  @defgroup LLVMCCoreValueInstructionCall Call Sites and Invocations
##
##  Functions in this group apply to instructions that refer to call
##  sites and invocations. These correspond to C++ types in the
##  llvm::CallInst class tree.
##
##  @{
##
## *
##  Obtain the argument count for a call instruction.
##
##  This expects an LLVMValueRef that corresponds to a llvm::CallInst or
##  llvm::InvokeInst.
##
##  @see llvm::CallInst::getNumArgOperands()
##  @see llvm::InvokeInst::getNumArgOperands()
##

proc GetNumArgOperands*(instr: ValueRef): cuint {.llvmc.}
## *
##  Set the calling convention for a call instruction.
##
##  This expects an LLVMValueRef that corresponds to a llvm::CallInst or
##  llvm::InvokeInst.
##
##  @see llvm::CallInst::setCallingConv()
##  @see llvm::InvokeInst::setCallingConv()
##

proc SetInstructionCallConv*(instr: ValueRef; cc: cuint) {.llvmc.}
## *
##  Obtain the calling convention for a call instruction.
##
##  This is the opposite of LLVMSetInstructionCallConv(). Reads its
##  usage.
##
##  @see LLVMSetInstructionCallConv()
##

proc GetInstructionCallConv*(instr: ValueRef): cuint {.llvmc.}
proc SetInstrParamAlignment*(instr: ValueRef; index: cuint; align: cuint) {.llvmc.}
proc AddCallSiteAttribute*(c: ValueRef; idx: AttributeIndex; a: AttributeRef) {.llvmc.}
proc GetCallSiteAttributeCount*(c: ValueRef; idx: AttributeIndex): cuint {.llvmc.}
proc GetCallSiteAttributes*(c: ValueRef; idx: AttributeIndex; attrs: ptr AttributeRef) {.llvmc.}
proc GetCallSiteEnumAttribute*(c: ValueRef; idx: AttributeIndex; kindID: cuint): AttributeRef {.llvmc.}
proc GetCallSiteStringAttribute*(c: ValueRef; idx: AttributeIndex; k: cstring;
                                kLen: cuint): AttributeRef {.llvmc.}
proc RemoveCallSiteEnumAttribute*(c: ValueRef; idx: AttributeIndex; kindID: cuint) {.llvmc.}
proc RemoveCallSiteStringAttribute*(c: ValueRef; idx: AttributeIndex; k: cstring;
                                   kLen: cuint) {.llvmc.}
## Obtain the function type called by this instruction
proc GetCalledFunctionType*(c: ValueRef): TypeRef {.llvmc.}

## *
##  Obtain the pointer to the function invoked by this instruction.
##
##  This expects an LLVMValueRef that corresponds to a llvm::CallInst or
##  llvm::InvokeInst.
##
##  @see llvm::CallInst::getCalledValue()
##  @see llvm::InvokeInst::getCalledValue()
##

proc GetCalledValue*(instr: ValueRef): ValueRef {.llvmc.}
## *
##  Obtain whether a call instruction is a tail call.
##
##  This only works on llvm::CallInst instructions.
##
##  @see llvm::CallInst::isTailCall()
##

proc IsTailCall*(callInst: ValueRef): Bool {.llvmc.}
## *
##  Set whether a call instruction is a tail call.
##
##  This only works on llvm::CallInst instructions.
##
##  @see llvm::CallInst::setTailCall()
##

proc SetTailCall*(callInst: ValueRef; isTailCall: Bool) {.llvmc.}
## *
##  Return the normal destination basic block.
##
##  This only works on llvm::InvokeInst instructions.
##
##  @see llvm::InvokeInst::getNormalDest()
##

proc GetNormalDest*(invokeInst: ValueRef): BasicBlockRef {.llvmc.}
## *
##  Return the unwind destination basic block.
##
##  This only works on llvm::InvokeInst instructions.
##
##  @see llvm::InvokeInst::getUnwindDest()
##

proc GetUnwindDest*(invokeInst: ValueRef): BasicBlockRef {.llvmc.}
## *
##  Set the normal destination basic block.
##
##  This only works on llvm::InvokeInst instructions.
##
##  @see llvm::InvokeInst::setNormalDest()
##

proc SetNormalDest*(invokeInst: ValueRef; b: BasicBlockRef) {.llvmc.}
## *
##  Set the unwind destination basic block.
##
##  This only works on llvm::InvokeInst instructions.
##
##  @see llvm::InvokeInst::setUnwindDest()
##

proc SetUnwindDest*(invokeInst: ValueRef; b: BasicBlockRef) {.llvmc.}
## *
##  @}
##
## *
##  @defgroup LLVMCCoreValueInstructionTerminator Terminators
##
##  Functions in this group only apply to instructions that map to
##  llvm::TerminatorInst instances.
##
##  @{
##
## *
##  Return the number of successors that this terminator has.
##
##  @see llvm::TerminatorInst::getNumSuccessors
##

proc GetNumSuccessors*(term: ValueRef): cuint {.llvmc.}
## *
##  Return the specified successor.
##
##  @see llvm::TerminatorInst::getSuccessor
##

proc GetSuccessor*(term: ValueRef; i: cuint): BasicBlockRef {.llvmc.}
## *
##  Update the specified successor to point at the provided block.
##
##  @see llvm::TerminatorInst::setSuccessor
##

proc SetSuccessor*(term: ValueRef; i: cuint; `block`: BasicBlockRef) {.llvmc.}
## *
##  Return if a branch is conditional.
##
##  This only works on llvm::BranchInst instructions.
##
##  @see llvm::BranchInst::isConditional
##

proc IsConditional*(branch: ValueRef): Bool {.llvmc.}
## *
##  Return the condition of a branch instruction.
##
##  This only works on llvm::BranchInst instructions.
##
##  @see llvm::BranchInst::getCondition
##

proc GetCondition*(branch: ValueRef): ValueRef {.llvmc.}
## *
##  Set the condition of a branch instruction.
##
##  This only works on llvm::BranchInst instructions.
##
##  @see llvm::BranchInst::setCondition
##

proc SetCondition*(branch: ValueRef; cond: ValueRef) {.llvmc.}
## *
##  Obtain the default destination basic block of a switch instruction.
##
##  This only works on llvm::SwitchInst instructions.
##
##  @see llvm::SwitchInst::getDefaultDest()
##

proc GetSwitchDefaultDest*(switchInstr: ValueRef): BasicBlockRef {.llvmc.}
## *
##  @}
##
## *
##  @defgroup LLVMCCoreValueInstructionAlloca Allocas
##
##  Functions in this group only apply to instructions that map to
##  llvm::AllocaInst instances.
##
##  @{
##
## *
##  Obtain the type that is being allocated by the alloca instruction.
##

proc GetAllocatedType*(alloca: ValueRef): TypeRef {.llvmc.}
## *
##  @}
##
## *
##  @defgroup LLVMCCoreValueInstructionGetElementPointer GEPs
##
##  Functions in this group only apply to instructions that map to
##  llvm::GetElementPtrInst instances.
##
##  @{
##
## *
##  Check whether the given GEP instruction is inbounds.
##

proc IsInBounds*(gep: ValueRef): Bool {.llvmc.}
## *
##  Set the given GEP instruction to be inbounds or not.
##

proc SetIsInBounds*(gep: ValueRef; inBounds: Bool) {.llvmc.}
## *
##  @}
##
## *
##  @defgroup LLVMCCoreValueInstructionPHINode PHI Nodes
##
##  Functions in this group only apply to instructions that map to
##  llvm::PHINode instances.
##
##  @{
##
## *
##  Add an incoming value to the end of a PHI list.
##

proc AddIncoming*(phiNode: ValueRef; incomingValues: ptr ValueRef;
                 incomingBlocks: ptr BasicBlockRef; count: cuint) {.llvmc.}
## *
##  Obtain the number of incoming basic blocks to a PHI node.
##

proc CountIncoming*(phiNode: ValueRef): cuint {.llvmc.}
## *
##  Obtain an incoming value to a PHI node as an LLVMValueRef.
##

proc GetIncomingValue*(phiNode: ValueRef; index: cuint): ValueRef {.llvmc.}
## *
##  Obtain an incoming value to a PHI node as an LLVMBasicBlockRef.
##

proc GetIncomingBlock*(phiNode: ValueRef; index: cuint): BasicBlockRef {.llvmc.}
## *
##  @}
##
## *
##  @defgroup LLVMCCoreValueInstructionExtractValue ExtractValue
##  @defgroup LLVMCCoreValueInstructionInsertValue InsertValue
##
##  Functions in this group only apply to instructions that map to
##  llvm::ExtractValue and llvm::InsertValue instances.
##
##  @{
##
## *
##  Obtain the number of indices.
##  NB: This also works on GEP.
##

proc GetNumIndices*(inst: ValueRef): cuint {.llvmc.}
## *
##  Obtain the indices as an array.
##

proc GetIndices*(inst: ValueRef): ptr cuint {.llvmc.}
