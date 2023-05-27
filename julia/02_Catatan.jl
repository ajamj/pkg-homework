### A Pluto.jl notebook ###
# v0.19.25

using Markdown
using InteractiveUtils

# ╔═╡ 17991cb0-ea35-11ed-1488-ed95c3e2ca5d
md"Catatan PKG Week 2 Post UTS"

# ╔═╡ fc1c8f51-fdc3-4c02-bfd1-a71e801523e0
md"array"

# ╔═╡ 13626996-7cfc-4964-89f7-9aca13e6bbd4
B = [1,2,3] # Vector pake koma

# ╔═╡ 51fb8bf9-425d-4cc5-a4e6-bea916a61d4f
# ╠═╡ disabled = true
#=╠═╡
C = Array{Int64}(undef, 2, 3) # Membuat array tipe data int64
  ╠═╡ =#

# ╔═╡ c49c0257-a011-42ff-8546-2c9f28a84577
#=╠═╡
sizeof(C)
  ╠═╡ =#

# ╔═╡ 5f670186-3c6b-418a-a142-6c6cf9719165
D = trues(2,4)

# ╔═╡ f1b3998c-b506-45ff-b455-bc893fd4afa0
E = ones(2,4)

# ╔═╡ 4acaab27-7a5a-42c4-be15-14ded1f17df0
sizeof(D)

# ╔═╡ 06bacd77-5d7b-458e-8dab-8ad0056b5479
sizeof(E)

# ╔═╡ 87dad6a4-2ba4-43c0-a6c1-68c5cca36ca1
md"""
Membuat matriks dengan fungsi trues lebih hemat memori daripada dengan ones
"""

# ╔═╡ 3a8a783a-45de-4444-96f9-69c7e42499f5
md"""
Di Julia, `copy` dan `deepcopy` adalah fungsi untuk menyalin nilai dari suatu objek ke objek baru. Perbedaan utama antara keduanya adalah dalam cara mereka menangani objek yang terdiri dari objek lain.

- `copy` digunakan untuk menyalin objek ke objek baru. Ketika digunakan pada objek yang terdiri dari objek lain, hanya objek terluar yang akan disalin, sementara objek yang diperoleh dengan cara menyusun objek tersebut secara bertingkat akan tetap merujuk pada objek yang sama seperti yang ada pada objek asli. Dalam hal ini, jika nilai di salah satu objek itu diubah, nilai di objek lain yang dirujuk oleh objek itu juga akan berubah.

Contoh penggunaan `copy`:

```julia
a = [1, 2, [3, 4]]
b = copy(a)
b[1] = 5
println(a) # Output: [1, 2, [3, 4]]
println(b) # Output: [5, 2, [3, 4]]
```

Pada contoh di atas, meskipun `a` memiliki array yang lebih dalam, `copy` hanya menyalin nilai dari `a` ke `b`, sehingga ketika nilai pertama diubah di `b`, nilai pertama di `a` tidak berubah.

- `deepcopy` digunakan untuk menyalin objek ke objek baru dan menyalin semua objek di dalam objek tersebut secara rekursif. Dalam hal ini, objek baru yang diperoleh dengan `deepcopy` akan terdiri dari objek-objek baru yang sepenuhnya independen dari objek asli. Jadi, jika nilai di salah satu objek diubah, nilai di objek lain yang dihasilkan dengan `deepcopy` tidak akan berubah.

Contoh penggunaan `deepcopy`:

```julia
a = [1, 2, [3, 4]]
b = deepcopy(a)
b[1] = 5
println(a) # Output: [1, 2, [3, 4]]
println(b) # Output: [5, 2, [3, 4]]
b[3][1] = 6
println(a) # Output: [1, 2, [3, 4]]
println(b) # Output: [5, 2, [6, 4]]
```

Pada contoh di atas, karena `b` dibuat dengan `deepcopy`, ketika nilai dalam array yang lebih dalam diubah di `b`, nilai di `a` tidak berubah.

Dalam ringkasan, penggunaan `copy` dan `deepcopy` dalam Julia tergantung pada kebutuhan Anda dalam menyalin objek. Jika objeknya sederhana, `copy` mungkin sudah cukup. Namun, jika objeknya kompleks atau jika Anda ingin menghindari ketergantungan antara objek asli dan objek baru, maka `deepcopy` mungkin lebih sesuai untuk digunakan.
"""

# ╔═╡ e4904470-2cfa-4044-ae1f-23158fcfce79
typeof(A)

# ╔═╡ 5ae096b5-28fb-4c39-82ff-8ad05c7146fa
eltype(A)

# ╔═╡ c0f8fe2b-6dcb-4c6f-8d19-367c2f6059bc
length(A)

# ╔═╡ 72ef5a50-ebff-49ba-b8a0-e1e9fc147ec4
ndims(A)

# ╔═╡ ee3b5e78-abbb-4514-bf2f-a66ead8e1ae9
size(A)

# ╔═╡ c7f6348e-8c11-43f0-8bc4-a0c58d1cdec0
size(A,1)

# ╔═╡ 67f29e4f-3c7d-4013-935b-9b419a506b38
axes(A)

# ╔═╡ a6cbbd7f-cb0d-412e-b861-5a8fde27a99b
axes(A,1) # Inklusif

# ╔═╡ cb9308e3-d9d9-409b-9ca9-91a18e84ff05
strides(A) # Jarak penyimpanan array pada RAM

# ╔═╡ 7a66b2e6-cb29-404f-ae27-08dc0733c3fb
sizeof(A)

# ╔═╡ 367d0097-4b5a-4279-ba56-a040be538861
F = copy(A)

# ╔═╡ 73ef7905-6481-4750-a043-8b1aa7d20a03
G = deepcopy(A)

# ╔═╡ 64f64cf3-4991-4d40-a863-b2413f4396f7
Sim = similar(A)

# ╔═╡ 7df88527-7cee-45c2-86ef-bb6aed012cc2
eltype(A)

# ╔═╡ 918f63a7-e792-4883-95bb-15edc7dc3e66
reinterpret(Float16, B) #Melihat dalam bentuk biner saja

# ╔═╡ 35a5df1f-2cc3-43e3-9470-f00826126305
rand(Float16,3,4)

# ╔═╡ e8abb4dd-5b6b-418d-b391-167224dafae4
randn(Float16,3,4)

# ╔═╡ 35d21317-dc2b-4c1f-8be8-17e9c75e1f50
range(5,10,100) # Dimulai dari 5.0, berakhir di 10, 100 data

# ╔═╡ 91576efd-d137-4133-8b6c-254ce5e67905
fill!(B,4) # Tanda seru artinya update value pada variabel yang sudah didefinisikan

# ╔═╡ 5c2b033f-0f63-4b33-81bf-71f7978713ca
p1 = 4//5 # Pecahan 4/5

# ╔═╡ fc7bc54e-d972-4f57-b837-78adff02090b
typeof(p1)

# ╔═╡ 84e11547-fe97-4445-a8e1-49f0796913ce
p2 = 1//5

# ╔═╡ adfdfb90-2240-4972-bcd4-40fa4613e98b
p3 = p1+p2

# ╔═╡ a540fcbb-8035-434b-8149-0516180cf713
p1 + 0.3 # 0.8+0.3=1.1

# ╔═╡ 72bc11d1-a55f-4b25-986e-15deb5c01f9a
promote()

# ╔═╡ b34b2e49-332f-4638-a6a7-c3fda292b90c
md"""
ARRAY COMPREHENSION
Array comprehension adalah teknik konstruksi array yang sangat berguna dalam Julia. Array comprehension memungkinkan kita membuat array baru dengan melakukan operasi atau pengujian pada setiap elemen dalam suatu koleksi.

Sintaksis dari array comprehension di Julia adalah sebagai berikut:

```
[expression for var in collection if condition]
```

`expression` adalah ekspresi yang menghasilkan nilai untuk setiap elemen dalam koleksi. `var` adalah variabel yang mewakili setiap elemen dalam koleksi. `collection` adalah koleksi yang ingin kita gunakan, seperti array atau range. `condition` adalah kondisi opsional yang memfilter elemen yang termasuk dalam array.

Contohnya, jika kita ingin membuat array berisi bilangan kuadrat dari 1 hingga 10, kita dapat menggunakan array comprehension sebagai berikut:

```julia
squares = [x^2 for x in 1:10]
```

Di sini, `x^2` adalah ekspresi yang menghasilkan nilai kuadrat dari setiap elemen dalam rentang 1 hingga 10. Variabel `x` mewakili setiap elemen dalam rentang, dan rentang itu sendiri adalah `collection`.

Kita juga dapat menambahkan kondisi untuk memfilter elemen yang termasuk dalam array, contohnya:

```julia
evensquares = [x^2 for x in 1:10 if x % 2 == 0]
```

Di sini, kita menambahkan kondisi `if x % 2 == 0` untuk memastikan bahwa hanya bilangan genap yang termasuk dalam array.

Array comprehension juga dapat digunakan untuk membangun array multi-dimensi. Contohnya, untuk membuat matriks 3x3 dengan bilangan acak antara 0 dan 1, kita dapat menggunakan array comprehension sebagai berikut:

```julia
randmat = [rand() for i in 1:3, j in 1:3]
```

Di sini, kita menggunakan dua variabel `i` dan `j` untuk menunjukkan posisi setiap elemen dalam matriks. Kita dapat memanggil matriks dengan menggunakan indeks seperti biasa.

Ringkasan, array comprehension adalah teknik yang berguna untuk membangun array baru dengan melakukan operasi atau pengujian pada setiap elemen dalam suatu koleksi. Sintaksisnya mirip dengan for loop dan if statement. Array comprehension dapat digunakan untuk membangun array multi-dimensi juga."""

# ╔═╡ 6dbe580c-03b6-43d1-b10b-72029d06377e
md""""
Cartesian indexing dan linear indexing adalah dua cara yang berbeda untuk mengindeks elemen dalam array di Julia.

1. Cartesian Indexing

Cartesian indexing menggunakan pasangan koordinat atau indeks multi-dimensi untuk mengakses elemen dalam array. Dalam sistem koordinat kartesian, kita menggunakan koordinat x dan y untuk menunjukkan posisi setiap titik dalam ruang dua dimensi. Dalam Julia, kita dapat menggunakan objek `CartesianIndex` untuk merepresentasikan indeks multi-dimensi. Indeks multi-dimensi ini dapat digunakan untuk mengakses elemen dalam array.

Contoh penggunaan cartesian indexing:

```julia
A = [1 2 3; 4 5 6; 7 8 9]
idx = CartesianIndex(2, 3)
println(A[idx]) # Output: 6
```

Pada contoh di atas, kita menggunakan `CartesianIndex(2, 3)` untuk mengakses elemen pada baris ke-2 dan kolom ke-3 dari array `A`.

2. Linear Indexing

Linear indexing mengindeks elemen dalam array dengan satu indeks tunggal, yang menghitung jumlah elemen dalam array mulai dari elemen pertama hingga elemen yang ingin diakses. Secara default, indeks linier dihitung dengan mengikuti urutan elemen dalam kolom pertama, diikuti oleh kolom kedua, dan seterusnya hingga kolom terakhir. Indeks linier juga dapat dihitung dengan menggunakan fungsi `linearindices`.

Contoh penggunaan linear indexing:

```julia
A = [1 2 3; 4 5 6; 7 8 9]
idx = 6
println(A[idx]) # Output: 6
```

Pada contoh di atas, kita menggunakan indeks linier 6 untuk mengakses elemen pada baris ke-2 dan kolom ke-3 dari array `A`.

Perbedaan utama antara cartesian indexing dan linear indexing adalah cara indeks didefinisikan dan digunakan. Cartesian indexing menggunakan koordinat multi-dimensi untuk mengakses elemen, sedangkan linear indexing mengindeks elemen dengan satu indeks tunggal. Kedua metode indeksasi ini dapat digunakan tergantung pada kebutuhan spesifik dalam manipulasi array.
"""

# ╔═╡ eb0fda74-8dc8-4c75-8e83-3ef4ba557788
md"""BROADCAST()
`broadcast()` adalah fungsi yang memungkinkan kita untuk menerapkan suatu fungsi atau operasi pada semua elemen dalam array, tanpa menggunakan loop atau ekspresi yang panjang. Fungsi ini sangat berguna untuk melakukan operasi pada array secara efisien.

Fungsi `broadcast()` bekerja dengan cara mengambil suatu fungsi atau operasi, kemudian menerapkannya pada semua elemen dalam array. Dalam Julia, kita dapat menggunakan tanda `.` untuk menandakan bahwa suatu operasi atau fungsi harus diterapkan pada semua elemen dalam array menggunakan `broadcast()`.

Contoh penggunaan `broadcast()`:

```julia
A = [1 2 3; 4 5 6; 7 8 9]
B = [10, 20, 30]

C = broadcast(+, A, B)
```

Pada contoh di atas, kita menggunakan fungsi `broadcast()` untuk menambahkan array `A` dengan array `B` pada setiap elemennya. Kita menggunakan operator `+` sebagai argumen pertama untuk `broadcast()`. Kemudian, kita memasukkan array `A` dan `B` sebagai argumen kedua dan ketiga, masing-masing. Hasilnya, fungsi `broadcast()` akan menerapkan operasi penjumlahan pada setiap elemen array dan menghasilkan array baru `C` yang berisi hasilnya.

Kita juga dapat menulis ekspresi yang lebih singkat dan mudah dibaca dengan menggunakan notasi titik, seperti ini:

```julia
C = A .+ B
```

Dalam contoh ini, operasi penjumlahan `.+` akan secara otomatis dijalankan pada setiap elemen array.

`broadcast()` juga mendukung penggunaan fungsi, seperti `sin()` atau `exp()`, dan operasi, seperti `*` dan `^`. Dengan menggunakan `broadcast()`, kita dapat memproses array dengan ukuran yang besar dengan lebih cepat dan lebih mudah.
"""

# ╔═╡ 8a614a7c-523b-4beb-9984-578e09038df8
😁=3

# ╔═╡ 6106f1d7-0add-4df8-8681-c94096574c0d
println(😁)

# ╔═╡ 262d01fd-9a25-4a86-8a69-027a870231d6
md"""
Lebih baik gunakan "using"
"""

# ╔═╡ 99281914-16c8-42a2-84a9-49a94059da22
md"""
`using` dan `import` adalah dua kata kunci pada Julia yang digunakan untuk memuat modul dan definisi nama dari modul tertentu ke dalam lingkup kerja saat ini. Meskipun keduanya memiliki tujuan yang sama, namun ada beberapa perbedaan penting antara keduanya.

1. Penggunaan

Kata kunci `using` digunakan untuk memuat seluruh modul, sehingga seluruh definisi yang ada di dalamnya akan terlihat di lingkup kerja saat ini, dan dapat digunakan tanpa harus menambahkan prefix atau nama modul. Sementara itu, kata kunci `import` digunakan untuk memuat hanya definisi yang spesifik dari modul tertentu. Dalam hal ini, penggunaan prefix atau nama modul diperlukan untuk mengakses definisi.

2. Efisiensi

Dalam hal efisiensi, penggunaan `using` akan memakan lebih banyak waktu dan sumber daya daripada `import`. Hal ini karena seluruh modul akan dimuat ke dalam lingkup kerja saat ini, termasuk definisi yang mungkin tidak diperlukan. Sementara itu, penggunaan `import` hanya memuat definisi yang spesifik yang diperlukan, sehingga lebih efisien dan hemat sumber daya.

3. Kesalahan dan konflik nama

Penggunaan `using` dapat menyebabkan kesalahan jika ada nama yang sama antara definisi di dalam modul yang dimuat dan definisi di lingkup kerja saat ini. Ini dapat menyebabkan konflik nama dan kesulitan dalam debugging. Di sisi lain, penggunaan `import` lebih aman karena hanya mendefinisikan nama tertentu, sehingga mengurangi kemungkinan konflik nama.

4. Skop

Kata kunci `using` memperluas skop fungsi dan variabel yang ada di modul yang dimuat ke dalam skop global saat ini, sehingga dapat digunakan di seluruh program. Sementara itu, kata kunci `import` hanya memperluas skop fungsi dan variabel tertentu yang didefinisikan dalam modul ke dalam skop global, sehingga lebih terfokus dan tidak memperluas skop secara acak.

Secara umum, penggunaan `using` lebih sederhana dan nyaman untuk digunakan, namun kurang efisien dan rentan terhadap konflik nama. Di sisi lain, penggunaan `import` lebih terfokus, lebih efisien, dan lebih aman, namun memerlukan lebih banyak penulisan dan prefix dalam kode. Pilihan antara `using` dan `import` tergantung pada kebutuhan dan preferensi pengguna.
"""

# ╔═╡ 2525bc49-0011-4299-b4f5-9103c4cda958
# ╠═╡ disabled = true
#=╠═╡
A = [1 2 3; 4 5 6]
  ╠═╡ =#

# ╔═╡ d309623c-abe4-49b4-bd3a-c07e7f9d9384
A = [[1,2,3],[4,5,6]]

# ╔═╡ Cell order:
# ╟─17991cb0-ea35-11ed-1488-ed95c3e2ca5d
# ╟─fc1c8f51-fdc3-4c02-bfd1-a71e801523e0
# ╠═2525bc49-0011-4299-b4f5-9103c4cda958
# ╠═13626996-7cfc-4964-89f7-9aca13e6bbd4
# ╠═e4904470-2cfa-4044-ae1f-23158fcfce79
# ╠═5ae096b5-28fb-4c39-82ff-8ad05c7146fa
# ╠═c0f8fe2b-6dcb-4c6f-8d19-367c2f6059bc
# ╠═72ef5a50-ebff-49ba-b8a0-e1e9fc147ec4
# ╠═ee3b5e78-abbb-4514-bf2f-a66ead8e1ae9
# ╠═c7f6348e-8c11-43f0-8bc4-a0c58d1cdec0
# ╠═67f29e4f-3c7d-4013-935b-9b419a506b38
# ╠═a6cbbd7f-cb0d-412e-b861-5a8fde27a99b
# ╠═cb9308e3-d9d9-409b-9ca9-91a18e84ff05
# ╠═51fb8bf9-425d-4cc5-a4e6-bea916a61d4f
# ╠═7a66b2e6-cb29-404f-ae27-08dc0733c3fb
# ╠═c49c0257-a011-42ff-8546-2c9f28a84577
# ╠═5f670186-3c6b-418a-a142-6c6cf9719165
# ╠═f1b3998c-b506-45ff-b455-bc893fd4afa0
# ╠═4acaab27-7a5a-42c4-be15-14ded1f17df0
# ╠═06bacd77-5d7b-458e-8dab-8ad0056b5479
# ╟─87dad6a4-2ba4-43c0-a6c1-68c5cca36ca1
# ╟─3a8a783a-45de-4444-96f9-69c7e42499f5
# ╠═d309623c-abe4-49b4-bd3a-c07e7f9d9384
# ╠═367d0097-4b5a-4279-ba56-a040be538861
# ╠═73ef7905-6481-4750-a043-8b1aa7d20a03
# ╠═64f64cf3-4991-4d40-a863-b2413f4396f7
# ╠═7df88527-7cee-45c2-86ef-bb6aed012cc2
# ╠═918f63a7-e792-4883-95bb-15edc7dc3e66
# ╠═35a5df1f-2cc3-43e3-9470-f00826126305
# ╠═e8abb4dd-5b6b-418d-b391-167224dafae4
# ╠═35d21317-dc2b-4c1f-8be8-17e9c75e1f50
# ╠═91576efd-d137-4133-8b6c-254ce5e67905
# ╠═5c2b033f-0f63-4b33-81bf-71f7978713ca
# ╠═fc7bc54e-d972-4f57-b837-78adff02090b
# ╠═84e11547-fe97-4445-a8e1-49f0796913ce
# ╠═adfdfb90-2240-4972-bcd4-40fa4613e98b
# ╠═a540fcbb-8035-434b-8149-0516180cf713
# ╠═72bc11d1-a55f-4b25-986e-15deb5c01f9a
# ╟─b34b2e49-332f-4638-a6a7-c3fda292b90c
# ╟─6dbe580c-03b6-43d1-b10b-72029d06377e
# ╟─eb0fda74-8dc8-4c75-8e83-3ef4ba557788
# ╠═8a614a7c-523b-4beb-9984-578e09038df8
# ╠═6106f1d7-0add-4df8-8681-c94096574c0d
# ╠═262d01fd-9a25-4a86-8a69-027a870231d6
# ╟─99281914-16c8-42a2-84a9-49a94059da22
