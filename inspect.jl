# either include this file from your REPL, or from your shell with
# julia --project=. --load inspect.jl
using Herb

grammar = @csgrammar begin
   Number = 1 | 2
   Number = x
   Number = Number + Number
   Number = Number * Number
end

addconstraint!(
   grammar,
   Ordered(RuleNode(4, [VarNode(:a), VarNode(:b)]), [:a, :b])
)
addconstraint!(
   grammar,
   Ordered(RuleNode(5, [VarNode(:a), VarNode(:b)]), [:a, :b])
)

insp = @inspect BFSIterator(grammar, :Number, max_depth=3)
