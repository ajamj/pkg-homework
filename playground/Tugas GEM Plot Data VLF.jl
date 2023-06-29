### A Pluto.jl notebook ###
# v0.19.26

using Markdown
using InteractiveUtils

# ╔═╡ 15663fbe-35ec-4e27-a4f7-8139a1f49477
begin
using PyCall

# Import modul Python
np = pyimport("numpy")
plt = pyimport("matplotlib.pyplot")
griddata = pyimport("scipy.interpolate").griddata

# Data
data1 = np.array([
    [40, -10, -0.035860833],
    [50, -10, -0.061771966],
    [60, -10, -0.068313176],
    [70, -10, -0.0180683],
    [80, -10, -0.040482699],
    [90, -10, -0.095735517],
    [100, -10, -0.105332233],
    [110, -10, -0.097632799],
    [120, -10, -0.077027436],
    [130, -10, -0.129555669],
    [140, -10, -0.182205239],
    [150, -10, -0.095073675],
    [160, -10, -0.164368584],
    [170, -10, 0.376444981],
    [180, -10, 0.432271396],
    [190, -10, 0.123157858],
    [200, -10, -0.211480739],
    [210, -10, -0.217591751],
    [220, -10, 0.418240335],
    [230, -10, 0.45741038],
    [240, -10, 0.504665934],
    [250, -10, 0.388424331],
    [260, -10, 0.080071911],
    [270, -10, -0.223393904],
    [280, -10, -0.347114328],
    [290, -10, -0.245433259],
    [300, -10, -0.104482869],
    [310, -10, -0.095172951],
    [320, -10, -0.076520023],
    [330, -10, -0.07678476],
    [340, -10, -0.041398248],
    [350, -10, 0.004974849],
    [360, -10, 0.033312739],
    [370, -10, 0.005063095],
    [380, -10, -0.0612094],
    [390, -10, -0.146906973],
    [400, -10, -0.213157407],
    [410, -10, -0.305936694],
    [420, -10, -0.365535611],
    [430, -10, -0.16342],
    [440, -10, 0.328472],
    [450, -10, 0.831241],
    [70, -20, -0.091687247],
    [80, -20, -0.11120057],
    [90, -20, -0.159018691],
    [100, -20, -0.20527045],
    [110, -20, -0.200538276],
    [120, -20, -0.126643562],
    [130, -20, -0.135887295],
    [140, -20, -0.233520094],
    [150, -20, -0.381497046],
    [160, -20, 0.160055577],
    [170, -20, 0.353809968],
    [180, -20, 0.525381605],
    [190, -20, 0.239862752],
    [200, -20, -0.077159804],
    [210, -20, 0.083259786],
    [220, -20, 0.248742472],
    [230, -20, 0.853225285],
    [240, -20, 0.79084663],
    [250, -20, 0.466918851],
    [260, -20, 0.074854386],
    [270, -20, -0.21086302],
    [280, -20, -0.375452218],
    [290, -20, -0.3410695],
    [300, -20, -0.225611076],
    [310, -20, -0.12925784],
    [320, -20, -0.180197651],
    [330, -20, -0.175708152],
    [340, -20, -0.117466012],
    [350, -20, -0.037405132],
    [360, -20, -0.035099714],
    [370, -20, -0.092988871],
    [380, -20, -0.165780515],
    [390, -20, -0.188922941],
    [400, -20, -0.257412608],
    [410, -20, -0.401462628],
    [420, -20, -0.414622263],
    [100, -30, -0.115072349],
    [110, -30, -0.182646468],
    [120, -30, -0.346573823],
    [130, -30, -0.357968545],
    [140, -30, -0.36832638],
    [150, -30, 0.186981536],
    [160, -30, 0.266082745],
    [170, -30, 0.400028636],
    [180, -30, 0.047233493],
    [190, -30, 0.204211502],
    [200, -30, 0.483795834],
    [210, -30, 0.251930346],
    [220, -30, 0.442276248],
    [230, -30, 0.511880018],
    [240, -30, 0.898495312],
    [250, -30, 0.613417687],
    [260, -30, 0.252625281],
    [270, -30, -0.119374325],
    [280, -30, -0.330766818],
    [290, -30, -0.483983356],
    [300, -30, -0.358343589],
    [310, -30, -0.246646637],
    [320, -30, -0.118602175],
    [330, -30, -0.152323051],
    [340, -30, -0.185713005],
    [350, -30, -0.20728907],
    [360, -30, -0.12303652],
    [370, -30, -0.024929401],
    [380, -30, -0.022028324],
    [390, -30, -0.240656962],
    [130, -40, -0.336833708],
    [140, -40, 0.162030074],
    [150, -40, 0.201343518],
    [160, -40, 0.243436701],
    [170, -40, -0.179767453],
    [180, -40, 0.001158224],
    [190, -40, 0.300145572],
    [200, -40, 0.60379891],
    [210, -40, 0.92930408],
    [220, -40, 0.60473652],
    [230, -40, 0.508868634],
    [240, -40, 0.268597747],
    [250, -40, 0.500529419],
    [260, -40, 0.401175829],
    [270, -40, 0.170964948],
    [280, -40, -0.076244256],
    [290, -40, -0.357990606],
    [300, -40, -0.624867563],
    [310, -40, -0.570618539],
    [320, -40, -0.380173361],
    [330, -40, -0.023947668],
    [340, -40, 0.090165009],
    [350, -40, 0.096430452],
    [360, -40, 0.002316449],
    [160, -50, -0.241848279],
    [170, -50, -0.096000254],
    [180, -50, 0.162052135],
    [190, -50, 0.460940207],
    [200, -50, 0.74879757],
    [210, -50, 0.958756072],
    [220, -50, 0.99999989],
    [230, -50, 0.376202306],
    [240, -50, 0.176050104],
    [250, -50, 0.057414837],
    [260, -50, 0.421284811],
    [270, -50, 0.217470414],
    [280, -50, -0.017814594],
    [290, -50, -0.265586363],
    [300, -50, -0.390608411],
    [310, -50, -0.441890174],
    [320, -50, -0.246205409],
    [330, -50, -0.126654592],
    [190, -60, 0.62280482],
    [200, -60, 0.821534061],
    [210, -60, 0.818070418],
    [220, -60, 0.712219741],
    [230, -60, 0.629941688],
    [240, -60, 0.118127855],
    [250, -60, 0.031261027],
    [260, -60, -0.089922334],
    [270, -60, 0.333634803],
    [280, -60, 0.261063773],
    [290, -60, 0.090815821],
    [300, -60, -0.04645],
    [220, -70, 0.798936271],
    [230, -70, 0.742786043],
    [240, -70, 0.713078051],
    [250, -70, 0.347220031],
    [260, -70, 0.193911862],
    [270, -70, 0.396085116],
    [280, -70, 0.277586688],
    [290, -70, 0.104958176],
    [300, -70, -0.124317503],
    [310, -70, -0.359530249],
    [320, -70, -0.484422265],
    [220, -70, 0.401529],
    [230, -70, 0.428686],
    [240, -70, 0.558761],
    [250, -70, 0.161887],
    [260, -70, 0.156493],
    [270, -70, 0.060437],
])

# Extract x, y, z values from data
x = data1[:, 1]
y = data1[:, 2]
z = data1[:, 3]

# Define the grid size
x_grid = np.linspace(np.min(x), np.max(x), 999)
y_grid = np.linspace(np.min(y), np.max(y), 999)

# Create a meshgrid for the heatmap
X_grid, Y_grid = np.meshgrid(x_grid, y_grid)

# Perform interpolation using nearest method
Z_grid = griddata((x, y), z, (X_grid, Y_grid), method="cubic")

# Plot the heatmap
plt.imshow(Z_grid, cmap="jet", extent=[np.min(x), np.max(x), np.min(y), np.max(y)], origin="lower")
plt.colorbar()
plt.xlabel("X")
plt.ylabel("Y")
plt.title("Heatmap")
plt.show()

end

# ╔═╡ 5d29702e-00ed-11ee-0145-d54098cd82e2
md"""ngolah GEM"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PyCall = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"

[compat]
PyCall = "~1.95.1"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.0"
manifest_format = "2.0"
project_hash = "2861984172f9cae19c964b507b90a6163fe64c88"

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

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

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

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "42324d08725e200c23d4dfb549e0d5d89dede2d2"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.10"

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
git-tree-sha1 = "a5aef8d4a6e8d81f171b2bd4be5265b01384c74c"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.10"

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

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.PyCall]]
deps = ["Conda", "Dates", "Libdl", "LinearAlgebra", "MacroTools", "Serialization", "VersionParsing"]
git-tree-sha1 = "62f417f6ad727987c755549e9cd88c46578da562"
uuid = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"
version = "1.95.1"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

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
"""

# ╔═╡ Cell order:
# ╠═5d29702e-00ed-11ee-0145-d54098cd82e2
# ╠═15663fbe-35ec-4e27-a4f7-8139a1f49477
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
