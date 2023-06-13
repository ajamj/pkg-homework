### A Pluto.jl notebook ###
# v0.19.26

using Markdown
using InteractiveUtils

# ╔═╡ 445152e2-aa3f-4544-8cd9-da18a186df81
using PlutoUI, Plots

# ╔═╡ c7d13ff0-08bb-11ee-19ed-411e0be3b771
md"""
# Catatan Pasca UTS Pemrograman Komputer Geofisika
"""

# ╔═╡ 7f39a629-ca6a-47eb-b749-559612c19ebc
TableOfContents()

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
1. **Gampang digunain**
Julia tuh enak banget buat digunain. Antar mukanya nyaman, bahasanya juga ga bikin ribet. Praktis deh!

2. **Performa tinggi**
Julia tuh jagoan banget dalam performa. Bisa ngehasilin kode yang berjalan cepat dan efisien. Ga heran kalo disebut-sebut sebagai bahasa yang cepat!

3. **Sintaks fleksibel dan ekspresif**
Sintaks di Julia tuh fleksibel banget. Bisa dengan mudah ngungkapin gagasan dan konsep-konsep dalam kode. Serasa kayak lagi ngobrol pake bahasa manusia!

4. **Ekosistem dan komunitas yang berkembang**
Ekosistem Julia terus berkembang dan komunitasnya juga makin besar. Banyak banget library dan alat bantu yang bisa dimanfaatkan. Dukungan dan kolaborasi yang keren banget deh!
"""

# ╔═╡ 0fa9a8eb-28d0-4d02-9ec6-8218952e7757
md"""
## Fitur Kunci Julia
[![](https://mermaid.ink/img/pako:eNqdksFu4yAQQH8FzV4ayY6MYxObw0pNUkvNKntJT617QDZO0GJAGLpNo_x7SaOm2VVPgQsD896MxOyh0S0HChvLzBY9LGqFwrp9qmHpBxcLFTvRc3SzvH8YoUb3RkjmhFY1PKM4_omqm0o4b9EvrxqBll4KNjo5ZsGx8tIJIzlqxWCYa7Zn7JQzf1pxx4zVoXzfC7X553URDL9DtReODLNMSi7F0P-nuAtJa2-Mtm5AnQ6tNMzxjbaCD0h3oWfVeGu5coip9ixCF0UvjCfn4Hah51vUCSnpj6oqiySJBmf1Hx7CfDo_h_Ff0botTc3rJTm7mpxfTS6uJu-uJqtPMj_uMznNj_sbEiLoue2ZaMPE7Y-mGtyW97wGGo4t71gYmBpqdQipzDu93qkGqLOeR-BNG352Idjx34B2TA7hlrfCabs6TfHHMEdgmHrU-isnxED38Ao0LcbTAqckxTjJSkxIBDugmEzGuCSTJMsJnpKsPETw9iFIxmVeFCnJ0pSUeJLl-PAOyXIBTg?type=png)](https://mermaid.live/edit#pako:eNqdksFu4yAQQH8FzV4ayY6MYxObw0pNUkvNKntJT617QDZO0GJAGLpNo_x7SaOm2VVPgQsD896MxOyh0S0HChvLzBY9LGqFwrp9qmHpBxcLFTvRc3SzvH8YoUb3RkjmhFY1PKM4_omqm0o4b9EvrxqBll4KNjo5ZsGx8tIJIzlqxWCYa7Zn7JQzf1pxx4zVoXzfC7X553URDL9DtReODLNMSi7F0P-nuAtJa2-Mtm5AnQ6tNMzxjbaCD0h3oWfVeGu5coip9ixCF0UvjCfn4Hah51vUCSnpj6oqiySJBmf1Hx7CfDo_h_Ff0botTc3rJTm7mpxfTS6uJu-uJqtPMj_uMznNj_sbEiLoue2ZaMPE7Y-mGtyW97wGGo4t71gYmBpqdQipzDu93qkGqLOeR-BNG352Idjx34B2TA7hlrfCabs6TfHHMEdgmHrU-isnxED38Ao0LcbTAqckxTjJSkxIBDugmEzGuCSTJMsJnpKsPETw9iFIxmVeFCnJ0pSUeJLl-PAOyXIBTg)
- **Just-in-time (JIT) compilation**
Di Julia, kode kita dikompilasi secara cepat, jadi ga perlu nunggu lama-lama. Kodenya langsung siap jalan, kayak abis dapet ide langsung bisa implementasi! Dia tuh "IR-friendly" alias bersahabat sama **Intermediate Representation**. Nah, IR itu tuh representasi perantara antara kode asli dan kode mesin yang dipake pas proses kompilasi.

Jadi, Julia dirancang dengan canggih biar bisa nyambung dan ngejalanin IR dengan mudah. Kodenya di-JIT (Just-in-Time) compile jadi IR yang efisien buat dieksekusi. Ga cuma itu, Julia juga punya metaprogramming yang keren banget, jadi bisa manipulasi dan bikin IR secara dinamis, lho!

- **Multiple dispatch**
Ini fitur keren banget di Julia. Kita bisa bedain fungsi-fungsi berdasarkan parameter yang kita lempar. Jadi, bisa ada banyak versi fungsi yang berbeda, tergantung dari tipe data yang kita gunakan. Keren kan?

- **Metaprogramming**
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

- **Native parallelism**
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
1. Technical computing
Buat urusan komputasi teknis, Julia jago banget! Bisa buat ngitung angka-angka kompleks, analisis numerik, dan simulasi matematika. Makin gampang deh buat ngurusin perhitungan yang rumit!

2. Data science
Kalo kita suka ngotak-atik data, Julia juga oke banget! Bisa buat ngolah dan menganalisis data secara efisien. Bikin visualisasi data juga bisa pakai Julia. Jadi, bisa dapetin insight dan informasi berharga dari data dengan mudah!

3. Machine learning
Buat yang demen machine learning, Julia bisa jadi pilihan yang keren! Bisa buat ngembangin dan menjalankan model-machine learning dengan cepat. Training, evaluasi, dan prediksi jadi lebih lancar dan efisien. Bikin mesin jadi "pintar" tuh seru!

4. Scientific computing
Julia juga pas buat komputasi ilmiah, bro! Bisa buat riset, pemodelan fisika, kimia, biologi, dan banyak lagi. Komputasi rumit jadi lebih mudah dan efisien pake Julia. Jadi, bisa fokus ke penelitian dan eksperimen yang penting!

5. General-purpose programming
Jangan salah, Julia juga bisa dipake buat pemrograman umum, lho! Bisa buat bangun aplikasi, sistem, dan berbagai proyek seru lainnya. Dukungan yang lengkap, syntax yang fleksibel, bikin Julia jadi bahasa pemrograman yang powerful dan serbaguna!

Jadi, Julia cocok banget buat technical computing, data science, machine learning, scientific computing, dan general-purpose programming. Banyak banget pilihan dan kesempatan seru yang bisa kita eksplor dengan menggunakan Julia, bro!
"""

# ╔═╡ 12c046b2-b8d5-4517-9f0a-86a7dce3ee0d
md"""
## Instalasi
### Julia
1. Lo bisa download Julia versi terbaru lewat link [https://julialang.org/downloads/](https://julialang.org/downloads/). Pantau aja terus link-nya! Soalnya rilis versi terbarunya cepet banget!
2. Instalnya gampang banget. kalo di Windows, tinggal sat set sat set.
3. Kalo di linux (WSL, misalnya), lo pilih link download yang sesuai dulu.  Kalo lo pake WSL Ubuntu, lo pilih link download yang **Generic Linux on x86**, terus pilih yang **64-bit (glibc)**.
4. Simpan file di direktori WSL, biar gampang.
5. Ekstrak file julia yang biasanya ekstensinya .tar.gz pake perintah berikut di terminal:
> tar -xvf nama\_file\_julia
6. Masuk ke folder julia, misalnya:
> cd julia-1.9.1/\
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
a = [1, 2, 3] # Vector 3 baris 1 kolom

# ╔═╡ b52e898a-8af1-4c11-aa7e-2da2bf9121c8
a2 = [1
	  2
	  3] # Vector 3 baris 1 kolom juga

# ╔═╡ e9107ce3-9c49-4c96-9218-d22699802ed6
b = [5 6 7] # Matriks 1 baris 3 kolom

# ╔═╡ 3f909ee3-7754-474a-8904-119a521f5308
md"""
!!! note

	**Cara membedakan baris dan kolom dalam pendefinisian matriks:** lihat **tanda koma**. Jika didefinisikan satu baris, tanda koma menandakan pembeda baris.
	"""

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

# ╔═╡ daafd4b5-bc57-4216-a465-b773cf8d92ce
md"""---"""

# ╔═╡ 25c6008c-02c1-4e21-b342-10dd44bc82b6
~x

# ╔═╡ 1e6c96ae-1e37-4dfd-908a-ce290d5316a5
bitstring(~x)

# ╔═╡ d6f013c2-8807-4695-a336-89dd1ff239e5
bitstring(x)

# ╔═╡ 5b33afe6-8ea4-4672-a989-4ffd59464ca3
md"""---"""

# ╔═╡ acea1573-076b-4a67-876b-a68cfb8c921a
x&y

# ╔═╡ b13e4a0f-026c-4bb2-8985-1971ca6e0278
bitstring(x&y)

# ╔═╡ 35201634-fd46-4a66-9c3e-c213679d0d9e
bitstring(x)

# ╔═╡ 2099d7ca-96f3-4bf5-a486-69f8c48f0ec4
bitstring(y)

# ╔═╡ 67c4155e-64d2-4c9d-84fe-df826daea517
md"""---"""

# ╔═╡ 07a7138b-3a8d-4b40-93a6-ae9895564898
x|y

# ╔═╡ c0ab53c0-b538-4bb1-8879-960e13c1bed3
bitstring(x|y)

# ╔═╡ d5f7a35f-0e42-4146-9dc5-b92332f30e16
bitstring(x)

# ╔═╡ d3531f10-54cc-4c7a-addf-8bd0d755d177
bitstring(y)

# ╔═╡ 813646b9-a13b-4bd4-b584-04adf734a197
md"""---"""

# ╔═╡ f875c3c4-c6d3-4e80-b5c7-97a6a18d42de
x⊻y

# ╔═╡ a11123b4-3f8e-4757-b220-47fbd3b1163b
bitstring(x⊻y)

# ╔═╡ 03b9429a-d99d-467a-b075-4ea3f88d5ac9
bitstring(x)

# ╔═╡ 6883deca-52d7-49b6-a8ea-688ff7b17ed3
bitstring(y)

# ╔═╡ 20cce784-cefe-46f0-b345-5fc7b1cb5cbd
md"""---"""

# ╔═╡ 7a7564c2-3d24-4020-b085-48717badb09b
x⊼y

# ╔═╡ e2c87e04-aacf-494d-8c5d-4137e45ab555
bitstring(x⊼y)

# ╔═╡ 6e427b6d-9d3c-462b-82af-ae436c9347ff
bitstring(x)

# ╔═╡ 05ef9e97-0251-4f31-82bd-a5590866054b
bitstring(y)

# ╔═╡ 16ad0d95-77f0-40a0-94aa-bf1e7d3de985
md"""---"""

# ╔═╡ 2cb8b0ff-9a86-4b6c-ad27-ce2116f91d67
x⊽y

# ╔═╡ 0692fa77-c206-4bcb-ae81-a7ca151612ed
bitstring(x⊽y)

# ╔═╡ 668e22b9-b3b3-4cf7-b03c-24ce88c84634
md"""---"""

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

# ╔═╡ 2649fe5c-8cb0-48e6-ba4c-733c2dccae51
bitstring(Int8(13))

# ╔═╡ a9d9022f-0e6b-4e63-aa9e-190216c49978
13<<1

# ╔═╡ c49ba88c-e086-4065-b3e5-02f56f6518e1
bitstring(Int8(13<<1)) # Posisi kosong pada bit paling tidak signifikan (LSB) diisi dengan angka nol.

# ╔═╡ 883c9940-0a96-41b1-9513-e770def3fb89
md"""
### Aliran Kontrol: if, else, elseif
Mengeksekusi perintah berdasarkan kondisi tertentu.
"""

# ╔═╡ 9774b019-53a6-475b-ac37-c14cdc2a5567
begin
	println("x = $x, y = $y")
	if x < y
		println("x kurang dari y")
	elseif x > y
		println("x lebih dari y")
	else
		println("x sama dengan y")
	end
end

# ╔═╡ 675252d2-51d9-426c-903d-698ed029a881
md"""
### Fungsi
"""

# ╔═╡ cb9b064b-7f8e-4f92-808f-b00113d19231
"""
Mendefinisikan fungsi tambah_kuadrat dengan keluaran x^2+y^2
"""
function tambah_kuadrat(x,y)
	x^2+y^2
end

# ╔═╡ 0c178948-0220-488f-8e07-cba0b23ecc37
# Memanggil fungsi tambah kuadrat
tambah_kuadrat(x,y)

# ╔═╡ 8a74c2c7-6224-4462-83d8-4d807f37ee9f
# Mendefinisikan fungsi kurang_kuadrat dengan keluarang x^2-y^2
kurang_kuadrat(x,y) = x^2-y^2

# ╔═╡ c9b70398-4b20-44cc-ae91-c4cfbb18454f
# Memanggil fungsi kurang kuadrat
kurang_kuadrat(x,y)

# ╔═╡ 4a5274d2-c0f4-48c2-95c3-7c32f3622a84
"""
Mendefinisikan fungsi kali(x,y). Keluaran yang akan keluar adalah perintah yang terdapat keyword 'return' sebelum suatu perintah, walaupun ada perintah lain pada baris antara baris yang mengandung keyword 'return' dan 'end'.
"""
function kali(x,y)::Int8
	return x*y
	x+y
end

# ╔═╡ b1c58b4f-e57c-4747-ad4d-9b58b9b3754b
kali(x,y)

# ╔═╡ fae3b57f-80db-4e9f-9375-44df488c0731
"""
Mendefinisikan fungsi tanpa memberikan nilai keluaran atau dengan keluaran 'nothing'.
"""
function cetak(x)
	println("Nilai dari x adalah $x")
	return nothing
end

# ╔═╡ 33609a97-6ad9-4fa7-bba7-3ebefda0d7ce
cetak(x)

# ╔═╡ 4683cef9-2567-461a-bb86-696be5a3d753
# Mendefinisikan fungsi anonymous
x -> x^0 + x^1 + x^2

# ╔═╡ 87f0e00a-cbd3-4dce-9c29-0077733ec312
ganjilkah(n::Integer) = n%2!=0 ? println("Ya, bilangan tersebut ganjil") : println("Bukan, bilangan tersebut bukan ganjil")

# ╔═╡ b168b027-c973-44b8-bf05-065ac16692d9
ganjilkah(5)

# ╔═╡ 62e37a70-9e9a-4942-8b5a-fdcc1186a75a
ganjilkah(10)

# ╔═╡ d97944fc-88f9-466c-8c40-9a427acf4632
map(x -> x^3, [2, 3, 4]) # map(f,c..) -> collection. Fungsi yang dapat mengubah koleksi c dengan menerapkan f ke setiap elemen dari c.

# ╔═╡ baa71d46-3670-44ef-961d-b645999f62c1
md"""
!!! note

	Operasi yang diterapkan pada tiap elemen juga bisa digunakan dengan tanda titik `.`. Fungsi map di atas ekuivalen dengan kode berikut:
"""

# ╔═╡ 451060bb-8d17-4240-af14-1e822828e6ac
[2,3,4] .^= 3 

# ╔═╡ 79b45993-b019-4c6f-ac61-77e0c142c79d
md""" ## Collatz Conjecture
### Batas-batas Fungsi
Syarat:
+ Integer dan positif, atau
+ Bilangan bulat positif yang memiliki tipe data float, misalnya 3.0, atau
+ Bilangan kompleks, tetapi bilangan imajinernya 0 dan bilangan real-nya positif, atau
+ Pecahan rasional dengan bentuk paling sederhana adalah bilangan bulat. Misalnya adalah 10//2, ia memenuhi syarat karena bentuk paling sederhananya sama dengan 5.
+ (TODO) Masukan berupa seperti di atas, tetapi memiliki tipe data string.
Jika memenuhi syarat:\
Masukkan nilai input ke dalam sequence.\
Pengecekan nilai n:\

+ Jika ganjil, maka n = 3n+1
+ Jika genap, maka n = n dibagi 2.
+ Masukkan n ke dalam sequence.
+ Ulangi pengecekan nilai n.
+ Jika n = 1, stop pengecekan nilai n.
Fungsi mengembalikan dictionary dengan key berupa nilai input, jumlah step, dan sequence."""

# ╔═╡ b788818d-c661-4fde-8009-183f202b2f1d
"""
Mengubah tipe data yang memiliki nilai sama dengan bilangan bulat positif 
ke dalam tipe variabel integer.
	
Parameter valid: 
float: 3.0, 5.0
rational: 10//2, 20//10
complex: 10+0im

Jika parameter tidak senilai dengan bilangan bulat positif,
maka fungsi akan 'melempar' error.

Jika parameter valid, maka fungsi akan mengembalikan nilai bilangan bulat.

Contoh:
n = 3.0
to_int(n) = 3

n = 10//2
to_int(n) = 5

n = 10+0im
to_int(n) = 10
"""
function to_int(n)
	try
		if (isa(n, String))
			if occursin(".0",n)
				n = parse(Float64, n)
				n = convert(Int, n)
			elseif occursin("0im", n)
				n = parse(Complex{Float64}, n)
				n = real(n)
			elseif !occursin(".",n)
				n = parse(Int, n)
				return n
			end
		end
		if (isa(n, Float64) && isinteger(n) && n>0)
			return convert(Int, n)
		elseif (isa(n, Rational) && n>0 && denominator(n)==1)
        	return numerator(n)
		elseif (isa(n, Complex) && imag(n)==0 && real(n)>0) # Syarat kompleks, imajiner = 0, real positif
			return real(n) # Ambil nilai real-nya saja
		elseif (isa(n, Integer) && n>0)
			return n
		else
			error("ERROR: Masukan harus berupa bilangan bulat positif atau yang semisal.")
		end
	catch
		error("ERROR: Masukan harus berupa bilangan bulat positif atau yang semisal.")
	end
end

# ╔═╡ 7da9c41b-2eaf-4636-82f1-1e79f8ba1f38
"""
collatz_conjecture(n)

Input: n = bilangan bulat positif
Output: dictionary dengan keys: number, steps, dan sequence.

Jika n ganjil, kali 3 dan tambah 1 -> n = 3n+1
Jika n genap, bagi 2 -> n = n/2

Contoh: n = 5
Sequence: 5, 16, 8, 4, 2, 1
Total steps: 5
"""
function collatz_conjecture(n)
    if typeof(n) != Int
        n = to_int(n)
    end
    if n > 0
        sequence = [n]
        while n > 1
            if isodd(n)
                n = 3*n + 1
            else
                n = n÷2
            end
            push!(sequence, n)
        end
        return Dict("number" => sequence[1], "steps" => length(sequence), "sequence" => sequence)
    else
        error("ERROR: Masukan harus berupa bilangan bulat positif atau yang semisal.")
    end
end

# ╔═╡ 64cf632f-4379-4ce4-91ce-77674e9ea254
"""
Fungsi plot grafik collatz conjecture.

Input: Bilangan bulat positif yang valid dengan format input fungsi collatz_conjecture.

Output: Plot grafik bilangan yang ada dalam sequence.
"""
function plot_cc(n)
	dict = collatz_conjecture(n)
	x = range(1, dict["steps"], length=dict["steps"])
	y = dict["sequence"]
	plot(x, y, label="n = $n",seriestype=:line, fontfamily = "Arial")
	title!("Grafik Nilai n untuk Setiap Step")
	xlabel!("Step")
	ylabel!("Nilai Bilangan")
end

# ╔═╡ 91eba44e-24cc-4cf8-b50b-67863f964ada
"""
Fungsi plot grafik jumlah step yang dimiliki untuk setiap bilangan <= n.

Input: Bilangan bulat positif.

Output: grafik jumlah step.
"""
function plot_total_step(n)
	nums = []
	total_step = []
	for i in range(1, n)
		push!(nums, i)
		push!(total_step, collatz_conjecture(i)["steps"])
	end
	
	dict_step = Dict("numbers" => nums, "steps" => total_step)
	
	plot(range(1, n), dict_step["steps"], seriestype=:scatter, label="Jumlah input n = $n", fontfamily = "Arial")
	
	# Label
	title!("Grafik Jumlah Step untuk Setiap Nilai Input")
	xlabel!("Nilai Input (n)")
	ylabel!("Jumlah Step")
end

# ╔═╡ f186205b-ea65-4e09-972d-3e2ea126226f
collatz_conjecture(27) #Int

# ╔═╡ 8fa29071-d3e9-4372-94e5-e1c823cdfe61
collatz_conjecture(3+0im) #Complex

# ╔═╡ d97972fe-a50f-4c6e-8dcb-36ab2e491b72
collatz_conjecture(104//2) #Rational

# ╔═╡ f30d8765-efa2-42b9-aa51-88d6b419cb2d
collatz_conjecture(9.0) #Float

# ╔═╡ 89772ae7-4144-4ce6-a50e-e2913f932620
collatz_conjecture("51") #String

# ╔═╡ 6b55336e-9488-4274-91e1-a5b66b2d182c
collatz_conjecture("2+0im") #String complex

# ╔═╡ 11aaaedf-b70c-46db-a5c5-e1df7e509394
collatz_conjecture(12+5im) # Akan tidak valid karena mengandung nilai imajiner

# ╔═╡ c940b976-cd74-4591-ab0b-b54ea1c34700
plot_cc(55)

# ╔═╡ 5dd28052-c904-4296-a1ef-6068c6fc336d
plot_total_step(222)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
Plots = "~1.38.15"
PlutoUI = "~0.7.51"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.1"
manifest_format = "2.0"
project_hash = "8b84250a988674a09a8d2bdbf6a3e925351a3615"

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

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "738fec4d684a9a6ee9598a8bfee305b26831f28c"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.2"

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseStaticArraysExt = "StaticArrays"

    [deps.ConstructionBase.weakdeps]
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

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
git-tree-sha1 = "5e77dbf117412d4f164a464d610ee6050cc75272"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.9.6"

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

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f689897ccbe049adb19a065c495e75f372ecd42b"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "15.0.4+0"

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
git-tree-sha1 = "f428ae552340899a935973270b8d98e5a31c49fe"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.1"

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
git-tree-sha1 = "c3ce8e7420b3a6e071e0fe4745f5d4300e37b13f"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.24"

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
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1aa4b74f80b01c6bc2b89992b861b5f210e665b5"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.21+0"

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
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "64779bc4c9784fee475689a1752ef4d5747c5e87"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.42.2+0"

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
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "ceb1ec8d4fbeb02f8817004837d924583707951b"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.38.15"

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
# ╟─c7d13ff0-08bb-11ee-19ed-411e0be3b771
# ╠═445152e2-aa3f-4544-8cd9-da18a186df81
# ╠═7f39a629-ca6a-47eb-b749-559612c19ebc
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
# ╟─3f909ee3-7754-474a-8904-119a521f5308
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
# ╟─daafd4b5-bc57-4216-a465-b773cf8d92ce
# ╠═25c6008c-02c1-4e21-b342-10dd44bc82b6
# ╠═1e6c96ae-1e37-4dfd-908a-ce290d5316a5
# ╠═d6f013c2-8807-4695-a336-89dd1ff239e5
# ╟─5b33afe6-8ea4-4672-a989-4ffd59464ca3
# ╠═acea1573-076b-4a67-876b-a68cfb8c921a
# ╠═b13e4a0f-026c-4bb2-8985-1971ca6e0278
# ╠═35201634-fd46-4a66-9c3e-c213679d0d9e
# ╠═2099d7ca-96f3-4bf5-a486-69f8c48f0ec4
# ╟─67c4155e-64d2-4c9d-84fe-df826daea517
# ╠═07a7138b-3a8d-4b40-93a6-ae9895564898
# ╠═c0ab53c0-b538-4bb1-8879-960e13c1bed3
# ╠═d5f7a35f-0e42-4146-9dc5-b92332f30e16
# ╠═d3531f10-54cc-4c7a-addf-8bd0d755d177
# ╟─813646b9-a13b-4bd4-b584-04adf734a197
# ╠═f875c3c4-c6d3-4e80-b5c7-97a6a18d42de
# ╠═a11123b4-3f8e-4757-b220-47fbd3b1163b
# ╠═03b9429a-d99d-467a-b075-4ea3f88d5ac9
# ╠═6883deca-52d7-49b6-a8ea-688ff7b17ed3
# ╟─20cce784-cefe-46f0-b345-5fc7b1cb5cbd
# ╠═7a7564c2-3d24-4020-b085-48717badb09b
# ╠═e2c87e04-aacf-494d-8c5d-4137e45ab555
# ╠═6e427b6d-9d3c-462b-82af-ae436c9347ff
# ╠═05ef9e97-0251-4f31-82bd-a5590866054b
# ╟─16ad0d95-77f0-40a0-94aa-bf1e7d3de985
# ╠═2cb8b0ff-9a86-4b6c-ad27-ce2116f91d67
# ╠═0692fa77-c206-4bcb-ae81-a7ca151612ed
# ╟─668e22b9-b3b3-4cf7-b03c-24ce88c84634
# ╠═c2750b20-ead0-4d69-8cf6-405e82d019ec
# ╠═ed8785ec-320c-41a7-a7cb-6419ff5f8c7e
# ╠═b77cdb9d-ab40-40c1-a4c0-9d3228c4e5ea
# ╠═241750f9-d225-4ccf-8004-b616917cfbb8
# ╠═99a9c209-21ee-40dd-92f1-68775a14f73c
# ╠═b0a99045-a168-45c5-9a55-92cd5dbb7a9e
# ╟─7accf684-78a3-43b4-be61-9bd8e9d503fc
# ╠═2649fe5c-8cb0-48e6-ba4c-733c2dccae51
# ╠═a9d9022f-0e6b-4e63-aa9e-190216c49978
# ╠═c49ba88c-e086-4065-b3e5-02f56f6518e1
# ╟─883c9940-0a96-41b1-9513-e770def3fb89
# ╠═9774b019-53a6-475b-ac37-c14cdc2a5567
# ╟─675252d2-51d9-426c-903d-698ed029a881
# ╠═cb9b064b-7f8e-4f92-808f-b00113d19231
# ╠═0c178948-0220-488f-8e07-cba0b23ecc37
# ╠═8a74c2c7-6224-4462-83d8-4d807f37ee9f
# ╠═c9b70398-4b20-44cc-ae91-c4cfbb18454f
# ╠═4a5274d2-c0f4-48c2-95c3-7c32f3622a84
# ╠═b1c58b4f-e57c-4747-ad4d-9b58b9b3754b
# ╠═fae3b57f-80db-4e9f-9375-44df488c0731
# ╠═33609a97-6ad9-4fa7-bba7-3ebefda0d7ce
# ╠═4683cef9-2567-461a-bb86-696be5a3d753
# ╠═87f0e00a-cbd3-4dce-9c29-0077733ec312
# ╠═b168b027-c973-44b8-bf05-065ac16692d9
# ╠═62e37a70-9e9a-4942-8b5a-fdcc1186a75a
# ╠═d97944fc-88f9-466c-8c40-9a427acf4632
# ╟─baa71d46-3670-44ef-961d-b645999f62c1
# ╠═451060bb-8d17-4240-af14-1e822828e6ac
# ╟─79b45993-b019-4c6f-ac61-77e0c142c79d
# ╠═b788818d-c661-4fde-8009-183f202b2f1d
# ╠═7da9c41b-2eaf-4636-82f1-1e79f8ba1f38
# ╠═64cf632f-4379-4ce4-91ce-77674e9ea254
# ╠═91eba44e-24cc-4cf8-b50b-67863f964ada
# ╠═f186205b-ea65-4e09-972d-3e2ea126226f
# ╠═8fa29071-d3e9-4372-94e5-e1c823cdfe61
# ╠═d97972fe-a50f-4c6e-8dcb-36ab2e491b72
# ╠═f30d8765-efa2-42b9-aa51-88d6b419cb2d
# ╠═89772ae7-4144-4ce6-a50e-e2913f932620
# ╠═6b55336e-9488-4274-91e1-a5b66b2d182c
# ╠═11aaaedf-b70c-46db-a5c5-e1df7e509394
# ╠═c940b976-cd74-4591-ab0b-b54ea1c34700
# ╠═5dd28052-c904-4296-a1ef-6068c6fc336d
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
