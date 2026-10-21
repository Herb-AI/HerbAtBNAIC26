### A Pluto.jl notebook ###
# v1.0.4

using Markdown
using InteractiveUtils

# ╔═╡ 6241adcb-1b7d-49b4-8151-62422958fa4d
begin
	using Pkg
	Pkg.activate(".")
end

# ╔═╡ f19f04e7-8e73-4dab-ba6f-a0b7a8a8f216
using HerbBenchmarks, Herb

# ╔═╡ 41267ef7-8c5d-448a-97da-9bc6f67c0f13
md"""
## DreamCoder

Benchmark domains from DreamCoder: Growing generalizable, interpretable knowledge with wake-sleep Bayesian program learning, Ellis, Wong, Nye, Sablé-Meyer, Cary, Morales, Hewitt, Solar-Lezama and Tenenbaum ([arXiv:2006.08381](https://arxiv.org/abs/2006.08381); Phil. Trans. R. Soc. A 381, 2023). Ported from the reference implementation at [https://github.com/ellisk42/ec](https://github.com/ellisk42/ec).
"""

# ╔═╡ 06bc7840-cd28-11f1-9fe0-35ea8e64d093
import HerbBenchmarks.DreamCoder_2021.List_2021 as Lists

# ╔═╡ 62e16ac2-a1cc-4379-bafc-6fe2a0f50cee
(; problem, grammar) = get_problem_grammar_pair(Lists, "001_add_k_with_k_1")

# ╔═╡ 401a698f-1c77-418c-a4ed-aca343278220
problem.spec[1]

# ╔═╡ e242ff53-962c-4215-9b0e-2cd7fc0c2d9b
program = expr2rulenode(:(dc_map(dc_add(1), _arg_1)), grammar)

# ╔═╡ 52a6c8ed-2bef-4898-84e3-35722516738b
interpret = Lists.make_list_interpreter(grammar);

# ╔═╡ a886975f-3589-4f25-ac28-8d5d6fe2beef
interpret(program, problem.spec) == [ex.out for ex in problem.spec]

# ╔═╡ bf70ebbc-0bf0-4b0c-81dd-790c997bacbe
import HerbBenchmarks.DreamCoder_2021.Tower_2021 as Towers

# ╔═╡ b410ae5d-85a4-4357-b0fa-8982f0ddd31f
problem_towers, grammar_towers = let
	(; problem, grammar) = get_problem_grammar_pair(Towers, "010_arch_stack_5")
	(problem, grammar)
end

# ╔═╡ c50f9717-faad-46cc-8e54-5f52501661b7
program_towers = Towers.reference_program("010_arch_stack_5")

# ╔═╡ 4b707012-623e-4ecb-9689-d246a97e3c6e
rulenode2expr(program_towers, grammar_towers)

# ╔═╡ b17af5f2-1800-4811-a6dd-3b4359c0bfba
output = (Towers.make_interpreter(grammar_towers; target_module=Towers, cache_module=Towers))(program_towers, problem_towers.spec[1]);

# ╔═╡ a5844b40-f395-4c90-8c5c-6d1c3b1a9bcc
problem_towers.spec[1].out == output

# ╔═╡ 23a2fca3-e443-4f3d-af45-1c1e26243014
Towers.print_tower(output)

# ╔═╡ Cell order:
# ╟─41267ef7-8c5d-448a-97da-9bc6f67c0f13
# ╠═f19f04e7-8e73-4dab-ba6f-a0b7a8a8f216
# ╠═06bc7840-cd28-11f1-9fe0-35ea8e64d093
# ╠═62e16ac2-a1cc-4379-bafc-6fe2a0f50cee
# ╠═401a698f-1c77-418c-a4ed-aca343278220
# ╠═e242ff53-962c-4215-9b0e-2cd7fc0c2d9b
# ╠═52a6c8ed-2bef-4898-84e3-35722516738b
# ╠═a886975f-3589-4f25-ac28-8d5d6fe2beef
# ╠═bf70ebbc-0bf0-4b0c-81dd-790c997bacbe
# ╠═b410ae5d-85a4-4357-b0fa-8982f0ddd31f
# ╠═c50f9717-faad-46cc-8e54-5f52501661b7
# ╠═4b707012-623e-4ecb-9689-d246a97e3c6e
# ╠═b17af5f2-1800-4811-a6dd-3b4359c0bfba
# ╠═a5844b40-f395-4c90-8c5c-6d1c3b1a9bcc
# ╠═23a2fca3-e443-4f3d-af45-1c1e26243014
# ╠═6241adcb-1b7d-49b4-8151-62422958fa4d
