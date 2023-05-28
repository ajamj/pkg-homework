### A Pluto.jl notebook ###
# v0.19.26

#> [frontmatter]
#> title = "Post-mid Assignment 01"
#> date = "2023-04-28"
#> description = "Post-mid Assignment 01 Pemrograma Komputer Geofisika"

using Markdown
using InteractiveUtils

# ╔═╡ ac59b63a-5ad8-49e8-bb68-3b2c0ceb1781
using Images

# ╔═╡ 55aeacfd-c258-4ab0-b2f2-0da7ec021d15
using PlutoUI

# ╔═╡ 882774af-ad2a-4729-8f55-724f3f016591
md"""
# Post-mid Assignment 01
Pemrograman Komputer Geofisika\
Ajam Jamaludin (19/445602/PA/19426)\
[https://github.com/ajamj/pkg-homework](https://github.com/ajamj/pkg-homework)
"""

# ╔═╡ 4f11812f-5a81-4188-9454-d327b95aa152
md"""
## Instalasi Julia dan Pluto.jl
Bahasa pemrograman Julia diunduh melalui tautan pada [situs resmi Julia.](https://julialang.org/downloads/) Versi dari Julia yang akan digunakan dalam pengerjaan tugas ini adalah versi terbaru dari yang tersedia, yaitu versi 1.9.0-rc2, yang diinstal pada sistem operasi Windows 10. Saat tulisan ini ditulis, terdapat versi stabil dari Julia, yaitu versi 1.8.5, serta juga terdapat versi dengan dukungan jangka panjang (long term support - LTS) versi 1.6.7.\
\
"""

# ╔═╡ f9324fdd-8750-44d6-812a-b7750cfe0b4a
load(download("https://github.com/ajamj/pkg-homework/blob/main/img/pluto_ss.png?raw=true"))

# ╔═╡ c8fc9aa7-ec37-4797-aa0a-6e1495e3fba8
md"""
Adapun untuk dalam penulisan kode serta markdown, digunakan bantuan dari paket [Pluto.jl](https://plutojl.org/). Instalasi Pluto.jl dilakukan dengan cara menjalankan perintah berikut pada terminal Julia:\

> import Pkg; Pkg.add("Pluto")

Lalu memasukkan perintah:\

> import Pluto; Pluto.run()

Setelah itu, secara otomatis komputer akan membuka aplikasi peramban dan membuka jendela Pluto.jl.\
\
"""

# ╔═╡ 91be7b4d-437a-49b2-be6f-22a47d3bada3
load(download("https://github.com/ajamj/pkg-homework/blob/main/img/terminal_ss.png?raw=true"))

# ╔═╡ 81868301-fbfa-482e-b50d-62a4e0d69f60
md"""
## Sintaks Dasar pada Bahasa Pemrograman Julia
### Operator Aritmetika
|Ekspresi |Keterangan|
|:-------:|:---------|
|`+`      | penjumlahan|
|`-`      | pengurangan|
|`*`      | perkalian  |
|`/`      | pembagian  |
|`\`      | pembagian terbalik|
|`%`      | modulus; sisa pembagian|
|`÷`      | pembagian dengan hasil bilangan integer; pembulatan ke bawah|
|`^`      | pangkat|
|`.`      | (dot) operasi per elemen matriks/array|
"""

# ╔═╡ 45626aa0-e4d8-11ed-37a7-d13338b216e8
x = 2 # Memasukkan nilai ke dalam variabel

# ╔═╡ fcb2860f-c022-44b1-b370-4b10f89951e6
y = 3

# ╔═╡ 8343079e-fba8-450c-a1ee-9cf89bc0dd78
x+y # Penjumlahan

# ╔═╡ 557d9041-2766-49e2-98cb-509f6aa7419d
x-y # Pengurangan

# ╔═╡ 5879411a-e937-4003-804a-9f4c8137a07c
x*y # Perkalian

# ╔═╡ d468ddb7-37f5-47dc-be62-aa7e5d075ffc
x/y # Pembagian

# ╔═╡ 15e3fa1d-3139-49cb-8a0c-f279997ed385
x\y # Pembagian terbalik; sama dengan y/x

# ╔═╡ 1f7afb64-0296-4b75-96b7-83a70f53d613
x%y # Modulus; sisa hasil pembagian

# ╔═╡ edae3275-9f96-4c29-a855-cf064fb2a9b3
y÷x	# Pembagian dengan hasil bilangan integer; pembulatan ke bawah

# ╔═╡ 4f75b046-8a29-4ecf-ab46-971730b408f6
x^y # Pangkat

# ╔═╡ cda07515-615c-4c4d-b12d-3c83a8f894d0
a = [1, 2, 3] # Matriks 3 baris 1 kolom

# ╔═╡ 068213c3-22ab-4c36-98b9-4ebd1572075e
b = [5 6 7] # Matriks 1 baris 3 kolom

# ╔═╡ 07203a2e-a4b3-41ae-97f7-8a06864340ea
a.*3 # Perkalian dot; perkalian tiap elemen dengan satu nilai

# ╔═╡ 2f4115cb-4d2e-4cbc-a971-419b0da3042f
a.^3 # Operator dot juga bisa digunakan pada operator aritmetika lain

# ╔═╡ ab316c33-7eaf-40f8-be7a-03c62baffdcd
md"""
### Operator Pembanding
Membandingkan nilai kebenaran dari variabel.
"""

# ╔═╡ 9a669a79-2449-45a0-8c45-df26f12e9ace
md"""
|Ekspresi|Keterangan|
|:-------|:---------|
|`<`     | kurang dari?|
|`>`     | lebih dari? |
|`<=`    | kurang dari atau sama dengan?|
|`>=`    | lebih dari atau sama dengan? |
|`==`    | bernilai sama?|
|`!=`    | bernilai tidak sama?|
"""

# ╔═╡ c3b7c8a8-90a7-4f59-b310-c34e308bdf83
x<y # Apakah x kurang dari y?

# ╔═╡ 1ea13fce-777e-48eb-a359-e94981c65110
x>y # Apakah x lebih dari y?

# ╔═╡ c892d967-7964-4e50-a943-ebca0a3afdda
x<=y # Apakah x kurang dari atau sama dengan y?

# ╔═╡ 0c975c74-2061-40a9-b75f-efa4ca500e2e
x>=y # Apakah x lebih dari atau sama dengan y?

# ╔═╡ 821dc8e7-2a67-404e-907b-fe4de780ffb2
x==y # Apakah x sama dengan y?

# ╔═╡ 1c3a0a62-6f3a-47ad-82d6-3aba078bf2ff
x!=y # Apakah x tidak sama dengan y?

# ╔═╡ eae8dee2-d12c-443f-b706-9b2208a76859
md"""
### Operator Logika
|Ekspresi|Keterangan|
|:-------|:---------|
|`&&`    | Jika keduanya true, maka bernilai true. Selain itu, false.|
|`\|\|`  | Jika salah satunya true, maka true. Jika tidak ada yang true, maka false.|
|`!`     | Negasi; pembalik nilai kebenaran.|
"""

# ╔═╡ 4cb80c58-63bf-41d0-b11a-ea8343656664
c = true

# ╔═╡ 8431546b-0802-46db-be0b-f0d76260a3f3
d = false

# ╔═╡ 18b54554-da37-458e-9df7-05579ca76cee
!c # Negasi dari true; false

# ╔═╡ 95ecbdad-ef68-4db3-978d-f98f68ddb9b8
c&&d # Tidak memenuhi syarat keduanya true, maka false

# ╔═╡ 96e326fe-8867-4a06-92d7-1fa08b66b20d
c&&c # Memenuhi syarat keduanya true, maka true

# ╔═╡ 301c54f8-5e1d-4007-bda3-b20522a9c39d
d&&d # Tidak memenuhi syarat keduanya true, maka false

# ╔═╡ 5fdaf5d5-2dc5-4f83-8d1b-a8fc58524358
c||d # Memenuhi syarat salah satunya true, maka true

# ╔═╡ 5fa10a66-8aed-467c-90f3-01f07feb4fa3
c||c # Memenuhi syarat salah satunya true, maka true

# ╔═╡ 4d8863c3-0c2f-477a-bdb1-ab6977290ff1
d||d # Tidak memenuhi syarat salah satunya true, maka false

# ╔═╡ d8405b87-5d9d-4e94-9ac7-8ee324d979c8
md"""
### Operator Bitwise
Operasi yang dilakukan pada tingkat bit.
"""

# ╔═╡ db1a51cc-f05f-406a-97aa-b2a7ffbb788a
md"""
| Ekspresi | Nama        | Keterangan                                         |
|:-------- | :---------- | :------------------------------------------------- |
| `~`      | bitwise not | Membalik nilai bentuk binernya, 0 jadi 1, 1 jadi 0.|       
| `&`      | bitwise and | Membandingkan nilai bit pada 'posisi' yang sama. Jika nilai bit pada posisi yang sama dari kedua nilai adalah bernilai 1, maka hasilnya pada posisi tersebut akan bernilai 1. Jika tidak, maka nilai bit pada posisi tersebut akan bernilai 0|
| `\|`     | bitwise or  | Membandingkan nilai bit pada 'posisi' yang sama. Jika nilai bit pada posisi yang sama dari kedua nilai ada yang bernilai 1, maka hasilnya pada posisi tersebut akan bernilai 1. Jika tidak ada yang bernilai 1, maka akan bernilai 0.|
|`⊻`       | bitwsie xor | Jika nilai bit pada 'posisi' yang sama berbeda, maka posisi tersebut akan bernilai 1. Jika sama, maka 0. |
|`⊼`       | bitwise nand| Negasi dari bitwise and.                           |
|`⊽`       | bitwsie nor | Negasi dari bitwise or.                            |
|`>>>`     | logical shift right| Menggeser nilai bit ke kanan. Most Significant Bit (MSB) yang kosong akan diisi 0. |
|`>>`      | arithmetic shift right| Menggeser nilai bit ke kanan. MSB yang kosong akan diisi nilai MSB asli.|
|`<<`      | logical/arithmetic shift left| Menggeser nilai bit ke kiri. Least Significant Bit (LSB) yang kosong akan diisi nilai LSB asli. |
"""

# ╔═╡ 14209da3-8ad8-48fe-95fc-323965098eed
bitstring(x)

# ╔═╡ 355c97c6-783c-42ab-9351-962376b8bf4a
bitstring(y)

# ╔═╡ a544d273-b26d-4faf-90e4-868a3ac355f6
~x

# ╔═╡ 4d7cc38f-71b6-45e5-8ca6-ca42a72d415d
bitstring(~x)

# ╔═╡ 563f594c-8d49-404e-afd3-ff60e95d4a66
x&y

# ╔═╡ 8b7622ce-70e4-474b-8a06-c7d6e9cb98c2
bitstring(x&y)

# ╔═╡ 5c395d87-a6e9-4684-8cc6-95bd5eda1ec0
x|y

# ╔═╡ 03c8fd1d-66dd-4643-b516-7693d7b0b6ed
bitstring(x|y)

# ╔═╡ 050126c6-2c20-4d6f-8895-6ad8bf4a26c6
x⊻y

# ╔═╡ 29183a63-1fdc-4e52-b325-7d213499f4d8
bitstring(x⊻y)

# ╔═╡ 51ab37aa-9f9d-4acc-8b60-f434043d223d
x⊼y

# ╔═╡ 988fd207-0bb1-4601-aa8e-ebfb5d6beaaf
bitstring(x⊼y)

# ╔═╡ bd3f932f-85bd-455c-a62f-9fb09feb82af
x⊽y

# ╔═╡ f1464b07-865c-4ef8-ae48-889e6c93b2e4
bitstring(x⊽y)

# ╔═╡ 43d697d2-8f45-4462-a993-09646fda53d8
x>>>1

# ╔═╡ a7f0a92a-4af7-4ad2-8e21-cbc3fbc62711
bitstring(x>>>1) # Posisi kosong pada bit paling signifikan (MSB) diisi dengan nol.

# ╔═╡ f0aa1590-526e-4cf3-8e4e-b6d1b0ee0b6a
x>>1

# ╔═╡ 126a7c31-9da5-4f20-8fc6-453582e051ff
bitstring(x>>1) # Posisi kosong pada bit paling signifikan (MSB) diisi dengan salinan MSB asli.

# ╔═╡ 0f700b6f-bb04-4776-9bac-84bdc66c0c77
md"""
!!! catatan
	Perbedaan *logical shift right* `>>>` dengan *arithmetic shift right* `>>` adalah pada pengisian **MSB**. *Logical shift right* `>>>` akan mengisi **MSB** dengan `0`, sedangkan *arithmetic shift right* `>>` akan mengisi **MSB** dengan nilai yang sama dengan **MSB** asli.
"""

# ╔═╡ 07dfe8b4-05ff-42f5-bad8-e36defc092fd
x<<1

# ╔═╡ bd9b7c0b-86e3-4d39-b7ca-cc35c909544d
bitstring(x<<1) # Posisi kosong pada bit paling tidak signifikan (LSB) diisi dengan angka nol.

# ╔═╡ 50b19a93-16c0-4610-8b78-8de634678593
md"""
### Aliran Kontrol: if, else, elseif
Mengeksekusi perintah berdasarkan kondisi tertentu.
"""

# ╔═╡ 9d07a369-3782-444a-9ffa-216c371b7846
if x < y
	println("x kurang dari y")
elseif x > y
	println("x lebih dari y")
else
	println("x sama dengan y")
end

# ╔═╡ ead86c29-bcf9-4445-9c49-b005c396f939
md"""
### Fungsi
"""

# ╔═╡ 27f4c2e9-7cd9-4223-85ca-1b0f3a4804f6
# Mendefinisikan fungsi tambah_kuadrat dengan keluaran x^2+y^2
function tambah_kuadrat(x,y)
	x^2+y^2
end

# ╔═╡ 409dfc55-625f-4ded-80c9-6d6a51931376
# Memanggil fungsi tambah kuadrat
tambah_kuadrat(x,y)

# ╔═╡ e72bc015-02e8-4ab4-b5f3-0b61f7342ec6
# Mendefinisikan fungsi kurang_kuadrat dengan keluarang x^2-y^2
kurang_kuadrat(x,y) = x^2-y^2

# ╔═╡ b6dd0707-d532-4c01-94ba-5464003f8443
# Memanggil fungsi kurang kuadrat
kurang_kuadrat(x,y)

# ╔═╡ dd310ec1-31b9-4e4f-a394-9ea7f46663a1
# Mendefinisikan fungsi kali(x,y). Keluaran yang akan keluar adalah perintah yang terdapat keyword 'return' sebelum suatu perintah, walaupun ada perintah lain pada baris antara baris yang mengandung keyword 'return' dan 'end'.
function kali(x,y)::Int8
	return x*y
	x+y
end

# ╔═╡ 99ff6d08-a9b8-40d0-8380-1aea23422332
kali(x,y)

# ╔═╡ b10bb293-1501-450f-a2ae-384fc0b3b5f2
# Mendefinisikan fungsi tanpa memberikan nilai keluaran atau dengan keluaran 'nothing'
function cetak(x)
	println("Nilai dari x adalah $x")
	return nothing
end

# ╔═╡ 5d5703fa-1d95-4e9b-82c9-141166d65ca6
cetak(x)

# ╔═╡ abd9f506-336b-4109-88e6-4e83a2e9f196
# Mendefinisikan fungsi anonymous
x -> x^0 + x^1 + x^2

# ╔═╡ f3039f0f-99b8-4f80-a933-5944f3df6b3f
ganjilkah(n::Integer) = n%2!=0 ? println("Ya, bilangan tersebut ganjil") : println("Bukan, bilangan tersebut bukan ganjil")

# ╔═╡ c69e3e59-ff2d-4ffc-a907-8e73cb77f5b7
ganjilkah(5)

# ╔═╡ d03571e4-91d8-4048-bb5a-7788e20d9736
ganjilkah(10)

# ╔═╡ 37d4fd05-1273-48aa-b942-7aadb09eceea
map(x -> x^3, [2, 3, 4]) # map(f,c..) -> collection. Fungsi yang dapat mengubah koleksi c dengan menerapkan f ke setiap elemen dari c.

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Images = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
Images = "~0.25.3"
PlutoUI = "~0.7.50"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.0"
manifest_format = "2.0"
project_hash = "ef4faae9a7538636e2003088537efb6b5498928f"

[[deps.AbstractFFTs]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "16b6dbc4cf7caee4e1e75c49485ec67b667098a0"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.3.1"
weakdeps = ["ChainRulesCore"]

    [deps.AbstractFFTs.extensions]
    AbstractFFTsChainRulesCoreExt = "ChainRulesCore"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "76289dc51920fdc6e0013c872ba9551d54961c24"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.6.2"
weakdeps = ["StaticArrays"]

    [deps.Adapt.extensions]
    AdaptStaticArraysExt = "StaticArrays"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.ArnoldiMethod]]
deps = ["LinearAlgebra", "Random", "StaticArrays"]
git-tree-sha1 = "62e51b39331de8911e4a7ff6f5aaf38a5f4cc0ae"
uuid = "ec485272-7323-5ecc-a04f-4719b315124d"
version = "0.2.0"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "66771c8d21c8ff5e3a93379480a2307ac36863f7"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.0.1"

[[deps.AxisArrays]]
deps = ["Dates", "IntervalSets", "IterTools", "RangeArrays"]
git-tree-sha1 = "1dd4d9f5beebac0c03446918741b1a03dc5e5788"
uuid = "39de3d68-74b9-583c-8d2d-e117c070f3a9"
version = "0.4.6"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.CEnum]]
git-tree-sha1 = "eb4cb44a499229b3b8426dcfb5dd85333951ff90"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.4.2"

[[deps.CatIndices]]
deps = ["CustomUnitRanges", "OffsetArrays"]
git-tree-sha1 = "a0f80a09780eed9b1d106a1bf62041c2efc995bc"
uuid = "aafaddc9-749c-510e-ac4f-586e18779b91"
version = "0.2.2"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "e30f2f4e20f7f186dc36529910beaedc60cfa644"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.16.0"

[[deps.Clustering]]
deps = ["Distances", "LinearAlgebra", "NearestNeighbors", "Printf", "Random", "SparseArrays", "Statistics", "StatsBase"]
git-tree-sha1 = "a6e6ce44a1e0a781772fc795fb7343b1925e9898"
uuid = "aaaa29a8-35af-508c-8bc3-b662a17a0fe5"
version = "0.15.2"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "be6ab11021cd29f0344d5c4357b163af05a48cba"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.21.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "600cc5508d66b78aae350f7accdb58763ac18589"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.10"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.Compat]]
deps = ["UUIDs"]
git-tree-sha1 = "7a60c856b9fa189eb34f5f8a6f6b5529b7942957"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.6.1"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.2+0"

[[deps.ComputationalResources]]
git-tree-sha1 = "52cb3ec90e8a8bea0e62e275ba577ad0f74821f7"
uuid = "ed09eef8-17a6-5b46-8889-db040fac31e3"
version = "0.3.2"

[[deps.CoordinateTransformations]]
deps = ["LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "f9d7112bfff8a19a3a4ea4e03a8e6a91fe8456bf"
uuid = "150eb455-5306-5404-9cee-2592286d6298"
version = "0.6.3"

[[deps.CustomUnitRanges]]
git-tree-sha1 = "1a3f97f907e6dd8983b744d2642651bb162a3f7a"
uuid = "dc8bdbbb-1ca9-579f-8c36-e416f6a65cce"
version = "1.0.2"

[[deps.DataAPI]]
git-tree-sha1 = "8da84edb865b0b5b0100c0666a9bc9a0b71c553c"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.15.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Distances]]
deps = ["LinearAlgebra", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "49eba9ad9f7ead780bfb7ee319f962c811c6d3b2"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.8"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FFTViews]]
deps = ["CustomUnitRanges", "FFTW"]
git-tree-sha1 = "cbdf14d1e8c7c8aacbe8b19862e0179fd08321c2"
uuid = "4f61f5a4-77b1-5117-aa51-3ab5ef4ef0cd"
version = "0.3.2"

[[deps.FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "f9818144ce7c8c41edf5c4c179c684d92aa4d9fe"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.6.0"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c6033cc3892d0ef5bb9cd29b7f2f0331ea5184ea"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.10+0"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "299dc33549f68299137e51e6d49a13b5b1da9673"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.1"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "d61890399bc535850c4bf08e4e0d3a7ad0f21cbd"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.2"

[[deps.Graphs]]
deps = ["ArnoldiMethod", "Compat", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "1cf1d7dcb4bc32d7b4a5add4232db3750c27ecb4"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.8.0"

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
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.ImageAxes]]
deps = ["AxisArrays", "ImageBase", "ImageCore", "Reexport", "SimpleTraits"]
git-tree-sha1 = "c54b581a83008dc7f292e205f4c409ab5caa0f04"
uuid = "2803e5a7-5153-5ecf-9a86-9b4c37f5f5ac"
version = "0.6.10"

[[deps.ImageBase]]
deps = ["ImageCore", "Reexport"]
git-tree-sha1 = "b51bb8cae22c66d0f6357e3bcb6363145ef20835"
uuid = "c817782e-172a-44cc-b673-b171935fbb9e"
version = "0.1.5"

[[deps.ImageContrastAdjustment]]
deps = ["ImageCore", "ImageTransformations", "Parameters"]
git-tree-sha1 = "0d75cafa80cf22026cea21a8e6cf965295003edc"
uuid = "f332f351-ec65-5f6a-b3d1-319c6670881a"
version = "0.3.10"

[[deps.ImageCore]]
deps = ["AbstractFFTs", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Graphics", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "Reexport"]
git-tree-sha1 = "acf614720ef026d38400b3817614c45882d75500"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.9.4"

[[deps.ImageDistances]]
deps = ["Distances", "ImageCore", "ImageMorphology", "LinearAlgebra", "Statistics"]
git-tree-sha1 = "b1798a4a6b9aafb530f8f0c4a7b2eb5501e2f2a3"
uuid = "51556ac3-7006-55f5-8cb3-34580c88182d"
version = "0.2.16"

[[deps.ImageFiltering]]
deps = ["CatIndices", "ComputationalResources", "DataStructures", "FFTViews", "FFTW", "ImageBase", "ImageCore", "LinearAlgebra", "OffsetArrays", "Reexport", "SnoopPrecompile", "SparseArrays", "StaticArrays", "Statistics", "TiledIteration"]
git-tree-sha1 = "c3630289f3591711f5add6ef1347bc20f1bb8d27"
uuid = "6a3955dd-da59-5b1f-98d4-e7296123deb5"
version = "0.7.4"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs"]
git-tree-sha1 = "342f789fd041a55166764c351da1710db97ce0e0"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.6"

[[deps.ImageMagick]]
deps = ["FileIO", "ImageCore", "ImageMagick_jll", "InteractiveUtils"]
git-tree-sha1 = "ca8d917903e7a1126b6583a097c5cb7a0bedeac1"
uuid = "6218d12a-5da1-5696-b52f-db25d2ecc6d1"
version = "1.2.2"

[[deps.ImageMagick_jll]]
deps = ["JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pkg", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "1c0a2295cca535fabaf2029062912591e9b61987"
uuid = "c73af94c-d91f-53ed-93a7-00f77d67a9d7"
version = "6.9.10-12+3"

[[deps.ImageMetadata]]
deps = ["AxisArrays", "ImageAxes", "ImageBase", "ImageCore"]
git-tree-sha1 = "36cbaebed194b292590cba2593da27b34763804a"
uuid = "bc367c6b-8a6b-528e-b4bd-a4b897500b49"
version = "0.9.8"

[[deps.ImageMorphology]]
deps = ["ImageCore", "LinearAlgebra", "Requires", "TiledIteration"]
git-tree-sha1 = "e7c68ab3df4a75511ba33fc5d8d9098007b579a8"
uuid = "787d08f9-d448-5407-9aad-5290dd7ab264"
version = "0.3.2"

[[deps.ImageQualityIndexes]]
deps = ["ImageContrastAdjustment", "ImageCore", "ImageDistances", "ImageFiltering", "LazyModules", "OffsetArrays", "PrecompileTools", "Statistics"]
git-tree-sha1 = "bcc2f0db769e5d42a67f501ec6781401a4389e8f"
uuid = "2996bd0c-7a13-11e9-2da2-2f5ce47296a9"
version = "0.3.5"

[[deps.ImageSegmentation]]
deps = ["Clustering", "DataStructures", "Distances", "Graphs", "ImageCore", "ImageFiltering", "ImageMorphology", "LinearAlgebra", "MetaGraphs", "RegionTrees", "SimpleWeightedGraphs", "StaticArrays", "Statistics"]
git-tree-sha1 = "44664eea5408828c03e5addb84fa4f916132fc26"
uuid = "80713f31-8817-5129-9cf8-209ff8fb23e1"
version = "1.8.1"

[[deps.ImageShow]]
deps = ["Base64", "ColorSchemes", "FileIO", "ImageBase", "ImageCore", "OffsetArrays", "StackViews"]
git-tree-sha1 = "ce28c68c900eed3cdbfa418be66ed053e54d4f56"
uuid = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
version = "0.3.7"

[[deps.ImageTransformations]]
deps = ["AxisAlgorithms", "ColorVectorSpace", "CoordinateTransformations", "ImageBase", "ImageCore", "Interpolations", "OffsetArrays", "Rotations", "StaticArrays"]
git-tree-sha1 = "8717482f4a2108c9358e5c3ca903d3a6113badc9"
uuid = "02fcd773-0e25-5acc-982a-7f6622650795"
version = "0.9.5"

[[deps.Images]]
deps = ["Base64", "FileIO", "Graphics", "ImageAxes", "ImageBase", "ImageContrastAdjustment", "ImageCore", "ImageDistances", "ImageFiltering", "ImageIO", "ImageMagick", "ImageMetadata", "ImageMorphology", "ImageQualityIndexes", "ImageSegmentation", "ImageShow", "ImageTransformations", "IndirectArrays", "IntegralArrays", "Random", "Reexport", "SparseArrays", "StaticArrays", "Statistics", "StatsBase", "TiledIteration"]
git-tree-sha1 = "5fa9f92e1e2918d9d1243b1131abe623cdf98be7"
uuid = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
version = "0.25.3"

[[deps.Imath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3d09a9f60edf77f8a4d99f9e015e8fbf9989605d"
uuid = "905a6f67-0a94-5f89-b386-d35d92009cd1"
version = "3.1.7+0"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.Inflate]]
git-tree-sha1 = "5cd07aab533df5170988219191dfad0519391428"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.3"

[[deps.IntegralArrays]]
deps = ["ColorTypes", "FixedPointNumbers", "IntervalSets"]
git-tree-sha1 = "be8e690c3973443bec584db3346ddc904d4884eb"
uuid = "1d092043-8f09-5a30-832f-7509e371ab51"
version = "0.1.5"

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0cb9352ef2e01574eeebdb102948a58740dcaf83"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2023.1.0+0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Interpolations]]
deps = ["Adapt", "AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "721ec2cf720536ad005cb38f50dbba7b02419a15"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.14.7"

[[deps.IntervalSets]]
deps = ["Dates", "Random", "Statistics"]
git-tree-sha1 = "16c0cc91853084cb5f58a78bd209513900206ce6"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.4"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[deps.JLD2]]
deps = ["FileIO", "MacroTools", "Mmap", "OrderedCollections", "Pkg", "Printf", "Reexport", "Requires", "TranscodingStreams", "UUIDs"]
git-tree-sha1 = "42c17b18ced77ff0be65957a591d34f4ed57c631"
uuid = "033835bb-8acc-5ee8-8aae-3f567f8a3819"
version = "0.4.31"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo]]
deps = ["CEnum", "FileIO", "ImageCore", "JpegTurbo_jll", "TOML"]
git-tree-sha1 = "106b6aa272f294ba47e96bd3acbabdc0407b5c60"
uuid = "b835a17e-a41a-41e7-81f0-2f016b05efe0"
version = "0.1.2"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6f2675ef130a300a112286de91973805fcc5ffbc"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.91+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

[[deps.LazyModules]]
git-tree-sha1 = "a560dd966b386ac9ae60bdd3a3d3a326062d3c3e"
uuid = "8cdb02fc-e678-4876-92c5-9defec4f444e"
version = "0.3.1"

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

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "0a1b7c2863e44523180fdb3146534e265a91870b"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.23"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "Pkg"]
git-tree-sha1 = "2ce8695e1e699b68702c03402672a69f54b8aca9"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2022.2.0+0"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "42324d08725e200c23d4dfb549e0d5d89dede2d2"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.10"

[[deps.MappedArrays]]
git-tree-sha1 = "2dab0221fe2b0f2cb6754eaa743cc266339f527e"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.2"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+0"

[[deps.MetaGraphs]]
deps = ["Graphs", "JLD2", "Random"]
git-tree-sha1 = "1130dbe1d5276cb656f6e1094ce97466ed700e5a"
uuid = "626554b9-1ddb-594c-aa3c-2596fe9399a5"
version = "0.7.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "f66bdc5de519e8f8ae43bdc598782d35a25b1272"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.1.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "7b86a5d4d70a9f5cdf2dacb3cbe6d251d1a61dbe"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.4"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.10.11"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NearestNeighbors]]
deps = ["Distances", "StaticArrays"]
git-tree-sha1 = "2c3726ceb3388917602169bed973dbc97f1b51a8"
uuid = "b8a86587-4115-5ab1-83bc-aa920d37bbce"
version = "0.4.13"

[[deps.Netpbm]]
deps = ["FileIO", "ImageCore", "ImageMetadata"]
git-tree-sha1 = "5ae7ca23e13855b3aba94550f26146c01d259267"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.1.0"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OffsetArrays]]
deps = ["Adapt"]
git-tree-sha1 = "82d7c9e310fe55aa54996e6f7f94674e2a38fcb4"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.12.9"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.21+4"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "327f53360fdb54df7ecd01e96ef1983536d1e633"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.2"

[[deps.OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "a4ca623df1ae99d09bc9868b008262d0c0ac1e4f"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.1.4+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "d321bf2de576bf25ec4d3e4360faca399afca282"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.0"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "f809158b27eba0c18c269cf2a2be6ed751d3e81d"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.3.17"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "0fac6313486baae819364c52b4f483450a9d793f"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.12"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

[[deps.Parsers]]
deps = ["Dates", "SnoopPrecompile"]
git-tree-sha1 = "478ac6c952fddd4399e71d4779797c538d0ff2bf"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.8"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.0"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f6cf8e7944e50901594838951729a1861e668cb8"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.2"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "5bb5129fdd62a2bbbe17c2756932259acf467386"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.50"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "259e206946c293698122f63e2b513a7c99a244e8"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.1.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "d7a7aef8f8f2d537104f170139553b14dfe39fe9"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.7.2"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "18e8f4d1426e965c7b532ddd260599e1510d26ce"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.0"

[[deps.Quaternions]]
deps = ["LinearAlgebra", "Random", "RealDot"]
git-tree-sha1 = "da095158bdc8eaccb7890f9884048555ab771019"
uuid = "94ee1d12-ae83-5a48-8b1c-48b8ff168ae0"
version = "0.7.4"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RangeArrays]]
git-tree-sha1 = "b9039e93773ddcfc828f12aadf7115b4b4d225f5"
uuid = "b3c3ace0-ae52-54e7-9d0b-2c1406fd6b9d"
version = "0.3.2"

[[deps.Ratios]]
deps = ["Requires"]
git-tree-sha1 = "6d7bb727e76147ba18eed998700998e17b8e4911"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.4"
weakdeps = ["FixedPointNumbers"]

    [deps.Ratios.extensions]
    RatiosFixedPointNumbersExt = "FixedPointNumbers"

[[deps.RealDot]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "9f0a1b71baaf7650f4fa8a1d168c7fb6ee41f0c9"
uuid = "c1ae055f-0cd5-4b69-90a6-9a35b1a98df9"
version = "0.1.0"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RegionTrees]]
deps = ["IterTools", "LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "4618ed0da7a251c7f92e869ae1a19c74a7d2a7f9"
uuid = "dee08c22-ab7f-5625-9660-a9af2021b33f"
version = "0.3.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Rotations]]
deps = ["LinearAlgebra", "Quaternions", "Random", "StaticArrays"]
git-tree-sha1 = "54ccb4dbab4b1f69beb255a2c0ca5f65a9c82f08"
uuid = "6038ab10-8711-5258-84ad-4b1120ba62dc"
version = "1.5.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[deps.SimpleWeightedGraphs]]
deps = ["Graphs", "LinearAlgebra", "Markdown", "SparseArrays"]
git-tree-sha1 = "4b33e0e081a825dbfaf314decf58fa47e53d6acb"
uuid = "47aef6b3-ad0c-573a-a1e2-d07658019622"
version = "1.4.0"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "8fb59825be681d451c246a795117f317ecbcaa28"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.2"

[[deps.SnoopPrecompile]]
deps = ["Preferences"]
git-tree-sha1 = "e760a70afdcd461cf01a575947738d359234665c"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "a4ada03f999bd01b3a25dcaa30b2d929fe537e00"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.1.0"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "ef28127915f4229c971eb43f3fc075dd3fe91880"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.2.0"
weakdeps = ["ChainRulesCore"]

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "46e589465204cd0c08b4bd97385e4fa79a0c770c"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.1"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "StaticArraysCore", "Statistics"]
git-tree-sha1 = "8982b3607a212b070a5e46eea83eb62b4744ae12"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.5.25"

[[deps.StaticArraysCore]]
git-tree-sha1 = "6b7ba252635a5eff6a0b0664a41ee140a1c9e72a"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.9.0"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "45a7769a04a3cf80da1c1c7c60caf932e6f4c9f7"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.6.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "75ebe04c5bed70b91614d684259b661c9e6274a4"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.0"

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

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "Mmap", "OffsetArrays", "PkgVersion", "ProgressMeter", "UUIDs"]
git-tree-sha1 = "8621f5c499a8aa4aa970b1ae381aae0ef1576966"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.6.4"

[[deps.TiledIteration]]
deps = ["OffsetArrays"]
git-tree-sha1 = "5683455224ba92ef59db72d10690690f4a8dc297"
uuid = "06e1c1a7-607b-532d-9fad-de7d9aa2abac"
version = "0.3.1"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "9a6ae7ed916312b41236fcef7e0af564ef934769"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.13"

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

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "de67fa59e33ad156a590055375a30b23c40299d3"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "0.5.5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+0"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "49ce682769cd5de6c72dcf1b94ed7790cd08974c"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.5+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.7.0+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "libpng_jll"]
git-tree-sha1 = "d4f63314c8aa1e48cd22aa0c17ed76cd1ae48c3c"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.3+0"

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
# ╟─882774af-ad2a-4729-8f55-724f3f016591
# ╠═ac59b63a-5ad8-49e8-bb68-3b2c0ceb1781
# ╟─4f11812f-5a81-4188-9454-d327b95aa152
# ╟─f9324fdd-8750-44d6-812a-b7750cfe0b4a
# ╟─c8fc9aa7-ec37-4797-aa0a-6e1495e3fba8
# ╟─91be7b4d-437a-49b2-be6f-22a47d3bada3
# ╟─55aeacfd-c258-4ab0-b2f2-0da7ec021d15
# ╟─81868301-fbfa-482e-b50d-62a4e0d69f60
# ╠═45626aa0-e4d8-11ed-37a7-d13338b216e8
# ╠═fcb2860f-c022-44b1-b370-4b10f89951e6
# ╠═8343079e-fba8-450c-a1ee-9cf89bc0dd78
# ╠═557d9041-2766-49e2-98cb-509f6aa7419d
# ╠═5879411a-e937-4003-804a-9f4c8137a07c
# ╠═d468ddb7-37f5-47dc-be62-aa7e5d075ffc
# ╠═15e3fa1d-3139-49cb-8a0c-f279997ed385
# ╠═1f7afb64-0296-4b75-96b7-83a70f53d613
# ╠═edae3275-9f96-4c29-a855-cf064fb2a9b3
# ╠═4f75b046-8a29-4ecf-ab46-971730b408f6
# ╠═cda07515-615c-4c4d-b12d-3c83a8f894d0
# ╠═068213c3-22ab-4c36-98b9-4ebd1572075e
# ╠═07203a2e-a4b3-41ae-97f7-8a06864340ea
# ╠═2f4115cb-4d2e-4cbc-a971-419b0da3042f
# ╟─ab316c33-7eaf-40f8-be7a-03c62baffdcd
# ╟─9a669a79-2449-45a0-8c45-df26f12e9ace
# ╠═c3b7c8a8-90a7-4f59-b310-c34e308bdf83
# ╠═1ea13fce-777e-48eb-a359-e94981c65110
# ╠═c892d967-7964-4e50-a943-ebca0a3afdda
# ╠═0c975c74-2061-40a9-b75f-efa4ca500e2e
# ╠═821dc8e7-2a67-404e-907b-fe4de780ffb2
# ╠═1c3a0a62-6f3a-47ad-82d6-3aba078bf2ff
# ╟─eae8dee2-d12c-443f-b706-9b2208a76859
# ╠═4cb80c58-63bf-41d0-b11a-ea8343656664
# ╠═8431546b-0802-46db-be0b-f0d76260a3f3
# ╠═18b54554-da37-458e-9df7-05579ca76cee
# ╠═95ecbdad-ef68-4db3-978d-f98f68ddb9b8
# ╠═96e326fe-8867-4a06-92d7-1fa08b66b20d
# ╠═301c54f8-5e1d-4007-bda3-b20522a9c39d
# ╠═5fdaf5d5-2dc5-4f83-8d1b-a8fc58524358
# ╠═5fa10a66-8aed-467c-90f3-01f07feb4fa3
# ╠═4d8863c3-0c2f-477a-bdb1-ab6977290ff1
# ╟─d8405b87-5d9d-4e94-9ac7-8ee324d979c8
# ╟─db1a51cc-f05f-406a-97aa-b2a7ffbb788a
# ╠═14209da3-8ad8-48fe-95fc-323965098eed
# ╠═355c97c6-783c-42ab-9351-962376b8bf4a
# ╠═a544d273-b26d-4faf-90e4-868a3ac355f6
# ╠═4d7cc38f-71b6-45e5-8ca6-ca42a72d415d
# ╠═563f594c-8d49-404e-afd3-ff60e95d4a66
# ╠═8b7622ce-70e4-474b-8a06-c7d6e9cb98c2
# ╠═5c395d87-a6e9-4684-8cc6-95bd5eda1ec0
# ╠═03c8fd1d-66dd-4643-b516-7693d7b0b6ed
# ╠═050126c6-2c20-4d6f-8895-6ad8bf4a26c6
# ╠═29183a63-1fdc-4e52-b325-7d213499f4d8
# ╠═51ab37aa-9f9d-4acc-8b60-f434043d223d
# ╠═988fd207-0bb1-4601-aa8e-ebfb5d6beaaf
# ╠═bd3f932f-85bd-455c-a62f-9fb09feb82af
# ╠═f1464b07-865c-4ef8-ae48-889e6c93b2e4
# ╠═43d697d2-8f45-4462-a993-09646fda53d8
# ╠═a7f0a92a-4af7-4ad2-8e21-cbc3fbc62711
# ╠═f0aa1590-526e-4cf3-8e4e-b6d1b0ee0b6a
# ╠═126a7c31-9da5-4f20-8fc6-453582e051ff
# ╟─0f700b6f-bb04-4776-9bac-84bdc66c0c77
# ╠═07dfe8b4-05ff-42f5-bad8-e36defc092fd
# ╠═bd9b7c0b-86e3-4d39-b7ca-cc35c909544d
# ╟─50b19a93-16c0-4610-8b78-8de634678593
# ╠═9d07a369-3782-444a-9ffa-216c371b7846
# ╟─ead86c29-bcf9-4445-9c49-b005c396f939
# ╠═27f4c2e9-7cd9-4223-85ca-1b0f3a4804f6
# ╠═409dfc55-625f-4ded-80c9-6d6a51931376
# ╠═e72bc015-02e8-4ab4-b5f3-0b61f7342ec6
# ╠═b6dd0707-d532-4c01-94ba-5464003f8443
# ╠═dd310ec1-31b9-4e4f-a394-9ea7f46663a1
# ╠═99ff6d08-a9b8-40d0-8380-1aea23422332
# ╠═b10bb293-1501-450f-a2ae-384fc0b3b5f2
# ╠═5d5703fa-1d95-4e9b-82c9-141166d65ca6
# ╠═abd9f506-336b-4109-88e6-4e83a2e9f196
# ╠═f3039f0f-99b8-4f80-a933-5944f3df6b3f
# ╠═c69e3e59-ff2d-4ffc-a907-8e73cb77f5b7
# ╠═d03571e4-91d8-4048-bb5a-7788e20d9736
# ╠═37d4fd05-1273-48aa-b942-7aadb09eceea
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
