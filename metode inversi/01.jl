### A Pluto.jl notebook ###
# v0.19.26

using Markdown
using InteractiveUtils

# ╔═╡ 36a7d603-503f-4573-93ca-7748f36f3c0b
using PlutoUI

# ╔═╡ e2f429d2-2ce9-4bd2-be22-8a5f1bb1fa82
TableOfContents()

# ╔═╡ c752d570-019a-11ee-1f24-7d853caa2209
md"""
# BAB I: Pendahuluan"""

# ╔═╡ 4197ddad-a01c-4c93-9a14-049cea8d6862
md"""
## Masalah Inversi Dalam Geofisika
Nah, bro! Gue kasih analogi seru nih buat metode inversi di geofisika. Kita bayangin kita lagi main game detektif, seperti Sherlock Holmes gitu. Jadi, kita punya kasus untuk mencari harta karun yang tersembunyi di dalam sebuah rumah tua.

Di game ini, kita punya beberapa petunjuk yang bisa kita gunakan, misalnya ada suara berisik di ruangan tertentu, atau kita bisa ukur getaran di lantai. Nah, metode inversi ini kayak kita menggunakan akal dan petunjuk-petunjuk itu untuk mencari tahu di mana sebenarnya harta karun itu berada.

Kita harus pake otak dan logika buat menginterpretasi petunjuk-petunjuk itu. Misalnya, berdasarkan suara berisik dan getaran yang kita ukur, kita bisa tebak kalau harta karun mungkin ada di lantai atas atau di bawah lantai. Lalu, kita coba cocokkan petunjuk-petunjuk itu dengan informasi yang kita punya buat nyari tempat persisnya.

Dalam geofisika, metode inversi ini kayak main game detektif tadi. Data geofisika itu kayak petunjuk-petunjuk yang kita punya, misalnya data seismik atau medan magnet. Terus, kita pake metode inversi buat menganalisis data itu dan mencari tahu struktur bawah permukaan tanah.

Misalnya, kita pake data seismik buat ngukur getaran di permukaan tanah. Berdasarkan data itu, kita bisa duga ada struktur batuan yang menarik di bawah permukaan, kayak lapisan batuan atau kemungkinan adanya minyak dan gas. Nah, dengan metode inversi, kita bisa ngecek apa yang ada di bawah permukaan dengan lebih akurat.

Metode inversi ini keren banget, bro! Kita bisa jadi detektif geofisika yang pinter menginterpretasi petunjuk-petunjuk di data geofisika buat nyari tahu apa yang ada di dalam tanah. Ini penting banget buat eksplorasi minyak dan gas, pemetaan sumber daya air bawah tanah, atau bahkan untuk pemahaman ilmiah tentang fenomena geologis.

Jadi, bro, metode inversi itu kaya main game detektif, tapi dalam konteks geofisika. Kita pake data geofisika sebagai petunjuk, pake akal dan logika buat memecahkan teka-teki struktur bawah permukaan tanah. Keren, kan? Dengan metode inversi, kita bisa jadi detektif geofisika yang hebat!
"""

# ╔═╡ ad807e5d-f70a-4f50-8813-76a4c06763b6
md"""
## Apakah Metode Inversi Hanya Ada di Geofisika?
Tentu nggak, bro! Metode inversi tidak hanya ada di geofisika. Sebenarnya, metode inversi digunakan di banyak bidang ilmiah dan teknik, termasuk dalam matematika, fisika, kimia, astronomi, dan banyak lagi.

Dalam matematika, metode inversi digunakan untuk memecahkan persamaan yang kompleks atau mencari fungsi yang memenuhi kondisi tertentu. Ini membantu kita memperoleh solusi yang tepat atau mendekati solusi yang akurat.

Dalam fisika, metode inversi digunakan untuk mempelajari fenomena alam seperti sifat-sifat materi, medan elektromagnetik, atau pergerakan partikel. Dengan menganalisis data eksperimen dan menggunakan metode inversi, kita bisa memperoleh model yang menggambarkan fenomena tersebut dengan lebih baik.

Di bidang kimia, metode inversi dapat digunakan untuk memperkirakan struktur molekul berdasarkan data spektroskopi atau data lainnya. Metode ini membantu kita memahami sifat-sifat kimia dan melakukan prediksi tentang interaksi molekul.

Bahkan di astronomi, metode inversi digunakan untuk memperoleh informasi tentang objek langit seperti bintang atau galaksi. Dengan menganalisis data pengamatan dan menggunakan metode inversi, para astronom bisa mendapatkan pemahaman yang lebih baik tentang sifat-sifat objek-objek astronomi tersebut.

Jadi, metode inversi bukan cuma ada di geofisika, bro. Ini adalah teknik yang luas digunakan di berbagai bidang ilmiah dan teknik. Konsepnya tetap sama, yaitu mencari model yang sesuai dengan data yang ada."""

# ╔═╡ f612c525-afcd-4683-8d2f-305f8af55d5b
md"""
Ketika kita bilang bahwa metode inversi digunakan ketika data hanya secara tidak langsung membatasi atau mempengaruhi kuantitas yang ingin diteliti, itu berarti data yang kita punya tidak memberikan informasi langsung tentang kuantitas yang ingin kita ketahui. 

Paham nggak, bro? Gue kasih contoh biar lebih jelas. Bayangkan kita punya data pengukuran suhu di beberapa titik di sekitar sebuah danau. Kita tertarik untuk mengetahui distribusi suhu di dalam danau tersebut. Tapi masalahnya, kita nggak punya data langsung tentang suhu di dalam danau, seperti mengukur suhu di setiap titik di dalamnya.

Nah, di sinilah metode inversi masuk. Kita bisa menggunakan data yang kita punya, yaitu data suhu di sekitar danau, untuk mencari model atau distribusi suhu di dalam danau tersebut. Data yang kita miliki hanya memberikan petunjuk secara tidak langsung tentang apa yang terjadi di dalam danau.

Metode inversi membantu kita menghubungkan data yang ada dengan kuantitas yang ingin kita ketahui, dalam contoh ini distribusi suhu di dalam danau. Kita menggunakan teknik matematika dan pemodelan untuk mencocokkan data yang ada dengan model yang paling sesuai.

Dengan memanfaatkan metode inversi, kita bisa membuat estimasi yang mendekati distribusi suhu di dalam danau berdasarkan data yang hanya secara tidak langsung terkait dengan kuantitas yang ingin kita ketahui.

Jadi, intinya, metode inversi digunakan ketika kita memiliki data yang tidak langsung memberikan informasi langsung tentang kuantitas yang ingin kita teliti. Dengan menggunakan teknik inversi, kita bisa memperoleh perkiraan atau estimasi yang mendekati kuantitas tersebut berdasarkan data yang tersedia.
"""

# ╔═╡ 6fb09992-7abe-4205-972c-e159debba051
md"""
> *"Most people, if you describe a train of events to them will tell you what the result will be. There are few people, however that if you told them a result, would be able to evolve from their own inner consciousness what the steps were that led to that result. This power is what I mean when I talk of reasoning backward."*\
> Sherlock Holmes,\
> **A Study in Scarlet**,\
> Sir Arthur Conan Doyle (1887)"""

# ╔═╡ 11338610-a29b-4975-af5e-33ba3600b273
md"""
Kutipan itu berasal dari salah satu tokoh paling terkenal dalam sejarah ilmu pengetahuan, yaitu Sir Arthur Conan Doyle. Dia adalah penulis yang menciptakan karakter Sherlock Holmes, detektif fiksi yang sangat terkenal.

Kutipan tersebut mencerminkan salah satu kemampuan unik dari Sherlock Holmes, yaitu kemampuannya untuk "reasoning backward" atau berpikir mundur. Dalam konteks kutipan tersebut, Sherlock Holmes mengatakan bahwa kebanyakan orang, jika diberi rangkaian kejadian, mereka akan bisa memprediksi hasil akhirnya. Namun, hanya sedikit orang yang, jika diberi hasil akhir, dapat menemukan dengan kesadaran dalam diri mereka sendiri langkah-langkah apa yang mengarah ke hasil tersebut.

Jadi, dalam kata lain, kemampuan "reasoning backward" adalah kemampuan untuk menganalisis hasil akhir dan memahami langkah-langkah yang diperlukan untuk mencapai hasil tersebut. Sherlock Holmes menggunakan kemampuan ini untuk memecahkan misteri dan mencari petunjuk yang tidak terlihat oleh orang lain.

Kutipan tersebut menunjukkan betapa hebatnya kemampuan pemikiran mundur ini dalam mengungkapkan kebenaran dan menemukan solusi. Hal ini juga dapat menjadi inspirasi bagi kita untuk melatih kemampuan pemikiran analitis kita sendiri dan mampu melihat hubungan sebab-akibat dalam situasi yang kompleks.
"""

# ╔═╡ 174dc3f7-65a1-47d2-8120-226c76648f6b
md"""![reverse](https://github.com/ajamj/pkg-homework/blob/main/img/inversi_01.png?raw=true)\
Skema "reversing a forward problem" mengacu pada pendekatan yang digunakan dalam metode inversi. Biasanya, dalam sebuah masalah, kita memiliki "masalah maju" atau "forward problem," di mana kita memiliki pemahaman tentang parameter masukan dan ingin memprediksi hasil atau keluaran yang terkait.

Namun, dalam metode inversi, kita mengubah pendekatan ini dengan membalik arah masalah tersebut. Kita mencoba "membalikkan" masalah maju tersebut untuk mencari nilai-nilai parameter masukan yang paling sesuai dengan keluaran yang diamati atau diinginkan. Dengan kata lain, kita mencoba mendapatkan pemahaman tentang parameter masukan yang mungkin menghasilkan keluaran yang kita amati.

Misalnya, dalam konteks geofisika, kita dapat menggunakan metode inversi untuk memperoleh model yang menggambarkan struktur bawah permukaan tanah yang paling konsisten dengan data yang diukur. Dalam kasus ini, "masalah maju" adalah menghitung prediksi data pengukuran berdasarkan model struktur bawah permukaan tanah tertentu. Namun, dengan membalik arah masalah, kita mencoba mencari model struktur bawah permukaan tanah yang paling sesuai dengan data yang diukur.

Dalam skema "reversing a forward problem," kita menggunakan data pengukuran sebagai "petunjuk" dan mencoba mengembalikan nilai-nilai parameter yang dapat menghasilkan data tersebut. Metode inversi melibatkan optimisasi dan pencocokan data dengan model matematika atau numerik untuk mencari kombinasi parameter masukan yang paling cocok dengan keluaran yang diinginkan.

Jadi, dengan membalik arah masalah maju, skema "reversing a forward problem" dalam metode inversi memungkinkan kita untuk mendapatkan pemahaman yang lebih baik tentang parameter masukan yang paling sesuai dengan keluaran yang diamati atau diinginkan."""

# ╔═╡ 431bf188-9318-4e40-8cea-3fcd677d76f5
md"""
"Inverse problem" atau masalah inversi bisa dianggap sebagai pencarian informasi. Ketika kita memiliki masalah inversi, kita ingin mencari informasi yang mungkin tersembunyi dalam data yang kita miliki.

Dalam masalah inversi, kita memiliki data pengamatan atau hasil yang diamati, dan tujuannya adalah mencari model atau parameter yang dapat menjelaskan atau memprediksi data tersebut. Dalam konteks ini, pencarian tersebut dapat dianggap sebagai pencarian informasi yang terkandung dalam data.

Misalnya, dalam geofisika, ketika kita memiliki data pengukuran seismik atau medan magnet, kita ingin mencari informasi tentang struktur bawah permukaan tanah yang dapat menjelaskan data tersebut. Dengan menggunakan metode inversi, kita mencoba mengidentifikasi model atau parameter yang paling sesuai dengan data pengamatan kita. Dalam hal ini, kita melakukan pencarian informasi tentang struktur bawah permukaan tanah yang mungkin tersembunyi dalam data seismik atau medan magnet.

Begitu juga dalam konteks lain, seperti dalam ilmu fisika, matematika, atau bidang lainnya, masalah inversi dapat melibatkan pencarian informasi yang terkandung dalam data pengamatan atau hasil eksperimen. Metode inversi digunakan untuk memperoleh pemahaman yang lebih dalam tentang hubungan sebab-akibat, sifat-sifat sistem, atau struktur yang mendasari data yang diamati.

Jadi, dalam rangka mencari pemahaman yang lebih baik tentang data yang kita miliki, masalah inversi dapat dipandang sebagai "quest for information" atau pencarian informasi.
"""

# ╔═╡ 8444f125-e5d6-4792-9eb9-8563c2100065
md"""
Dalam menggambarkan anatomi metode inversi, kita bisa membaginya menjadi beberapa tahapan utama yang umumnya terjadi dalam prosesnya. Berikut adalah gambaran umum tentang anatomi metode inversi:

1. Formulasi Masalah: Tahap pertama dalam metode inversi adalah merumuskan masalah secara matematis. Ini melibatkan mendefinisikan parameter yang ingin ditentukan, membangun model matematika yang menghubungkan parameter tersebut dengan data pengamatan, dan menentukan persamaan inversi yang harus dipecahkan.

2. Pengumpulan Data: Tahap selanjutnya adalah pengumpulan data pengamatan yang diperlukan. Data ini bisa berupa data pengukuran langsung atau hasil pengamatan eksperimen yang diperoleh dari sistem yang ingin diteliti. Penting untuk mengumpulkan data yang relevan dan berkualitas tinggi agar hasil inversi dapat menjadi lebih akurat.

3. Penyelesaian Masalah Inversi: Tahap ini melibatkan penyelesaian persamaan inversi untuk mencari parameter yang paling sesuai dengan data yang diamati. Ini melibatkan penggunaan algoritma dan metode numerik untuk memperoleh solusi yang optimal. Proses ini bisa melibatkan optimisasi dan pencocokan data untuk menemukan model atau parameter yang paling sesuai dengan data.

4. Validasi dan Evaluasi: Setelah mendapatkan hasil inversi, tahap berikutnya adalah validasi dan evaluasi model atau parameter yang ditemukan. Ini melibatkan membandingkan hasil inversi dengan data pengamatan yang independen, melakukan analisis sensitivitas terhadap parameter, dan mengukur tingkat keakuratan dan ketepatan hasil inversi.

5. Interpretasi dan Pengambilan Keputusan: Tahap terakhir adalah interpretasi hasil inversi dan pengambilan keputusan berdasarkan hasil tersebut. Ini melibatkan pemahaman dan penafsiran tentang makna parameter yang ditemukan, menghubungkannya dengan konteks geologi atau fenomena yang sedang dipelajari, dan membuat keputusan berdasarkan informasi yang diperoleh.

Tentu saja, anatomi metode inversi dapat bervariasi tergantung pada aplikasinya dan jenis data yang digunakan. Namun, secara umum, langkah-langkah ini mencakup aspek fundamental dalam metode inversi.
"""

# ╔═╡ bcbfbd17-8b02-4273-83fe-79f4fbfed900
md""" ## Contoh Kasus Sederhana
Mari kita lihat contoh penerapan metode inversi dalam kasus yang sederhana: pemulihan distribusi resistivitas tanah.

Dalam geofisika, resistivitas tanah digunakan untuk memahami karakteristik struktur bawah permukaan. Untuk mendapatkan informasi tentang distribusi resistivitas tanah, metode inversi dapat digunakan. Berikut adalah langkah-langkah yang mungkin terlibat dalam contoh ini:

1. Pengumpulan Data: Data yang diperlukan adalah data resistivitas yang diukur di permukaan menggunakan metode geolistrik, seperti metode Wenner atau Schlumberger. Pengukuran ini memberikan nilai resistivitas pada titik-titik tertentu di permukaan tanah.

2. Model Matematika: Selanjutnya, kita membangun model matematika yang menghubungkan distribusi resistivitas tanah dengan data pengukuran. Dalam kasus ini, kita dapat menggunakan model inversi 2D sederhana yang mengasumsikan distribusi resistivitas hanya bervariasi dalam satu dimensi.

3. Persamaan Inversi: Dalam metode inversi, kita harus merumuskan persamaan inversi yang akan memungkinkan kita mencari distribusi resistivitas tanah yang paling sesuai dengan data pengukuran. Ini melibatkan pemodelan matematika, seperti persamaan Least Squares atau persamaan Tikhonov, yang menggabungkan data pengukuran dengan fungsi objektif untuk mencari solusi optimal.

4. Pemecahan Persamaan Inversi: Setelah merumuskan persamaan inversi, kita menggunakan algoritma dan metode numerik untuk memecahkan persamaan tersebut dan mendapatkan distribusi resistivitas yang paling sesuai dengan data pengukuran. Ini melibatkan iterasi dan optimisasi untuk mengoptimalkan solusi.

5. Validasi dan Evaluasi: Setelah mendapatkan hasil inversi, kita perlu melakukan validasi dan evaluasi. Ini melibatkan membandingkan hasil inversi dengan data pengukuran independen, melakukan analisis sensitivitas untuk melihat pengaruh perubahan resistivitas terhadap data pengukuran, dan mengukur tingkat keakuratan dan ketepatan hasil inversi.

6. Interpretasi dan Pengambilan Keputusan: Terakhir, berdasarkan hasil inversi yang diperoleh, kita melakukan interpretasi dan pengambilan keputusan. Ini melibatkan memahami makna distribusi resistivitas yang ditemukan dan menghubungkannya dengan karakteristik geologi atau fenomena yang sedang dipelajari. Hasil ini dapat membantu dalam pengambilan keputusan terkait aplikasi geoteknik, eksplorasi sumber daya alam, atau pemodelan lingkungan.

Itulah gambaran umum tentang penerapan metode inversi dalam pemulihan distribusi resistivitas tanah. Tentu saja, implementasi yang sebenarnya akan melibatkan langkah-langkah dan teknik yang lebih rinci, tergantung pada kompleksitas masalah dan data yang tersedia.
"""

# ╔═╡ 9b4086f8-8e90-4ceb-b074-c1d8cf39b385
md""" ## Estimation dan Appraisal
![estimation appraisal](https://github.com/ajamj/pkg-homework/blob/main/img/inversi_02.png?raw=true)\
Coba bayangin kita lagi main game online, dan di dalam game itu ada suatu item yang super langka dan bernilai tinggi. Kamu pengen tahu berapa harga sebenarnya dari item itu sebelum kamu jual. Nah, di sinilah "estimation and appraisal" masuk ke dalam permainan.

Pertama, kamu mulai naksir dan mengestimasi harga item itu berdasarkan data dan pengamatan kamu sejauh ini. Kamu lihat harga item serupa yang sudah dijual oleh pemain lain dan berusaha memperkirakan berapa harga yang sebanding untuk itemmu. Kamu bisa aja minta pendapat teman-temanmu tentang estimasi harganya.

Setelah itu, kamu melakukan penilaian lebih mendalam. Kamu coba cari tahu informasi tambahan tentang item tersebut, seperti keunikan, popularitas, atau sejarah harga. Kamu bisa browsing forum atau bertanya kepada pemain lain yang udah punya pengalaman dengan item itu. Semakin banyak informasi yang kamu dapetin, semakin akurat penilaianmu.

Tapi ingat, estimasi dan penilaian ini enggak selalu 100% tepat. Seperti saat kamu main game, selalu ada ketidakpastian. Kamu cuma bisa ngasih perkiraan berdasarkan apa yang kamu tahu sejauh ini. Jadi, penting juga buat tetap fleksibel dan siap mengubah perkiraan kamu ketika ada informasi baru yang muncul.

Intinya, "estimation and appraisal" itu kayak kamu mencoba menebak harga suatu item berdasarkan data dan informasi yang ada. Kamu mencari tahu sebanyak mungkin dan memberikan perkiraan yang seakurat mungkin. Itu penting supaya kamu bisa mengambil keputusan yang lebih cerdas dan nggak terjebak dalam ketidakpastian.

Jadi, seperti main game online, estimasi dan penilaian ini memungkinkan kamu untuk "grind" informasi dan mencoba mendapatkan harga yang optimal. Jangan lupa, dalam game dan kehidupan nyata, estimasi yang lebih akurat bisa bikin kamu "win" dalam pengambilan keputusan!"""

# ╔═╡ 0f5aa5d3-5978-4674-9dd3-48b4c2e7a71b
md""" ## Model
Model dalam konteks metode inversi itu bisa diumpamakan kayak foto diri kita yang di-edit di aplikasi kecantikan. Gue jelasin pake analogi ini ya.

Jadi, bayangin kamu punya foto diri yang asli, tapi kamu pengen tahu gimana penampilan kamu kalo muka kamu dikasih efek-efek kecantikan. Nah, aplikasi kecantikan itu kayak metode inversi yang dipake buat mendapatkan model.

Model ini adalah representasi atau gambaran dari struktur bawah permukaan tanah atau fenomena yang kita coba teliti. Misalnya, dalam geofisika, kita pengen tau gimana bentuk dan sifat tanah di bawah permukaan. Nah, metode inversi membantu kita bikin model yang bisa memperkirakan gimana bentuk dan sifat tanah tersebut berdasarkan data geofisika yang kita punya.

Jadi, model ini kayak hasil edit foto kamu dengan efek-efek kecantikan. Aplikasi kecantikan itu menganalisis foto asli kamu dan menghasilkan model baru yang menggambarkan penampilan kamu yang diubah. Begitu juga dengan metode inversi, dia menganalisis data geofisika dan menghasilkan model yang menggambarkan struktur bawah permukaan tanah.

Tapi, sama kayak foto editan, model yang dihasilkan ini enggak 100% akurat. Kadang-kadang bisa ada kesalahan atau ketidakpastian dalam proses pembuatan model. Jadi, kita harus tetap kritis dan mempertimbangkan hasil model ini dengan hati-hati.

Jadi, model dalam metode inversi itu kayak hasil editan foto yang menggambarkan struktur bawah permukaan tanah atau fenomena yang kita teliti. Itu adalah representasi yang didapatkan berdasarkan data geofisika, kayak foto kamu yang diubah-ubah dengan efek-efek kecantikan. Jadi, metode inversi ini bantu kita "edit" struktur bawah permukaan tanah supaya kita bisa paham lebih dalam tentang apa yang ada di bawah sana."""

# ╔═╡ 2278b36c-da4f-484e-91e2-4f3794b1c115
md""" ## Diskritisasi Model Kontinyu
Diskritisasi model kontinyu adalah proses mengubah model kontinu menjadi model yang terdiri dari elemen diskrit atau segmen-segmen diskrit. Dalam konteks metode inversi, diskritisasi digunakan ketika kita ingin merepresentasikan struktur bawah permukaan tanah dalam bentuk model yang terdiri dari elemen diskrit, misalnya grid atau jaringan sel-sel.

Bayangkan kamu punya sebuah kue cokelat yang bentuknya kontinu, seperti permukaan tanah yang kita ingin teliti. Nah, diskritisasi itu kayak ngiris kue itu menjadi beberapa bagian diskrit, kayak potongan-potongan kotak kecil. Setiap kotak kecil tersebut mewakili elemen diskrit dalam model.

Diskritisasi model kontinyu penting dalam metode inversi karena memungkinkan kita untuk memproses data geofisika secara lebih efisien dan memperoleh informasi yang lebih detail tentang struktur bawah permukaan tanah. Dengan membagi model menjadi elemen-elemen diskrit, kita dapat menghitung estimasi atau parameter geofisika di setiap elemen dengan lebih mudah.

Contohnya, jika kita ingin mengestimasi distribusi kecepatan gelombang seismik di bawah permukaan tanah, kita bisa membagi model kontinu menjadi grid atau jaringan sel-sel kecil. Setiap sel di grid itu mewakili nilai kecepatan gelombang di lokasi tertentu. Dengan demikian, kita bisa menghitung estimasi kecepatan gelombang di setiap sel berdasarkan data geofisika yang kita punya.

Diskritisasi juga membantu dalam memperoleh representasi yang lebih sederhana dan terstruktur dari model kontinu yang kompleks. Dengan menggantinya dengan elemen-elemen diskrit, kita dapat memahami dan memvisualisasikan model dengan lebih baik.

Jadi, diskritisasi model kontinyu itu adalah proses mengubah model yang kontinu menjadi model yang terdiri dari elemen-elemen diskrit. Ini memudahkan kita dalam memproses data geofisika, menghitung estimasi, dan memahami struktur bawah permukaan tanah dengan lebih baik."""

# ╔═╡ d25be995-3622-42b4-a7ea-af57b4168685
md""" ## Regresi Linier
Oke, bro! Aku jelasin tentang regresi linear pake bahasa gaul, interaktif, dan analogis buat kamu.

Regresi linear itu kayak ngehubungin dua hal yang punya hubungan linear, kayak duo sepakbola yang sering nongkrong bareng di lapangan. Bayangin ada dua pemain sepakbola, si A dan si B, yang selalu main bareng dan performanya selalu ada hubungan linier.

Jadi, regresi linear itu kayak ngeliatin data performa mereka seiring waktu. Kita coba nyari persamaan garis yang paling pas buat ngehubungin performa si A dengan performa si B. Dari data-datanya, kita bisa bikin garis regresi linear yang ngasih kita perkiraan performa si B berdasarkan performa si A.

Nah, kaitannya dengan metode inversi, regresi linear ini sering digunakan sebagai salah satu metode untuk mengestimasi hubungan antara dua variabel dalam proses inversi. Misalnya, dalam geofisika, kita punya data pengukuran di permukaan dan kita ingin memperkirakan karakteristik bawah permukaan tanah.

Dengan menggunakan regresi linear, kita bisa menentukan hubungan antara data yang kita punya di permukaan dengan karakteristik bawah permukaan yang ingin kita ketahui. Persamaan garis regresi linear ini bisa digunakan untuk memperkirakan karakteristik tanah di lokasi-lokasi yang belum diukur.

Jadi, regresi linear itu kayak duo sepakbola yang performanya berhubungan linier. Kita nyari persamaan garis yang pas buat ngehubungin performa mereka. Dalam metode inversi, regresi linear digunakan buat memperkirakan hubungan antara data yang ada di permukaan dengan karakteristik bawah permukaan yang ingin kita ketahui.

Pokoknya, regresi linear ini membantu kita bikin perkiraan yang lebih akurat dan bisa jadi alat penting dalam proses inversi.
"""

# ╔═╡ 1ae5497d-daec-4862-82c7-49cc58c88ef1
md""" ## Karakterisasi Masalah Inversi
Eits, gue ngerti nih, bro! Oke, gue jelasin karakterisasi masalah inversi pake bahasa gaul ala anak Jaksel buat kamu.

Karakterisasi masalah inversi itu kayak ngejelasin dulu sebelum main game seru. Jadi, bayangin kita mau main game petualangan seru banget di hutan. Sebelum kita mulai, kita harus tau tujuan mainnya, seperti nyari harta karun atau mengalahkan monster. Nah, karakterisasi masalah inversi itu kayak kita nentuin tujuan mainnya.

Terus, kita juga harus tau apa yang ada di hutan, misalnya ada pohon besar, sungai, atau jalan setapak. Nah, dalam karakterisasi masalah inversi, kita harus tau jenis data yang kita punya. Apakah data itu akurat, lengkap, atau ada gangguan lainnya. 

Selanjutnya, kita harus pikirin gimana cara kita mau main gamenya. Misalnya, mau pake strategi yang rumit atau yang simpel aja. Nah, dalam karakterisasi masalah inversi, kita pikirin juga jenis model yang kita mau pake. Apakah modelnya yang rumit atau yang sederhana.

Terus, kita juga harus tau kemungkinan adanya masalah atau ketidakpastian dalam game kita. Misalnya, ada jembatan yang rusak atau ada hewan buas di sekitar. Nah, dalam karakterisasi masalah inversi, kita perlu pikirin juga masalah atau ketidakpastian yang bisa muncul dalam data atau model kita.

Jadi, karakterisasi masalah inversi itu kayak nentuin tujuan main game, ngecek apa aja yang ada di sekitar kita, mikirin strategi mainnya, dan siapin solusi buat masalah yang mungkin muncul. Dengan karakterisasi yang baik, kita bisa main game dengan lebih siap dan sukses.

Nah, bro, sekarang kamu udah paham kan tentang karakterisasi masalah inversi dengan bahasa gaul ala anak Jaksel? Yuk, siap-siap main game inversi dengan penuh semangat!
"""

# ╔═╡ b0f0ee92-7b9a-4c95-b7bc-b0abbf6b4805
md""" ## Tipe-tipe Masalah Inversi
1. Inversi linier: Ini kayak pas lagi ngejodohin dua orang yang hubungannya lurus-lurus aja, gak rumit. Misalnya, si A sama si B emang cocok banget, jadi gue cariin persamaan garis yang pas buat mereka. Persamaan garis ini ngebantu gue estimasi hubungan mereka dengan lebih mudah.

2. Inversi non-linier: Beda sama yang linier, ini pas lagi jodohin dua orang yang hubungannya rumit dan bikin pusing. Misalnya, si A dan si B itu hubungannya gak lurus-lurus, tapi meliuk-meliuk kayak jalan berliku. Nah, dalam inversi non-linier, gue harus cari cara yang lebih kompleks buat estimasi hubungan mereka yang rumit ini.

3. Inversi kecil-kuadrat: Ini kayak gue lagi main tebak-tebakan, tapi gue harus cari jawaban yang paling mendekati dengan kesalahan yang paling kecil. Misalnya, ada data pengukuran yang gak sempurna, jadi gue harus cari solusi yang paling cocok dengan data itu dengan meminimalkan kesalahan.

4. Inversi probabilistik: Ini kayak gue main judi, bro! Gue harus perhitungin peluang-peluangnya berdasarkan data yang ada. Gue bikin model yang ada peluangnya berdasarkan distribusi probabilitas, jadi gue bisa dapetin perkiraan terbaik dan juga rentang kepercayaan yang mungkin.

5. Inversi berbasis model: Ini kayak lagi upgrade game yang udah ada. Misalnya, gue punya model yang udah ada tentang suatu masalah. Tapi gue mau tambahin atau perbaiki model itu berdasarkan data baru yang gue punya. Jadi gue cari parameter tambahan yang paling pas buat nge-upgrade model yang udah ada.

Jadi, bro, tipe-tipe masalah inversi itu kayak jodoh-jodohan, tebak-tebakan, judi, atau upgrade game. Tergantung dari hubungan data dan parameter yang mau diestimasi, kompleksitas masalahnya, dan tingkat ketidakpastian yang ada. Semakin paham tipe masalah inversi, semakin siap kita hadapi tantangannya dan dapetin hasil yang lebih mantap!"""

# ╔═╡ b19d3922-ca3e-43d1-868c-19d7355578e0


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

julia_version = "1.9.0"
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
# ╟─36a7d603-503f-4573-93ca-7748f36f3c0b
# ╟─e2f429d2-2ce9-4bd2-be22-8a5f1bb1fa82
# ╟─c752d570-019a-11ee-1f24-7d853caa2209
# ╟─4197ddad-a01c-4c93-9a14-049cea8d6862
# ╟─ad807e5d-f70a-4f50-8813-76a4c06763b6
# ╟─f612c525-afcd-4683-8d2f-305f8af55d5b
# ╟─6fb09992-7abe-4205-972c-e159debba051
# ╟─11338610-a29b-4975-af5e-33ba3600b273
# ╟─174dc3f7-65a1-47d2-8120-226c76648f6b
# ╟─431bf188-9318-4e40-8cea-3fcd677d76f5
# ╟─8444f125-e5d6-4792-9eb9-8563c2100065
# ╟─bcbfbd17-8b02-4273-83fe-79f4fbfed900
# ╟─9b4086f8-8e90-4ceb-b074-c1d8cf39b385
# ╟─0f5aa5d3-5978-4674-9dd3-48b4c2e7a71b
# ╟─2278b36c-da4f-484e-91e2-4f3794b1c115
# ╟─d25be995-3622-42b4-a7ea-af57b4168685
# ╟─1ae5497d-daec-4862-82c7-49cc58c88ef1
# ╟─b0f0ee92-7b9a-4c95-b7bc-b0abbf6b4805
# ╠═b19d3922-ca3e-43d1-868c-19d7355578e0
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
