### A Pluto.jl notebook ###
# v1.0.4

using Markdown
using InteractiveUtils

# ╔═╡ fb7d7d7c-cd15-11f1-b6ac-012c14a28988
# ╠═╡ show_logs = false
begin
	using Pkg
	Pkg.activate(".")
end

# ╔═╡ 45b899a5-16f7-479e-bc36-9797e872ef7f
using Herb

# ╔═╡ 50f390ae-e0e7-4b1b-ab55-fdd05c8f5cd8
using HerbBenchmarks

# ╔═╡ cb7150c2-9f35-44d7-a656-5beba29ead3f
md"""
Today, we are...
"""

# ╔═╡ d9f22dd7-75a8-4bd6-bcb8-e48c2a6f744d
md"""
In synthesis, we have two ingredients: the space of solutions, the intended behavior.
"""

# ╔═╡ bffa731d-c105-4f41-9e49-25051bdb0cfa
grammar = @csgrammar begin
	Number = 1 | 2
	Number = x
	Number = Number + Number
	Number = Number * Number
end

# ╔═╡ 16d76c01-5fd6-485d-b091-8071a58115b7
problem = Problem([
	IOExample(
		Dict(:x => x),
		2x + 1
	) for x in 1:5])

# ╔═╡ ac0ab47b-7066-4e42-a717-8ffd1505e225
md"""
Now, the grammar defines an infinite space that grows *very* quickly.
"""

# ╔═╡ 46fccef8-551d-4c6a-951c-4224252f3418
count_programs(grammar, :Number, max_depth=5)

# ╔═╡ a8e44817-b986-4d04-8b75-88fc025b6801
md"""
But, if your solution is simple, you can find a solution fairly quickly.
"""

# ╔═╡ 979157d2-9c1c-48b6-b28b-3a28c2f59c6a
solution, flag = @time synth(problem, BFSIterator(grammar, :Number, max_depth=5))

# ╔═╡ 09bc2887-3bea-4459-98b8-18a50c9f6dea
md"""
Here is the found program that matches our specification:
"""

# ╔═╡ 19caa52a-3285-4fef-8cb0-d49226039245
program = rulenode2expr(solution, grammar)

# ╔═╡ 3d7292b6-998f-4a0b-86e0-cc5bccd7b986
md"""
If we execute that program on some given input, we can explore its behavior. This is what the search is doing under the hood to check against the specification.
"""

# ╔═╡ eb236113-32ab-469c-8d47-77fa090ef799
execute_on_input(grammar2symboltable(grammar), program, Dict(:x => 10))

# ╔═╡ fcd538a7-694e-40a1-8d03-192aab3063f8
md"""
The space is incredibly large, though, so Herb allows for the application of syntactic constraints to "shape" the space. At depth 3, there are 885 programs present within the grammar.
"""

# ╔═╡ 96acd433-a338-49f2-8be5-2dcb90209267
length(BFSIterator(grammar, :Number, max_depth=3))

# ╔═╡ 1b1dc73b-f0e5-4fd0-8663-f311e00d2b78
grammar_constrained = deepcopy(grammar);

# ╔═╡ bc1d8b77-f80c-4b47-8be7-ebfd5d10961f
md"""
We can add two constraints to split the symmetry present in the space because of the commutative operators `+`, `*`.

To do this, we enforce an order on the subexpressions of the two operators (ex: force `1+x` instead of `x+1`, because they are equivalent).
"""

# ╔═╡ e3f5c0fb-f10a-4661-8270-42727834899f
begin
	addconstraint!(
		grammar_constrained,
		Ordered(RuleNode(4, [VarNode(:a), VarNode(:b)]), [:a, :b])
	)
	addconstraint!(
		grammar_constrained,
		Ordered(RuleNode(5, [VarNode(:a), VarNode(:b)]), [:a, :b])
	)
	grammar_constrained.constraints
end

# ╔═╡ 33723e25-637e-496b-b079-0546940d5a9b
md"""
Which reduces the space (at depth 3) to:
"""

# ╔═╡ 6238d3bf-c139-427f-8690-0aef1b825ea3
length(BFSIterator(grammar_constrained, :Number, max_depth=3))

# ╔═╡ 679ac017-feac-4430-ac86-6823ed9c213a
md"""
Inspector interlude...
"""

# ╔═╡ de1fe91f-3ba3-4d3f-b0bd-5c909284252e
md"""
## Benchmarks

First, programming by example in the SLIA (*string linear integer arithmetic domain*)
"""

# ╔═╡ 76dcce4b-ee69-41d3-baf4-a85def0debfa
import HerbBenchmarks.PBE_SLIA_Track_2019 as SLIA

# ╔═╡ e3c263df-9db3-4741-a01c-1460d7b942b9
length(get_all_problems(SLIA))

# ╔═╡ a4688767-f0ba-454d-9ce3-8b6419fc7088
problem_firstname = HerbBenchmarks.get_problem(SLIA, "firstname");

# ╔═╡ bd90a820-2b28-4a47-8224-18cd03e43a49
problem.spec

# ╔═╡ 250b0067-7900-474f-9d96-67c06899f890
grammar_firstname = HerbBenchmarks.get_grammar(SLIA, "firstname")

# ╔═╡ 4dbf693c-80df-43d8-833f-db2163bdb69e
solution_firstname, _ = @time synth(problem_firstname, BFSIterator(grammar_firstname, :Start, max_depth=4), allow_evaluation_errors=true, mod=SLIA)

# ╔═╡ c625ea6f-8087-4152-88cb-dd8a8b336c79
program_firstname = rulenode2expr(solution_firstname, grammar_firstname)

# ╔═╡ 911b65a0-7979-4315-adb9-9d59afc3a64a
execute_on_input(grammar2symboltable(grammar_firstname, SLIA), program_firstname, Dict(:_arg_1 => "Ada Lovelace"))

# ╔═╡ 90c9ca1c-c412-442f-bf54-2a4d701db7b5
md"""
- DreamCoder
- Minecraft
- [`Garden.jl`](https://github.com/Herb-AI/Garden.jl)

That concludes our tour of `Herb.jl`.

If you want to try it yourself, you just need Julia installed, and then:

```julia
] add Herb.jl
```
"""

# ╔═╡ Cell order:
# ╟─cb7150c2-9f35-44d7-a656-5beba29ead3f
# ╠═45b899a5-16f7-479e-bc36-9797e872ef7f
# ╟─d9f22dd7-75a8-4bd6-bcb8-e48c2a6f744d
# ╟─bffa731d-c105-4f41-9e49-25051bdb0cfa
# ╠═16d76c01-5fd6-485d-b091-8071a58115b7
# ╟─ac0ab47b-7066-4e42-a717-8ffd1505e225
# ╠═46fccef8-551d-4c6a-951c-4224252f3418
# ╟─a8e44817-b986-4d04-8b75-88fc025b6801
# ╠═979157d2-9c1c-48b6-b28b-3a28c2f59c6a
# ╟─09bc2887-3bea-4459-98b8-18a50c9f6dea
# ╠═19caa52a-3285-4fef-8cb0-d49226039245
# ╟─3d7292b6-998f-4a0b-86e0-cc5bccd7b986
# ╠═eb236113-32ab-469c-8d47-77fa090ef799
# ╟─fcd538a7-694e-40a1-8d03-192aab3063f8
# ╠═96acd433-a338-49f2-8be5-2dcb90209267
# ╠═1b1dc73b-f0e5-4fd0-8663-f311e00d2b78
# ╟─bc1d8b77-f80c-4b47-8be7-ebfd5d10961f
# ╠═e3f5c0fb-f10a-4661-8270-42727834899f
# ╟─33723e25-637e-496b-b079-0546940d5a9b
# ╠═6238d3bf-c139-427f-8690-0aef1b825ea3
# ╟─679ac017-feac-4430-ac86-6823ed9c213a
# ╟─de1fe91f-3ba3-4d3f-b0bd-5c909284252e
# ╠═76dcce4b-ee69-41d3-baf4-a85def0debfa
# ╠═e3c263df-9db3-4741-a01c-1460d7b942b9
# ╠═a4688767-f0ba-454d-9ce3-8b6419fc7088
# ╠═bd90a820-2b28-4a47-8224-18cd03e43a49
# ╠═250b0067-7900-474f-9d96-67c06899f890
# ╠═4dbf693c-80df-43d8-833f-db2163bdb69e
# ╠═c625ea6f-8087-4152-88cb-dd8a8b336c79
# ╠═911b65a0-7979-4315-adb9-9d59afc3a64a
# ╟─90c9ca1c-c412-442f-bf54-2a4d701db7b5
# ╟─fb7d7d7c-cd15-11f1-b6ac-012c14a28988
# ╟─50f390ae-e0e7-4b1b-ab55-fdd05c8f5cd8
