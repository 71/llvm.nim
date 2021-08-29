include Transforms/PassManagerBuilder

## Aggressive Instruction Combining transformations
proc AddAggressiveInstCombinerPass*(pm: PassManagerRef) {.llvmc.}

## Coroutine transformations

proc AddCoroEarlyPass*(pm: PassManagerRef) {.llvmc.}
proc AddCoroSplitPass*(pm: PassManagerRef) {.llvmc.}
proc AddCoroElidePass*(pm: PassManagerRef) {.llvmc.}
proc AddCoroCleanupPass*(pm: PassManagerRef) {.llvmc.}
proc PassManagerBuilderAddCoroutinePassesToExtensionPoints*(pmb: PassManagerBuilderRef) {.llvmc.}


##I nstruction Combining transformations
proc AddInstructionCombiningPass*(pm: PassManagerRef) {.llvmc.}