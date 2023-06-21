### A Pluto.jl notebook ###
# v0.19.26

using Markdown
using InteractiveUtils

# ╔═╡ 8019fea8-102d-11ee-2602-41125f96071f
using PlutoUI, BenchmarkTools

# ╔═╡ 57e80c11-c9b1-41bc-8d5c-6b70488a68f6
TableOfContents()

# ╔═╡ 9d61bdbe-1ac5-423b-a7d0-42b1e3f52c14
struct Gelombang
	f # fungsi kondisi batas y(t,0) dan y(t,L)
	g # kondisi awal t(0,x)
	c # cepat rambat gelombang
end

# ╔═╡ d885aba3-4395-4fd6-9ab0-55a3b02c76f9
f(x, L) = 2*exp(-(x-L/2)^2)+x/L # Fungsi untuk kondisi batas

# ╔═╡ 35e21eab-6578-4dec-bfec-865ce6dee369
g(x) = 0 # kondisi awal

# ╔═╡ e4f22d84-9dd7-47be-809a-2bb87be50e45
L = 100 # panjang tali

# ╔═╡ 59e250c2-d5a7-49d8-8949-57588248acb3
T = 2400 # waktu simulasi

# ╔═╡ 787137c3-edbb-40c4-8fdd-53737b33ea93
c = 0.02 # kecepatan gelombang

# ╔═╡ 14952c02-564d-4cc6-a588-c81489fcc625
function sls_gelombang(T, L, gelombang::Gelombang; n_t=100, n_x=100)
	ts = range(0, T; length=n_t)
	xs = range(0, L; length=n_x)
	dt = ts[2] - ts[1]
	dx = xs[2] - xs[1]
	y = zeros(n_t, n_x)

	# kondisi batas
	y[:,1] .= gelombang.f(0)
	y[:,end] .= gelombang.f(L)

	# kondisi awal
	y[1,2:end-1] = gelombang.f.(xs[2:end-1])
	y[2,2:end-1] = y[1,2:end-1] + dt*gelombang.g.(xs[2:end-1])

	# solusi untuk t = 2*dt, 3*dt, ..., T
	for t in 2:n_t-1, x in 2:n_x-1
		dy_xx = (y[t, x+1] - 2*y[t, x] + y[t, x-1])/dx^2
		y[t+1, x] = c^2 * dt^2 * dy_xx + 2*y[t, x] - y[t-1, x]
	end

	return y
end

# ╔═╡ e8b17246-3c56-472b-8b98-03ee21c7cf18
gelombang = Gelombang(x -> f(x,L), g, c)

# ╔═╡ 69307fe4-1789-457a-a190-77eec287b86c
y = sls_gelombang(T, L, gelombang; n_t=2401, n_x=101)

# ╔═╡ 1ca519f5-046e-4fb8-8ff0-85243be52b4b
function sls_gelombang_op(T, L, gelombang::Gelombang; n_t=100, n_x=100)
    ts = range(0, T; length=n_t)
    xs = range(0, L; length=n_x)
    dt = ts[2] - ts[1]
    dx = xs[2] - xs[1]
    y = zeros(Float64, n_t, n_x)
    y[:, 1] .= gelombang.f(0)
    y[:, end] .= gelombang.f(L)
    y[1, 2:end-1] = gelombang.f.(xs[2:end-1])
    y[2, 2:end-1] = y[1, 2:end-1] + dt .* gelombang.g.(xs[2:end-1])

    c_squared_dt_squared = gelombang.c^2 * dt^2

    @inbounds for t in 2:n_t-1
        @inbounds for x in 2:n_x-1
            dy_xx = (y[t, x+1] - 2*y[t, x] + y[t, x-1]) / dx^2
            y[t+1, x] = c_squared_dt_squared * dy_xx + 2*y[t, x] - y[t-1, x]
        end
    end

    return y
end


# ╔═╡ e6fa189e-a1de-495f-ac9e-ba9ef3acf4da
y_op = sls_gelombang_op(T, L, gelombang; n_t=2401, n_x=101)

# ╔═╡ e79958c0-6efa-4664-a3e0-6c1106061025
@btime y

# ╔═╡ e5600169-b3bf-4e70-bce0-6992b3bc7447
@btime y_op

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
BenchmarkTools = "~1.3.2"
PlutoUI = "~0.7.51"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.1"
manifest_format = "2.0"
project_hash = "87102eed376ba65bbdad12009996051af50b626f"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "d9a9701b899b30332bbcb3e1679c41cce81fb0e8"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.3.2"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.2+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "d75853a0bdbfb1ac815478bacd89cd27b550ace6"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.3"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.10.11"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.21+4"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "5a6ab2f64388fd1175effdf73fe5933ef1e0bac0"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.7.0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "b478a748be27bd2f2c73a7690da219d0844db305"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.51"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "9673d39decc5feece56ef3940e5dafba15ba0f81"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.1.2"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "7eb1686b4f04b82f96ed7a4ea5890a4f0c7a09f1"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.9.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "Pkg", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "5.10.1+6"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "aadb748be58b492045b4f56166b5188aa63ce549"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.7"

[[deps.URIs]]
git-tree-sha1 = "074f993b0ca030848b897beff716d93aca60f06a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.2"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"
"""

# ╔═╡ Cell order:
# ╠═8019fea8-102d-11ee-2602-41125f96071f
# ╠═57e80c11-c9b1-41bc-8d5c-6b70488a68f6
# ╠═9d61bdbe-1ac5-423b-a7d0-42b1e3f52c14
# ╠═14952c02-564d-4cc6-a588-c81489fcc625
# ╠═d885aba3-4395-4fd6-9ab0-55a3b02c76f9
# ╠═35e21eab-6578-4dec-bfec-865ce6dee369
# ╠═e4f22d84-9dd7-47be-809a-2bb87be50e45
# ╠═59e250c2-d5a7-49d8-8949-57588248acb3
# ╠═787137c3-edbb-40c4-8fdd-53737b33ea93
# ╠═e8b17246-3c56-472b-8b98-03ee21c7cf18
# ╠═69307fe4-1789-457a-a190-77eec287b86c
# ╠═1ca519f5-046e-4fb8-8ff0-85243be52b4b
# ╠═e6fa189e-a1de-495f-ac9e-ba9ef3acf4da
# ╠═e79958c0-6efa-4664-a3e0-6c1106061025
# ╠═e5600169-b3bf-4e70-bce0-6992b3bc7447
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
