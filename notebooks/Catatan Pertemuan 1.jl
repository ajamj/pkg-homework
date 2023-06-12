### A Pluto.jl notebook ###
# v0.19.26

using Markdown
using InteractiveUtils

# ╔═╡ 445152e2-aa3f-4544-8cd9-da18a186df81
using PlutoUI

# ╔═╡ c7d13ff0-08bb-11ee-19ed-411e0be3b771
md"""
# Catatan Pertemuan 1 Pasca UTS: Julia, Instalasi, dan Sintaks Dasar
"""

# ╔═╡ 7f39a629-ca6a-47eb-b749-559612c19ebc
TableOfContents()

# ╔═╡ f42b2488-ee94-4822-a23b-96ca4e63ab67
md"""
## Outline
+ *Overview: Julia in a Nutshell*
+ *Why Julia?*
+ Instalasi
+ Sintaks Dasar
+ Struktur Kontrol
+ Fungsi
"""

# ╔═╡ edd71197-1e00-4d2e-a421-29180298d9e7
md"""## *Overview: Julia in a Nutshell*
[![](https://mermaid.ink/img/pako:eNp1U8Fu2zAM_RVCvbiAk9lO7Do-DGibthiwIsXW05CLYssJYVkSJHmrl-bfR8dpukssGKD4yMcnUtqzUleCFWxrudnB63KtgL7b4JE7fw2Tydf3JVquSq620CnfNWCErbVtOXhU2y2-w11wr1uDUlTgNYi6xhKF8qC4x98ChgLXI-19sOwVb7EcmV_RCKi451Dh4Ha0UVB1Tae2ZKDywvLGY001RoJl8EMYq6uuxI0UI8t3knHK6AeVG3QDoR0DG4fn7IejUO34Ofe5kx6NJBXoDPfl7qjAaMnpmK3V1JWWHKvVyxGoqYxDrbg8cz4GT0KRTHlq1of4sVffvqyAu16VO6uV7lwIrfDcjMQtCQ-hknJ6ZnsKVkYocLqz5Unii9W9aEB_-kOQYoODVIsQT6MogkYrb3HTeW2PXCOb8z0d7RZqlLK4ypPNzXzzP3J_EVleRB4uIo8XkaeLyN0JqRfDCp23uhHFVZZlJ3vyByu_KxLz9uGouNtxa3lfQBpCulYsZK2g-4gVXeP9wL5mfidasWYFmZWoOU15zdbqQKGcevSTBsIKbzsRss7QBRRL5MNEWFFz6cgrKqRWPo9P4_hCQma4-qX1ZwztWbFnb6xIoulNHs_imzxa5PRn85D15I6TabzIZlESpbMsTZPkELK_R4poukjzPMnmUZzP5nGWp4d_8Rkkdg?type=png)](https://mermaid.live/edit#pako:eNp1U8Fu2zAM_RVCvbiAk9lO7Do-DGibthiwIsXW05CLYssJYVkSJHmrl-bfR8dpukssGKD4yMcnUtqzUleCFWxrudnB63KtgL7b4JE7fw2Tydf3JVquSq620CnfNWCErbVtOXhU2y2-w11wr1uDUlTgNYi6xhKF8qC4x98ChgLXI-19sOwVb7EcmV_RCKi451Dh4Ha0UVB1Tae2ZKDywvLGY001RoJl8EMYq6uuxI0UI8t3knHK6AeVG3QDoR0DG4fn7IejUO34Ofe5kx6NJBXoDPfl7qjAaMnpmK3V1JWWHKvVyxGoqYxDrbg8cz4GT0KRTHlq1of4sVffvqyAu16VO6uV7lwIrfDcjMQtCQ-hknJ6ZnsKVkYocLqz5Unii9W9aEB_-kOQYoODVIsQT6MogkYrb3HTeW2PXCOb8z0d7RZqlLK4ypPNzXzzP3J_EVleRB4uIo8XkaeLyN0JqRfDCp23uhHFVZZlJ3vyByu_KxLz9uGouNtxa3lfQBpCulYsZK2g-4gVXeP9wL5mfidasWYFmZWoOU15zdbqQKGcevSTBsIKbzsRss7QBRRL5MNEWFFz6cgrKqRWPo9P4_hCQma4-qX1ZwztWbFnb6xIoulNHs_imzxa5PRn85D15I6TabzIZlESpbMsTZPkELK_R4poukjzPMnmUZzP5nGWp4d_8Rkkdg)

### 1. *Fast*
Julia memang dirancang dari awal untuk performa yang tinggi. Program-program Julia dikompilasi menjadi kode native yang efisien untuk berbagai platform melalui LLVM. Mantap dah!

### 2. *Dynamic*
Julia tuh keren banget, tipe datanya dinamis. Kita ga perlu repot deklarasiin tipe data variabel. Bisa langsung pake berbagai jenis tipe data dalam satu fungsi atau operasi tanpa ribet konversi tipe data. Lebih fleksibel dan kode jadi cepat!

### 3. *Reproducible*
Reproducible di Julia itu top banget! Kita bisa bikin lingkungan Julia yang sama tiap kali kita jalankan, di berbagai platform, dengan binary yang udah ada. Hasil kode jadi konsisten dan kolaborasi jadi lebih gampang. Stabil dan konsisten, mantap deh!

### 4. *Composable*
Julia pake *multiple dispatch* sebagai paradigma, jadi gampang banget buat ngungkapin pola pemrograman berorientasi objek dan fungsional. Dengan *multiple dispatch*, kita bisa bikin banyak versi fungsi yang berbeda tergantung dari tipe data yang kita pake. Keren kan? Jadi, kita bisa ngatur berbagai aksi berdasarkan jenis data yang kita lempar ke fungsi itu.

Ini bikin kode Julia jadi lebih ekspresif dan mudah diubah-ubah. Kita bisa bikin kode yang *reusable*, nggak perlu nulis ulang buat kasus yang mirip tapi beda tipe data.

Jadi, *Composable* di Julia itu bikin kode jadi lebih modular, reusable, dan gampang diubah-ubah. Gampang banget buat ngungkapin pola pemrograman yang berbeda-beda!

### 5. *General*
Julia punya dukungan buat I/O asynchronous, metaprogramming, debugging, logging, profiling, package manager, dan masih banyak lagi. Bisa banget deh bangun Aplikasi dan Microservices lengkap pakai Julia. Makin seru!

### 6. *Open source*
Julia itu proyek open source dengan lebih dari 1.000 kontributor. Kodenya tersedia di GitHub dan menggunakan lisensi MIT. Asyik banget kan?
"""

# ╔═╡ 047b66fd-e76c-4d4f-aee3-acd6379b04fd
md"""
## *Why Julia?*
[![](https://mermaid.ink/img/pako:eNqdkltr4zAQRv-KUF92wQm2fImih13aJhQWFgotFBr3YRzJtrAtGUlm403z36vE6QX6FgnBaDhnEOjb463mAjNcGehr9LjKFfLrenMHXQ-qQlxWg4IG1AuazX69Rq_o5sdTPaI_Qyvh988Jv93cC1Nq0wFyUlWVnGDi4QlYbR5G5WCHylY0VhaiRRwU8nVvhJXlxMcf_HqzbrSV1onuBDa6G5R0YNF4fFQhTCO6wpeTmJzESbVubAW6RqVsW3ZFSbFIisA6oxvBrtKCbqPyfJ39k9zVjPS7r-btxebqYnN9sXlzNsvlcX-YWZZ9094bHGwNxsDIUBqgNFc4wJ3wfye5z8H-OD3HrhadyDHzJRclDK3Lca4OHoXBaf-ZW8ycGUSAh56DEysJPkEdZiW01ncFl06bv1O2ThELsM_Ts9afjL9jtsc7zEg4X9AojhY0XFJ_siTAo29HZB4tszgkYRpnaUrIIcD_TyPC-TKllGRJGNE4iTKaHt4AwS_kPg?type=png)](https://mermaid.live/edit#pako:eNqdkltr4zAQRv-KUF92wQm2fImih13aJhQWFgotFBr3YRzJtrAtGUlm403z36vE6QX6FgnBaDhnEOjb463mAjNcGehr9LjKFfLrenMHXQ-qQlxWg4IG1AuazX69Rq_o5sdTPaI_Qyvh988Jv93cC1Nq0wFyUlWVnGDi4QlYbR5G5WCHylY0VhaiRRwU8nVvhJXlxMcf_HqzbrSV1onuBDa6G5R0YNF4fFQhTCO6wpeTmJzESbVubAW6RqVsW3ZFSbFIisA6oxvBrtKCbqPyfJ39k9zVjPS7r-btxebqYnN9sXlzNsvlcX-YWZZ9094bHGwNxsDIUBqgNFc4wJ3wfye5z8H-OD3HrhadyDHzJRclDK3Lca4OHoXBaf-ZW8ycGUSAh56DEysJPkEdZiW01ncFl06bv1O2ThELsM_Ts9afjL9jtsc7zEg4X9AojhY0XFJ_siTAo29HZB4tszgkYRpnaUrIIcD_TyPC-TKllGRJGNE4iTKaHt4AwS_kPg)
### 1. Gampang digunain
Julia tuh enak banget buat digunakan. Antar mukanya nyaman, bahasanya juga ga bikin ribet. Praktis deh!

### 2. Performa tinggi
Julia tuh jagoan banget dalam performa. Bisa ngehasilin kode yang berjalan cepat dan efisien. Ga heran kalo disebut-sebut sebagai bahasa yang cepat!

### 3. Sintaks fleksibel dan ekspresif
Sintaks di Julia tuh fleksibel banget. Bisa dengan mudah ngungkapin gagasan dan konsep-konsep dalam kode. Serasa kayak lagi ngobrol pake bahasa manusia!

### 4. Ekosistem dan komunitas yang berkembang
Ekosistem Julia terus berkembang dan komunitasnya juga makin besar. Banyak banget library dan alat bantu yang bisa dimanfaatkan. Dukungan dan kolaborasi yang keren banget deh!
"""

# ╔═╡ 0fa9a8eb-28d0-4d02-9ec6-8218952e7757
md"""
## Fitur Kunci Julia
[![](https://mermaid.ink/img/pako:eNqdksFu4yAQQH8FzV4ayY6MYxObw0pNUkvNKntJT617QDZO0GJAGLpNo_x7SaOm2VVPgQsD896MxOyh0S0HChvLzBY9LGqFwrp9qmHpBxcLFTvRc3SzvH8YoUb3RkjmhFY1PKM4_omqm0o4b9EvrxqBll4KNjo5ZsGx8tIJIzlqxWCYa7Zn7JQzf1pxx4zVoXzfC7X553URDL9DtReODLNMSi7F0P-nuAtJa2-Mtm5AnQ6tNMzxjbaCD0h3oWfVeGu5coip9ixCF0UvjCfn4Hah51vUCSnpj6oqiySJBmf1Hx7CfDo_h_Ff0botTc3rJTm7mpxfTS6uJu-uJqtPMj_uMznNj_sbEiLoue2ZaMPE7Y-mGtyW97wGGo4t71gYmBpqdQipzDu93qkGqLOeR-BNG352Idjx34B2TA7hlrfCabs6TfHHMEdgmHrU-isnxED38Ao0LcbTAqckxTjJSkxIBDugmEzGuCSTJMsJnpKsPETw9iFIxmVeFCnJ0pSUeJLl-PAOyXIBTg?type=png)](https://mermaid.live/edit#pako:eNqdksFu4yAQQH8FzV4ayY6MYxObw0pNUkvNKntJT617QDZO0GJAGLpNo_x7SaOm2VVPgQsD896MxOyh0S0HChvLzBY9LGqFwrp9qmHpBxcLFTvRc3SzvH8YoUb3RkjmhFY1PKM4_omqm0o4b9EvrxqBll4KNjo5ZsGx8tIJIzlqxWCYa7Zn7JQzf1pxx4zVoXzfC7X553URDL9DtReODLNMSi7F0P-nuAtJa2-Mtm5AnQ6tNMzxjbaCD0h3oWfVeGu5coip9ixCF0UvjCfn4Hah51vUCSnpj6oqiySJBmf1Hx7CfDo_h_Ff0botTc3rJTm7mpxfTS6uJu-uJqtPMj_uMznNj_sbEiLoue2ZaMPE7Y-mGtyW97wGGo4t71gYmBpqdQipzDu93qkGqLOeR-BNG352Idjx34B2TA7hlrfCabs6TfHHMEdgmHrU-isnxED38Ao0LcbTAqckxTjJSkxIBDugmEzGuCSTJMsJnpKsPETw9iFIxmVeFCnJ0pSUeJLl-PAOyXIBTg)
### 1. Just-in-time (JIT) compilation
Di Julia, kode kita dikompilasi secara cepat, jadi ga perlu nunggu lama-lama. Kodenya langsung siap jalan, kayak abis dapet ide langsung bisa implementasi!

### 2. Multiple dispatch
Ini fitur keren banget di Julia. Kita bisa bedain fungsi-fungsi berdasarkan parameter yang kita lempar. Jadi, bisa ada banyak versi fungsi yang berbeda, tergantung dari tipe data yang kita gunakan. Keren kan?

### 3. Metaprogramming
Metaprogramming di Julia itu sungguh canggih! Jadi, kita bisa bikin kode yang bisa nge-generate kode lain secara otomatis. Keren kan?

Dalam Julia, kita bisa menulis program yang dapat memanipulasi kode program itu sendiri. Kita bisa membuat kode yang menghasilkan kode baru, mengubah struktur kode, atau bahkan mengevaluasi kode saat runtime.

Dengan metaprogramming, kita bisa membuat kode yang lebih fleksibel dan dinamis. Kita dapat menghasilkan kode secara otomatis berdasarkan aturan atau pola tertentu, menghindari repetisi kode yang berlebihan, dan memungkinkan pembuatan alat bantu otomatis yang sangat kuat.

Ini juga sangat berguna dalam pengembangan framework, library, atau aplikasi yang memerlukan tingkat abstraksi tinggi. Kita dapat menghasilkan kode yang lebih generik dan dapat dikonfigurasi dengan mudah.

Jadi, metaprogramming di Julia memungkinkan kita untuk menulis kode yang dapat membuat atau memanipulasi kode lainnya secara otomatis. Bikin kode jadi lebih fleksibel, efisien, dan memperluas kemampuan kita sebagai pengembang. Canggih abis!

!!! note

	"Bisa bikin kode yang bisa nge-generate kode lain secara otomatis" itu maksundya si Julia ini bisa bikin kode yang bisa bikin kode baru dengan sendirinya. Gampangnya, kita bisa bikin kode yang otomatis bikin kode lain.

	Contohnya, bayangin kita punya fungsi yang bisa nerima parameter dan bikin fungsi baru berdasarkan parameter itu. Fungsinya baru ini punya implementasi yang berbeda-beda tergantung parameter yang kita kasih. Jadi, setiap kali kita panggil fungsinya, dia akan bikin fungsi baru sesuai parameter kita. Keren kan?

	Nah, contoh kasusnya bisa kayak gini:

	```julia
	function generate_function(x)
    	quote
        	f(y) = $x * y
        	return f
    	end
	end

	multiply_by_two = generate_function(2)
	result = multiply_by_two(5)
	println(result)  # Hasil: 10
	```

	Di contoh ini, ada fungsi `generate_function` yang nerima parameter `x`. Fungsinya ini bakal bikin fungsi baru yang namanya `f`, dan cara kerjanya dia akan kaliin parameter `x` dengan parameter `y`. Terus, kita panggil `generate_function(2)` buat bikin fungsi `multiply_by_two`, yang bisa kita pakai buat ngalikan angka dengan 2.

	Dengan metaprogramming, kita bisa bikin kode yang otomatis bikin kode lainnya. Contoh di atas cuma contoh yang sederhana, tapi di Julia, metaprogramming bisa dipake dalam skala yang lebih kompleks buat bikin kode yang generik, otomatis, dan bisa dipake di banyak aspek pengembangan perangkat lunak. Keren banget!

### 4. Native parallelism
Julia punya dukungan bawaan buat komputasi paralel. Jadi, bisa ngelakuin perhitungan secara bersamaan di beberapa core komputer. Makin cepat dan efisien deh!
[![](https://mermaid.ink/img/pako:eNqFkcFvwiAYxf8V8l28VCNtxZbDEm2XXWZituyydgdW0JK10FBIdOr_PqZNzJJtcoL3_XiQ9w5QaS6AwtawrkaPT6VCfi2KRb9XVW200q5HI8v6j370dhkui5VrrBzb2gjGpdoOelbksrdGvjsrOKp02zl7nebFw_rlhzo8hcbju2OmVeWMEcqi-52oPKLVES1vI9ltJB--fUbWzLCmEc0vHn8Dg0P2HwABtMK0THKf5uH7Qgm2Fq0ogfotFxvmUyuhVCePMmf1s08YqDVOBOA6zqzIJfM9tEA3rOm9Kri02qwuDZ2LCqBj6lXrK-PPQA-wAxomk3mCQxJiPI1TTEgAe6CYRBOckmgazwiekzg9BfB5NphO0lmShCQOQ5LiKJ7h0xfNjKgK?type=png)](https://mermaid.live/edit#pako:eNqFkcFvwiAYxf8V8l28VCNtxZbDEm2XXWZituyydgdW0JK10FBIdOr_PqZNzJJtcoL3_XiQ9w5QaS6AwtawrkaPT6VCfi2KRb9XVW200q5HI8v6j370dhkui5VrrBzb2gjGpdoOelbksrdGvjsrOKp02zl7nebFw_rlhzo8hcbju2OmVeWMEcqi-52oPKLVES1vI9ltJB--fUbWzLCmEc0vHn8Dg0P2HwABtMK0THKf5uH7Qgm2Fq0ogfotFxvmUyuhVCePMmf1s08YqDVOBOA6zqzIJfM9tEA3rOm9Kri02qwuDZ2LCqBj6lXrK-PPQA-wAxomk3mCQxJiPI1TTEgAe6CYRBOckmgazwiekzg9BfB5NphO0lmShCQOQ5LiKJ7h0xfNjKgK)
1. Tugas *"asynchronous"* atau *coroutines*: Di Julia, kita bisa ngejalanin kode secara *"asynchronous"* pake tugas atau coroutines. Jadi, bisa jalanin beberapa tugas secara bersamaan tanpa nungguin satu sama lain.

2. *Multi-threading*: Julia juga dukung *"multi-threading"* nih. Jadi, bisa jalanin tugas-tugas secara paralel pake beberapa "thread". Dengan begitu, performa eksekusi program bisa lebih cepat, terutama di mesin dengan banyak core atau CPU.

3. Komputasi terdistribusi: Julia punya dukungan buat "komputasi terdistribusi". Artinya, kita bisa jalanin tugas-tugas secara paralel di beberapa mesin atau node yang terhubung. Cocok banget buat tugas yang butuh daya komputasi besar atau proses data skala besar. Dengan komputasi terdistribusi, kita bisa tingkatkan kecepatan eksekusi program.

4. Komputasi di GPU: Julia juga bisa lakuin komputasi di GPU *(Graphics Processing Unit)*. Jadi, bisa manfaatin kecepatan dan kemampuan paralel di GPU buat ngebutin komputasi tertentu, khususnya yang butuh hitungan angka yang banyak. Makin cepat dan efisien deh!

Jadi, Julia dukung empat kategori pemrograman konkuren dan paralel: tugas *"asynchronous"* atau *coroutines*, *"multi-threading"*, komputasi terdistribusi, dan komputasi di GPU. Bisa manfaatin semua ini buat dapetin performa tinggi dan efisiensi dalam pemrograman kita, bro!"""

# ╔═╡ 5395fc75-32cf-43a8-9977-7c1cd18e393c
md"""
## Contoh Penggunaan Julia
Nah, Julia itu keren banget buat berbagai hal, bro! Cek contoh penggunaannya nih:
[![](https://mermaid.ink/img/pako:eNp1UDtvwjAQ_ivWzQnCIZjEQ6W2tJWqspROjRlOzkEsJbZlbKkU8d8b6FCpgu0e3-PuO4J2LYGEXUDfsbd3Ze-bD9KdNRp7pt3gUzR2t2F5fscemtfUG9wo-9gsMSLba0NW0__tslmh7owl1hMGe4X_1KzP1Gi2Rt92eW5eyFLAPvcpeLcn5oMbLx2GK2DIYKAwoGnHd47KMqYgdjSQAjmWLW0x9VGBsqcRiim69cFqkDEkyiD5FiMtDZ7lQW6x349Tak10YfUb0SWpDDzaT-f-MGMP8ghfIItqsqh4IQrOp2XNhcjgAJKL2YTXYjYt54IvRFmfMvi-CEwn9byqClEWhaj5rJzz0w_BqYEw?type=png)](https://mermaid.live/edit#pako:eNp1UDtvwjAQ_ivWzQnCIZjEQ6W2tJWqspROjRlOzkEsJbZlbKkU8d8b6FCpgu0e3-PuO4J2LYGEXUDfsbd3Ze-bD9KdNRp7pt3gUzR2t2F5fscemtfUG9wo-9gsMSLba0NW0__tslmh7owl1hMGe4X_1KzP1Gi2Rt92eW5eyFLAPvcpeLcn5oMbLx2GK2DIYKAwoGnHd47KMqYgdjSQAjmWLW0x9VGBsqcRiim69cFqkDEkyiD5FiMtDZ7lQW6x349Tak10YfUb0SWpDDzaT-f-MGMP8ghfIItqsqh4IQrOp2XNhcjgAJKL2YTXYjYt54IvRFmfMvi-CEwn9byqClEWhaj5rJzz0w_BqYEw)
### 1. Technical computing
Buat urusan komputasi teknis, Julia jago banget! Bisa buat ngitung angka-angka kompleks, analisis numerik, dan simulasi matematika. Makin gampang deh buat ngurusin perhitungan yang rumit!

### 2. Data science
Kalo kita suka ngotak-atik data, Julia juga oke banget! Bisa buat ngolah dan menganalisis data secara efisien. Bikin visualisasi data juga bisa pakai Julia. Jadi, bisa dapetin insight dan informasi berharga dari data dengan mudah!

### 3. Machine learning
Buat yang demen machine learning, Julia bisa jadi pilihan yang keren! Bisa buat ngembangin dan menjalankan model-machine learning dengan cepat. Training, evaluasi, dan prediksi jadi lebih lancar dan efisien. Bikin mesin jadi "pintar" tuh seru!

### 4. Scientific computing
Julia juga pas buat komputasi ilmiah, bro! Bisa buat riset, pemodelan fisika, kimia, biologi, dan banyak lagi. Komputasi rumit jadi lebih mudah dan efisien pake Julia. Jadi, bisa fokus ke penelitian dan eksperimen yang penting!

### 5. General-purpose programming
Jangan salah, Julia juga bisa dipake buat pemrograman umum, lho! Bisa buat bangun aplikasi, sistem, dan berbagai proyek seru lainnya. Dukungan yang lengkap, syntax yang fleksibel, bikin Julia jadi bahasa pemrograman yang powerful dan serbaguna!

Jadi, Julia cocok banget buat technical computing, data science, machine learning, scientific computing, dan general-purpose programming. Banyak banget pilihan dan kesempatan seru yang bisa kita eksplor dengan menggunakan Julia, bro!
"""

# ╔═╡ 12c046b2-b8d5-4517-9f0a-86a7dce3ee0d
md"""
## Instalasi
### Julia
1. Lo bisa download Julia versi terbaru lewat link [https://julialang.org/downloads/](https://julialang.org/downloads/). Pantau aja terus lin-nya! Soalnya rilis versi terbarunya cepet banget!
2. Instalnya gampang banget. kalo di Windows, tinggal sat set sat set.
3. Kalo di linux (WSL, misalnya), lo pilih link download yang sesuai dulu.  Kalo lo pake WSL Ubuntu, lo pilih link download yang **Generic Linux on x86**, terus pilih yang **64-bit (glibc)**.
4. Simpan file di direktori WSL, biar gampang.
5. Ekstrak file julia yang biasanya ekstensinya .tar.gz pake perintah berikut di terminal:
> tar -xvf nama\_file\_julia
6. Masuk ke folder julia, misalnya:
> cd julia-1.9.1/
> cd bin/
7. Jalankan julia:
> /.julia
8. Sampun ready!
"""

# ╔═╡ de3e93d0-3fa9-4492-8d70-56a9406f06d0
md"""
### Pluto
Kalo di Python, lo pasti ga asing sama yang namanya Jupyter Notebook. Di Julia juga ada notebook-nya, yaitu [Pluto.jl](https://plutojl.org/). Sama-sama nama planet😂"""

# ╔═╡ 2a141861-901b-425b-8faf-cb6f2b9ee06e
md"""
Biar bisa pake Pluto.jl, kita perlu install dulu, caranya gampang kok. Cukup ketik perintah ini di terminal Julia:

```
import Pkg; Pkg.add("Pluto")
```

Setelah itu, masukin perintah ini:

```
import Pluto; Pluto.run()
```

Nah, setelah itu, komputernya langsung buka aplikasi browser dan muncul jendela Pluto.jl yang seru banget. Kita bisa langsung mulai nulis kode dan markdown dengan nyaman di sana, bro. Keren kan?
"""

# ╔═╡ ee02b4fc-38b8-469e-80e4-37504894838e
md"""## Sintaks Dasar pada Bahasa Pemrograman Julia
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

# ╔═╡ 86c9c809-1aa2-420d-9f1f-f4e89c4877cb
x = Int8(7) 

# ╔═╡ 97c48f9a-c362-4d91-984f-0c44ecd0bcd9
y = Int8(60)

# ╔═╡ 077dd5cb-7683-438a-9208-c42efd2adc4f
x+y # Penjumlahan

# ╔═╡ eb7fa7dc-3840-4ccb-b22b-c9cfa400dc5d
x-y # Pengurangan

# ╔═╡ 313f2513-a3ac-45f2-b946-278373ffa566
x*y # Perkalian

# ╔═╡ d4de8d95-a303-44bb-8abd-90e822d10d37
x/y # Pembagian

# ╔═╡ e90c4fe4-a070-4efd-a716-95826ac9ac0c
x\y # Pembagian terbalik; sama dengan y/x

# ╔═╡ 88fef381-cc8f-4ee9-b57c-7d92c39d3b80
x%y # Modulus; sisa hasil pembagian

# ╔═╡ d9dbf395-b972-4c07-939e-e3a5f8e57820
y÷x	# Pembagian dengan hasil bilangan integer; pembulatan ke bawah

# ╔═╡ 1ff72dd7-3d55-4533-bbbb-5af7f3f483f9
x^y # Pangkat

# ╔═╡ 54dd7610-c042-4abd-b79a-36a40ac5b4b0
a = [1, 2, 3] # Matriks 3 baris 1 kolom

# ╔═╡ b52e898a-8af1-4c11-aa7e-2da2bf9121c8
a2 = [1
	  2
	  3] # 3 baris 1 kolom juga

# ╔═╡ e9107ce3-9c49-4c96-9218-d22699802ed6
b = [5 6 7] # Matriks 1 baris 3 kolom

# ╔═╡ 6f5435a5-5b29-4f87-9a1e-12e7f21baf2e
a.*3 # Perkalian dot; perkalian tiap elemen dengan satu nilai

# ╔═╡ fadf496c-6c7d-4925-a989-6499a8ec96f4
a.^3 # Operator dot juga bisa digunakan pada operator aritmetika lain

# ╔═╡ 40bafe46-c055-437e-bb63-101abecaef5e
md"""
### Operator Pembanding
Membandingkan nilai kebenaran dari variabel.
"""

# ╔═╡ 36dfed44-bffb-4517-bc24-33512b2179ea
md"""
|Ekspresi|Keterangan|
|:-------:|:---------|
|`<`     | kurang dari?|
|`>`     | lebih dari? |
|`<=`    | kurang dari atau sama dengan?|
|`>=`    | lebih dari atau sama dengan? |
|`==`    | bernilai sama?|
|`!=`    | bernilai tidak sama?|
"""

# ╔═╡ eecc6800-01dc-4fa6-844a-9b7b61aefb3f
x<y # Apakah x kurang dari y?

# ╔═╡ 627c48e7-60bc-467f-bb14-52a40afd5a45
x>y # Apakah x lebih dari y?

# ╔═╡ c1877f22-16c3-43b4-9329-e2b6a510ebf9
x<=y # Apakah x kurang dari atau sama dengan y?

# ╔═╡ 038b6ea8-102a-440d-8333-fb55fa1f5646
x>=y # Apakah x lebih dari atau sama dengan y?

# ╔═╡ ddfadc25-7204-4e1a-9ea6-3955fd6e217f
x==y # Apakah x sama dengan y?

# ╔═╡ 2070c0af-2116-4917-9403-740e9f317a8f
x!=y # Apakah x tidak sama dengan y?

# ╔═╡ 60ef6bc7-d2df-4f94-aa1d-eb5b063e8697
md"""
### Operator Logika
|Ekspresi|Keterangan|
|:-------|:---------|
|`&&`    | Jika keduanya true, maka bernilai true. Selain itu, false.|
|`\|\|`  | Jika salah satunya true, maka true. Jika tidak ada yang true, maka false.|
|`!`     | Negasi; pembalik nilai kebenaran.|
"""

# ╔═╡ 51bb382f-4022-4f3a-b232-b077552b6361
c = true

# ╔═╡ 755eae95-c56b-4204-86d9-b6e4da2aadcd
d = false

# ╔═╡ f17ccbb1-3424-4da3-ae5c-4876bda8fad5
!c # Negasi dari true; false

# ╔═╡ f5b664d2-424b-4bae-b080-f772b810aff6
c&&d # Tidak memenuhi syarat keduanya true, maka false

# ╔═╡ c5e3e37d-1c3e-4d43-948f-61acf7f3ec11
c&&c # Memenuhi syarat keduanya true, maka true

# ╔═╡ ce469ffc-22e4-42c1-a073-aad658789345
d&&d # Tidak memenuhi syarat keduanya true, maka false

# ╔═╡ 2dff491e-0a44-433e-b3f1-3977f96ab307
c||d # Memenuhi syarat salah satunya true, maka true

# ╔═╡ 740d6745-593d-4643-afe0-317af66e19da
c||c # Memenuhi syarat salah satunya true, maka true

# ╔═╡ 5efe4817-fa69-464c-a2d3-bbacfba26af1
d||d # Tidak memenuhi syarat salah satunya true, maka false

# ╔═╡ d228703e-ce29-49c3-851e-424d942bb326
md"""
### Operator Bitwise
Operasi yang dilakukan pada tingkat bit.
"""

# ╔═╡ daef92f9-97a1-4073-880a-936b7e7ea08e
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

# ╔═╡ dfef7067-1716-4bd4-96b7-1b987a7b016f
bitstring(x)

# ╔═╡ 859e193a-ab5c-4a21-af16-82e60d366082
bitstring(y)

# ╔═╡ 25c6008c-02c1-4e21-b342-10dd44bc82b6
~x

# ╔═╡ 1e6c96ae-1e37-4dfd-908a-ce290d5316a5
bitstring(~x)

# ╔═╡ d6f013c2-8807-4695-a336-89dd1ff239e5
bitstring(x)

# ╔═╡ acea1573-076b-4a67-876b-a68cfb8c921a
x&y

# ╔═╡ b13e4a0f-026c-4bb2-8985-1971ca6e0278
bitstring(x&y)

# ╔═╡ 35201634-fd46-4a66-9c3e-c213679d0d9e
bitstring(x)

# ╔═╡ 2099d7ca-96f3-4bf5-a486-69f8c48f0ec4
bitstring(y)

# ╔═╡ 07a7138b-3a8d-4b40-93a6-ae9895564898
x|y

# ╔═╡ c0ab53c0-b538-4bb1-8879-960e13c1bed3
bitstring(x|y)

# ╔═╡ d5f7a35f-0e42-4146-9dc5-b92332f30e16
bitstring(x)

# ╔═╡ d3531f10-54cc-4c7a-addf-8bd0d755d177
bitstring(y)

# ╔═╡ f875c3c4-c6d3-4e80-b5c7-97a6a18d42de
x⊻y

# ╔═╡ a11123b4-3f8e-4757-b220-47fbd3b1163b
bitstring(x⊻y)

# ╔═╡ 03b9429a-d99d-467a-b075-4ea3f88d5ac9
bitstring(x)

# ╔═╡ 6883deca-52d7-49b6-a8ea-688ff7b17ed3
bitstring(y)

# ╔═╡ 7a7564c2-3d24-4020-b085-48717badb09b
x⊼y

# ╔═╡ e2c87e04-aacf-494d-8c5d-4137e45ab555
bitstring(x⊼y)

# ╔═╡ 6e427b6d-9d3c-462b-82af-ae436c9347ff
bitstring(x)

# ╔═╡ 05ef9e97-0251-4f31-82bd-a5590866054b
bitstring(y)

# ╔═╡ 2cb8b0ff-9a86-4b6c-ad27-ce2116f91d67
x⊽y

# ╔═╡ 0692fa77-c206-4bcb-ae81-a7ca151612ed
bitstring(x⊽y)

# ╔═╡ c2750b20-ead0-4d69-8cf6-405e82d019ec
num = Int8(-127)

# ╔═╡ ed8785ec-320c-41a7-a7cb-6419ff5f8c7e
bitstring(num)

# ╔═╡ b77cdb9d-ab40-40c1-a4c0-9d3228c4e5ea
num>>>1

# ╔═╡ 241750f9-d225-4ccf-8004-b616917cfbb8
bitstring(num>>>1)

# ╔═╡ 99a9c209-21ee-40dd-92f1-68775a14f73c
num>>1

# ╔═╡ b0a99045-a168-45c5-9a55-92cd5dbb7a9e
bitstring(num>>1)

# ╔═╡ 7accf684-78a3-43b4-be61-9bd8e9d503fc
md"""
!!! note
	Perbedaan *logical shift right* `>>>` dengan *arithmetic shift right* `>>` adalah pada pengisian **MSB**. *Logical shift right* `>>>` akan mengisi **MSB** dengan `0`, sedangkan *arithmetic shift right* `>>` akan mengisi **MSB** dengan nilai yang sama dengan **MSB** asli.
"""

# ╔═╡ 54a01299-c87c-4918-9789-ab2edff4b0f2
x<<1

# ╔═╡ c49ba88c-e086-4065-b3e5-02f56f6518e1
bitstring(x<<1) # Posisi kosong pada bit paling tidak signifikan (LSB) diisi dengan angka nol.

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.51"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.1"
manifest_format = "2.0"
project_hash = "dcebd3174a85b0f68c71e8431fe1914ebcbe8db2"

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
git-tree-sha1 = "a5aef8d4a6e8d81f171b2bd4be5265b01384c74c"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.10"

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
# ╟─c7d13ff0-08bb-11ee-19ed-411e0be3b771
# ╠═445152e2-aa3f-4544-8cd9-da18a186df81
# ╠═7f39a629-ca6a-47eb-b749-559612c19ebc
# ╟─f42b2488-ee94-4822-a23b-96ca4e63ab67
# ╟─edd71197-1e00-4d2e-a421-29180298d9e7
# ╟─047b66fd-e76c-4d4f-aee3-acd6379b04fd
# ╟─0fa9a8eb-28d0-4d02-9ec6-8218952e7757
# ╟─5395fc75-32cf-43a8-9977-7c1cd18e393c
# ╟─12c046b2-b8d5-4517-9f0a-86a7dce3ee0d
# ╟─de3e93d0-3fa9-4492-8d70-56a9406f06d0
# ╟─2a141861-901b-425b-8faf-cb6f2b9ee06e
# ╟─ee02b4fc-38b8-469e-80e4-37504894838e
# ╠═86c9c809-1aa2-420d-9f1f-f4e89c4877cb
# ╠═97c48f9a-c362-4d91-984f-0c44ecd0bcd9
# ╠═077dd5cb-7683-438a-9208-c42efd2adc4f
# ╠═eb7fa7dc-3840-4ccb-b22b-c9cfa400dc5d
# ╠═313f2513-a3ac-45f2-b946-278373ffa566
# ╠═d4de8d95-a303-44bb-8abd-90e822d10d37
# ╠═e90c4fe4-a070-4efd-a716-95826ac9ac0c
# ╠═88fef381-cc8f-4ee9-b57c-7d92c39d3b80
# ╠═d9dbf395-b972-4c07-939e-e3a5f8e57820
# ╠═1ff72dd7-3d55-4533-bbbb-5af7f3f483f9
# ╠═54dd7610-c042-4abd-b79a-36a40ac5b4b0
# ╠═b52e898a-8af1-4c11-aa7e-2da2bf9121c8
# ╠═e9107ce3-9c49-4c96-9218-d22699802ed6
# ╠═6f5435a5-5b29-4f87-9a1e-12e7f21baf2e
# ╠═fadf496c-6c7d-4925-a989-6499a8ec96f4
# ╟─40bafe46-c055-437e-bb63-101abecaef5e
# ╟─36dfed44-bffb-4517-bc24-33512b2179ea
# ╠═eecc6800-01dc-4fa6-844a-9b7b61aefb3f
# ╠═627c48e7-60bc-467f-bb14-52a40afd5a45
# ╠═c1877f22-16c3-43b4-9329-e2b6a510ebf9
# ╠═038b6ea8-102a-440d-8333-fb55fa1f5646
# ╠═ddfadc25-7204-4e1a-9ea6-3955fd6e217f
# ╠═2070c0af-2116-4917-9403-740e9f317a8f
# ╟─60ef6bc7-d2df-4f94-aa1d-eb5b063e8697
# ╠═51bb382f-4022-4f3a-b232-b077552b6361
# ╠═755eae95-c56b-4204-86d9-b6e4da2aadcd
# ╠═f17ccbb1-3424-4da3-ae5c-4876bda8fad5
# ╠═f5b664d2-424b-4bae-b080-f772b810aff6
# ╠═c5e3e37d-1c3e-4d43-948f-61acf7f3ec11
# ╠═ce469ffc-22e4-42c1-a073-aad658789345
# ╠═2dff491e-0a44-433e-b3f1-3977f96ab307
# ╠═740d6745-593d-4643-afe0-317af66e19da
# ╠═5efe4817-fa69-464c-a2d3-bbacfba26af1
# ╟─d228703e-ce29-49c3-851e-424d942bb326
# ╟─daef92f9-97a1-4073-880a-936b7e7ea08e
# ╠═dfef7067-1716-4bd4-96b7-1b987a7b016f
# ╠═859e193a-ab5c-4a21-af16-82e60d366082
# ╠═25c6008c-02c1-4e21-b342-10dd44bc82b6
# ╠═1e6c96ae-1e37-4dfd-908a-ce290d5316a5
# ╠═d6f013c2-8807-4695-a336-89dd1ff239e5
# ╠═acea1573-076b-4a67-876b-a68cfb8c921a
# ╠═b13e4a0f-026c-4bb2-8985-1971ca6e0278
# ╠═35201634-fd46-4a66-9c3e-c213679d0d9e
# ╠═2099d7ca-96f3-4bf5-a486-69f8c48f0ec4
# ╠═07a7138b-3a8d-4b40-93a6-ae9895564898
# ╠═c0ab53c0-b538-4bb1-8879-960e13c1bed3
# ╠═d5f7a35f-0e42-4146-9dc5-b92332f30e16
# ╠═d3531f10-54cc-4c7a-addf-8bd0d755d177
# ╠═f875c3c4-c6d3-4e80-b5c7-97a6a18d42de
# ╠═a11123b4-3f8e-4757-b220-47fbd3b1163b
# ╠═03b9429a-d99d-467a-b075-4ea3f88d5ac9
# ╠═6883deca-52d7-49b6-a8ea-688ff7b17ed3
# ╠═7a7564c2-3d24-4020-b085-48717badb09b
# ╠═e2c87e04-aacf-494d-8c5d-4137e45ab555
# ╠═6e427b6d-9d3c-462b-82af-ae436c9347ff
# ╠═05ef9e97-0251-4f31-82bd-a5590866054b
# ╠═2cb8b0ff-9a86-4b6c-ad27-ce2116f91d67
# ╠═0692fa77-c206-4bcb-ae81-a7ca151612ed
# ╠═c2750b20-ead0-4d69-8cf6-405e82d019ec
# ╠═ed8785ec-320c-41a7-a7cb-6419ff5f8c7e
# ╠═b77cdb9d-ab40-40c1-a4c0-9d3228c4e5ea
# ╠═241750f9-d225-4ccf-8004-b616917cfbb8
# ╠═99a9c209-21ee-40dd-92f1-68775a14f73c
# ╠═b0a99045-a168-45c5-9a55-92cd5dbb7a9e
# ╟─7accf684-78a3-43b4-be61-9bd8e9d503fc
# ╠═54a01299-c87c-4918-9789-ab2edff4b0f2
# ╠═c49ba88c-e086-4065-b3e5-02f56f6518e1
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
