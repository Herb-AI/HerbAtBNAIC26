# `Herb.jl` demo @ BNAIC '26

[![Notebooks DOI](https://img.shields.io/badge/Notebooks%20(this%20repo)-10.5281%2Fzenodo.23538699-4063d8)](https://zenodo.org/records/23538699)
[![Video DOI](https://img.shields.io/badge/Video-10.5281%2Fzenodo.23537710-cb3c33)](https://zenodo.org/records/23537710)
[![Abstract DOI](https://img.shields.io/badge/Abstract-10.5281%2Fzenodo.23538216-389826)](https://zenodo.org/records/23538216)

Specific branches of `HerbBenchmarks.jl` and `HerbSearch.jl` used during the
demos are added directly to this repo (via `git subtree add`).

The `demo_*.jl` files are `Pluto.jl` notebooks. To view them, run `julia --project=.`
(or `--project=bench/Minecraft`, etc.), and `using Pluto; Pluto.run()`.

The inspector demo can be run with `julia --project=. --load inspect.jl`. This
will launch the inspector in your browser.

