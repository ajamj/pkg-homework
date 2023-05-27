### A Pluto.jl notebook ###
# v0.19.25

using Markdown
using InteractiveUtils

# ╔═╡ 9524b82b-3060-4a04-8bd2-693d312fea22
using GMT

# ╔═╡ 4f4c3bc0-f376-11ed-23b1-4780df300c33
md"""
# Generic Mapping Tools
"""

# ╔═╡ cd465684-4124-4c91-bcd9-c108c1454787
md"""
Peta sederhana.
"""

# ╔═╡ 615a0220-939f-4822-bb11-0685593e9b67
coast(R="104/116/-10/-4", J="M15c", B="afg", W="0.5p", show=true)

# ╔═╡ d0eff324-1a16-4c9e-ad76-ab23509ab23c
md"""
Peta dengan data grid dengan `cpt` otomatis.
"""

# ╔═╡ b844ff45-2cb8-441b-af54-28dad491b127
grdimage("@earth_relief_20m.grd", R="104/116/-10/-4", J="R15c",  B="a", show=true)

# ╔═╡ 72b8958b-1be4-4961-b35d-0cfcfe00ba49
md"""
Mendefinisikan nilai `cpt`.
"""

# ╔═╡ c7c662cb-0a10-4c15-beec-3fbd37ff56a1
begin
	CPT = makecpt(T="-10000/8000/1000")
	grdimage("@earth_relief_20m.grd", J="R15c", B="a", C=CPT, show=true)
end

# ╔═╡ 5f175a4b-0744-445a-8104-d4e1e1bf3cba


# ╔═╡ 638ec4e9-e037-4852-82d5-e4d496b208d1
begin
	G = gmtread("@earth_relief_20m.grd")
	grdimage(G, J="R15c", B="a", C=CPT, show=true)
end

# ╔═╡ 2173944a-c97d-45e6-bc29-1515f63fdf45
md"""
Example: create three grids with random data, compute their average and display it
"""

# ╔═╡ ba4a288b-bc7d-4afd-9ff2-9dff5672058a
begin
    G1 = mat2grid(rand(128,128));
    G2 = mat2grid(rand(128,128));
    G3 = mat2grid(rand(128,128));
    Gavg = (G1 .+ G2 .+ G3) ./ 3;
    imshow(Gavg)
end

# ╔═╡ 78eb76d6-3509-47a6-9a07-ef753de6bba0
md"""
Memunculkan manual
"""

# ╔═╡ 0870f543-e54c-49f9-b706-75c82880c361
gmthelp(plot)

# ╔═╡ b34b04ba-6a70-48e9-b006-510095d39dd5
gmthelp(:b)

# ╔═╡ ab68b159-2b71-4fef-9e7b-367a507c0829
# A Scatter plot
scatter(rand(100),rand(100), markersize=rand(100), marker=:c, color=:ocean, zcolor=rand(100), figsize=10, alpha=50, Y=4, title="Scatter", show=true)

# ╔═╡ 43e0856a-2054-4313-96eb-fca3c49d075e
    # Colored bar plot
    bar(rand(15), color=:rainbow, figsize=(14,8), title="Colored bars", Y=3, show=true)

# ╔═╡ 2d51e897-6f26-4699-849a-f01525dab206
    # Arrow
    arrows([0.5 0.5 0 8], limits=(-0.1,9,0,2.5), figsize=(16,5), arrow=(len=2,stop=1,shape=0.5), pen=6, B="a WSrt", title="Arrow", show=true)

# ╔═╡ 39156ee0-ec76-4731-ace6-ff511be6e040
begin
    # Peaks 3D bars
    G! = GMT.peaks()  
	cmap = grd2cpt(G!) # Compute a colormap with the grid's data range
    bar3(G!, lw=:thinnest, color=cmap, figsize=14, Y=5, show=true)
end

# ╔═╡ 465b577e-0b4a-4335-a320-8a69ddcfc551
begin
	# Contours
    grdcontour(G!, color=makecpt(range=(-6,8,1)), pen="+c", figsize=16, region=(-3,3,-3,3), title="Contours", show=true)
end

# ╔═╡ aaeb0ad1-ed94-4a42-b829-d903a78d4a85
md"""Hello World"""

# ╔═╡ 604f33b4-02e1-4e35-b81c-0ee88887c4c4
begin
	plot(1:10, rand(10), lw=1, lc=:blue, marker=:square,
     markeredgecolor=0, size=0.2, markerfacecolor=:red, title="Hello World", xlabel="Spoons", ylabel="Forks", show=true)
end

# ╔═╡ 0264fd99-3622-453b-af88-3b69c26cb41f
md"""
!!! catatan

	Nilai default dari `figsize` adalah 12x8 cm (tidak termasuk label dan judul).
"""

# ╔═╡ 89d74c54-4ca3-41d5-b0e6-033a68a97932
md""" Hello Round World"""

# ╔═╡ 5c1e878a-3da3-4a48-99cc-d2ab56364ab8
begin
	x = range(0, stop=2pi, length=180)
	seno = sin.(x/0.2)*45
	coast(region=[0 360 -90 90], proj=(name=:laea, center=(114,10)), frame=:g, res=:crude, land=:navy, figsize=6)
	plot!(collect(x)*60, seno, lw=0.5, lc=:red, marker=:circle,
      markeredgecolor=0, size=0.05, markerfacecolor=:cyan, show=true)
end

# ╔═╡ c73584e7-a4bb-4390-9045-d49f63560c34
md"""
## Color Images
"""

# ╔═╡ 2c76a9a5-c182-4dc7-9df1-1c977b1757ac
md"""
## Perspective View
"""

# ╔═╡ 2450fa2b-34e1-4428-9f83-1562f8c48bae
begin
topo = makecpt(color=:rainbow, range=(1000,5000,500), continuous=true)
grdview("@tut_relief.nc", proj=:Mercator, zsize=1, shade=(azim=100, norm="e0.8"), view=(135,30), frame=:a, fmt=:jpg, Q="i100", show=true)
end

# ╔═╡ f593568f-bbb5-4226-8aa9-eb2da9bf7dbb
md"""
## Simple filled rectangle
"""

# ╔═╡ df2dd981-6bc2-4fb1-a3d8-7db5828345c7
begin
rect = [2 2; 2 6; 6 6; 6 2; 2 2];
plot(rect, region=[0 10 0 10], lw=1, fill=:blue, axes=:a, aspect=:equal, show=true)
end

# ╔═╡ e377ad89-9ab0-4392-82e2-aa03a49056d6
md"""
## Rectangle with pattern
"""

# ╔═╡ e51b967d-e462-47a3-acdd-2474abe34287
begin
rect2 = [1 1; 1 7; 4 7; 4 1; 1 1];
plot(rect2, region=[0 10 0 10], lw=1, fill="p20+bgreen+r200", axes=:a, aspect=:equal)
plot!([4 0].+rect2, lw=1, fill="p89+r200", show=true)
end

# ╔═╡ 703f2079-14ec-4837-b4fb-c94d68ffe1a3
md"""
## With transparency
"""

# ╔═╡ ce9ea5ea-a994-4f40-9ded-adbe54733a0d
begin
rect3 = [0.5 0.5; 0.5 7; 2.5 7; 2.5 0.5; 0.5 0.5];
plot(rect3, region=[0 10 0 10], lw=0.5, fill=:blue, axes=:a, aspect=:equal)
plot!([3 0].+rect3, lw=1, ls="--", fill=:blue, transparency=30)
plot!([6 0].+rect3, lw=2, lc=:red, fill=:blue, transparency=70, show=true)
end

# ╔═╡ f787c54d-2bc7-494f-b859-de20f0835377
begin
	coast(region=(92,150,-13,10), proj=(name=:cylindricalStereographic, center=(0,45)), xaxis=(annot=60, ticks=10, grid=10), yaxis=(annot=10,grid=10), res=:low, area=50, shore=:darkgray, land=:pink, ocean=:skyblue, figsize=12, show=true)
end

# ╔═╡ 990da4d9-d72b-4c6d-9155-0e6264d9afa3
md"""
## Peta Administratif Indonesia
"""

# ╔═╡ c3c8da14-a02d-4249-bbbc-26f606dac984
mozambique = gadm("IDN") 

# ╔═╡ ccef510c-1af2-4ed5-aa69-7f8350ec1b37


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
GMT = "5752ebe1-31b9-557e-87aa-f909b540aa54"

[compat]
GMT = "~0.44.8"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.0"
manifest_format = "2.0"
project_hash = "27431362f1302efa77e76a590e0c412b6b7b164e"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.2+0"

[[deps.Conda]]
deps = ["Downloads", "JSON", "VersionParsing"]
git-tree-sha1 = "e32a90da027ca45d84678b826fffd3110bb3fc90"
uuid = "8f4d0f93-b110-5947-807f-2305c1781a2d"
version = "1.8.0"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "8da84edb865b0b5b0100c0666a9bc9a0b71c553c"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.15.0"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.GMT]]
deps = ["Conda", "Dates", "Pkg", "PrettyTables", "Printf", "SnoopPrecompile", "Statistics", "Tables"]
git-tree-sha1 = "5968385e86d9c119db96d05e41df420c245f73da"
uuid = "5752ebe1-31b9-557e-87aa-f909b540aa54"
version = "0.44.8"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

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

[[deps.OrderedCollections]]
git-tree-sha1 = "d321bf2de576bf25ec4d3e4360faca399afca282"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "7302075e5e06da7d000d9bfa055013e3e85578ca"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.9"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.0"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "259e206946c293698122f63e2b513a7c99a244e8"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.1.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "7eb1686b4f04b82f96ed7a4ea5890a4f0c7a09f1"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.0"

[[deps.PrettyTables]]
deps = ["Crayons", "Formatting", "LaTeXStrings", "Markdown", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "213579618ec1f42dea7dd637a42785a608b1ea9c"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.2.4"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

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

[[deps.SnoopPrecompile]]
deps = ["Preferences"]
git-tree-sha1 = "e760a70afdcd461cf01a575947738d359234665c"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.9.0"

[[deps.StringManipulation]]
git-tree-sha1 = "46da2434b41f41ac3594ee9816ce5541c6096123"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.3.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "Pkg", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "5.10.1+6"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "1544b926975372da01227b382066ab70e574a3ec"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.10.1"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.VersionParsing]]
git-tree-sha1 = "58d6e80b4ee071f5efd07fda82cb9fbe17200868"
uuid = "81def892-9a0e-5fdd-b105-ffc91e053289"
version = "1.3.0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.7.0+0"

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
# ╟─4f4c3bc0-f376-11ed-23b1-4780df300c33
# ╠═9524b82b-3060-4a04-8bd2-693d312fea22
# ╟─cd465684-4124-4c91-bcd9-c108c1454787
# ╠═615a0220-939f-4822-bb11-0685593e9b67
# ╟─d0eff324-1a16-4c9e-ad76-ab23509ab23c
# ╠═b844ff45-2cb8-441b-af54-28dad491b127
# ╟─72b8958b-1be4-4961-b35d-0cfcfe00ba49
# ╠═c7c662cb-0a10-4c15-beec-3fbd37ff56a1
# ╠═5f175a4b-0744-445a-8104-d4e1e1bf3cba
# ╠═638ec4e9-e037-4852-82d5-e4d496b208d1
# ╟─2173944a-c97d-45e6-bc29-1515f63fdf45
# ╠═ba4a288b-bc7d-4afd-9ff2-9dff5672058a
# ╟─78eb76d6-3509-47a6-9a07-ef753de6bba0
# ╠═0870f543-e54c-49f9-b706-75c82880c361
# ╠═b34b04ba-6a70-48e9-b006-510095d39dd5
# ╠═ab68b159-2b71-4fef-9e7b-367a507c0829
# ╠═43e0856a-2054-4313-96eb-fca3c49d075e
# ╠═2d51e897-6f26-4699-849a-f01525dab206
# ╠═39156ee0-ec76-4731-ace6-ff511be6e040
# ╠═465b577e-0b4a-4335-a320-8a69ddcfc551
# ╟─aaeb0ad1-ed94-4a42-b829-d903a78d4a85
# ╠═604f33b4-02e1-4e35-b81c-0ee88887c4c4
# ╟─0264fd99-3622-453b-af88-3b69c26cb41f
# ╟─89d74c54-4ca3-41d5-b0e6-033a68a97932
# ╠═5c1e878a-3da3-4a48-99cc-d2ab56364ab8
# ╟─c73584e7-a4bb-4390-9045-d49f63560c34
# ╠═a444039e-2511-42d7-be4d-a8b90e10a32d
# ╟─2c76a9a5-c182-4dc7-9df1-1c977b1757ac
# ╠═2450fa2b-34e1-4428-9f83-1562f8c48bae
# ╠═eb1dbd02-48db-485c-8612-297c6f7e548d
# ╟─f593568f-bbb5-4226-8aa9-eb2da9bf7dbb
# ╠═df2dd981-6bc2-4fb1-a3d8-7db5828345c7
# ╟─e377ad89-9ab0-4392-82e2-aa03a49056d6
# ╠═e51b967d-e462-47a3-acdd-2474abe34287
# ╟─703f2079-14ec-4837-b4fb-c94d68ffe1a3
# ╠═ce9ea5ea-a994-4f40-9ded-adbe54733a0d
# ╠═f787c54d-2bc7-494f-b859-de20f0835377
# ╟─990da4d9-d72b-4c6d-9155-0e6264d9afa3
# ╠═c3c8da14-a02d-4249-bbbc-26f606dac984
# ╟─ccef510c-1af2-4ed5-aa69-7f8350ec1b37
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
