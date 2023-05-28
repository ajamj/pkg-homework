### A Pluto.jl notebook ###
# v0.19.26

using Markdown
using InteractiveUtils

# ╔═╡ 95484ff5-be27-4470-a526-e0bd0181fd70
using PlutoUI, Images, DataFrames, Plots, Statistics,StatsPlots
#using StatsBase

# ╔═╡ b1763ae5-4d44-489d-af8f-4f22abc6974e
TableOfContents()

# ╔═╡ 3ddf4e30-fd27-11ed-24eb-37e1034712a0
md"""
# GEOSTATISTIKA I
## I. PENDAHULUAN
Geostatistika tuh kumpulan metode statistik yang awalnya dikembangkan buat bidang pertambangan, tapi sekarang udah dipake luas banget di banyak disiplin ilmu, kayak geofisika, geologi, geografi, dan banyak lagi. Metode-metode ini dipake buat ngeproses dan menganalisis data geografis, kayak data tentang bumi, air, cuaca, dan lain-lain.

Ada juga istilah statistika yang mungkin udah sering lo denger. Statistika itu sebenernya kumpulan konsep dan metode buat ngumpulin, analisis, dan interpretasi data kuantitatif yang punya ketidakpastian. Awalnya statistika cuma dipake buat data-data negara, tapi sekarang udah jadi lebih luas, bisa dipake di banyak bidang.

Di geostatistika, konsep dan metode statistika juga dipake, tapi lebih fokus ke pengolahan data yang bersifat spasial (ada hubungannya sama ruang), kayak data geofisika, gravitasi, dan data-data lain yang nyambung sama ruang dan waktu. Buat ngeproses data geostatistika ini, kita bisa pake berbagai metode, misalnya interpolasi, perataan berbobot, regresi, dan yang terkenal banget, metode kriging.

Metode kriging itu tuh metode interpolasi yang diusulin oleh Matheron, seorang ahli geomatematika dari Perancis. Dia mengembangkan metode kriging untuk ngeluarin prediksi yang akurat buat variabel yang nyambung sama ruang. Setelah kriging, muncul juga metode-metode geostatistik lain yang lebih advanced, kayak Simulated Annealing, Sequential Gaussian Simulation, Bayesian Simulation, dan sebagainya.

Jadi, intinya geostatistika itu gabungan antara statistika sama informasi spasial buat ngeproses dan menganalisis data yang nyambung sama ruang.
"""

# ╔═╡ 58b1a84d-0c21-4347-b640-13fc87305402
md"""
Buat ngertiin konsep-konsep dalam geostatistika, penting buat paham dulu konsep dasar dalam statistika. Ada beberapa hal yang harus dipahami dalam terminologi statistika secara umum:

1. Populasi, Sampel, Variabel, dan Data: Konsep statistik dimulai dari populasi, yang merupakan keseluruhan objek atau individu yang ingin kita pelajari. Sampel adalah subset dari populasi yang diambil untuk penelitian. Variabel adalah karakteristik yang diukur atau diamati dalam populasi atau sampel. Data adalah hasil pengukuran atau observasi dari variabel tersebut.

2. Distribusi Frekuensi: Dari data yang kita dapatkan, kita bisa menyusun distribusi frekuensi, yang menunjukkan sebaran frekuensi atau jumlah kemunculan nilai-nilai dalam data. Distribusi frekuensi bisa disajikan dalam bentuk histogram atau ogive.

3. Ukuran Tengah: Dari distribusi frekuensi, kita bisa mencari nilai-nilai ukuran tengah seperti mean (rata-rata), median (nilai tengah), kuartil, decatil, persentil, dan modus (nilai yang paling sering muncul).

4. Variabilitas atau Dispersi: Selain ukuran tengah, kita juga bisa menghitung ukuran-ukuran variabilitas atau dispersi, seperti rentang (range), deviasi rata-rata, deviasi standar, dan varian.

5. Fungsi Densitas Peluang (PDF) dan Fungsi Densitas Kumulatif (CDF): Dari distribusi frekuensi, kita bisa mendapatkan PDF yang menunjukkan probabilitas suatu nilai terjadi dalam variabel statistik, serta CDF yang menunjukkan probabilitas bahwa suatu nilai lebih kecil atau sama dengan suatu nilai tertentu. PDF merupakan konsep yang sangat penting dalam statistika.

6. Distribusi Peluang: Distribusi peluang mengacu pada jenis distribusi yang digunakan untuk memodelkan variabel statistik yang bersifat random. Ada distribusi peluang diskrit seperti distribusi Uniform, Binomial, Hypergeometrik, dan Poisson, serta distribusi peluang kontinu seperti distribusi Normal.

7. Statistika Inferensial: Selain statistika deskriptif yang membahas pengumpulan dan analisis data, ada juga statistika inferensial yang fokus pada interpretasi data dan pengambilan kesimpulan. Meskipun dalam geostatistika yang sering digunakan hanya metode pengujian data, seperti uji Chi-square (χ2) dan uji Student t.

Jadi, paham konsep-konsep tersebut akan membantu dalam pemahaman geostatistika dan penggunaan metode-metode statistik yang relevan.
"""

# ╔═╡ 7c792798-f2cc-4125-b7e1-e5d1709e604b
md"""
## II. POPULASI, SAMPEL, PARAMETER, DAN DATA

### 1. Definisi-Definisi
- **Populasi** tuh kayak himpunan lengkap semua benda yang lagi kita selidiki, contohnya "mahasiswa FMIPA-UGM". Jumlah anggota populasi ini punya batas tertentu, biasanya disimbolkan dengan N (dari 0 sampe gak terhingga).

- **Sampel** tuh kayak sebagian kecil aja dari populasi. Misalnya, kita ambil sampel "mahasiswa FMIPA-UGM Program Studi Geofisika". Jumlah anggota sampel ini lebih kecil daripada populasi, biasanya disimbolkan dengan n (dengan n < N).

- **Parameter** tuh kayak karakteristik dari anggota populasi atau sampel. Misalnya, "IP" (Indeks Prestasi) atau "lama studi" atau "waktu tunggu dapet kerja" mahasiswa FMIPA-UGM Program Studi Geofisika. Ini yang bakal kita ukur.

- **Statistik** tuh nilai yang dihitung dari sampel. Misalnya, rata-rata Indeks Prestasi mahasiswa FMIPA-UGM Program Studi Geofisika, itu statistik yang kita dapet dari sampel tadi.

Ini ada contoh-contoh lainnya buat terminologi ini:

- **Populasi**: Gempa bumi di Indonesia; **Sampel**: Gempa bumi di Indonesia Barat; **Parameter**: Magnitudo gempa bumi di Indonesia Barat; **Statistik**: Jumlah gempa bumi di Indonesia Barat yang magnitudonya lebih besar dari 8.

- **Populasi**: Pasir gas di lapangan minyak Arun; **Sampel**: Pasir gas di sekitar Sumur A, B, dan C di lapangan minyak Arun (misalnya ada 15 sumur di Arun); **Parameter**: Porositas (atau permeabilitas) pasir gas di sekitar Sumur A, B, dan C; **Statistik**: Sebaran porositas di sekitar Sumur A, B, dan C.
"""

# ╔═╡ 6f1d5682-e9d5-42f0-84f4-7ed483648fab
md"""
### 2. Data

Data itu adalah nilai atau fakta yang terkait sama parameter yang lagi kita perhatiin. Data bisa jadi kuantitatif atau kualitatif. Nah, **data kuantitatif** itu data yang punya nilai numerik, misalnya angka-angka gitu. Nah, **data kualitatif** itu data yang nilai atau fakta nya gak numerik, misalnya kayak nama, alamat, agama, atau daerah asal mahasiswa Program Studi Geofisika. Nah, data kualitatif ini bisa diubah jadi data kuantitatif dengan kasih nilai (skor), peringkat, atau simbol numerik yang relevan.

Data itu bisa diukur langsung atau gak langsung. Kalo data yang gak bisa diukur langsung, kita harus pecah atau urai jadi dimensi-dimensi yang bisa diukur langsung.

Dalam ngukur data, kita sering pake skala pengukuran tertentu. Ada beberapa jenis skala pengukuran yang umum dipake:

1. **Skala nominal (klasifikasi):** Nah, skala ini buat ngelompokin data atau objek ke dalam kategori-kategori yang gak nyampur, misalnya status pendidikan diklasifikasikan jadi "sekolah" atau "gak sekolah". Jenis kelamin diklasifikasikan jadi "cowok" atau "cewek", gitu deh.

2. **Skala ordinal (rangking):** Nah, skala ini buat ngelompokin data atau objek ke dalam kelas-kelas yang ada urutannya. Misalnya, tingkat pendidikan bisa dikelompokin jadi "S3", "S2", "S1", gitu deh. Nah, di sini tingkat S3 dianggap lebih tinggi daripada tingkat S2, gitu deh.

3. **Skala interval:** Nah, skala ini buat ngelompokin data atau objek ke dalam kelas-kelas yang ada urutannya dan ada perbedaan intervalnya. Misalnya, skor Ujian Masuk Perguruan Tinggi Negeri (UMPTN) bisa dikelompokin jadi skor antara 100-200, 200-300, 300-400, gitu deh.

4. **Skala rasio:** Nah, skala ini buat ngelompokin data atau objek ke dalam kelas-kelas yang ada urutannya dan ada perbedaan yang bisa diukur secara proposional. Misalnya, buat ngukur panjang, luas, berat, dan sejenisnya gitu.
"""

# ╔═╡ 8d01ca3a-1622-491d-81db-1bc4c0eaca5d
md"""
### 3. Cara Pengambilan Sampel Data
Posedur pengambilan sampel itu penting banget dalam penelitian statistik. Kita harus pilih sampel yang representatif, artinya bisa mewakili sifat-sifat dari seluruh populasi. Nah, sampel yang representatif itu harus bisa kasih gambaran yang akurat atau setidaknya mendekati karakteristik populasi itu sendiri. Karena setiap populasi bisa punya sifat yang beda-beda, maka jenis sampel yang kita pilih juga harus beda-beda. Di bawah ini adalah beberapa jenis sampel yang sering digunakan dalam penelitian statistik:

1. **Sampel random sederhana:** Nah, ini tuh sampel yang pengambilannya dilakukan dengan cara yang setiap elemen dalam populasi punya peluang yang sama buat terpilih. Proses pengambilan sampel random sederhana bisa dilakukan dengan menggunakan tabel atau mesin bilangan random.

2. **Sampel sistematik:** Nah, ini tuh sampel yang pengambilannya dilakukan secara sistematik dari populasi. Misalnya, dalam uji kualitas produksi, kita bisa ambil sampel pada jam-jam dan interval waktu tertentu. Contoh lainnya, untuk keperluan tertentu, kita bisa pilih sampel dari orang-orang dengan nomor keamanan sosial (social security number) ganjil atau genap.

3. **Sampel kelompok:** Nah, ini tuh sampel random sederhana, tapi unit sampling-nya itu berupa kumpulan atau kelompok elemen. Proses pemilihan sampelnya dilakukan secara random terhadap kelompok-kelompok ini. Misalnya, dalam penelitian pendapatan per kapita di suatu kota, kita pilih kelompok yang terdiri dari beberapa rumah tangga dalam satu RT (blok). Setelah itu, kita pilih blok-blok ini secara random buat dijadikan sampel dalam survei statistik.
"""

# ╔═╡ 30318226-b5ca-4b8d-aa38-39d80ba55c09
md"""
### 4. Data Geostatistika
Bedanya statistika sama geostatistika itu terletak di sumber datanya. Dalam statistika, datanya diambil dari "ruang sampel" gitu, yang isinya variabel, parameter, dan data statistik spesifik. Sedangkan dalam geostatistika, datanya diambil langsung dari "ruang aslinya" atau ruang fisik di lapangan. Jadi, data geostatistika ini biasanya diukur di tempat-tempat tertentu di dunia nyata, dan kadang juga melibatkan dimensi waktu.

Bahkan, data geostatistika pun sering disebut sebagai data teregionalisasi, loh. 

> Variabel teregionalisasi itu adalah suatu fungsi angka yang berubah dari satu tempat ke tempat lain di ruang dengan cara yang halus. (Matheron, 1963) 

Variabilitas dari variabel teregionalisasi gak bisa dijelaskan dengan fungsi matematika biasa, jadi variabel ini punya fenomena dan sifat yang unik, guys. Contohnya, kayak topografi permukaan tanah, ukuran bijih mineral, porositas batuan, permeabilitas batuan, dan sebagainya.

Meskipun nggak acak banget, variabel teregionalisasi ini tetap dianggap sebagai fungsi acak yang dihasilkan, tapi dengan asumsi tetap mengikuti suatu tingkat stasioner tertentu. Stasioner itu artinya, fungsi densitas peluangnya tetap sama meskipun tempatnya bergeser. Misalnya dalam hal waktu, konten frekuensinya tetap nggak berubah seiring berjalannya waktu.

Coba liat gambar 2.1, tuh, itu contoh data geostatistika yang gampang dipahamin. Itu seismogram gelombang mikroseismik yang murni alias nggak ada gangguan, dan sifatnya acak stasioner. Nah, di gambar 2.2 juga ada contoh data geostatistika 2D.

Jadi, intinya bedanya statistika sama geostatistika itu ada di sumber data yang dipakai, bro. Statistika pake data dari ruang sampel, sedangkan geostatistika pake data langsung dari ruang fisik yang sebenarnya.
"""

# ╔═╡ f6fc1a90-ab96-4427-a4b0-29eb38ce0705
load(download("https://github.com/ajamj/pkg-homework/blob/main/img/geostat_2_1.png?raw=true"))

# ╔═╡ 5651410a-8795-48dc-83a5-cdfc0c6fd7f7
load(download("https://github.com/ajamj/pkg-homework/blob/main/img/geostat_2_2.png?raw=true"))

# ╔═╡ 4e09ae2f-9384-4ccb-ba8b-3044b1789c40
md"""
## III. DISTRIBUSI DATA/FREKUENSI
### 1. Distribusi Data
Distribusi data tuh penting banget, bro, dalam statistik. Kurva distribusinya tuh kayak gambaran gimana tingkah laku populasi atau sampel itu. Populasi tuh kumpulan lengkap hasil pengamatan dari suatu peristiwa, sementara sampel itu cuma sebagiannya aja. Parameter itu istilah buat besaran yang bisa berupa variabel atau konstanta yang dimiliki oleh sampel. Nah, data itu sendiri adalah anggota dari parameter tuh.

Supaya data bisa dianalisis dengan baik, kita perlu ngecek distribusinya. Ada beberapa bentuk distribusi data yang sering dipake, nih:

1. **Distribusi frekuensi**: Itu susunan data berdasarkan jumlah kejadiannya. Misalnya, kita bisa bikin distribusi frekuensi buat magnitudo gempa, yaitu kita lihat berapa kali kejadian gempa dengan magnitudo tertentu.

2. **Distribusi runtun waktu (time series)**: Itu susunan data berdasarkan urutan waktunya. Misalnya, kita bisa analisis seismogram dan sinyal lainnya pake distribusi runtun waktu.

3. **Distribusi spasial**: Itu susunan data berdasarkan lokasinya. Misalnya, data gravitasi atau data geografi pada umumnya bisa dianalisis pake distribusi spasial.

Statistik tuh bisa memprediksi tingkah laku populasi cuma berdasarkan tingkah laku sampelnya. Nah, konsep yang penting di sini tuh "distribusi peluang" atau *probability distribution*. Konsep ini ngebahas tentang gimana peluang berubah ketika nilai variabelnya berubah. Variabel dalam statistik tuh bukan sembarang variabel, tapi variabel acak yang mengikuti distribusi peluang tertentu. Total peluangnya pasti 1.

Walaupun data geofisika (data geostatistika pada umumnya) nggak benar-benar acak banget, tetep aja direpresentasikan sebagai fungsi acak dengan asumsi derajat stasioner tertentu. Nah, data geofisika ini bisa berupa:

1. Variabel atau fungsi yang tergantung pada lokasinya, misalnya lithofacies, porositas, permeabilitas, dan sejenisnya.

2. Fungsi atau data yang tergantung pada tempatnya, misalnya data log sumur (gamma ray, resistivitas, dan lain-lain) yang bergantung pada kedalamannya.

3. Fungsi atau data yang tergantung pada waktu, misalnya seismogram, sinyal komunikasi, dan sejenisnya.

4. Fungsi atau data yang tergantung pada tempat dan waktu, contohnya data gravitasi, magnetik, dan sebagainya.

Jadi, distribusi data ini penting banget buat analisis statistik, khususnya dalam geostatistika.
"""

# ╔═╡ f9049804-9bb6-4ce4-a055-851cd1cdfdbb
md"""
### 2. Distribusi Frekuensi
#### a. Pengertian Distribusi Frekuensi
Distribusi frekuensi itu yang paling umum dipake dalam statistik. Distribusi ini disusun berdasarkan jumlah kejadiannya. Ada dua bentuk distribusi frekuensi yang sering dipake, nih:

1. **Distribusi frekuensi kuantitatif**: Itu susunan data berdasarkan nilai-nilainya, bro. Misalnya, kita bisa bikin distribusi frekuensi buat gempa berdasarkan kekuatannya atau magnitudonya (skala Richter). Kita juga bisa bikin distribusi frekuensi gempa berdasarkan waktu kejadiannya (runtun waktu) atau berdasarkan tempat kejadiannya (spasial, kayak lintang, bujur, kedalaman, dan sejenisnya).

2. **Distribusi frekuensi kualitatif**: Nah, ini susunan data berdasarkan kategorinya. Misalnya, kita bisa bikin distribusi frekuensi gempa berdasarkan jenis sesar penyebabnya, kayak sesar naik, turun, atau gesar.

Dalam distribusi frekuensi, sebaran itu artinya gimana data terdistribusi atau tersebar, sementara frekuensi itu nyambung sama ukuran seberapa sering kejadian itu terjadi atau berapa banyak kemunculannya dalam data sampel. Jadi, distribusi frekuensi tuh kayak gambaran tentang sebaran dan frekuensi suatu kejadian atau kemunculan dalam data sampel.

Misalnya, nilai ujian Geostatistika yang diikuti 37 mahasiswa di PS Geofisika bisa kita kelompokin kayak yang terlihat di Gambar 3.1. Nah, distribusi frekuensinya itu bisa ditampilin dalam bentuk grafik yang sering disebut histogram, bro. Histogram ini bentuknya kayak blockgraph atau bargraph kayak di Gambar 3.1. Jarang juga histogram ditampilin dalam bentuk linegraph, sih.

Jadi, distribusi frekuensi tuh berguna banget buat ngeliat sebaran dan frekuensi suatu kejadian atau data dalam statistik.
"""

# ╔═╡ 38ab93f1-84bd-45f1-9a6d-3cdd19254206
gambar_3_1 = DataFrame("nilai"=>["4-5","5-6","6-7","7-8","8-9","9-10"], "jumlah mahasiswa"=>[1,3,6,15,10,2])

# ╔═╡ 19212461-c647-4733-b9c7-7bc69b690e22
gambar_3_2 = plot(bar([4.5,5.5,6.5,7.5,8.5,9.5],[1,3,6,15,10,2]), legend = false)

# ╔═╡ e6c58801-300b-4ad0-bf27-ab84e81e0a10
md"""
#### b. Penyusunan Distribusi Frekuensi
Cara menyusun distribusi frekuensi itu penting banget supaya data kita bisa teratur dan bisa dibuat histogramnya. Ada dua jenis penyusunan data yang umum, yaitu data yang tak dikelompokkan dan data yang dikelompokkan.

Kalo data tak dikelompokkan, biasanya nilai-nilainya tersebar secara acak. Nah, kita perlu mengelompokkan data ini ke dalam kelompok-kelompok dengan interval nilai tertentu yang nantinya akan mempresentasikan histogramnya. Interval kelas ini bisa dipilih sembarang, tapi kita harus hati-hati dalam memilih lebar intervalnya, bro.

Kalo lebar interval terlalu besar, jumlah kelompoknya akan sedikit banget (misalnya cuma 2 kelompok), dan jumlah data per kelompoknya akan terlalu banyak. Sebaliknya, kalo lebar intervalnya terlalu kecil, jumlah kelompoknya bakal terlalu banyak, dan jumlah data per kelompoknya bakal terlalu sedikit bahkan bisa aja jadi nol. Nah, pengelompokan yang terlalu sedikit atau terlalu banyak pastinya bakal ngasih hasil histogram yang gak bisa merepresentasikan distribusi frekuensi dengan baik.

Berikut ini langkah-langkah buat membuat histogram yang representatif:

1. Tentuin banyaknya dan lebar interval kelas:
   - Interval kelas itu interval antara dua nilai, misalnya antara 0-2, 2-4, 4-6, dan seterusnya.
   - Banyaknya interval kelas yang efisien biasanya antara 5 sampai 15. Tapi ada rumus Sturges (1925) yang bisa dipake buat menentuin banyaknya interval kelas, yaitu:
$$k = 1 + 3.322*log_{10}(n)$$
atau

$$k = 1 + log_{2}(n)$$

dengan `n` adalah jumlah data keseluruhan.
   - Lebar interval kelas itu lebar jangkauan (range) dibagi dengan banyaknya interval kelas.
   - Lebar jangkauan (range) itu nilai data terbesar dikurangi nilai data terkecil.

!!! catatan

	Rumus Sturgess untuk menentukan banyaknya kelas interval adalah $$k=1+3.322*log_{10}(n)$$ atau $$k = 1 + log_{2}(n)$$ dengan ```n``` adalah banyaknya data. Referensi: [https://www.statology.org/sturges-rule/](https://www.statology.org/sturges-rule/)

2. Interval-interval kelas ini diletakkan dalam satu kolom dan diurutkan dari interval kelas dengan nilai batas terkecil di paling atas, lalu nilai batas yang lebih besar (berikutnya) di bawahnya, dan seterusnya.

3. Data dimasukkan ke dalam interval kelas sesuai dengan nilainya. Jumlah data yang masuk dalam suatu kelas disebut frekuensi interval kelas tersebut.

4. Gambarkan histogramnya.

Nah, contohnya kita punya data umur baterai (dibulatkan dalam jam) dari 50 sampel produksi, yaitu:
"""

# ╔═╡ 6c02a01d-4be6-4ee8-985d-65da3d9b0210
sampel_50 =  [169, 171, 171, 176, 166, 179, 181, 174, 167, 172, 181, 172, 177, 182, 167, 179, 183, 185, 185, 173, 179, 180, 184, 170, 174, 175, 176, 175, 182, 170, 176, 167, 180, 165, 168, 171, 177, 176, 170, 175, 170, 169, 175, 178, 171, 168, 178, 183, 174, 166]

# ╔═╡ 20b88bf4-099f-477e-b69f-d2fb13d67702
n = length(sampel_50)

# ╔═╡ 7bbf3082-26d7-4fe0-849e-1ae02c8e7d9b
maximum(sampel_50)

# ╔═╡ 14f12a6e-f88f-46b9-b875-85ef9f71aa2d
minimum(sampel_50)

# ╔═╡ a4efd439-06ea-4d72-af87-6a15de067271
data_range = maximum(sampel_50) - minimum(sampel_50)

# ╔═╡ 4efd078d-3f64-4855-ac89-aa1e43467608
md"""
Dari data ini, kita bisa cari:
- Nilai data terbesar = 185
- Nilai data terkecil = 165
- Jangkauan (range) = 185 - 165 = 20

Pake rumus Sturges, dengan jumlah data 50, kita bisa perkirakan jumlah interval kelas: 

$$k = 1 + 3.322*log_{10}(n)$$

$$k = 1 + 3.322*log_{10}(50) = 6.644$$
"""

# ╔═╡ 16fc3402-665d-4f8e-ad78-6c2a7e730db3
md"""
Kita bisa pilih banyaknya interval kelas = 6, jadi lebar interval kelasnya = 20/6 = 3.333. 
"""

# ╔═╡ 2f1a33e4-6a06-43bb-877a-c3308b9c2f97
20/6

# ╔═╡ 3092d142-e0e5-4b1f-a685-dd15fed5ceb4
md"""
Atau kita bisa pilih banyaknya interval kelas = 7, jadi lebar interval kelasnya = 20 / 7 = 2.857.
"""

# ╔═╡ 159cef77-fe64-4bd3-afbf-0ae1416e2110
20/7

# ╔═╡ 468df0cc-5088-4a07-82e8-5cac07017226
md"""
Dari nilai-nilai di atas, kita bisa pilih banyaknya interval kelas = 20 dan lebar interval kelas = 3. Ini bakal menghasilkan interval kelas dengan nilai 164.5 - 167.5, 167.5 - 170.5, 170.5 - 173.5, ..., 182.5 - 185.5.

Kalo data dipecah-pecah dan dikelompokkan sesuai dengan nilai interval kelasnya, kita bakal dapetin tabel distribusi frekuensi yang ditulis di Tabel 3.1. Berdasarkan tabel distribusi frekuensi ini, kita bisa tampilin histogramnya kayak yang ada di Gambar 3.2.

Ada beberapa terminologi yang bisa kita dapatkan dari interval kelas di Gambar 3.2:
1. Batas bawah interval kelas, misalnya batas bawah interval pertama = 164.5 dan batas bawah interval keempat = 173.5.
2. Batas atas interval kelas, misalnya batas atas interval pertama = 167.5 dan batas atas interval keempat = 176.5.
3. Titik tengah interval kelas, misalnya titik tengah interval pertama = 166 dan titik tengah interval keempat = 175.
4. Lebar interval kelas, sama untuk semua interval, yaitu 3.

Tabel 3.1 menunjukkan distribusi frekuensi umur baterai.

| Umur Baterai | Frekuensi |
|--------------|-----------|
| 164.5 - 167.5| 6  	   |
| 167.5 - 170.5| 7         |
| 170.5 - 173.5| 8         |
| 173.5 - 176.5| 11        |
| 176.5 - 179.5| 7         |
| 179.5 - 182.5| 6        |
| 182.5 - 185.5| 5         |

Gambar 3.2 menampilkan histogram umur baterai.
"""

# ╔═╡ c038acd3-c29f-4e63-b1f6-2e3ba8b708b1
load(download("https://github.com/ajamj/pkg-homework/blob/main/img/geostat_3_2.png?raw=true"))

# ╔═╡ 1fdbb53f-3046-4a46-b27a-12412c589738
md"""
Versi kodingan:
"""

# ╔═╡ 69b0e611-edbd-4e47-8139-4a8114e9e2ea
df = DataFrame(Class = String[], Frequency = Int[])

# ╔═╡ 464cb752-363a-4ffd-82c4-0cbe9dc601f7
df

# ╔═╡ 802ef0a2-3128-4ece-9623-adaa5b791d27
histogram(sampel_50,bins=7) # versi kodingan

# ╔═╡ 8e4cca1b-5386-41aa-87c5-f4e9378bdc38
md"""
#### c. Pengembangan Distribusi Frekuensi
Distribusi frekuensi kumulatif kurang dari adalah distribusi frekuensi yang menunjukkan jumlah kumulatif data yang kurang dari suatu nilai tertentu. Distribusi frekuensi kumulatif lebih dari, di sisi lain, menunjukkan jumlah kumulatif data yang lebih besar dari suatu nilai tertentu.
"""

# ╔═╡ b7c4de9d-2ce9-45fc-940a-f55773443284
load(download("https://github.com/ajamj/pkg-homework/blob/main/img/geostats_t3_2.png?raw=true"))

# ╔═╡ 4a91b2f6-b19a-4200-9f81-ef9ca0ba30f9
load(download("https://github.com/ajamj/pkg-homework/blob/main/img/geostat_3_3_ogive.png?raw=true"))

# ╔═╡ 5d1d0130-8615-4182-9cf1-eec00623ce40
md"""
Gambar 3.3 menampilkan grafik Ogive untuk distribusi frekuensi kumulatif kurang dari dan lebih dari umur baterai.

Selanjutnya, distribusi frekuensi relatif (dalam fraksi atau persentase) menggambarkan frekuensi dalam bentuk proporsi atau peluang. Total frekuensi relatif akan menjadi 1 atau 100%.

Gambar 3.4 menampilkan histogram distribusi frekuensi relatif umur baterai. Bentuk histogramnya sama dengan histogram distribusi frekuensi (Gambar 3.2), hanya nilai frekuensinya yang berbeda.

![Histogram Distribusi Frekuensi Relatif Umur Baterai](https://github.com/ajamj/pkg-homework/blob/main/img/geostat_3_4.png?raw=true)

Distribusi frekuensi relatif pada dasarnya adalah distribusi peluang (probability distribution) yang total nilainya adalah 1. Histogramnya juga dikenal sebagai **fungsi densitas peluang (probability density function, PDF)**.
"""

# ╔═╡ c4d2d461-bc89-43e3-9c97-1aeff3483221
md"""
Versi kodingan
"""

# ╔═╡ 02a28654-b119-4954-93f2-f80db6cd6c5a
begin
df_ogive_tipe2 = DataFrame(Class = String[], CumulativeFrequency = Int[])
cumulative_freq_tipe2 = sum(df.Frequency)
for row in eachrow(df)
    class_interval = row.Class
    freq = row.Frequency
    push!(df_ogive_tipe2, [class_interval, cumulative_freq_tipe2])
    cumulative_freq_tipe2 -= freq
end
end

# ╔═╡ ee70462d-bed2-4c28-a475-cfb45570abcc
begin
plot(df_ogive_tipe1.Class, df_ogive_tipe1.CumulativeFrequency, label = "Ogive Tipe I", marker = :circle)
xlabel!("Class")
ylabel!("Cumulative Frequency")
title!("Ogive Tipe I")
end

# ╔═╡ e35ac2fb-9f5c-4daf-9ace-b75914cbc6c8
begin
plot(df_ogive_tipe2.Class, df_ogive_tipe2.CumulativeFrequency, label = "Ogive Tipe II", marker = :circle)
xlabel!("Class")
ylabel!("Cumulative Frequency")
title!("Ogive Tipe II")
end

# ╔═╡ a9c430fb-7808-47f7-bc46-c35982c8171e
histogram(sampel_50, weights = fill(1/length(sampel_50), length(sampel_50)), xlabel = "Umur Bateri", ylabel = "Frekuensi Relatif", title = "Histogram Distribusi Frekuensi Relatif Umur Bateri")

# ╔═╡ 411b9beb-1f66-4abb-bf11-c4db4e300b18
md"""
## SOAL LATIHAN
Berikut adalah format markdown lengkap untuk soal-soal yang diberikan:

### SOAL 1
Suatu data yang dikelompokkan mempunyai nilai tengah xi dan frekuensinya fi seperti yang terlihat dalam tabel dibawah.

| xi  | fi |
|-----|----|
| 75  | 1  |
| 72  | 3  |
| 69  | 6  |
| 66  | 12 |
| 63  | 20 |
| 60  | 18 |
| 57  | 11 |
| 54  | 6  |
| 51  | 3  |
| 48  | 2  |
| 45  | 1  |

a. Buatlah histogram distribusi frekuensinya!

b. Buatlah distribusi frekuensi kurang dari!

c. Berapa persen data yang nilainya kurang dari 55?

d. Berapa persen data yang nilainya antara 50 sampai 65?

### SOAL 2
Umur 50 orang (dalam tahun) yang diambil secara random dari suatu populasi masyarakat adalah sebagai berikut:

68, 80, 55, 84, 59, 76, 89, 72, 51, 80, 80, 84, 68, 63, 76, 68, 92, 68, 72, 63, 84, 64, 76, 76, 80, 72, 59, 65, 72, 72, 70, 60, 62, 53, 56, 71, 74, 82, 87, 78, 65, 59, 69, 75, 72, 68, 64, 74, 70, 63.

a. Hitunglah banyak interval kelas menurut rumus Sturges!

b. Buatlah distribusi frekuensinya!

c. Hitunglah frekuensi relatif untuk tiap-tiap kelas intervalnya!

### SOAL 3
Suatu rumah sakit melakukan survei pada jumlah hari pasien yang menjalani rawat inap dan hasilnya adalah sebagai berikut:

| Jumlah Hari | Frekuensi |
|-------------|-----------|
| 1-3         | 32        |
| 4-6         | 108       |
| 7-9         | 67        |
| 10-12       | 28        |
| 13-15       | 14        |
| 16-18       | 7         |
| 19-21       | 3         |
| 22-24       | 1         |

a. Gambarkan histogram distribusi frekuensinya!

b. Buatlah tabel distribusi kumulatif kurang dari!

c. Berapakah jumlah pasien yang menginap di rumah sakit kurang dari 10 hari?

d. Buatlah tabel distribusi frekuensi relatifnya!

e. Berapa persen pasien yang menginap antara 4 sampai 6 hari?
"""

# ╔═╡ ecd63f07-ea04-4e73-ad2c-92a9f03ed99f
md"""
## Jawaban
"""

# ╔═╡ c044700e-ec82-4257-bf99-dc7c931f03c4
md"""
### Soal 1
"""

# ╔═╡ f7867512-dc39-4551-a56c-96246e72309b
data1 = DataFrame((x=[75,72,69,66,63,60,57,54,51,48,45]),(f=[1,3,6,12,20,18,11,6,3,2,1]))

# ╔═╡ e6239100-be83-4e9d-bda0-5ced29d145a4
max1 = maximum(data1.x)

# ╔═╡ f1199f05-2188-406b-857b-6e8751b4fcd4
min1 = minimum(data1.x)

# ╔═╡ 6ce64de4-dc4b-4df4-902c-4776d4b9275c
range1 = max1-min1

# ╔═╡ bb562de0-67d1-44d4-88bd-d0b1d7f1116e
total_data1 = sum(data1.f)

# ╔═╡ 859ccac4-4fc0-46cc-ab08-807b187d53b1


# ╔═╡ 10264e4d-04cc-47f7-ba3f-c28507b017ef


# ╔═╡ 4d2219f8-63ac-480b-9563-ea113bde4239
histogram(data1.x,data1.f)

# ╔═╡ 97217e4a-97b0-4186-8961-d75c71f5bcff
md"""
## Fungsi-Fungsi
"""

# ╔═╡ 2fc519f7-d7f6-4f00-b28f-cbb7bdcd0dcd
"""
Fungsi untuk mencari banyak sampel data berdasarkan rumus Sturges (1925), yaitu ```k = 1 + 3.322*log_{2}(n)``` dengan n adalah jumlah data keseluruhan.

Input: n = jumlah data.

output: k = banyak interval kelas.
"""
function k_sturges(n)
	return 1 + log2(n)
end

# ╔═╡ 2cfe7bb8-b388-4fc2-9d8e-6fb482b4ea08
k_sampel_50 = k_sturges(n)

# ╔═╡ 30a442b9-ff0e-4bd7-94c5-94f49a5fbbd0
class_width = round(data_range / k_sampel_50)

# ╔═╡ 29bfe83e-ae36-420a-b346-4a4e460b9b0e
class_boundaries = minimum(sampel_50)-0.5:class_width:minimum(sampel_50)+round(k_sampel_50)*class_width

# ╔═╡ 53227240-8988-41b4-a04f-2df57ea71f0e
for i in 1:length(class_boundaries)-1
    lower_bound = class_boundaries[i]
    upper_bound = class_boundaries[i+1]
    freq = count(x -> lower_bound ≤ x < upper_bound, sampel_50)
    push!(df, [string(lower_bound) * " - " * string(upper_bound), freq])
end

# ╔═╡ b318abb8-846e-4910-a144-49bbaa718a1e
k1 = round(k_sturges(total_data1))

# ╔═╡ 90a45ccc-6a41-4a15-bd2a-53509d3a5289
class_width1 = round(total_data1/k1)

# ╔═╡ 8b0fd643-fe62-4f7f-a18a-7b64219aad9d
"""
Fungsi membuat tabel ogive tipe 1 (tabel frekuensi kurang dari).

Input: dataframe berisi

Output: dataframe ogive 1
"""
function ogive_1(df)
	df_ogive_tipe1 = DataFrame(Class = String[], CumulativeFrequency = Int[])
	cumulative_freq_tipe1 = 0
	for row in eachrow(df)
    	class_interval = row.Class
    	freq = row.Frequency
    	cumulative_freq_tipe1 += freq
    	push!(df_ogive_tipe1, [class_interval, cumulative_freq_tipe1])
	end
	return df_ogive_tipe1
end

# ╔═╡ d6390110-5514-4a27-a377-99f6db04cced
ogive_1(df)

# ╔═╡ 4b01494e-07c8-43cc-8a3f-5c9c74537ce0
ogive_1(data1)

# ╔═╡ 0e71ec1f-8659-4c56-bc5f-ff5345a14364
"""
Fungsi membuat tabel ogive tipe 2 (tabel frekuensi lebih dari).

Input: dataframe berisi

Output: dataframe ogive 1
"""
function ogive_2(df)
	df_ogive_tipe2 = DataFrame(Class = String[], CumulativeFrequency = Int[])
	cumulative_freq_tipe2 = sum(df.Frequency)
	for row in eachrow(df)
    	class_interval = row.Class
    	freq = row.Frequency
    	push!(df_ogive_tipe2, [class_interval, cumulative_freq_tipe2])
    	cumulative_freq_tipe2 -= freq
	end
	return df_ogive_tipe2
end

# ╔═╡ 0617e2ba-584e-4391-acf6-efca264af55e
ogive_2(df)

# ╔═╡ 7c9368b7-108a-4ff4-801f-46d74c9ae2e3
"""
Fungsi mengubah array menjadi dataframe (tabel) frekuensi data.

Input: array = [1,2,312,142,12,1,2,312]

Output: dataframe = tabel frekuensi data
"""
function arr_to_df(arr)
	n = length(arr)
	data_range = maximum(arr) - minimum(arr)
	k = k_sturges(n)
	class_width = round(data_range / arr)
	class_boundaries = minimum(arr)-0.5:class_width:minimum(arr)+round(arr)*class_width
	df = DataFrame(Class = String[], Frequency = Int[])
	for i in 1:length(class_boundaries)-1
    	lower_bound = class_boundaries[I]
    	upper_bound = class_boundaries[i+1]
    	freq = count(x -> lower_bound ≤ x < upper_bound, sampel_50)
    	push!(df, [string(lower_bound) * " - " * string(upper_bound), freq])
	end
	return df
end

# ╔═╡ c8f190dc-8301-4011-b2b9-b054dffda83e
#function create_array(df::DataFrame)
#    values = repeat(df.x, inner = df.f)
#    return values
#end


# ╔═╡ f7e9cdce-e33f-4ef9-84e3-a202a3e27600
#create_array(data1)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Images = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
StatsPlots = "f3b207a7-027a-5e70-b257-86293d7955fd"

[compat]
DataFrames = "~1.5.0"
Images = "~0.25.3"
Plots = "~1.38.13"
PlutoUI = "~0.7.51"
StatsBase = "~0.34.0"
StatsPlots = "~0.15.5"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.0"
manifest_format = "2.0"
project_hash = "ee03400be89e6ed912d4c74a994e5b36a0758fc2"

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

[[deps.Arpack]]
deps = ["Arpack_jll", "Libdl", "LinearAlgebra", "Logging"]
git-tree-sha1 = "9b9b347613394885fd1c8c7729bfc60528faa436"
uuid = "7d9fca2a-8960-54d3-9f78-7d1dccf2cb97"
version = "0.5.4"

[[deps.Arpack_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "OpenBLAS_jll", "Pkg"]
git-tree-sha1 = "5ba6c757e8feccf03a1554dfaf3e26b3cfc7fd5e"
uuid = "68821587-b530-5797-8361-c406ea357684"
version = "3.5.1+1"

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

[[deps.BitFlags]]
git-tree-sha1 = "43b1a4a8f797c1cddadf60499a8a077d4af2cd2d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.7"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.CEnum]]
git-tree-sha1 = "eb4cb44a499229b3b8426dcfb5dd85333951ff90"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.4.2"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

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

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "9c209fb7536406834aa938fb149964b985de6c83"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.1"

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

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "96d823b94ba8d187a6d8f0826e731195a74b90e9"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.2.0"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "738fec4d684a9a6ee9598a8bfee305b26831f28c"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.2"
weakdeps = ["IntervalSets", "StaticArrays"]

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseStaticArraysExt = "StaticArrays"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.CoordinateTransformations]]
deps = ["LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "f9d7112bfff8a19a3a4ea4e03a8e6a91fe8456bf"
uuid = "150eb455-5306-5404-9cee-2592286d6298"
version = "0.6.3"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.CustomUnitRanges]]
git-tree-sha1 = "1a3f97f907e6dd8983b744d2642651bb162a3f7a"
uuid = "dc8bdbbb-1ca9-579f-8c36-e416f6a65cce"
version = "1.0.2"

[[deps.DataAPI]]
git-tree-sha1 = "8da84edb865b0b5b0100c0666a9bc9a0b71c553c"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.15.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InlineStrings", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Random", "Reexport", "SentinelArrays", "SnoopPrecompile", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "aa51303df86f8626a962fccb878430cdb0a97eee"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.5.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.Distances]]
deps = ["LinearAlgebra", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "49eba9ad9f7ead780bfb7ee319f962c811c6d3b2"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.8"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Distributions]]
deps = ["FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SparseArrays", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns", "Test"]
git-tree-sha1 = "c72970914c8a21b36bbc244e9df0ed1834a0360b"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.95"

    [deps.Distributions.extensions]
    DistributionsChainRulesCoreExt = "ChainRulesCore"
    DistributionsDensityInterfaceExt = "DensityInterface"

    [deps.Distributions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DensityInterface = "b429d917-457f-4dbc-8f4c-0cc954292b1d"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.DualNumbers]]
deps = ["Calculus", "NaNMath", "SpecialFunctions"]
git-tree-sha1 = "5837a837389fccf076445fce071c8ddaea35a566"
uuid = "fa6b7ba4-c1ee-5f82-b5fc-ecf0adba8f74"
version = "0.6.8"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bad72f730e9e91c08d9427d5e8db95478a3c323d"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.8+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Pkg", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "74faea50c1d007c85837327f6775bea60b5492dd"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.2+2"

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

[[deps.FillArrays]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "Statistics"]
git-tree-sha1 = "ed569cb9e7e3590d5ba884da7edc50216aac5811"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.1.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "d972031d28c8c8d9d7b41a536ad7bb0c2579caca"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.8+0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "8b8a2fd4536ece6e554168c21860b6820a8a83db"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.72.7"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "19fad9cd9ae44847fe842558a744748084a722d1"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.72.7+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "d3b3624125c1474292d0d8ed0f65554ac37ddb23"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.74.0+2"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "d61890399bc535850c4bf08e4e0d3a7ad0f21cbd"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Graphs]]
deps = ["ArnoldiMethod", "Compat", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "1cf1d7dcb4bc32d7b4a5add4232db3750c27ecb4"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.8.0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "ba9eca9f8bdb787c6f3cf52cb4a404c0e349a0d1"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.9.5"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.HypergeometricFunctions]]
deps = ["DualNumbers", "LinearAlgebra", "OpenLibm_jll", "SpecialFunctions"]
git-tree-sha1 = "84204eae2dd237500835990bcade263e27674a93"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.16"

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

[[deps.InlineStrings]]
deps = ["Parsers"]
git-tree-sha1 = "9cc2baf75c6d09f9da536ddf58eb2f29dedaf461"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.4.0"

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

[[deps.InvertedIndices]]
git-tree-sha1 = "0dc7b50b8d436461be01300fd8cd45aa0274b038"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.3.0"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLD2]]
deps = ["FileIO", "MacroTools", "Mmap", "OrderedCollections", "Pkg", "Printf", "Reexport", "Requires", "TranscodingStreams", "UUIDs"]
git-tree-sha1 = "42c17b18ced77ff0be65957a591d34f4ed57c631"
uuid = "033835bb-8acc-5ee8-8aae-3f567f8a3819"
version = "0.4.31"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "f377670cda23b6b7c1c0b3893e37451c5c1a2185"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.5"

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

[[deps.KernelDensity]]
deps = ["Distributions", "DocStringExtensions", "FFTW", "Interpolations", "StatsBase"]
git-tree-sha1 = "90442c50e202a5cdf21a7899c66b240fdef14035"
uuid = "5ab0869b-81aa-558d-bb23-cbf5423bbe9b"
version = "0.6.7"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "099e356f267354f46ba65087981a77da23a279b7"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.0"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

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

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c7cb1f5d892775ba13767a87c7ada0b980ea0a71"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+2"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

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

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "cedb76b37bc5a6c702ade66be44f831fa23c681e"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.0"

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

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "Random", "Sockets"]
git-tree-sha1 = "03a9b9718f5682ecb107ac9f7308991db4ce395b"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.7"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+0"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

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

[[deps.MultivariateStats]]
deps = ["Arpack", "LinearAlgebra", "SparseArrays", "Statistics", "StatsAPI", "StatsBase"]
git-tree-sha1 = "68bf5103e002c44adfd71fea6bd770b3f0586843"
uuid = "6f286f6a-111f-5878-ab1e-185364afe411"
version = "0.10.2"

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

[[deps.Observables]]
git-tree-sha1 = "6862738f9796b3edc1c09d0890afce4eca9e7e93"
uuid = "510215fc-4207-5dde-b226-833fc4488ee2"
version = "0.5.4"

[[deps.OffsetArrays]]
deps = ["Adapt"]
git-tree-sha1 = "82d7c9e310fe55aa54996e6f7f94674e2a38fcb4"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.12.9"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

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

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "51901a49222b09e3743c65b8847687ae5fc78eb2"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.1"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9ff31d101d987eb9d66bd8b176ac7c277beccd09"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.20+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "d321bf2de576bf25ec4d3e4360faca399afca282"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.0"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+0"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "67eae2738d63117a196f497d7db789821bce61d1"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.17"

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
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "a5aef8d4a6e8d81f171b2bd4be5265b01384c74c"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.10"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.0"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f6cf8e7944e50901594838951729a1861e668cb8"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.2"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "1f03a2d339f42dca4a4da149c7e15e9b896ad899"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.1.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "f92e1315dadf8c46561fb9396e525f7200cdc227"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.3.5"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "3c5106dc6beba385fd1d37b9bf504271f8bfa916"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.38.13"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "b478a748be27bd2f2c73a7690da219d0844db305"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.51"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "a6062fe4063cdafe78f4a0a81cfffb89721b30e7"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.2"

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

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "0c03844e2231e12fda4d0086fd7cbe4098ee8dc5"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+2"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "6ec7ac8412e83d57e313393220879ede1740f9ee"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.8.2"

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

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RegionTrees]]
deps = ["IterTools", "LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "4618ed0da7a251c7f92e869ae1a19c74a7d2a7f9"
uuid = "dee08c22-ab7f-5625-9660-a9af2021b33f"
version = "0.3.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "90bc7a7c96410424509e4263e277e43250c05691"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.0"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "f65dcb5fa46aee0cf9ed6274ccbd597adc49aa7b"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.7.1"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6ed52fdd3382cf21947b15e8870ac0ddbff736da"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.4.0+0"

[[deps.Rotations]]
deps = ["LinearAlgebra", "Quaternions", "Random", "StaticArrays"]
git-tree-sha1 = "54ccb4dbab4b1f69beb255a2c0ca5f65a9c82f08"
uuid = "6038ab10-8711-5258-84ad-4b1120ba62dc"
version = "1.5.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "30449ee12237627992a99d5e30ae63e4d78cd24a"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.0"

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "77d3c4726515dca71f6d80fbb5e251088defe305"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.3.18"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

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

[[deps.StatsFuns]]
deps = ["HypergeometricFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "f625d686d5a88bcd2b15cd81f18f98186fdc0c9a"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.3.0"

    [deps.StatsFuns.extensions]
    StatsFunsChainRulesCoreExt = "ChainRulesCore"
    StatsFunsInverseFunctionsExt = "InverseFunctions"

    [deps.StatsFuns.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.StatsPlots]]
deps = ["AbstractFFTs", "Clustering", "DataStructures", "Distributions", "Interpolations", "KernelDensity", "LinearAlgebra", "MultivariateStats", "NaNMath", "Observables", "Plots", "RecipesBase", "RecipesPipeline", "Reexport", "StatsBase", "TableOperations", "Tables", "Widgets"]
git-tree-sha1 = "14ef622cf28b05e38f8af1de57bc9142b03fbfe3"
uuid = "f3b207a7-027a-5e70-b257-86293d7955fd"
version = "0.15.5"

[[deps.StringManipulation]]
git-tree-sha1 = "46da2434b41f41ac3594ee9816ce5541c6096123"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.3.0"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "Pkg", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "5.10.1+6"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableOperations]]
deps = ["SentinelArrays", "Tables", "Test"]
git-tree-sha1 = "e383c87cf2a1dc41fa30c093b2a19877c83e1bc1"
uuid = "ab02a1b2-a7df-11e8-156e-fb1833f50b87"
version = "1.2.0"

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

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["ConstructionBase", "Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "ba4aa36b2d5c98d6ed1f149da916b3ba46527b2b"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.14.0"

    [deps.Unitful.extensions]
    InverseFunctionsUnitfulExt = "InverseFunctions"

    [deps.Unitful.weakdeps]
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "e2d817cc500e960fdbafcf988ac8436ba3208bfd"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.3"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "ed8d92d9774b077c53e1da50fd81a36af3744c1c"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+0"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4528479aa01ee1b3b4cd0e6faef0e04cf16466da"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.25.0+0"

[[deps.Widgets]]
deps = ["Colors", "Dates", "Observables", "OrderedCollections"]
git-tree-sha1 = "fcdae142c1cfc7d89de2d11e08721d0f2f86c98a"
uuid = "cc8bc4a8-27d6-5769-a93b-9d913e69aa62"
version = "0.6.6"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "de67fa59e33ad156a590055375a30b23c40299d3"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "0.5.5"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "93c41695bc1c08c46c5899f4fe06d6ead504bb73"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.10.3+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+0"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "49ce682769cd5de6c72dcf1b94ed7790cd08974c"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.5+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "868e669ccb12ba16eaf50cb2957ee2ff61261c56"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.29.0+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.7.0+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

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

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9ebfc140cc56e8c2156a15ceac2f0302e327ac0a"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+0"
"""

# ╔═╡ Cell order:
# ╠═95484ff5-be27-4470-a526-e0bd0181fd70
# ╠═b1763ae5-4d44-489d-af8f-4f22abc6974e
# ╟─3ddf4e30-fd27-11ed-24eb-37e1034712a0
# ╟─58b1a84d-0c21-4347-b640-13fc87305402
# ╟─7c792798-f2cc-4125-b7e1-e5d1709e604b
# ╟─6f1d5682-e9d5-42f0-84f4-7ed483648fab
# ╟─8d01ca3a-1622-491d-81db-1bc4c0eaca5d
# ╟─30318226-b5ca-4b8d-aa38-39d80ba55c09
# ╟─f6fc1a90-ab96-4427-a4b0-29eb38ce0705
# ╟─5651410a-8795-48dc-83a5-cdfc0c6fd7f7
# ╟─4e09ae2f-9384-4ccb-ba8b-3044b1789c40
# ╟─f9049804-9bb6-4ce4-a055-851cd1cdfdbb
# ╠═38ab93f1-84bd-45f1-9a6d-3cdd19254206
# ╠═19212461-c647-4733-b9c7-7bc69b690e22
# ╟─e6c58801-300b-4ad0-bf27-ab84e81e0a10
# ╠═6c02a01d-4be6-4ee8-985d-65da3d9b0210
# ╠═20b88bf4-099f-477e-b69f-d2fb13d67702
# ╠═7bbf3082-26d7-4fe0-849e-1ae02c8e7d9b
# ╠═14f12a6e-f88f-46b9-b875-85ef9f71aa2d
# ╠═a4efd439-06ea-4d72-af87-6a15de067271
# ╟─4efd078d-3f64-4855-ac89-aa1e43467608
# ╠═2cfe7bb8-b388-4fc2-9d8e-6fb482b4ea08
# ╟─16fc3402-665d-4f8e-ad78-6c2a7e730db3
# ╠═2f1a33e4-6a06-43bb-877a-c3308b9c2f97
# ╟─3092d142-e0e5-4b1f-a685-dd15fed5ceb4
# ╠═159cef77-fe64-4bd3-afbf-0ae1416e2110
# ╟─468df0cc-5088-4a07-82e8-5cac07017226
# ╟─c038acd3-c29f-4e63-b1f6-2e3ba8b708b1
# ╟─1fdbb53f-3046-4a46-b27a-12412c589738
# ╠═30a442b9-ff0e-4bd7-94c5-94f49a5fbbd0
# ╠═29bfe83e-ae36-420a-b346-4a4e460b9b0e
# ╠═69b0e611-edbd-4e47-8139-4a8114e9e2ea
# ╠═53227240-8988-41b4-a04f-2df57ea71f0e
# ╠═464cb752-363a-4ffd-82c4-0cbe9dc601f7
# ╠═802ef0a2-3128-4ece-9623-adaa5b791d27
# ╟─8e4cca1b-5386-41aa-87c5-f4e9378bdc38
# ╟─b7c4de9d-2ce9-45fc-940a-f55773443284
# ╟─4a91b2f6-b19a-4200-9f81-ef9ca0ba30f9
# ╟─5d1d0130-8615-4182-9cf1-eec00623ce40
# ╟─c4d2d461-bc89-43e3-9c97-1aeff3483221
# ╠═d6390110-5514-4a27-a377-99f6db04cced
# ╠═02a28654-b119-4954-93f2-f80db6cd6c5a
# ╠═0617e2ba-584e-4391-acf6-efca264af55e
# ╠═ee70462d-bed2-4c28-a475-cfb45570abcc
# ╠═e35ac2fb-9f5c-4daf-9ace-b75914cbc6c8
# ╠═a9c430fb-7808-47f7-bc46-c35982c8171e
# ╟─411b9beb-1f66-4abb-bf11-c4db4e300b18
# ╟─ecd63f07-ea04-4e73-ad2c-92a9f03ed99f
# ╟─c044700e-ec82-4257-bf99-dc7c931f03c4
# ╠═f7867512-dc39-4551-a56c-96246e72309b
# ╠═e6239100-be83-4e9d-bda0-5ced29d145a4
# ╠═f1199f05-2188-406b-857b-6e8751b4fcd4
# ╠═6ce64de4-dc4b-4df4-902c-4776d4b9275c
# ╠═bb562de0-67d1-44d4-88bd-d0b1d7f1116e
# ╠═b318abb8-846e-4910-a144-49bbaa718a1e
# ╠═90a45ccc-6a41-4a15-bd2a-53509d3a5289
# ╠═859ccac4-4fc0-46cc-ab08-807b187d53b1
# ╠═10264e4d-04cc-47f7-ba3f-c28507b017ef
# ╠═4d2219f8-63ac-480b-9563-ea113bde4239
# ╠═4b01494e-07c8-43cc-8a3f-5c9c74537ce0
# ╟─97217e4a-97b0-4186-8961-d75c71f5bcff
# ╠═2fc519f7-d7f6-4f00-b28f-cbb7bdcd0dcd
# ╠═8b0fd643-fe62-4f7f-a18a-7b64219aad9d
# ╠═0e71ec1f-8659-4c56-bc5f-ff5345a14364
# ╠═7c9368b7-108a-4ff4-801f-46d74c9ae2e3
# ╠═c8f190dc-8301-4011-b2b9-b054dffda83e
# ╠═f7e9cdce-e33f-4ef9-84e3-a202a3e27600
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
