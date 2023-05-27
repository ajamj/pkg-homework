### A Pluto.jl notebook ###
# v0.19.25

#> [frontmatter]
#> title = "Post-mid Assignment 01"
#> date = "2023-04-28"
#> description = "Post-mid Assignment 01 Pemrograma Komputer Geofisika"

using Markdown
using InteractiveUtils

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
$(LocalResource("terminal_ss.png"))\
"""

# ╔═╡ c8fc9aa7-ec37-4797-aa0a-6e1495e3fba8
md"""
Adapun untuk dalam penulisan kode serta markdown, digunakan bantuan dari paket [Pluto.jl](https://plutojl.org/). Instalasi Pluto.jl dilakukan dengan cara menjalankan perintah berikut pada terminal Julia:\

> import Pkg; Pkg.add("Pluto")

Lalu memasukkan perintah:\

> import Pluto; Pluto.run()

Setelah itu, secara otomatis komputer akan membuka aplikasi peramban dan membuka jendela Pluto.jl.\
\
$(LocalResource("pluto_ss.png", :width => 500))
"""

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
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.50"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.0-rc3"
manifest_format = "2.0"
project_hash = "d8b0bbb312600ec81f2769bd72048a77429debd9"

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
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

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
deps = ["Dates", "SnoopPrecompile"]
git-tree-sha1 = "478ac6c952fddd4399e71d4779797c538d0ff2bf"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.8"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "5bb5129fdd62a2bbbe17c2756932259acf467386"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.50"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

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
# ╟─882774af-ad2a-4729-8f55-724f3f016591
# ╟─4f11812f-5a81-4188-9454-d327b95aa152
# ╟─c8fc9aa7-ec37-4797-aa0a-6e1495e3fba8
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
