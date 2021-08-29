## *
##  @defgroup LLVMCCoreValueBasicBlock Basic Block
##
##  A basic block represents a single entry single exit section of code.
##  Basic blocks contain a list of instructions which form the body of
##  the block.
##
##  Basic blocks belong to functions. They have the type of label.
##
##  Basic blocks are themselves values. However, the C API models them as
##  LLVMBasicBlockRef.
##
##  @see llvm::BasicBlock
##
##  @{
##
## *
##  Convert a basic block instance to a value type.
##

proc BasicBlockAsValue*(bb: BasicBlockRef): ValueRef {.llvmc.}
## *
##  Determine whether an LLVMValueRef is itself a basic block.
##

proc ValueIsBasicBlock*(val: ValueRef): Bool {.llvmc.}
## *
##  Convert an LLVMValueRef to an LLVMBasicBlockRef instance.
##

proc ValueAsBasicBlock*(val: ValueRef): BasicBlockRef {.llvmc.}
## *
##  Obtain the string name of a basic block.
##

proc GetBasicBlockName*(bb: BasicBlockRef): cstring {.llvmc.}
## *
##  Obtain the function to which a basic block belongs.
##
##  @see llvm::BasicBlock::getParent()
##

proc GetBasicBlockParent*(bb: BasicBlockRef): ValueRef {.llvmc.}
## *
##  Obtain the terminator instruction for a basic block.
##
##  If the basic block does not have a terminator (it is not well-formed
##  if it doesn't), then NULL is returned.
##
##  The returned LLVMValueRef corresponds to a llvm::TerminatorInst.
##
##  @see llvm::BasicBlock::getTerminator()
##

proc GetBasicBlockTerminator*(bb: BasicBlockRef): ValueRef {.llvmc.}
## *
##  Obtain the number of basic blocks in a function.
##
##  @param Fn Function value to operate on.
##

proc CountBasicBlocks*(fn: ValueRef): cuint {.llvmc.}
## *
##  Obtain all of the basic blocks in a function.
##
##  This operates on a function value. The BasicBlocks parameter is a
##  pointer to a pre-allocated array of LLVMBasicBlockRef of at least
##  LLVMCountBasicBlocks() in length. This array is populated with
##  LLVMBasicBlockRef instances.
##

proc GetBasicBlocks*(fn: ValueRef; basicBlocks: ptr BasicBlockRef) {.llvmc.}
## *
##  Obtain the first basic block in a function.
##
##  The returned basic block can be used as an iterator. You will likely
##  eventually call into LLVMGetNextBasicBlock() with it.
##
##  @see llvm::Function::begin()
##

proc GetFirstBasicBlock*(fn: ValueRef): BasicBlockRef {.llvmc.}
## *
##  Obtain the last basic block in a function.
##
##  @see llvm::Function::end()
##

proc GetLastBasicBlock*(fn: ValueRef): BasicBlockRef {.llvmc.}
## *
##  Advance a basic block iterator.
##

proc GetNextBasicBlock*(bb: BasicBlockRef): BasicBlockRef {.llvmc.}
## *
##  Go backwards in a basic block iterator.
##

proc GetPreviousBasicBlock*(bb: BasicBlockRef): BasicBlockRef {.llvmc.}
## *
##  Obtain the basic block that corresponds to the entry point of a
##  function.
##
##  @see llvm::Function::getEntryBlock()
##

proc GetEntryBasicBlock*(fn: ValueRef): BasicBlockRef {.llvmc.}

## Insert the given basic block after the insertion point of the given builder
proc InsertExistingBasicBlockAfterInsertBlock*(builder: BuilderRef, bb: BasicBlockRef) {.llvmc.}

## Append the given basic block to the basic block list of the given function
proc AppendExistingBasicBlock*(fn: ValueRef, bb: BasicBlockRef) {.llvmc.}

## Create a new basic block without inserting it into a function
proc CreateBasicBlockInContext*(c: ContextRef, name: cstring): BasicBlockRef {.llvmc.}

## *
##  Append a basic block to the end of a function.
##
##  @see llvm::BasicBlock::Create()
##

proc AppendBasicBlockInContext*(c: ContextRef; fn: ValueRef; name: cstring): BasicBlockRef {.llvmc.}
## *
##  Append a basic block to the end of a function using the global
##  context.
##
##  @see llvm::BasicBlock::Create()
##

proc AppendBasicBlock*(fn: ValueRef; name: cstring): BasicBlockRef {.llvmc.}
## *
##  Insert a basic block in a function before another basic block.
##
##  The function to add to is determined by the function of the
##  passed basic block.
##
##  @see llvm::BasicBlock::Create()
##

proc InsertBasicBlockInContext*(c: ContextRef; bb: BasicBlockRef; name: cstring): BasicBlockRef {.llvmc.}
## *
##  Insert a basic block in a function using the global context.
##
##  @see llvm::BasicBlock::Create()
##

proc InsertBasicBlock*(insertBeforeBB: BasicBlockRef; name: cstring): BasicBlockRef {.llvmc.}
## *
##  Remove a basic block from a function and delete it.
##
##  This deletes the basic block from its containing function and deletes
##  the basic block itself.
##
##  @see llvm::BasicBlock::eraseFromParent()
##

proc DeleteBasicBlock*(bb: BasicBlockRef) {.llvmc.}
## *
##  Remove a basic block from a function.
##
##  This deletes the basic block from its containing function but keep
##  the basic block alive.
##
##  @see llvm::BasicBlock::removeFromParent()
##

proc RemoveBasicBlockFromParent*(bb: BasicBlockRef) {.llvmc.}
## *
##  Move a basic block to before another one.
##
##  @see llvm::BasicBlock::moveBefore()
##

proc MoveBasicBlockBefore*(bb: BasicBlockRef; movePos: BasicBlockRef) {.llvmc.}
## *
##  Move a basic block to after another one.
##
##  @see llvm::BasicBlock::moveAfter()
##

proc MoveBasicBlockAfter*(bb: BasicBlockRef; movePos: BasicBlockRef) {.llvmc.}
## *
##  Obtain the first instruction in a basic block.
##
##  The returned LLVMValueRef corresponds to a llvm::Instruction
##  instance.
##

proc GetFirstInstruction*(bb: BasicBlockRef): ValueRef {.llvmc.}
## *
##  Obtain the last instruction in a basic block.
##
##  The returned LLVMValueRef corresponds to an LLVM:Instruction.
##

proc GetLastInstruction*(bb: BasicBlockRef): ValueRef {.llvmc.}