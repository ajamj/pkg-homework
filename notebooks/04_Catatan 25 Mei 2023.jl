### A Pluto.jl notebook ###
# v0.19.26

using Markdown
using InteractiveUtils

# ╔═╡ be3f54f4-be4e-41a4-a2bf-a24ffa464404
using Plots, PlutoUI

# ╔═╡ 9b0cef71-aa0b-42e7-af98-5d7ec42dc8c3
using .Threads

# ╔═╡ c38812a6-73e4-4223-93bc-0e246c54ff3a
using BenchmarkTools

# ╔═╡ a4c66e59-ba4e-4c0c-b397-eecfed910b3f
using Distributed

# ╔═╡ 5368d8a0-fab8-11ed-0e1c-5736fd7e3344
md"""# 25 Mei 2023"""

# ╔═╡ 9aabe96c-6f3f-49c6-a06a-b2ac0071daf7
TableOfContents()

# ╔═╡ b936f1bc-687e-476a-8823-90317b1ffb49
md""" 
# Parallel Computing
Julia ngerti banget sama yang namanya programming koncurrent dan paralel, bro. Ada empat kategori yang bisa kamu pilih:

1. "Tasks" atau coroutines yang asinkron:

Julia punya fitur Tasks yang bisa ngasih kamu kemampuan buat nyuspend dan melanjutkan komputasi untuk I/O, event handling, proses produsen-konsumen, dan pola serupa. Tasks bisa sinkronisasi dengan operasi kayak wait dan fetch, dan bisa komunikasi pake Channels. Walaupun sebenarnya ini bukan komputasi paralel langsung, Julia juga bisa jadwalin Tasks di beberapa thread.

2. Multi-threading:

Multi-threading di Julia ngasih kamu kemampuan buat menjadwalkan Tasks secara bersamaan di lebih dari satu thread atau inti CPU, sambil berbagi memori. Biasanya ini cara termudah buat dapetin paralelisme di PC atau server multi-core gede. Multi-threading di Julia bisa disusun secara komposisi. Ketika suatu fungsi multi-threaded manggil fungsi multi-threaded lainnya, Julia bakal menjadwalkan semua thread secara global di sumber daya yang tersedia, tanpa kelebihan langganan.

3. Komputasi terdistribusi:

Komputasi terdistribusi menjalankan beberapa proses Julia dengan ruang memori terpisah. Bisa di satu komputer atau beberapa komputer sekaligus. Library standar Distributed nyediain kemampuan buat eksekusi remote dari fungsi Julia. Dengan dasar yang ini, bisa banget bangun berbagai macam abstraksi komputasi terdistribusi. Contohnya, ada package seperti DistributedArrays.jl yang ngasih abstraksi semacam itu. Di sisi lain, ada juga package kayak MPI.jl dan Elemental.jl yang ngasih akses ke ekosistem library MPI yang udah ada.

4. Komputasi GPU:

Compiler GPU di Julia ngasih kemampuan buat jalanin kode Julia langsung di GPU. Ada ekosistem yang kaya banget package Julia yang membidik GPU. Situs JuliaGPU.org nyediain daftar kemampuan, GPU yang didukung, package terkait, dan dokumentasi yang bisa kamu cek, bro.
"""

# ╔═╡ 730b3add-28f8-4d4c-a430-2f1018dedd91
md"""
## Thread
"""

# ╔═╡ 80e8cc2f-008c-4446-b530-3af3def0cc37
Threads.nthreads() # Ngecek jumlah thread

# ╔═╡ f4de5557-3649-4911-957b-d188fe64a242
md"""
> julia -t auto\
> julia -t 4
"""

# ╔═╡ d3eacacb-3dbe-43ca-aa23-30924e8db7b1
md"""
!!! note

	Thread itu kayak tim kecil dalam program yang bisa jalan tugas sendiri. Jadi, satu program bisa punya banyak thread yang kerja bersamaan. Masing-masing thread punya jalur sendiri buat jalanin kode-kode. Mereka juga bisa komunikasi sama thread lainnya dalam program yang sama. Jadi, mereka bisa ngirim data atau nge-sync tugas bareng-bareng.

	Thread sering dipake buat ngakselerasin program, soalnya mereka bisa jalanin tugas-tugas secara paralel di beberapa inti prosesor yang ada. Jadi, lebih cepet dan efisien gitu.

	Tapi, ada juga masalah yang mesti diperhatiin. Misalnya, kalo dua thread atau lebih akses data bareng-bareng, bisa ada masalah race condition. Trus ada juga masalah deadlock, kalo thread saling nungguin satu sama lain sampe gak bisa lanjutin kerjanya.

	Jadi, thread itu bagus banget buat ngakselerasin program, tapi harus diperhatiin juga biar gak ada masalah kayak gitu.
"""

# ╔═╡ ceba284f-0eca-4c82-894c-450bb48b1839
begin
	a = zeros(10)
	@threads for i = 1:10
		a[i] = threadid()
	end
	a
end

# ╔═╡ 18e62923-7ec0-47fd-9093-bb052ed25af5
md"""
## Serial
"""

# ╔═╡ 15451455-012d-4bc1-89dd-fee56d5e4046
A = rand(112,112)

# ╔═╡ f8f3ce58-cb6d-47ba-91f0-013dc918e44b
function sqrt_array(A)
	B = similar(A)
	for i in eachindex(A)
		B[i] = sqrt(A[i])
	end
	return B
end

# ╔═╡ c6d357ac-ded2-40e9-b3a7-327a61389622
sqrt_array(A)

# ╔═╡ 15cf2b4e-8605-4f50-a66c-fdb406a14258
md"""
Nah, kode yang di atas itu bakal diproses secara serial. Maksudnya, proses eksekusi kode ini bakal berjalan satu per satu, langkah demi langkah, tanpa ada tugas yang dijalankan secara bersamaan atau paralel.

Jadi, di kode itu, kita punya fungsi `sqrt_array` yang mengambil array `A` sebagai input. Kita bikin array baru yang punya ukuran dan tipe data yang sama dengan `A`, yaitu array `B`. Terus, kita loopin setiap elemen di `A` pake `eachindex(A)`, dan untuk setiap elemen tersebut, kita hitung akar kuadratnya dan simpen hasilnya di elemen yang sesuai di array `B`.

Nah, yang penting di sini adalah bahwa proses looping dan perhitungan akar kuadratnya dilakukan secara berurutan, elemen per elemen. Jadi, kita mulai dari elemen pertama di `A`, hitung akarnya, simpen di elemen pertama di `B`, terus lanjut ke elemen kedua, dan seterusnya sampai elemen terakhir.

Baru setelah semua elemen selesai diproses, baru kita kembalikan array `B` yang berisi hasil akar kuadrat dari setiap elemen di `A`.

Jadi, intinya, proses eksekusi kode ini dilakukan satu per satu secara berurutan. Tugas-tugasnya gak dijalankan bersamaan atau paralel.
"""

# ╔═╡ 132ae45b-7d0b-420e-af1d-69fbf1230287
md"""
## Thread
"""

# ╔═╡ c350936c-f10a-4009-975d-2751c3702ec8
function threaded_sqrt_array(A)
	B = similar(A)
	@threads for i in eachindex(A)
		B[i] = sqrt(A[i])
	end
	return B
end

# ╔═╡ 6bb911d3-6c28-4726-9b3f-04b984f4d2cf
md"""
!!! note

	Fungsi `threaded_sqrt_array` beda dengan fungsi `sqrt_array`. Fungsi yang baru itu pake trik multi-threading yang ada di Julia.

	Jadi, dalam kode `threaded_sqrt_array`, kita punya fungsi yang ambil input array `A`. Terus, kita bikin array baru `B` yang ukurannya sama dengan `A`.

	Nah, yang beda tuh, kita pake `@threads` sebelum looping `for`. Itu trik buat pake multi-threading, bro! Jadi, loopingnya bakal dijalankan paralel di beberapa thread yang ada.

	Misalnya, kita punya 4 thread yang bisa dipake. Nah, loopingnya bakal dibagi-bagi jadi 4 bagian, dan setiap thread akan jalanin satu bagian itu sekaligus. Jadi, tiap thread bakal ngitung akar kuadrat dari elemen-elemen yang ada di bagian yang mereka tangani.

	Dengan pake multi-threading, kita bisa manfaatin kemampuan prosesor yang punya beberapa inti buat jalanin tugas-tugas ini sekaligus. Jadi, programnya jadi lebih cepet, terutama kalo elemen-elemennya banyak banget.

	Jadi, perbedaannya pokoknya di cara looping dan ngitung akar kuadratnya. Kode yang pertama jalaninnya serial, satu per satu, sedangkan yang kedua pake multi-threading buat parallel computing.
"""

# ╔═╡ 24caac5b-548f-44e1-9bc9-bdb6f7e914fe
@btime sqrt_array(A)

# ╔═╡ 8ed8c0ba-4b61-4ecc-9a07-e92388af133e
@btime threaded_sqrt_array(A)

# ╔═╡ 8ec5c02a-03fa-435b-b2a7-afa47154b648
sqrt_array(A) ≈ threaded_sqrt_array(A)

# ╔═╡ 54ddf3a5-a590-42ba-86a6-e4e78c5c94c2
md"""
Secara umum, waktu pemrosesan fungsi yang pake multithread bakal lebih cepet daripada yang serial. Akurasinyapun tinggi.
"""

# ╔═╡ 07a66f53-ddef-4c8b-b8b4-dcec79ffe85b
md"""
### Evaluasi:
mana sih yang cocok dilakukan multithreading?\
Kalo datanya kecil, mending jangan pake MT.\
Kalo datanya banyak, meding pake MT.\
Tambahan:
"""

# ╔═╡ 0b09bdf6-6b6d-428f-abd5-6d7fc4d1e6ea
md"""
!!! answer

	Jadi, multithreading itu cocok banget buat situasi-situasi kayak gini:

	1. **Tugas yang independen**: Multithreading bagus dipake kalo ada tugas-tugas yang gak bergantung satu sama lain dan bisa jalan sendiri-sendiri. Jadi, bisa dibagi-bagi ke thread-thread yang berbeda buat jalanin tugas-tugas itu secara paralel. Misalnya, kalo lo punya tugas matematika yang berat buat diitung di setiap elemen dalam array, atau ada tugas pengolahan data yang bisa dipisah-pisah.

	2. **Banyak I/O**: Kalo programnya banyak melibatkan operasi I/O, kayak baca tulis file, komunikasi jaringan, atau interaksi sama pengguna, multithreading berguna banget. Jadi, satu thread bisa tangani operasi I/O sementara thread lainnya tetep jalanin tugas komputasi. Jadi, programnya bisa lebih efisien, karena thread yang tangani I/O gak harus nunggu selesai, tapi bisa jalanin tugas lain.

	3. **Respon Cepet ke Input**: Kalo programnya harus cepet merespon input pengguna atau kejadian yang terjadi, multithreading bisa bantu. Misalnya, di aplikasi GUI, bisa pake satu thread buat tangani interaksi sama pengguna, sementara thread lainnya jalanin tugas komputasi di belakang layar. Jadi, programnya tetep bisa respon ke input pengguna tanpa terblokir oleh tugas yang memakan waktu lama.

	4. **Pemanfaatan Sumber Daya Paralel**: Kalo sistemnya punya sumber daya paralel yang banyak, kayak CPU dengan banyak core atau GPU, multithreading bisa dimanfaatin buat maksimalkan penggunaan sumber daya itu. Thread-thread yang berbeda bisa jalanin tugas-tugas secara paralel, pake inti prosesor yang ada biar jadi lebih cepet.

	Tapi inget ya, multithreading juga perlu diperhatiin dan direncanain dengan baik. Jangan sampe ada masalah kayak race condition atau deadlock, jadi perlu perhatiin soal sinkronisasi dan penguncian datanya.
"""

# ╔═╡ 0024ccfc-337e-4b8b-8318-8ef145e2e355
md"""
## Distributed Computing
"""

# ╔═╡ 5b80a001-6e27-4264-a219-6bbaff138d98
md"""
> julia -p 8
"""

# ╔═╡ 50b519cd-a6b4-417c-b689-2e462dd12506
myid()

# ╔═╡ 48415439-c270-45e8-8133-ff92fce70fd1
md"""
### Apa itu Distributed Computing?
"""

# ╔═╡ 601b1b71-effd-4ebb-a40f-c8477b1686bd
md"""
Distributed computing itu kaya kerja tim yang terpisah tapi tetep bisa kerja barengan. Jadi, dalam distributed computing, kita punya beberapa komputer atau server yang bisa kerja secara independen tapi tetep bisa saling bekerja sama.

Misalnya, kita punya tugas komputasi yang berat banget dan butuh waktu lama buat diselesain. Nah, dalam distributed computing, kita bisa bagi tugas itu ke beberapa komputer yang terhubung dalam jaringan. Setiap komputer bakal nangani sebagian tugas itu secara paralel. Jadi, kita bisa selesaiin tugas lebih cepet karena kerja barengan.

Komunikasinya juga penting dalam distributed computing. Komputer-komputer ini harus bisa ngobrol dan berbagi data supaya bisa kerja barengan. Biasanya pake protokol dan algoritma khusus buat ngatur komunikasi dan sinkronisasi antara komputer-komputer ini.

Keuntungannya adalah meningkatkan kecepatan dan efisiensi dalam menyelesaikan tugas yang berat. Tugas yang dulu butuh waktu lama bisa diselesain lebih cepet karena ada banyak komputer yang kerja barengan.

Tapi tentunya, distributed computing juga ada tantangan tersendiri. Misalnya, kalo komputer-komputer ini punya koneksinya lemah atau tiba-tiba mati, bisa jadi ada masalah dan tugas gak selesai. Jadi, perlu perencanaan yang matang dan manajemen yang baik buat ngatur distributed computing ini.

Pokoknya, distributed computing itu kaya kerja barengan tapi terpisah, supaya tugas yang berat bisa diselesain lebih cepet.
"""

# ╔═╡ cd59ff99-c8e8-4737-ba36-e0ec7f62ae6f
md"""
### Apa Bedanya Distributed Computing dengan Multithreading?
Multithreading itu kayak tim kecil dalam satu komputer yang bisa jalanin tugas-tugas sendiri secara paralel. Jadi, dalam satu komputer, ada beberapa thread yang bekerja bersamaan buat mempercepat eksekusi program. Misalnya, dalam program yang kompleks, kita bisa bagi-bagi tugas ke beberapa thread yang jalan barengan di komputer yang sama.

Sedangkan distributed computing itu kayak kerja barengan tim yang terpisah tapi tetep bisa bekerja sama. Jadi, kita punya beberapa komputer atau server yang terhubung dalam jaringan, dan setiap komputer itu punya peran dalam menyelesaikan tugas yang kompleks. Misalnya, kita bagi-bagi tugas ke beberapa komputer yang terhubung dalam jaringan, dan mereka bisa bekerja secara independen tapi tetap saling berkomunikasi dan berbagi data.

Jadi, perbedaannya ada di skala dan lingkupnya. Multithreading lebih berfokus pada meningkatkan kinerja di satu komputer dengan memanfaatkan beberapa thread. Sedangkan distributed computing lebih berfokus pada kerja barengan beberapa komputer atau server dalam jaringan untuk menyelesaikan tugas yang lebih besar atau kompleks.

Intinya, multithreading beroperasi di level satu komputer, sementara distributed computing beroperasi di level jaringan dengan melibatkan beberapa komputer yang bekerja secara terpisah tapi tetap bekerja sama.
"""

# ╔═╡ 067a3781-9f28-474e-b280-0fc78a5ae87a
md"""
### Distributed Computing di Julia
Jadi, distributed computing itu tuh jalanin beberapa proses Julia yang punya ruang memori terpisah. Proses-proses ini bisa dijalankan di satu komputer atau di beberapa komputer yang terhubung. Nah, library yang namanya Distributed ini bikin kita bisa jalanin fungsi-fungsi Julia secara remote. Dengan dasar ini, kita bisa bangun berbagai macam abstraksi untuk distributed computing.

Misalnya, ada paket yang namanya DistributedArrays.jl, ini contoh abstraksi yang bisa kita pake. Paket ini memungkinkan kita untuk bekerja dengan array yang didistribusikan di beberapa proses Julia secara otomatis. Jadi, kita bisa ngerjain operasi pada array itu secara paralel dengan proses-proses yang berjalan di komputer-komputer yang berbeda.

Di sisi lain, ada juga paket-paket kayak MPI.jl dan Elemental.jl. Ini paket-paket yang bisa kita pake untuk akses ekosistem library MPI yang udah ada.

Jadi, intinya distributed computing di Julia itu bisa jalanin proses Julia terpisah dengan memori yang terpisah juga. Bisa di satu komputer atau beberapa komputer. Library Distributed di Julia ini memberikan kemampuan buat ngerjain fungsi-fungsi Julia secara remote. Trus, dari situ kita bisa bangun abstraksi-abstraksi lain buat distributed computing. Ada paket-paket keren kayak DistributedArrays.jl, MPI.jl, dan Elemental.jl yang bisa dipake buat kerja barengan di distributed computing.

Mudeng kan? Makin gaul, makin keren!
"""

# ╔═╡ 04ee4cef-3fa6-4ae9-9809-623949212b39
md"""## Serial"""

# ╔═╡ 604e76a9-1633-4207-9aa9-c7303db41be8
function sqrt_sum(A)
	s = zero(eltype(A))
	@inbounds for i in eachindex(A)
		s+=sqrt(A[i])
	end
	return s
end

# ╔═╡ 7485e89f-978f-4830-ba65-cb60444b2f73
md"""
`@inbounds` salah satu cara untuk optimisasi. Macro `@inbounds` itu fungsinya buat mematikan pemeriksaan batas indeks saat akses array di Julia. Biasanya, Julia itu cek dulu indeksnya buat memastikan kita gak akses di luar batas array, karena kalo aksesnya keluar batas, bisa jadi error.

Tapi kalo kita yakin banget kalo akses arraynya gak bakal keluar batas, kita bisa pake `@inbounds` buat ngasih tahu Julia kalo kita udah ngecek sendiri dan kita mau matiin pemeriksaan batas indeksnya. Jadi, Julia gak perlu ngecek lagi dan kita bisa dapetin performa yang lebih baik.

Misalnya, kalo kita yakin banget kalo akses elemen-elemen array gak bakal keluar batas, kita bisa pake `@inbounds` sebelum looping buat ngitung sesuatu di array itu. Dengan begitu, Julia gak perlu ngecek batas indeks tiap iterasi, dan kita dapetin performa yang lebih cepat.

Tapi inget ya, kalo kita pake `@inbounds`, kita harus bener-bener yakin kalo akses arraynya gak bakal keluar batas, karena kalo keluar batas bisa aja jadi error atau menghasilkan nilai yang salah.

Jadi, intinya, macro `@inbounds` di Julia itu buat matiin pemeriksaan batas indeks saat akses array, supaya performanya lebih cepat. Tapi kalo dipake, kita harus yakin banget kalo gak ada akses yang keluar batas.
"""

# ╔═╡ f8c640b2-a28a-4a62-aab3-4b29205897d9
md""" ### Race condition"""

# ╔═╡ 00fbd47d-c0c7-416c-a63f-a192ffde828c
md"""
Race condition itu tuh kondisi yang terjadi saat dua atau lebih thread atau proses berbagi akses ke sumber daya bersama, dan hasil akhir dari eksekusi program jadi tergantung pada urutan atau kecepatan eksekusi thread atau proses tersebut.

Race condition itu kaya lagi adu cepet antar thread atau proses buat ngakses sumber daya yang sama. Misalnya, bayangin dua thread lagi lomba buat ngubah data di suatu variabel. Kalo mereka akses dan ngubah data di variabel itu secara bersamaan atau serentak, tanpa pengaturan yang bener, bisa jadi hasil akhirnya gak sesuai yang kita harapkan.

Contohnya, misal ada variabel `counter` yang awalnya nilainya 0. Terus ada dua thread yang berjalan barengan, dan tugasnya masing-masing nambahin nilai `counter` sebanyak satu. Kalo mereka ngakses dan nambahin nilai `counter` secara bersamaan, tanpa pengamanan yang bener, bisa aja hasil akhirnya gak bener. Misalnya, kalo salah satu thread baru baca nilai `counter` (masih 0), tapi belum sempet nambahin nilainya, trus thread yang lain juga baca nilai `counter` (masih 0), dan baru setelah itu mereka berdua nambahin nilainya, hasilnya jadi 1, padahal mestinya 2.

Ini disebut race condition karena hasil akhirnya jadi "perlombaan" antara thread-thread itu, dan tergantung pada faktor-faktor kayak kecepatan eksekusi, penjadwalan, dan kondisi yang gak terduga. Mau hasilnya bener atau gak, itu jadi "perlombaan" antara thread-thread itu.

Race condition bisa bikin program jadi unpredictable, karena hasil akhirnya bisa berbeda-beda setiap kali program dijalankan. Kalo gak diatasi dengan bener, bisa berakibat bug yang sulit ditemukan dan bisa jadi pengaruh ke kebenaran program kita.

Intinya, race condition itu terjadi kalo ada dua atau lebih thread atau proses yang berbagi akses ke sumber daya bersama, dan hasil akhir dari program jadi tergantung pada urutan atau kecepatan eksekusi thread atau proses itu.
"""

# ╔═╡ d1828b85-cfa9-4caa-9368-274bebf8cae0
function race_sqrt_sum(A)
	s = zero(eltype(A))
	@threads for i in eachindex(A)
		s+=sqrt(A[i])
	end
	return s
end

# ╔═╡ d9a4a664-ee10-4cc8-8e52-925ca8f939a9
race_sqrt_sum(A)

# ╔═╡ 415d41e8-e354-48c7-a128-54cbd69c32d4
sqrt_sum(A)

# ╔═╡ 5dd2739f-a408-44cb-81a1-82ea373a705e
race_sqrt_sum(A) ≈ sqrt_sum(A)

# ╔═╡ 32634589-b91a-4eb9-a6e4-51b7496efb69
md"""
Hasil yang berbeda antara `sqrt_sum(A)` dan `race_sqrt_sum(A)` itu bisa disebabkan oleh race condition yang terjadi di fungsi `race_sqrt_sum(A)` yang menggunakan `@threads`.

Nah, `@threads` itu mengaktifkan multithreading di Julia, yang berarti beberapa thread bisa jalanin looping `for` secara paralel untuk mempercepat eksekusi. Di sini, setiap thread ngebaca nilai `s`, ngitung akar kuadrat dari elemen A, terus nambahin hasilnya ke `s`.

Tapi masalahnya, saat beberapa thread akses dan ngubah nilai `s` secara bersamaan, tanpa pengamanan yang bener, bisa terjadi race condition. Maksudnya, thread-thread itu adu cepet buat akses dan ngubah nilai `s`, dan hasil akhirnya jadi tergantung pada urutan atau kecepatan eksekusi thread-thread tersebut.

Jadi, karena race condition, hasil akhir dari `race_sqrt_sum(A)` bisa berbeda-beda setiap kali dijalankan. Itu sebabnya hasilnya bisa beda dari yang diharapkan. Kemungkinan hasilnya bisa lebih kecil atau lebih besar dari `sqrt_sum(A)` yang hasilnya 666765.7283509015.

Jadi, kesimpulannya, race condition yang terjadi saat beberapa thread akses dan ngubah nilai `s` secara bersamaan di fungsi `race_sqrt_sum(A)` menggunakan `@threads` bisa menyebabkan hasil yang berbeda-beda setiap kali program dijalankan.
"""

# ╔═╡ b3755fae-5677-4882-bf00-c131b45c87cb
md"""
### Gimana caranya supaya gak ngehasilin `Race Condititon`?
1. Jaga Keselarasan Akses ke Sumber Daya Bersama: Pastikan cuma satu thread atau proses yang bisa nyentuh sumber daya bersama. Pake lock, mutex, atau semafora biar cuma satu yang bisa akses sumber daya itu pada satu waktu. Jadi, gak ada konflik yang bisa bikin race condition.

2. Pilih Operasi yang Gak Bisa Dicampuri: Pake operasi yang bisa selesai tanpa digangguin sama thread lain. Operasi ini gak bisa dipecah-pecah dan gak bisa diintervensi sama thread lain. Misalnya, operasi penambahan dan pengurangan atomik di Julia bisa jadi pilihan buat operasi yang gak kena race condition.

3. Hindari Saling Ngubah Data: Kalo bisa, hindari data yang bisa diubah-ubah sama beberapa thread secara bersamaan. Kalo tiap thread punya data yang terpisah dan gak saling interaksi, peluang race condition bisa kecil.

4. Pake Struktur Data yang Aman Buat Thread: Pilih struktur data yang udah dirancang khusus buat multithreading dan udah ada mekanisme sinkronisasi yang tepat. Misalnya, di Julia ada tipe data `Threads.Atomic` yang aman buat ngindarin race condition waktu operasi-modifikasi data bersama.

5. Jangan Lupa Urus Pengaturan Jadwal: Perhatiin juga cara jadwalin thread atau prosesnya. Pilih algoritma pengaturan jadwal yang pas buat kurangi risiko race condition. Pengaturan jadwal yang jelek bisa bikin akses bersama gak terkoordinasi dan jadi bikin race condition lebih mungkin terjadi.

6. Desain Program yang Aman: Bikin desain program yang baik juga bisa bantu ngindarin race condition. Hindari ketergantungan antara thread, jangan ubah data bersama langsung, dan pisahin data yang harus diakses sama beberapa thread.

Dengan cara ini, kita bisa ngindarin atau minimalisir kemungkinan terjadi race condition dalam program multithreading kita.
"""

# ╔═╡ 1165df8c-33c1-4d86-931c-63e2efcc0c2a
md""" ### Atomic"""

# ╔═╡ aa5c4e32-df0a-4daa-9696-620521091708
function threaded_sqrt_sum_atomic(A)
	s = Atomic{eltype(A)}(zero(eltype(A)))
	@threads for i in eachindex(A)
		atomic_add!(s, sqrt(A[i]))
	end
	return s[]
end

# ╔═╡ e41df968-2abc-44f7-9a77-e8ca40079c9d
md"""
Nah, "atomic" dalam konteks kode di atas mengacu pada operasi yang dapat dilakukan secara atomik atau tak terpisahkan. Ini berarti operasi tersebut akan dieksekusi secara utuh dan tidak dapat diinterupsi oleh thread lain. 

Dalam fungsi `threaded_sqrt_sum_atomic`, kita menggunakan jenis data `Atomic` yang diberikan oleh Julia. `Atomic` digunakan untuk membuat variabel yang bisa diakses secara atomik oleh beberapa thread. Dalam contoh ini, kita membuat variabel `s` dengan tipe `Atomic{eltype(A)}`. `eltype(A)` digunakan untuk mendapatkan tipe elemen dari array `A`.

Pada bagian `@threads for i in eachindex(A)`, kita mengulangi proses untuk setiap elemen dalam array `A` menggunakan thread-thread yang tersedia. Namun, perhatikan bahwa kita menggunakan fungsi `atomic_add!` untuk menambahkan nilai hasil akar kuadrat dari setiap elemen ke variabel `s` secara atomik. Fungsi `atomic_add!` memastikan bahwa operasi penambahan tersebut tidak akan terjadi secara bersamaan oleh beberapa thread dan menghindari potensi race condition.

Dengan menggunakan operasi atomik seperti ini, kita dapat memastikan bahwa akses dan perubahan pada variabel `s` dilakukan secara aman oleh thread-thread yang berjalan secara paralel. Akhirnya, kita mengembalikan nilai dari `s` dengan menggunakan `s[]`.

Intinya, dalam konteks ini, "atomic" berarti bahwa operasi yang dilakukan pada variabel `s` dilakukan dengan cara yang aman dan tak terpisahkan oleh thread-thread yang sedang berjalan.
"""

# ╔═╡ 12b47ab7-acb3-4d44-80f9-b9ff4e60325a
threaded_sqrt_sum_atomic(A)

# ╔═╡ 063a2de5-d07b-469a-9b3e-6ad451717304
threaded_sqrt_sum_atomic(A) ≈ sqrt_sum(A)

# ╔═╡ 02019587-9350-4c37-83d4-d57a212bece5
md"""### Perbandingan Akurasi dan Kecepatan"""

# ╔═╡ 33fb9fee-371a-4d38-859a-bc47a076d89e
md"""
Anggaplah nilai dari sqrt_sum(A) sebagai acuan.
"""

# ╔═╡ 4bf3bdbb-6eb7-4fc8-8d50-08b380c6956c
@btime sqrt_sum(A)

# ╔═╡ 3012d687-01b3-46e6-b029-18097cba5a4c
@btime race_sqrt_sum(A)

# ╔═╡ 9bc46d42-89ce-48fd-a9cb-a6c4991711ef
@btime threaded_sqrt_sum_atomic(A)

# ╔═╡ f25c5340-df73-46b6-ae73-d52b60d21754
md"""
Serial: cepat dan benar.\
Threads yg race condition: udah lama, salah lagi.\
Atomic threads: cepat dan benar. Tergantung jumlah thread.
"""

# ╔═╡ e43737f7-6a1d-422e-87eb-5215ea68dd05
md"""
Berdasarkan urutan kecepatan eksekusi, secara umum, urutan dari yang tercepat hingga yang paling lambat akan sebagai berikut:

1. `threaded_sqrt_sum_atomic`: Fungsi ini menggunakan pendekatan multithreading dengan operasi atomik, yang memungkinkan thread-thread untuk bekerja secara paralel tanpa adanya race condition. Karena itu, ini bisa menjadi yang paling cepat di antara ketiga fungsi ini.

2. `sqrt_sum`: Fungsi ini melakukan perhitungan secara serial, artinya setiap elemen dari array `A` diakses dan dihitung secara berurutan. Karena tidak ada paralelisasi atau multithreading, ini akan lebih lambat dibandingkan dengan pendekatan multithreading.

3. `race_sqrt_sum`: Fungsi ini menggunakan pendekatan multithreading tanpa melibatkan operasi atomik atau sinkronisasi. Karena tidak ada perlindungan terhadap race condition, kemungkinan terjadinya race condition akan lebih tinggi. Ini bisa menyebabkan ketidakpastian dan hasil yang tidak konsisten. Dalam hal ini, performa fungsi ini bisa lebih rendah dibandingkan dengan yang lain karena perlu mengatasi masalah race condition.

Namun, penting untuk diingat bahwa faktor-faktor seperti ukuran array `A`, jumlah thread yang tersedia, dan karakteristik sistem komputasi dapat mempengaruhi kecepatan eksekusi. Selain itu, kecepatan relatif antara fungsi-fungsi ini dapat berbeda-beda tergantung pada konteks dan lingkungan penggunaan spesifik. Jadi, sebaiknya melakukan pengujian kinerja yang lebih terperinci untuk mendapatkan pemahaman yang lebih akurat tentang urutan kecepatan eksekusi dalam kasus-kasus yang spesifik.
"""

# ╔═╡ c12f3128-6d75-455a-8773-68732e54a983
md"""
Dalam konteks umum, fungsi `sqrt_sum` yang melakukan perhitungan secara serial tidak akan lebih cepat dari `threaded_sqrt_sum_atomic` yang menggunakan pendekatan multithreading dengan operasi atomik. Pendekatan multithreading memungkinkan beberapa thread bekerja secara paralel, memanfaatkan kekuatan pemrosesan paralel dari sistem komputer.

Namun, ada beberapa faktor yang dapat mempengaruhi performa relatif antara kedua fungsi tersebut. Jika array `A` memiliki ukuran yang sangat kecil atau jika sistem komputer memiliki jumlah thread yang terbatas, maka overhead yang terkait dengan multithreading dan sinkronisasi dapat membuat `threaded_sqrt_sum_atomic` menjadi lebih lambat daripada `sqrt_sum` yang melakukan perhitungan secara serial.

Selain itu, karakteristik sistem komputer seperti arsitektur prosesor, cache, dan faktor-faktor lainnya juga dapat mempengaruhi performa relatif antara kedua fungsi tersebut.

Dalam kondisi umum dengan ukuran array yang signifikan dan jumlah thread yang memadai, fungsi `threaded_sqrt_sum_atomic` cenderung lebih cepat karena memanfaatkan paralelisme dan operasi atomik untuk menghindari race condition dan sinkronisasi yang berlebihan.
"""

# ╔═╡ 4ef3264b-1b7c-42be-9600-0e057e0c5789
md"""
# Laplace Toy Problem
Kita akan bahas masalah numerik yang keren nih. Kita bakal bahas tentang operator Laplace yang di-diskritisasi. Ini sering banget dipake dalam banyak aplikasi, kayak analisis numerik, masalah fisika, pengolahan gambar, dan bahkan machine learning. Kita akan bahas versi dua dimensinya yang sederhana dengan formula finite difference.

Jadi, rumusnya tuh kaya gini:

$$u_{\text{out}}(i, j) = 0.25 \left[ u(i-1, j) + u(i+1, j) + u(i, j-1) + u(i, j+1) \right]$$

Dalam Julia, kita bisa buat:
"""

# ╔═╡ 231b2af3-1738-43eb-880c-520d959a418f
function lap2d!(u, unew)
	M,N = size(u)
	for j in 2:N-1
		for i in 2:M-1
			@inbounds unew[i,j]=0.25*(u[i-1,j]+u[i+1,j]+u[i,j-1]+u[i,j+1])
		end
	end
end

# ╔═╡ 684d5c57-cd81-4a86-8e0c-b0aadc0fa67a
md"""
Kita bakal ikutin konvensi di Julia nih. Biasanya, fungsi yang mengubah argumen-argumennya bakal ditambahin tanda seru (!) di belakangnya.

Sekarang, kita mulai dengan menginisialisasi dua array floating point 64-bit, yaitu u dan unew. Terus, kita set nilai batasannya jadi 10.0 aja, biar ada sesuatu yang menarik buat disimulasikan.
"""

# ╔═╡ 39bc533d-8465-4525-a55b-d4d654cf00e4
begin
	M = 256
	N = 256
	u = zeros(M,N)
	#set boundary conditions
	u[1,:] = u[end,:] = u[:,1] = u[:,end] .= 10.0
	unew = copy(u)
end

# ╔═╡ d191e4ac-9b76-4d0c-b8c2-6e8d09afc59d
md"""
Buat mensimulasikan sesuatu yang mirip dengan evolusi suhu dalam penghantar panas 2D (walaupun kita mengabaikan konstanta fisik dan langkah waktu yang terlibat dalam menyelesaikan persamaan panas), kita bisa jalankan perulangan sebanyak 50.000 "langkah waktu" dan visualisasikan hasilnya pake metode heatmap dari package Plots.
"""

# ╔═╡ b63144a6-dbee-4726-bf22-0e256ee4566b
maximum_iteration = 500

# ╔═╡ ab94d0bc-563f-48b6-ae0b-17dc9810f515
u

# ╔═╡ fab06f18-63a3-46cf-9053-64a9ed96051b
for i in 1:maximum_iteration
	lap2d!(u, unew)
	# copy new computed field to old array
	u = copy(unew)
end

# ╔═╡ 9ee89cd4-1f7f-47c6-89ba-9c8697daa9b5
unew

# ╔═╡ e9242cd0-5986-434b-8173-0c316db782e0
heatmap(unew,xlabel="X",ylabel="Y")

# ╔═╡ 66116501-3435-40e4-b786-4d10ba9a65e9
@btime lap2d!(u, unew)

# ╔═╡ 6616e58e-40e5-4889-8a6e-bd36b014a69d
md"""
# Exercise
0. apakah bisa multithreading? apakaha ada risiko race condition? caranya dengan mengecek pada kode kita. apakah ada thread yang sama mengakses
1. Implementasikan mt pada fungsi yang tadi (lap2d), analisis hasilnya: jalanakan dengan thread yg berbeda, inspeksi scallingnya (penggunaan processornya)
2. Besarkan nilai N=512, 2048, 4096, 8192
"""

# ╔═╡ cc47bebf-9559-459a-8115-df74b6a747ae
md""" Jawaban bisa dicek di link [ini.](https://ajamj.github.io/pkg-homework/notebooks/05_Tugas%203_Laplace%20Toy%20Problem.html) """

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
Distributed = "8ba89e20-285c-5b6f-9357-94700520ee1b"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
BenchmarkTools = "~1.3.2"
Plots = "~1.38.12"
PlutoUI = "~0.7.51"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.1"
manifest_format = "2.0"
project_hash = "a4072104f9eff9203ee813c52da6164f43437fcf"

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

[[deps.BitFlags]]
git-tree-sha1 = "43b1a4a8f797c1cddadf60499a8a077d4af2cd2d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.7"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

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

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "96d823b94ba8d187a6d8f0826e731195a74b90e9"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.2.0"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

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

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

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

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

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

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "d972031d28c8c8d9d7b41a536ad7bb0c2579caca"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.8+0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "d014972cd6f5afb1f8cd7adf000b7a966d62c304"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.72.5"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "f670f269909a9114df1380cc0fcaa316fff655fb"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.72.5+0"

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

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

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

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

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

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6f2675ef130a300a112286de91973805fcc5ffbc"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.91+0"

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

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "42324d08725e200c23d4dfb549e0d5d89dede2d2"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.10"

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

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "f66bdc5de519e8f8ae43bdc598782d35a25b1272"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.1.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.10.11"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.21+4"

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
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "d03ef538114b38f89d66776f2d8fdc0280f90621"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.38.12"

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

[[deps.Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "0c03844e2231e12fda4d0086fd7cbe4098ee8dc5"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+2"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

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

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "30449ee12237627992a99d5e30ae63e4d78cd24a"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

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

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

    [deps.SpecialFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"

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
git-tree-sha1 = "d1bf48bfcc554a3761a133fe3a9bb01488e06916"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.21"

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

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

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
version = "5.8.0+0"

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
# ╟─5368d8a0-fab8-11ed-0e1c-5736fd7e3344
# ╠═be3f54f4-be4e-41a4-a2bf-a24ffa464404
# ╠═9aabe96c-6f3f-49c6-a06a-b2ac0071daf7
# ╠═b936f1bc-687e-476a-8823-90317b1ffb49
# ╟─730b3add-28f8-4d4c-a430-2f1018dedd91
# ╠═80e8cc2f-008c-4446-b530-3af3def0cc37
# ╠═f4de5557-3649-4911-957b-d188fe64a242
# ╠═9b0cef71-aa0b-42e7-af98-5d7ec42dc8c3
# ╟─d3eacacb-3dbe-43ca-aa23-30924e8db7b1
# ╠═ceba284f-0eca-4c82-894c-450bb48b1839
# ╟─18e62923-7ec0-47fd-9093-bb052ed25af5
# ╠═15451455-012d-4bc1-89dd-fee56d5e4046
# ╠═f8f3ce58-cb6d-47ba-91f0-013dc918e44b
# ╠═c6d357ac-ded2-40e9-b3a7-327a61389622
# ╟─15cf2b4e-8605-4f50-a66c-fdb406a14258
# ╟─132ae45b-7d0b-420e-af1d-69fbf1230287
# ╠═c350936c-f10a-4009-975d-2751c3702ec8
# ╟─6bb911d3-6c28-4726-9b3f-04b984f4d2cf
# ╠═c38812a6-73e4-4223-93bc-0e246c54ff3a
# ╠═24caac5b-548f-44e1-9bc9-bdb6f7e914fe
# ╠═8ed8c0ba-4b61-4ecc-9a07-e92388af133e
# ╠═8ec5c02a-03fa-435b-b2a7-afa47154b648
# ╟─54ddf3a5-a590-42ba-86a6-e4e78c5c94c2
# ╟─07a66f53-ddef-4c8b-b8b4-dcec79ffe85b
# ╟─0b09bdf6-6b6d-428f-abd5-6d7fc4d1e6ea
# ╟─0024ccfc-337e-4b8b-8318-8ef145e2e355
# ╠═a4c66e59-ba4e-4c0c-b397-eecfed910b3f
# ╟─5b80a001-6e27-4264-a219-6bbaff138d98
# ╠═50b519cd-a6b4-417c-b689-2e462dd12506
# ╟─48415439-c270-45e8-8133-ff92fce70fd1
# ╟─601b1b71-effd-4ebb-a40f-c8477b1686bd
# ╟─cd59ff99-c8e8-4737-ba36-e0ec7f62ae6f
# ╟─067a3781-9f28-474e-b280-0fc78a5ae87a
# ╟─04ee4cef-3fa6-4ae9-9809-623949212b39
# ╠═604e76a9-1633-4207-9aa9-c7303db41be8
# ╟─7485e89f-978f-4830-ba65-cb60444b2f73
# ╟─f8c640b2-a28a-4a62-aab3-4b29205897d9
# ╟─00fbd47d-c0c7-416c-a63f-a192ffde828c
# ╠═d1828b85-cfa9-4caa-9368-274bebf8cae0
# ╠═d9a4a664-ee10-4cc8-8e52-925ca8f939a9
# ╠═415d41e8-e354-48c7-a128-54cbd69c32d4
# ╠═5dd2739f-a408-44cb-81a1-82ea373a705e
# ╟─32634589-b91a-4eb9-a6e4-51b7496efb69
# ╟─b3755fae-5677-4882-bf00-c131b45c87cb
# ╟─1165df8c-33c1-4d86-931c-63e2efcc0c2a
# ╠═aa5c4e32-df0a-4daa-9696-620521091708
# ╟─e41df968-2abc-44f7-9a77-e8ca40079c9d
# ╠═12b47ab7-acb3-4d44-80f9-b9ff4e60325a
# ╠═063a2de5-d07b-469a-9b3e-6ad451717304
# ╟─02019587-9350-4c37-83d4-d57a212bece5
# ╟─33fb9fee-371a-4d38-859a-bc47a076d89e
# ╠═4bf3bdbb-6eb7-4fc8-8d50-08b380c6956c
# ╠═3012d687-01b3-46e6-b029-18097cba5a4c
# ╠═9bc46d42-89ce-48fd-a9cb-a6c4991711ef
# ╟─f25c5340-df73-46b6-ae73-d52b60d21754
# ╟─e43737f7-6a1d-422e-87eb-5215ea68dd05
# ╟─c12f3128-6d75-455a-8773-68732e54a983
# ╟─4ef3264b-1b7c-42be-9600-0e057e0c5789
# ╠═231b2af3-1738-43eb-880c-520d959a418f
# ╟─684d5c57-cd81-4a86-8e0c-b0aadc0fa67a
# ╠═39bc533d-8465-4525-a55b-d4d654cf00e4
# ╟─d191e4ac-9b76-4d0c-b8c2-6e8d09afc59d
# ╠═b63144a6-dbee-4726-bf22-0e256ee4566b
# ╠═ab94d0bc-563f-48b6-ae0b-17dc9810f515
# ╠═fab06f18-63a3-46cf-9053-64a9ed96051b
# ╠═9ee89cd4-1f7f-47c6-89ba-9c8697daa9b5
# ╠═e9242cd0-5986-434b-8173-0c316db782e0
# ╠═66116501-3435-40e4-b786-4d10ba9a65e9
# ╟─6616e58e-40e5-4889-8a6e-bd36b014a69d
# ╟─cc47bebf-9559-459a-8115-df74b6a747ae
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
