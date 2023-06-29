### A Pluto.jl notebook ###
# v0.19.26

using Markdown
using InteractiveUtils

# ╔═╡ 4de902f0-0374-11ee-38f8-f977695d796b
md"""# Catatan 5 Juni 2023: GPU Programming"""

# ╔═╡ c66db4fe-509c-4a46-9b9b-17c55f254956
md""" ## GPU vs CPUs"""

# ╔═╡ 3aa0427c-6d3b-48fa-8654-fed16fa6b3a3
md"""
+ gpu punya memori sendiri
+ streaming multiprosessor (SMs)"""

# ╔═╡ c00d805b-aa1d-44fe-831a-360901151da4


# ╔═╡ 1cfdbefb-cf3e-4a71-b927-64e08b49d45d
md""" ## SIMD vs SPMD"""

# ╔═╡ 2770886f-84a9-42c9-a576-348342888bbe
md""" 
https://godbolt.org"""

# ╔═╡ e0c85c95-c1f7-4541-8b16-c3c92491146a
md""" map -> sesuai indeks. broadcats -> harus saa bentuk kolom/barisnya."""

# ╔═╡ 1999d35a-0247-44db-bb37-6fdd06d6e53a
broadcast(+, [1,2,3,4], [10 20 30 40])

# ╔═╡ 0a851749-28f8-4955-8d7e-5583b0f98eb9


# ╔═╡ Cell order:
# ╟─4de902f0-0374-11ee-38f8-f977695d796b
# ╟─c66db4fe-509c-4a46-9b9b-17c55f254956
# ╠═3aa0427c-6d3b-48fa-8654-fed16fa6b3a3
# ╠═c00d805b-aa1d-44fe-831a-360901151da4
# ╟─1cfdbefb-cf3e-4a71-b927-64e08b49d45d
# ╠═2770886f-84a9-42c9-a576-348342888bbe
# ╠═e0c85c95-c1f7-4541-8b16-c3c92491146a
# ╠═1999d35a-0247-44db-bb37-6fdd06d6e53a
# ╠═0a851749-28f8-4955-8d7e-5583b0f98eb9
