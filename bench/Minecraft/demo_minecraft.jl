### A Pluto.jl notebook ###
# v1.0.4

using Markdown
using InteractiveUtils

# ╔═╡ 3e94f7f8-cd2b-11f1-a8bb-616795c3060a
begin
	using Pkg
	Pkg.activate(".")
end

# ╔═╡ 75e03bd0-7647-4f9a-9310-3437326d42be
using HerbBenchmarks, Herb

# ╔═╡ c1ad9b18-8917-46b4-a1f5-da56035290d1
using PlutoUI

# ╔═╡ cd174a7c-ac5d-47b2-b8ef-21d15699fa32
md"""
## Minecraft Houses

[3D-Craft](https://github.com/facebookresearch/voxelcnn) (Chen et al., ICCV 2019) is 2,586 Minecraft houses built by crowdworkers, each given 30 minutes and no instruction. Every house is recorded as the **ordered** sequence of blocks the human placed and broke, which is the point of the dataset and of the paper's order-aware model. The data was collected under [CraftAssist](https://github.com/facebookresearch/craftassist) (Gray et al., 2019).
"""

# ╔═╡ f463a410-249e-4e1c-8810-edd9519885b0
import HerbBenchmarks.Minecraft_Houses_2019 as Houses

# ╔═╡ f4b2ac15-81a0-46bf-a834-1633f74fa11f
(; problem, grammar) = get_problem_grammar_pair(Houses, "house_0030");

# ╔═╡ 837bb791-fd40-4339-a3ab-e1ac39933a51
program = Houses.compact_program("house_0030")

# ╔═╡ 0a2a0b28-05f9-4ddd-a225-b51f18daac16
length(program)

# ╔═╡ f102ec84-9a59-42d1-a49d-50349cd6a610
built = Houses.interpret(program, problem.spec[1], grammar)

# ╔═╡ fd3a1581-f24d-4070-bd4e-4b57b6dbd809
Houses.visualize(program, "house_0030"; path="house_build.gif")

# ╔═╡ 29dfc8ae-f67c-4409-95e0-3e20b3f83e28
PlutoUI.LocalResource("house_build.gif")

# ╔═╡ 1c800aa3-4e18-4b27-9050-c89f7dd829f2
md"""
## MineRL

[MineRL](https://github.com/minerllabs/minerl) (Guss et al., IJCAI 2019) is a dataset of 500+ hours of human Minecraft play paired with RL environments built on Malmo. This is a program synthesis rendering of those environments: 17 problems covering all six MineRL task families except `Survival`, which by design has no reward function.
"""

# ╔═╡ a4cdc159-3f99-47a5-8695-dec6db99bf4f
import HerbBenchmarks.MineRL_2019 as MineRL

# ╔═╡ 3a219706-a0a8-4110-890d-ea800b231d3e
problem_minerl, grammar_minerl = let
	(; problem, grammar) = get_problem_grammar_pair(MineRL, "obtain_diamond")
	(problem, grammar)
end

# ╔═╡ 167e23f3-8100-45ab-95ca-fcbff4ba0747
program_minerl = MineRL.reference_program("obtain_diamond")

# ╔═╡ eefa5552-1c51-4a62-a4fb-6108db0e13c4
MineRL.interpret(program_minerl, problem_minerl.spec[1])

# ╔═╡ be8fe549-7a35-4795-ae8a-19773f295cc5
MineRL.visualize(program_minerl, problem_minerl; path="minerl_diamond.gif")

# ╔═╡ 0f4fb6e7-8f01-4857-9312-9ef1e8ee44ed
PlutoUI.LocalResource("minerl_diamond.gif")

# ╔═╡ Cell order:
# ╟─cd174a7c-ac5d-47b2-b8ef-21d15699fa32
# ╠═75e03bd0-7647-4f9a-9310-3437326d42be
# ╠═f463a410-249e-4e1c-8810-edd9519885b0
# ╠═f4b2ac15-81a0-46bf-a834-1633f74fa11f
# ╠═837bb791-fd40-4339-a3ab-e1ac39933a51
# ╠═0a2a0b28-05f9-4ddd-a225-b51f18daac16
# ╠═f102ec84-9a59-42d1-a49d-50349cd6a610
# ╠═fd3a1581-f24d-4070-bd4e-4b57b6dbd809
# ╠═29dfc8ae-f67c-4409-95e0-3e20b3f83e28
# ╟─1c800aa3-4e18-4b27-9050-c89f7dd829f2
# ╠═a4cdc159-3f99-47a5-8695-dec6db99bf4f
# ╠═3a219706-a0a8-4110-890d-ea800b231d3e
# ╠═167e23f3-8100-45ab-95ca-fcbff4ba0747
# ╠═eefa5552-1c51-4a62-a4fb-6108db0e13c4
# ╠═be8fe549-7a35-4795-ae8a-19773f295cc5
# ╠═0f4fb6e7-8f01-4857-9312-9ef1e8ee44ed
# ╠═3e94f7f8-cd2b-11f1-a8bb-616795c3060a
# ╠═c1ad9b18-8917-46b4-a1f5-da56035290d1
