# `Herb.jl` demo @ BNAIC '26

- Demo notebooks (this repository): [![DOI](https://zenodo.org/badge/1428568870.svg)](https://doi.org/10.5281/zenodo.23538698)
- Demo video: [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.23537710.svg)](https://doi.org/10.5281/zenodo.23537710)
- Abstract: [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.23538216.svg)](https://doi.org/10.5281/zenodo.23538216)

Specific branches of `HerbBenchmarks.jl` and `HerbSearch.jl` used during the
demos are added directly to this repo (via `git subtree add`).

The `demo_*.jl` are `Pluto.jl` notebooks. To view them, run `julia --project=.`
(or `--project=bench/Minecraft`, etc.), and `using Pluto; Pluto.run()`.

The inspector demo can be run with `julia --project=. --load inspect.jl`. This
will launch the inspector in your browser.

