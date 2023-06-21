### A Pluto.jl notebook ###
# v0.19.26

#> [frontmatter]
#> Author = "Ajam Jamaludin"
#> title = "UAS PKG 2022"
#> date = "2023-06-22"

using Markdown
using InteractiveUtils

# ╔═╡ 8019fea8-102d-11ee-2602-41125f96071f
using PlutoUI, BenchmarkTools

# ╔═╡ 2ad9348e-a232-46ba-aaef-6914b2d27204
using .Threads

# ╔═╡ 480109e2-59bb-4794-9869-8752d1072d68
md"""
# UAS PKG 2022
"""

# ╔═╡ 57e80c11-c9b1-41bc-8d5c-6b70488a68f6
TableOfContents()

# ╔═╡ 66a08004-48e0-48ec-bdbf-5c25da0a415d
md"""
## Satu
!!! soal
	
	Pilih 6 fungsi standar yang terdapat di bahasa pemrograman fortran dan 6 fungsi standar yang terdapat di bahasa pemrograman julia. jelaskan masing-masing kegunaannya dan berikan contoh penggunaannya
"""

# ╔═╡ 2438dbc6-c885-482f-8b27-1683f745b965
md"""
### Fungsi standar Julia
1. Fungsi`sqrt` untuk mendapatkan nilai akar dua dari input. Contoh:
"""

# ╔═╡ a2ad03f4-d150-4f7d-b64d-e4006c672baa
sqrt(100)

# ╔═╡ 6d1239ce-bde2-4db8-ab73-52ac5c7575a0
md"""
2. Fungsi `sum` untuk mendapatkan jumlah nilai dari input. Contoh:
"""

# ╔═╡ 8b4398ae-cade-45ea-9651-070e2973ef6a
sum([10, 20])

# ╔═╡ 5cbc2a21-7e0b-488b-8140-446a3011d482
md"""
3. Fungsi `length` untuk mengetahui panjang atau jumlah elemen dari sebuah collection. Contoh:
"""

# ╔═╡ 29967cf1-a39f-4d55-9017-d62bb1d9998e
length([23, 12, 1])

# ╔═╡ 2d951a37-0038-4987-af21-eb50b6ff17d9
md"""
4. Fungsi `typeof` untuk mengetahui tipe data dari sebuah variabel. Contoh:
"""

# ╔═╡ 085b0d21-dfee-4875-beec-70556ab36136
typeof("kata")

# ╔═╡ c9a1b3b8-a272-4469-981c-cf0114d5c89e
md"""
5. Fungsi `size` untuk mengetahui ukuran dimensi dari vektor atau matriks. Contoh:
"""

# ╔═╡ a26ad96f-77e5-4821-8639-ffeadcabefaa
size([2 3 3 2])

# ╔═╡ cbaa8437-bdef-47a6-b018-1cbc90bf9a16
size([1, 2, 4])

# ╔═╡ 038cea98-2bc1-4de6-8617-6614bfe9f385
md"""
6. Fungsi `abs` untuk mendapatkan nilai absolute atau nilai mutlak dari input. Contoh:
"""

# ╔═╡ 7f80e1fc-150a-4f6a-b18f-6d59a4dfc612
abs(-2)

# ╔═╡ f05eed58-40e3-4a9e-94e7-13fc331cece2
md"""
### Fungsi standar FORTRAN"""

# ╔═╡ eeb2856a-d568-4537-990c-b1f60d89513d
md"""Berikut adalah 6 + bonus 4 contoh fungsi standar dalam Fortran beserta penjelasan dan contoh penggunaannya:

1. **ABS**: Fungsi ini mengembalikan nilai absolut dari suatu bilangan.

   Contoh penggunaan:
   ```fortran
   real :: x = -3.5
   x = ABS(x)  ! x sekarang bernilai 3.5
   ```

2. **SIN**: Fungsi ini mengembalikan sinus dari suatu sudut dalam radian.

   Contoh penggunaan:
   ```fortran
   real :: angle = 0.5
   real :: result = SIN(angle)  ! result berisi nilai sinus dari sudut 0.5 radian
   ```

3. **COS**: Fungsi ini mengembalikan kosinus dari suatu sudut dalam radian.

   Contoh penggunaan:
   ```fortran
   real :: angle = 1.0
   real :: result = COS(angle)  ! result berisi nilai kosinus dari sudut 1.0 radian
   ```

4. **SQRT**: Fungsi ini mengembalikan akar kuadrat dari suatu bilangan.

   Contoh penggunaan:
   ```fortran
   real :: x = 16.0
   real :: result = SQRT(x)  ! result berisi nilai akar kuadrat dari 16.0, yaitu 4.0
   ```

5. **EXP**: Fungsi ini mengembalikan nilai eksponensial (e^x) dari suatu bilangan.

   Contoh penggunaan:
   ```fortran
   real :: x = 2.0
   real :: result = EXP(x)  ! result berisi nilai eksponensial dari 2.0, yaitu 7.389056
   ```

6. **LOG**: Fungsi ini mengembalikan logaritma natural (basis e) dari suatu bilangan.

   Contoh penggunaan:
   ```fortran
   real :: x = 10.0
   real :: result = LOG(x)  ! result berisi logaritma natural dari 10.0, yaitu 2.302585
   ```

7. **MAX**: Fungsi ini mengembalikan nilai maksimum dari dua bilangan.

   Contoh penggunaan:
   ```fortran
   real :: a = 5.0
   real :: b = 7.0
   real :: result = MAX(a, b)  ! result berisi nilai maksimum dari a dan b, yaitu 7.0
   ```

8. **MIN**: Fungsi ini mengembalikan nilai minimum dari dua bilangan.

   Contoh penggunaan:
   ```fortran
   real :: a = 3.0
   real :: b = 2.0
   real :: result = MIN(a, b)  ! result berisi nilai minimum dari a dan b, yaitu 2.0
   ```

9. **MOD**: Fungsi ini mengembalikan sisa pembagian dari dua bilangan.

   Contoh penggunaan:
   ```fortran
   integer :: a = 17
   integer :: b = 5
   integer :: result = MOD(a, b)  ! result berisi sisa pembagian 17 dengan 5, yaitu 2
   ```

10. **LEN**: Fungsi ini mengembalikan panjang string.

    Contoh penggunaan:
```fortran
character(len=10) :: str = 'Hello'
integer :: length = LEN(str)  ! length berisi panjang string str, yaitu 5
```


Fungsi-fungsi standar ini dapat digunakan dalam program Fortran untuk melakukan operasi matematika, manipulasi string, dan pemrosesan data secara umum."""

# ╔═╡ 35a8f79f-862f-4a0a-8c09-0692b0d75997
md"""
## Dua
!!! soal
	Tuliskan 3 contoh fungsi sederhana dengan julia yang memanfaatkan fitur multiple dispatch yang memenuhi kriteria:
	1. Memiliki input dua integer atau float dan hasilnya adalah bilangan pertama pangkat bilangan kedua
	2. Memiliki input dua string dan hasilnya adalah gabungan kedua string tersebut dan jumlah karakter pada string yang digabungkan
	3. Memiliki input dua matriks dan hasilnya perkalian matriks yang dihitung menggunakan bahasa pemrograman C/fortran/C++.
"""

# ╔═╡ b0a0065c-c285-413b-b63f-660a07ea9b67
function soal2(x::Union{Int, Float64}, y::Union{Int, Float64})
	return x^y
end

# ╔═╡ 233f0859-c1df-4560-9cda-7d8aa4d3ca26
function soal2(x::String, y::String)
	gabungan = string(x,y)
	panjang = length(gabungan)
	return gabungan, panjang
end

# ╔═╡ f6e65059-263b-4a44-8290-6e9b6b95a6fb
function soal2(x::Matrix, y::Matrix)
	return nothing
end
# gak ngerti :')

# ╔═╡ 3ab64cfc-fee0-48ea-82cf-1e19f910e187
soal2(2, 3)

# ╔═╡ 88071582-a35b-4b65-ad26-e16af55cc790
soal2("foot", "ball")

# ╔═╡ d0d49447-982f-48a2-8226-5b2f507ece3c
md"""
## Tiga
!!! soal
	1. Optimasi kode di bawah! sertakan penjelasannya!
	2. Estimasikan perkiraan peningkatan kecepatan setelah dilakukan optimasi beserta alasan penjelasannya
"""

# ╔═╡ d96ca305-6623-451c-8603-653bf7029815
md""" ### Kode soal"""

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

# ╔═╡ 67b3f43c-e8e6-4830-9761-92775159744e
@btime y

# ╔═╡ a8179635-72a8-4dd1-a726-0aa97ebc6dc5
md""" ### Kode optimasi"""

# ╔═╡ 1ca519f5-046e-4fb8-8ff0-85243be52b4b
function sls_gelombang_op(T, L, gelombang::Gelombang; n_t=100, n_x=100)
    ts = range(0, T; length=n_t)
    xs = range(0, L; length=n_x)
    dt = ts[2] - ts[1]
    dx = xs[2] - xs[1]
    y = zeros(n_t, n_x)

    # kondisi batas
    @inbounds y[:,1] .= gelombang.f(0)
    @inbounds y[:,end] .= gelombang.f(L)

    # kondisi awal
    @inbounds y[1,2:end-1] = gelombang.f.(xs[2:end-1])
    @inbounds y[2,2:end-1] = y[1,2:end-1] + dt*gelombang.g.(xs[2:end-1])

    # solusi untuk t = 2*dt, 3*dt, ..., T
    for t in 2:n_t-1
		@simd for x in 2:n_x-1
        	@inbounds dy_xx = (y[t, x+1] - 2*y[t, x] + y[t, x-1])/dx^2
        	@inbounds y[t+1, x] = c^2 * dt^2 * dy_xx + 2*y[t, x] - y[t-1, x]
		end
    end

    return y
end


# ╔═╡ e6fa189e-a1de-495f-ac9e-ba9ef3acf4da
y_op = sls_gelombang_op(T, L, gelombang; n_t=2401, n_x=101)

# ╔═╡ e5600169-b3bf-4e70-bce0-6992b3bc7447
@btime y_op

# ╔═╡ b1877f2e-2a59-4f1f-a95f-bc30797f9a89
y_op ≈ y # If true, there is no race condition

# ╔═╡ 81c7a95c-3ddf-4356-b5ee-c7b1a0406942
md"""
Aku masih gak ngerti, kenapa walaupun udah dioptimasi pake `@inbound` dan `@simd`, tapi waktunya masih gak beda jauh, bahkan terkadang malah lebih lambat.

Aku udah coba pake `@threads`, tapi hasilnya beda. Sepertinya ada race condition.
"""

# ╔═╡ c745236d-edc6-4f6c-80a7-2230f83430ed
md"""
Kita coba lagi multithreading"""

# ╔═╡ 7c11766d-7e82-4fd8-ac13-ccf214b24a05
function sls_gelombang_mt(T, L, gelombang::Gelombang; n_t=100, n_x=100)
    ts = range(0, T; length=n_t)
    xs = range(0, L; length=n_x)
    dt = ts[2] - ts[1]
    dx = xs[2] - xs[1]
    y = zeros(n_t, n_x)

    # kondisi batas
    @inbounds y[:,1] .= gelombang.f(0)
    @inbounds y[:,end] .= gelombang.f(L)

    # kondisi awal
    @inbounds y[1,2:end-1] = gelombang.f.(xs[2:end-1])
	@inbounds y[2,2:end-1] = y[1,2:end-1] + dt*gelombang.g.(xs[2:end-1])

    # solusi untuk t = 2*dt, 3*dt, ..., T
    @threads for t in 2:n_t-1
        partial = zeros(n_x)
        @simd for x in 2:n_x-1
            @inbounds dy_xx = (y[t, x+1] - 2*y[t, x] + y[t, x-1])/dx^2
            @inbounds partial[x] = c^2 * dt^2 * dy_xx + 2*y[t, x] - y[t-1, x]
        end
        @inbounds y[t+1, 2:n_x-1] .= partial[2:n_x-1]
    end

    return y
end


# ╔═╡ 9fc02121-f151-4e1e-afad-4e4fd27f8cf6
y_mt = sls_gelombang_mt(T, L, gelombang; n_t=2401, n_x=101)

# ╔═╡ 34409a9f-2c31-4905-9cbe-fc08f23b5fc5
@btime y_mt

# ╔═╡ 63e5233d-51b5-4142-848b-8e104074b270
y_mt ≈ y 

# ╔═╡ 46c7ed5a-a7c5-4fd2-8136-c8f98783f0cb
md"""Jika hasil kode di atas `false`, berarti memang race condition."""

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
# ╟─480109e2-59bb-4794-9869-8752d1072d68
# ╠═8019fea8-102d-11ee-2602-41125f96071f
# ╠═57e80c11-c9b1-41bc-8d5c-6b70488a68f6
# ╟─66a08004-48e0-48ec-bdbf-5c25da0a415d
# ╟─2438dbc6-c885-482f-8b27-1683f745b965
# ╠═a2ad03f4-d150-4f7d-b64d-e4006c672baa
# ╟─6d1239ce-bde2-4db8-ab73-52ac5c7575a0
# ╠═8b4398ae-cade-45ea-9651-070e2973ef6a
# ╟─5cbc2a21-7e0b-488b-8140-446a3011d482
# ╠═29967cf1-a39f-4d55-9017-d62bb1d9998e
# ╟─2d951a37-0038-4987-af21-eb50b6ff17d9
# ╠═085b0d21-dfee-4875-beec-70556ab36136
# ╟─c9a1b3b8-a272-4469-981c-cf0114d5c89e
# ╠═a26ad96f-77e5-4821-8639-ffeadcabefaa
# ╠═cbaa8437-bdef-47a6-b018-1cbc90bf9a16
# ╟─038cea98-2bc1-4de6-8617-6614bfe9f385
# ╠═7f80e1fc-150a-4f6a-b18f-6d59a4dfc612
# ╟─f05eed58-40e3-4a9e-94e7-13fc331cece2
# ╟─eeb2856a-d568-4537-990c-b1f60d89513d
# ╟─35a8f79f-862f-4a0a-8c09-0692b0d75997
# ╠═b0a0065c-c285-413b-b63f-660a07ea9b67
# ╠═233f0859-c1df-4560-9cda-7d8aa4d3ca26
# ╠═f6e65059-263b-4a44-8290-6e9b6b95a6fb
# ╠═3ab64cfc-fee0-48ea-82cf-1e19f910e187
# ╠═88071582-a35b-4b65-ad26-e16af55cc790
# ╟─d0d49447-982f-48a2-8226-5b2f507ece3c
# ╟─d96ca305-6623-451c-8603-653bf7029815
# ╠═9d61bdbe-1ac5-423b-a7d0-42b1e3f52c14
# ╠═14952c02-564d-4cc6-a588-c81489fcc625
# ╠═d885aba3-4395-4fd6-9ab0-55a3b02c76f9
# ╠═35e21eab-6578-4dec-bfec-865ce6dee369
# ╠═e4f22d84-9dd7-47be-809a-2bb87be50e45
# ╠═59e250c2-d5a7-49d8-8949-57588248acb3
# ╠═787137c3-edbb-40c4-8fdd-53737b33ea93
# ╠═e8b17246-3c56-472b-8b98-03ee21c7cf18
# ╠═69307fe4-1789-457a-a190-77eec287b86c
# ╠═67b3f43c-e8e6-4830-9761-92775159744e
# ╟─a8179635-72a8-4dd1-a726-0aa97ebc6dc5
# ╠═1ca519f5-046e-4fb8-8ff0-85243be52b4b
# ╠═e6fa189e-a1de-495f-ac9e-ba9ef3acf4da
# ╠═e5600169-b3bf-4e70-bce0-6992b3bc7447
# ╠═b1877f2e-2a59-4f1f-a95f-bc30797f9a89
# ╟─81c7a95c-3ddf-4356-b5ee-c7b1a0406942
# ╟─c745236d-edc6-4f6c-80a7-2230f83430ed
# ╠═2ad9348e-a232-46ba-aaef-6914b2d27204
# ╠═7c11766d-7e82-4fd8-ac13-ccf214b24a05
# ╠═9fc02121-f151-4e1e-afad-4e4fd27f8cf6
# ╠═34409a9f-2c31-4905-9cbe-fc08f23b5fc5
# ╠═63e5233d-51b5-4142-848b-8e104074b270
# ╟─46c7ed5a-a7c5-4fd2-8136-c8f98783f0cb
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
