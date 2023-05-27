### A Pluto.jl notebook ###
# v0.19.26

using Markdown
using InteractiveUtils

# ╔═╡ 07a4255e-4b73-4fc9-8059-67727789dae1
using Plots, PlutoUI, Images, DataFrames, Statistics, NamedArrays, ScikitLearn, RDatasets, StatsBase, PyCall, PyPlot

# ╔═╡ d1cac0d0-5615-4096-bae1-1dca4eef3538
using ScikitLearn.CrossValidation

# ╔═╡ f33c17c5-9fa0-496f-bee3-3e8c4ea1e684
using NearestNeighbors

# ╔═╡ 8f160e80-f75d-11ed-037b-4d1603fba55d
md"""
# Supervised Learning: Classification
"""

# ╔═╡ d2483a60-aa2d-4287-9bfe-477f2ff93c72
md"""
## Pakeeeet
"""

# ╔═╡ a3de3ec7-ea17-4a94-8cd6-cca79fa2a725
TableOfContents(title="📚 Table of Contents", indent=true, depth=4, aside=true)

# ╔═╡ b9047edc-7c3b-41ed-b356-8a5949b051ee
md"""
Modul terakhir kita udah bikin model linear regression buat ngeprediksi harga rumah di Boston. Sekarang kita mau bahas masalah klasifikasi yang fokusnya ngeprediksi nilai yang cuma bisa pilih-pilih.

Jadi, data diskrit itu cuma bisa punya nilai tertentu aja, gak bisa sembarangan nilai kayak yang kontinu gitu.

Contoh masalah klasifikasi itu bisa misalnya:
- Ngeprediksi apakah kanker payudara itu jinak atau ganas, berdasarkan fitur-fiturnya.
- Klasifikasi gambar apakah ada kucing, anjing, atau kuda.
- Ngeprediksi apakah email itu spam atau bukan, cuma dari alamat emailnya aja.

Intinya, labelnya itu bentuknya kategori gitu, terbatas banget pilihan-pilihannya.
Data diskrit bisa berupa angka juga, misalnya jumlah murid di kelas, atau bisa juga berupa kategori kayak merah, biru, atau kuning.kuning.
"""

# ╔═╡ 580506b4-33d6-4612-a47f-0f203a066c07
md"""
## Binary and Multi-class Classification
Ada dua jenis klasifikasi: **binary** dan **multi-class**. Kalau ada dua kelas yang mau diprediksi, itu adalah masalah klasifikasi binary. Contohnya, klasifikasi tumor jinak atau ganas. Kalau ada lebih dari dua kelas, maka itu adalah masalah klasifikasi multi-class. Contohnya, mengklasifikasikan spesies bunga iris, yang bisa berupa versicolor, virginica, atau setosa, berdasarkan karakteristik sepal dan petalnya.

Algoritma yang umum digunakan untuk klasifikasi antara lain *regresi logistik*, *k-nearest neighbors*, *pohon keputusan (decision tree)*, *naive bayes*, *support vector machines*, *jaringan saraf tiruan*, dan sebagainya. Di sini kita akan belajar cara menggunakan *k-nearest neighbors* untuk mengklasifikasikan spesies iris.

Supervised learning dibagi menjadi masalah regresi dan masalah klasifikasi. Keduanya memiliki tujuan yang sama, yaitu membangun fungsi pemetaan dari variabel masukan (X) ke variabel keluaran (y). Perbedaannya terletak pada variabel keluarannya, yang kontinu dalam regresi dan kategorikal dalam klasifikasi."""

# ╔═╡ c481d00c-1c8f-44d1-9673-00b978d65cf7
md"""
## Iris Dataset
Jadi, ada database yang terkenal banget namanya database iris. Nah, database ini sebenernya pertama kali digunakan sama Sir R. A. Fisher dan sering banget dipakai di literatur pengenalan pola (pattern recognition). Di database ini, ada 150 tanaman iris, dan tiap tanaman punya 4 atribut numerik yang diukur: panjang sepal dalam satuan cm, lebar sepal dalam satuan cm, panjang kelopak dalam satuan cm, dan lebar kelopak dalam satuan cm.

Nah, tugasnya adalah memprediksi jenis setiap tanaman iris ini. Jenisnya ada 3, yaitu iris-setosa, iris-versicolor, atau iris-virginica. Jadi, berdasarkan atribut-atribut yang udah diukur ini, kita mau nebak jenis tanaman irisnya tuh termasuk yang mana.
"""

# ╔═╡ 2d5ee741-4849-4e38-8d3c-95c0bd67e30b
load(download("https://api.sololearn.com/DownloadFile?id=3831"))

# ╔═╡ 1fb09b83-c335-4279-bc35-0d86a09beb6e
md"""
Buat ngeliat list dataset yang ada dalam paket RDatasets, lo bisa pake:
"""

# ╔═╡ 6c0cd3f2-2dba-452b-8e45-849e34e24397
RDatasets.datasets()

# ╔═╡ f0e542ef-7f09-4a3f-ab6c-2700a5138fc0
md"""
Kalo lo nyari, di datasets tersebut ada dataset iris.
"""

# ╔═╡ 07ac9fbc-f60f-4fd5-afb0-2fbbf1071957
filter(row -> row.Dataset == "iris", RDatasets.datasets())


# ╔═╡ 3558b2bd-f25f-4a90-8712-3bb5ae0e738f
md"""
Untuk ngeload datasetnya, lo bisa pake:
"""

# ╔═╡ a2068e1d-8424-4163-9203-198587291ceb
iris = dataset("datasets", "iris")

# ╔═╡ 1d273845-9d26-4bf2-b6f6-5cad6dbe533d
md"""
Parameter pertama diisi dengan nama `Package`. Parameter kedua diisi dengan nama `Dataset`.
"""

# ╔═╡ 1caeb827-fc6a-49a2-bb6f-097c720f91dc
md"""
Buat ngecek dimensi dan beberapa baris pertama dari DataFrame-nya di Julia, kita bisa pake cara berikut:
"""

# ╔═╡ ccefc503-3bfd-4c17-9e99-07abbc86f889
size(iris)  # Cek dimensinya

# ╔═╡ 1687eca6-36a7-4fb7-85ae-e6b1f2aafb6e
first(iris, 5)  # Liat baris pertamanya, cuma 5 aja

# ╔═╡ 51ca8d59-aa75-4b3f-b7d6-960635bf167b
md"""
Jadi, `size(iris)` bakal ngasih tau kita berapa jumlah baris dan kolom dari DataFrame `iris`-nya. Terus, `first(iris, 5)` bakal nampilin baris-baris pertama dari DataFrame `iris`, cuma 5 aja.
"""

# ╔═╡ 271dcd99-fdc7-4918-9f98-547638aa0a0b
md"""
Pas kita lagi belajar tentang algoritma machine learning, menggunakan data yang sederhana dan gampang dipahami seperti dataset bunga iris itu bermanfaat banget. Data yang kayak gitu bisa bantu ngekurangi learning curve dan bikin lebih mudah buat dipahami dan debug.

Dengan data yang sederhana dan well-behaved kayak iris flower dataset, kita bisa lebih fokus ke konsep-konsep dasar dari algoritma machine learning tanpa terlalu ribet sama masalah kompleks dari data yang lebih rumit. Ini jadi kesempatan bagus buat memahami algoritma dan melakukan debugging dengan lebih efektif.

Jadi, dengan menggunakan dataset yang well-behaved seperti iris flower dataset, kita bisa lebih lancar dan nyaman dalam mempelajari algoritma machine learning.
"""

# ╔═╡ 3b895a35-2893-4bc5-bf54-be1d0d415c68
md"""
Cek statistik ringkasnya:
"""

# ╔═╡ e8e970a8-e8b1-4214-92ac-25b307241c9a
describe(iris,:all)

# ╔═╡ 2801bb38-cfb4-46b5-aaea-f19d5cb4cec3
md"""
Fungsi `describe()` ini bakal nampilin statistik ringkas dari setiap kolom dalam DataFrame `iris`, kayak jumlah data, rata-rata, standar deviasi, nilai minimum, nilai maksimum, dan juga kuartil-kuartilnya.
"""

# ╔═╡ 231ef95b-547e-404e-9366-ee486ba5478f
md"""
Semua fitur di sini angkanya beda-beda dan gak ada yang kelewat atau hilang nilainya, jadi datanya udah rapi nih.

Rentang angka dari setiap atribut ini masih sekitar level yang sama, jadi kita bisa lewatin langkah standarisasi dulu. Tapi, tau gak, kadang-kadang kita perlu standardisasi ini buat ngelakuin preprosesing yang penting buat algoritma machine learning. Jadi, bisa dibilang ini tuh scaling fiturnya, biar lebih enak diproses sama algoritma. Kalo mau tau lebih detil soal pentingnya scaling fitur, bisa cek sendiri deh.

Jadi, intinya sekarang kita skip dulu standardisasinya karena rentang angkanya masih mirip-mirip, tapi tetep harus diinget ya, standardisasi bisa jadi langkah yang penting di tahap pra-pemrosesan tergantung dari algoritma machine learning yang digunakan.
"""

# ╔═╡ 5fc14e03-3f89-46f6-88bc-070b3d26b8f1
md"""
## Class Distribution
Dataset ini ada 3 kelas dengan masing-masing 50 contoh data. Buat ngecek ini, kita bisa lakukan langkah berikut ini:
"""

# ╔═╡ 9cb7b0f7-9379-4847-892b-f4c64ee3d62f
combine(groupby(iris, :Species), nrow => :size)

# ╔═╡ 9cc250b2-38a1-40c0-ac5f-28df3472c525
md"""
Metode di atas berguna banget supaya kita tahu distribusi datanya. Dataset iris ini termasuk balanced dataset karena jumlah data di setiap kelas terdistribusi dengan rata.

Contohnya, dataset `fraud` itu termasuk imbalanced dataset. Biasanya, cuma sebagian kecil dari total transaksi yang beneran penipuan, sekitar 1 dari 1000. Nah, kalo dataset imbalanced, analisis yang sedikit berbeda bakal digunakan. Jadi, penting buat kita ngerti apakah datanya *balanced* atau *imbalanced*.

Imbalanced dataset itu artinya kelas-kelas dalam data gak terwakili secara sama. Buat liat lebih lanjut tentang data imbalanced, cek [link ini](https://machinelearningmastery.com/tactics-to-combat-imbalanced-classes-in-your-machine-learning-dataset/), bro.
"""

# ╔═╡ 5408755c-014c-4a78-99db-6e451cb81de0
md"""
# Data Visualization
## Univariate Plot
Buat lebih paham tentang setiap atributnya, kita bisa mulai dengan plot univariat, maksudnya plot untuk masing-masing variabelnya. Buat dataset iris ini, kita bisa bikin histogramnya pake kode berikut:
"""

# ╔═╡ bfc3c304-7bfb-4ae3-9144-f8d12ee0c12d
begin
	p1 = histogram(iris[:,1], title="SepalLength")
	p2 = histogram(iris[:,2], title="SepalWidth")
	p3 = histogram(iris[:,3], title="PetalLength")
	p4 = histogram(iris[:,4], title="PetalWidth")
	plot(p1, p2, p3, p4, layout=(2, 2), legend=false)
end 

# ╔═╡ facfa26e-b5be-44d9-930b-a974f0c0a313
md"""
Plot histogramnya ngasih kita gambaran yang lebih jelas tentang distribusi dari variabel masukan. Kita bisa lihat bahwa sepal length dan sepal width punya distribusi yang "normal" banget, bro. Artinya, distribusinya punya bentuk symmetric bell shape dan kece banget. Tapi, beda ceritanya sama panjang kelopak bunga (petal length). Plotnya nunjukin ada dua puncak, satu deket nol dan satu lagi di sekitar lima. Nah, buat lebar kelopak (petal width), pola-pola yang munculnya sedikit banget.

Histogram itu sejenis grafik batang yang nunjukin jumlah atau frekuensi relatif dari nilai-nilai yang jatuh dalam interval atau rentang kelas yang berbeda. Ada juga plot univariat lainnya kayak density plot sama boxplot yang bisa bantu kita ngeliatin ringkasan dari variabelnya.
"""

# ╔═╡ 55954998-3298-4b75-9f78-0cc72aef7125
md"""
## Multivariate Plot
Bro, buat ngeliat interaksi antara atribut-atributnya, kita bisa pake scatter plot. Tapi, susah banget kan ngeliat grup-grupnya kalo kita gak tahu spesies asli dari bunga yang direpresentasikan oleh data. Makanya, kita bikin kode warna buat masing-masing spesies biar bisa bedain spesiesnya secara visual:
"""

# ╔═╡ 0bf07e51-4aa9-4dd5-a47c-d0209462d03a
begin
	# Membangun kamus yang memetakan spesies ke kode integer
	inv_name_dict = Dict(
    "setosa" => 1,
    "versicolor" => 2,
    "virginica" => 3
	)

	colors = [inv_name_dict[item] for item in iris.Species]

	# Plot scatter
	scatter(iris.SepalLength, iris.SepalWidth, group = colors, xlabel = "sepal length (cm)", ylabel = "sepal width (cm)", legend = :topleft)
end

# ╔═╡ 4158b26b-0b9d-405b-a8af-00e390530805
begin
	# Membangun kamus yang memetakan spesies ke kode integer
	petal_name_dict = Dict(
    "setosa" => 1,
    "versicolor" => 2,
    "virginica" => 3
	)

	colors_petal = [petal_name_dict[item] for item in iris.Species]

	# Plot scatter
	scatter(iris.PetalLength, iris.PetalWidth, group = colors_petal, xlabel = "petal length (cm)", ylabel = "petal width (cm)", legend = :topleft)
end

# ╔═╡ cd90839c-1e54-4c0a-b44b-13c9cbd26429
md"""
## K nearest neighbors
Bro, K nearest neighbors (KNN) itu model machine learning yang bersifat supervised. Jadi, model ini akan ngambil satu data point, trus lihat k data point terdekat yang udah diketahui labelnya, terus nentuin label untuk data point tersebut berdasarkan mayoritas suara.

Kita bisa lihat bahwa mengubah nilai k bisa berpengaruh pada hasil prediksi model. Dalam KNN, k itu adalah hyperparameter. Nah, hyperparameter itu adalah parameter yang nilainya udah ditentuin sebelum proses pembelajaran dimulai. Nanti kita akan belajar cara nge-tune hyperparameter ini.

Misalnya, lihat gambar di bawah ini. Ada dua kelas: kotak biru dan segitiga merah. Label apa yang harus kita berikan ke titik hijau yang belum diketahui labelnya, berdasarkan algoritma 3NN, yaitu ketika k=3? Dari 3 data point terdekat dari titik hijau (lingkaran garis solid), dua di antaranya adalah segitiga merah dan satu lagi kotak biru. Jadi, titik hijau diprediksi sebagai segitiga merah. Kalo k=5 (lingkaran garis putus-putus), maka diprediksi sebagai kotak biru (3 kotak biru versus 2 segitiga merah, kotak biru lebih banyak).

Jadi, dalam KNN, kita memilih label berdasarkan mayoritas suara dari tetangga terdekatnya sesuai dengan nilai k yang kita tentukan.
"""

# ╔═╡ eeb5a22c-74ab-48ed-a31c-1529b6e472ff
load(download("https://api.sololearn.com/DownloadFile?id=3838"))

# ╔═╡ d72e8039-47e4-4732-b18f-32ca4ad8e68f
md"""
Di dalam Julia, algoritma k nearest neighbors diimplementasikan dalam paket NearestNeighbors:
"""

# ╔═╡ 2fc06331-1613-4c48-9888-cd88658f0579
md"""
Lihatlah contohnya dalam dataset iris kita di bawah ini. Tiga tetangga paling dekat dari data yang ditunjuk oleh warna merah adalah setosa (warna ungu).
"""

# ╔═╡ 6cc7e533-c49a-4ef7-933c-e18189ac0d49
load(download("https://api.sololearn.com/DownloadFile?id=3839"))

# ╔═╡ 2c72f583-c0b8-455d-a1f7-33d6355d086a
md"""
Jadi, berdasarkan 3-nn, data yang ditunjuk oleh panah tersebut seharusnya diberi label iris-setosa juga.

K nearest neighbors juga bisa digunakan untuk masalah regresi. Perbedaannya terletak pada cara prediksinya. Di KNN untuk regresi, bukan menggunakan mayoritas suara, melainkan menggunakan rata-rata label dari k data point terdekat untuk membuat prediksi. Jadi, nilai prediksi regresi dihasilkan dari rata-rata label dari k tetangga terdekat tersebut.
"""

# ╔═╡ bb1eb372-68b8-46ef-a7e1-9a77ca77025c
md"""
# Modeling
## Data Preparation
Sebelumnya kita mengidentifikasi bahwa panjang dan lebar kelopak bunga adalah fitur yang paling berguna untuk memisahkan spesies-spesies tersebut; maka kita menentukan fitur dan label sebagai berikut:



"""

# ╔═╡ 615411e4-dcfc-4ad9-853b-8b05be671d2f
X = reshape(convert(Array, [iris.SepalLength iris.SepalWidth iris.PetalLength iris.PetalWidth]), (150, 4))

# ╔═╡ 0a364111-5d8b-4d3e-80f8-103b556b71e3
y = convert(Array, iris.Species)

# ╔═╡ 747e49b4-9295-448f-9018-e56e25555369
md"""
Ingat, untuk mengevaluasi kinerja model, kita melakukannya pada data yang tidak dilihat oleh model saat proses konstruksi. Oleh karena itu, kita menyisihkan sebagian data sebagai data uji yang akan mensimulasikan data yang tidak diketahui oleh model di masa depan. Seperti yang kita lakukan dalam modul sebelumnya, kita menggunakan `train_test_split` dari `ScikitLearn.CrossValidation`.
"""

# ╔═╡ 30bce95f-656d-4382-aba4-f73733aa1e36
X_train, X_test, Y_train, Y_test = train_test_split(X, y, test_size=0.3, random_state=42, stratify=y)

# ╔═╡ c9e24a4d-3fa8-4ebb-a03e-7d68f3f9a0d5
md"""
Kita menggunakan pembagian 70-30, yaitu 70% data digunakan untuk pelatihan dan 30% untuk pengujian.
"""

# ╔═╡ 72603079-c545-4eef-b986-f5518bf409ed
size(Y_train)

# ╔═╡ b78406ec-385b-42d7-9e57-9beac25f0561
size(Y_test)

# ╔═╡ 0970e48d-4e9f-47be-beef-b120d83bf0c9
countmap(Y_train)

# ╔═╡ 7462a53a-9e05-4dc3-a1ad-2ccd9b2ebb7c
md"""
## Modeling
Sekarang kita siap untuk membangun dan melatih model knn. Pertama, kita mengimpor kelas modelnya:
"""

# ╔═╡ 4bf31ddb-015b-4f43-a35e-e0607a103a64
@sk_import neighbors: KNeighborsClassifier

# ╔═╡ a936e05a-26eb-4d76-ac49-b2bfad4bae57
knn = KNeighborsClassifier(n_neighbors=5)

# ╔═╡ 9f1cf2c2-a1a6-4d5f-bbe2-11bbf18eda0a
md"""
Perhatikan bahwa parameter yang perlu kita atur dalam masalah ini adalah `n_neighbors`, atau `k` seperti dalam knn. Kita setel `k` menjadi 5 secara acak.

Gunakan data `X_train` dan `Y_train` untuk melatih model:
"""

# ╔═╡ 819815d6-74a5-4c46-a689-2f7d267bf391
ScikitLearn.fit!(knn, X_train, Y_train)

# ╔═╡ 338c9a25-459c-4bfd-9ac7-1805d8b91591
md"""
## Prediction
Untuk melakukan prediksi dalam ScikitLearn, kita dapat memanggil metode `predict()`. Kita akan mencoba memprediksi spesies iris menggunakan fitur-fitur yang ada dalam matriks fitur X.

Mari kita lakukan prediksi pada data uji dan simpan hasilnya dalam variabel pred untuk ditinjau nanti:
"""

# ╔═╡ 01d4e401-4a28-4088-bcd1-c9828da9f4dc
pred = ScikitLearn.predict(knn, X_test)

# ╔═╡ fc2f493f-ffe0-4964-8fac-2761ea001d36
md"""
Mari kita tinjau lima prediksi pertama:
"""

# ╔═╡ 0d7c720a-28ab-4448-976b-bfabeea2fccc
first_five_pred = pred[1:5]

# ╔═╡ 02e1e36b-8243-4c82-ab65-0e3649c6b83f
md"""
## Probability Prediction
Dari semua algoritma klasifikasi yang diimplementasikan dalam scikit-learn, terdapat metode tambahan `predict_prob`. Alih-alih membagi label, metode ini menghasilkan probabilitas untuk target dalam bentuk array. Mari kita lihat bagaimana probabilitas yang diprediksi untuk bunga ke-11 dan ke-12:
"""

# ╔═╡ beabe24e-f5b5-444a-a082-f9670a138193
proba = predict_proba(knn, X_test)

# ╔═╡ 3c6ef5e6-8f6d-40fb-9adb-3710160f1513
eleventh_proba = proba[11, :]

# ╔═╡ 5f06af67-c860-4ae1-9268-1a24727c343f
twelfth_proba = proba[12, :]

# ╔═╡ ae754d3a-a794-4f07-bc7e-dc0890dab4a8
pred[11:12]

# ╔═╡ beb863ea-ebc9-4cc0-98f5-c66754a7edd9
combine(groupby(iris, :Species), nrow => :size)

# ╔═╡ cbc9212f-3d45-438c-b7cf-0774c1a0a1b4
md"""
# Model Evaluation
## Accuracy
Dalam klasifikasi, metrik yang paling simpel adalah akurasi. Ini menghitung proporsi dari data-data yang label prediksinya sama persis dengan label yang sebenarnya. Mantap banget deh!
"""

# ╔═╡ 843f09d8-a930-4fb3-81ea-5873cb6257fd
 sum(pred .== Y_test)

# ╔═╡ ccc977b9-e194-4ee1-9ce6-99d7323004c8
size(Y_test)

# ╔═╡ ca1c7225-9943-4ae2-a3e5-38d53cbd01cd
md"""
Akurasi:
"""

# ╔═╡ f7e1e53e-0097-43eb-9efb-77c1e6bd99a8
(sum(pred .== Y_test)/size(Y_test)[1])

# ╔═╡ 335cfa81-ddb0-4462-b341-fb5d56a769d8
md"""
Woooooooooow... Akurasinya $(sum(pred .== Y_test)/size(Y_test)[1]*100)%! Mantap banget, kan! Akurasi dari model juga bisa dicek pake fungsi berikut:
"""

# ╔═╡ 8c726c0f-1264-4dda-85ff-a2eef87abd42
knn.score(X_test, Y_test)

# ╔═╡ b2abc829-f6f2-48d5-b93a-40b1bf6b1125
md"""
## Confusion Matrix
Dalam model klasifikasi, metric yang paling gampang dipahamin adalah akurasi. Nah, akurasi ini menghitung proporsi data yang hasil prediksinya cocok persis sama kayak label yang aslinya. Jadi, semakin tinggi akurasi, semakin bagus lah prediksi modelnya.

Tapi, hati-hati ya! Akurasi aja kadang bisa menyesatkan, terutama kalo jumlah data di setiap kelas beda-beda atau kalo ada lebih dari dua kelas di datasetnya. Nah, supaya lebih jelas apa yang bener dan apa yang salah, kita bisa pake yang namanya confusion matrix. Itu tuh kayak ringkasan yang ngitung jumlah prediksi yang bener dan yang salah, terus dipecah-pecah berdasarkan tiap kelas.

Kalo kita lagi klasifikasi iris, kita bisa pake `confusion_matrix()` buat ngitungnya. Nah, jadi kita bisa liat hasil prediksi yang bener dan juga jenis kesalahan yang sering dilakuin sama modelnya.
"""

# ╔═╡ 58d544f4-58ae-40a0-aac8-fb2dbbe8a03c
md"""
### 1. Confusion Matrix: ScikitLearn Julia
"""

# ╔═╡ 5cd3c624-1a4c-492e-bb28-ac18b32a15c1
@sk_import metrics: confusion_matrix

# ╔═╡ 1e42e413-fd83-40b8-af0a-a50f38dc43bc
cm = confusion_matrix(Y_test, pred)

# ╔═╡ 4207c0ea-594d-492b-96ca-2accf38b6150
function cm_fix(m)
	return reverse(m, dims=1)
end

# ╔═╡ 4d876256-1b0e-415a-b7f1-9015d9113d6e
md"""
### 2. Confusion Matrix: sklearn matplolib python
"""

# ╔═╡ 3473835e-a3d4-4c1f-9c62-efa8f9852549
sklearn_metrics = pyimport("sklearn.metrics")

# ╔═╡ 29785a52-33c2-4eb1-89c6-4b0a425b824b
matplotlib_pyplot = pyimport("matplotlib.pyplot")


# ╔═╡ 0abb981a-f8b9-43a2-a0a0-b101f2fbe83f
display_labels = ["setosa", "versicolor", "virginica"]

# ╔═╡ e01f3319-6eec-4e68-84e6-2fd19c5c3ac1
function plot_cm(m)
	heatmap(cm_fix(cm), c=:dense, colorbar=:true, xlabel="Predicted label", ylabel="True label", xtickfont=font(10), ytickfont=font(10), aspect_ratio=:equal, title="Confusion Matrix") 
	for i in 1:size(cm_fix(cm), 1)
   		for j in 1:size(cm_fix(cm), 2)
    	    annotate!(j, i, Plots.text(string(cm_fix(cm)[i, j]), :orange, :center))
   		end
	end
	xticks!(1:size(cm_fix(cm), 2), display_labels)
yticks!(1:size(cm_fix(cm), 1), reverse(display_labels))
	plot!()
end

# ╔═╡ 040e8cb2-4ae2-4d77-8f56-caf1571d329f
plot_cm(cm)

# ╔═╡ 88ad99ec-e3cf-44f5-a187-4921dec3a649
cm_py = sklearn_metrics.confusion_matrix(Y_test, pred, labels=display_labels)

# ╔═╡ bab49bf4-1628-4512-ac8d-3cb4c7af13d9
begin
	display_obj = sklearn_metrics.ConfusionMatrixDisplay(cm_py,display_labels=display_labels)
	# Plot confusion matrix
	figure, ax = matplotlib_pyplot.subplots()
	display_obj.plot(include_values=true, ax=ax)
	ax.set_xticklabels(display_labels)
	ax.set_yticklabels(display_labels)
	ax.set_xlabel("Predicted", fontdict=Dict([("fontsize",12)]))
	ax.set_ylabel("True", fontdict=Dict([("fontsize",12)]))
	ax.set_title("Confusion Matrix")
end

# ╔═╡ 968a4212-62c5-468a-a8cb-7e3bfb760432
figure

# ╔═╡ e3d674dd-ce1b-4971-aa04-470635f52776
md"""
Di sini kita sebutin labelnya secara berurutan. Setiap kolom dari matriks ini nunjukin kelas yang diprediksi dan setiap baris nunjukin sama kelas yang sebenarnya. Jadi jumlah di setiap baris itu nunjukin total jumlah instansi dari kelas tersebut.

Baris pertama ngacu ke iris-setosa aslinya; [15, 0, 0] nunjukin bahwa 15 iris-setosa diprediksi dengan benar, dan gak ada yang salah diprediksi; sedangkan baris terakhir [0, 1, 14] nunjukin bahwa dari 15 iris-virginica yang asli, gak ada yang diprediksi jadi iris-setosa, 1 diprediksi jadi iris-versicolor, dan sisanya 14 diprediksi dengan benar sebagai iris-virginica. Ini konsisten sama yang kita lihat pas exploratory data analysis, bahwa ada beberapa tumpang tindih antara dua spesies ini di scatter plot, dan lebih sulit membedakan iris-versicolor sama iris-virginica daripada mengidentifikasi iris-setosa.

Confusion matrix ini tuh tabel yang sering dipakai buat ngambarkan performa model klasifikasi (atau "classifier") di atas set data test yang nilai-nilainya udah diketahui.
"""

# ╔═╡ cc98d7d2-7d00-4667-ac3f-171e23cb33c9
md"""
## K-fold Cross Validation
Sebelumnya kita udah bagi data jadi data train dan data test sebelum ngefit modelnya biar kita bisa ngecek performa modelnya di data test. Itu metode cross validation sederhana, yang juga dikenal sebagai metode holdout. Tapi, pembagian data secara acak bisa mempengaruhi performa model. Buat ngatasin ini, kita perkenalkan k-fold cross validation.

Di k-fold cross validation, data dibagi jadi k subset. Terus, metode holdout diulang sebanyak k kali, jadi setiap kali, salah satu subset dari k subset itu dipake sebagai data test dan k-1 subset lainnya digabung buat ngetrain modelnya. Terus akurasinya diambil rata-rata dari k percobaan untuk nunjukin efektivitas total modelnya. Dengan cara ini, semua data point dipake; dan ada lebih banyak metrik jadi kita gak cuma mengandalkan satu data test aja buat ngevaluasi performa model.

Cara termudah buat pake k-fold cross-validation di scikit-learn adalah manggil fungsi cross_val_score di atas model dan datasetnya:
"""

# ╔═╡ c82d886c-4c38-42ca-a10f-7d291f50fdf0
knn_cv = KNeighborsClassifier(n_neighbors=5)

# ╔═╡ 39d03ee2-4a15-4937-883a-7e49531e4056
md"""
Setiap holdout set berisi 20% dari data asli.
"""

# ╔═╡ 0b9ba632-3b1d-47dd-bb74-5b8db194772e
cv_scores = cross_val_score(knn_cv, X, y, cv=5) 

# ╔═╡ 83f627ad-5c58-4a36-b27b-b93afcfc875b
md"""
Bro, kayak yang lo lihat, gara-gara pembagian data yang acak, akurasi pada holdsets ini fluktuatif antara 0.9 sampe 1 gitu.
"""

# ╔═╡ c4f59d6d-6a30-4ccf-bdc9-1d9ece45d21f
mean_cv = round(mean(cv_scores), digits=2)

# ╔═╡ e7bf0e2a-e7dc-4d77-a718-9fa9aefeaf7a
md"""
Kita nggak bisa mengandalkan hanya satu pembagian train-test aja, yang kita tahu model 3nn ini memiliki akurasi $(mean_cv*100)% berdasarkan cross validation 5-fold.

Sebagai aturan umum, cross validation dengan 5-fold atau 10-fold lebih disukai, tapi sebenarnya nggak ada aturan formalnya sih. Ketika nilai `k` semakin besar, perbedaan ukuran antara set pelatihan dan subset resampling semakin kecil. Ketika perbedaan ini mengecil, bias dari teknik ini juga semakin kecil.
"""

# ╔═╡ 22f91140-8526-4b6e-a87c-e1fc8039d6c6
md"""
## Grid Search
Jadi begini, pas kita bikin model knn pertama, kita atur hyperparameter k-nya jadi 5, terus kemudian jadi 3 pas di k-fold cross validation, random banget sih pilihannya. Nah, pertanyaannya adalah, k yang paling oke tuh yang mana ya? Nah, buat nyari k yang paling optimal, kita bisa pake alat yang keren abis namanya grid search. 

Di scikit-learn, kita bisa pake GridSearchCV, yang ngelatih model kita beberapa kali pake berbagai nilai yang kita tentuin pake param_grid, terus diitungin skor cross validation-nya. Jadi kita bisa ngecek mana nilai dari hyperparameter yang kita uji yang paling bagus performanya.

Contohnya kodingannya gini bro:"""

# ╔═╡ bad128da-a052-4395-8745-d94347159cd1
param_grid = Dict("n_neighbors" => collect(2:10))

# ╔═╡ ca3056b6-40a0-4e58-bb2d-5ad33c07c91a
knn2 = KNeighborsClassifier()

# ╔═╡ 721e2f06-e897-4b21-92c9-f6ae03200ea1
knn_gscv = GridSearch.GridSearchCV(knn2, param_grid, cv=5)

# ╔═╡ ad890540-39aa-450d-b96f-dc3670774023
#fit model to data
ScikitLearn.fit!(knn_gscv, X, y)

# ╔═╡ 9f0d4f8c-4a3d-4014-9f8c-48e4a4d95102
knn_gscv.best_estimator_

# ╔═╡ d33d0c9d-cc73-4d92-8942-1db38997c3ab
knn_gscv.best_score_

# ╔═╡ d6119bf9-32ac-4118-8cea-c11125ec070e
knn_final = KNeighborsClassifier(n_neighbors=knn_gscv.best_estimator_["n_neighbors"])

# ╔═╡ 991cd30c-544d-412a-9964-abb471981c10
knn_final.fit(X, y)

# ╔═╡ 2360f8b8-4798-44cb-8109-8846b6ca4955
knn_final.score(X, y)

# ╔═╡ b43dc017-f34b-4a36-971a-952c5db815b6
md"""
Teknik k-fold cross validation dan tuning parameter dengan grid search itu bisa dipake buat dua jenis masalah nih, baik masalah klasifikasi maupun regresi. Jadi nggak cuma buat satu jenis masalah aja, tapi bisa digunakan secara luas. Mantap kan? Jadi kita bisa ngoptimalkan performa model baik buat klasifikasi maupun regresi pake kedua teknik tersebut. Keren abis!
"""

# ╔═╡ 3a87ebdf-6d1f-416f-808f-5a42b3a2d5d5
md"""
# Label Prediction
## Label Prediction with New Data
Oke bro, sekarang kita siap deploy model kita yang udah jadi, yaitu 'knn_final'. Kita punya data ukuran beberapa iris nih, dan panjang dan lebar kelopaknya (sepal) adalah 5.84 cm dan 3.06 cm, sedangkan panjang dan lebar mahkotanya (petal) adalah 3.76 cm dan 1.20 cm. Nah, gimana caranya kita buat prediksi pake model yang udah kita buat tadi?

Kita bisa menggunakan fungsi 'predict' dari model tersebut. Karena model ini dilatih dengan menggunakan panjang dan lebar mahkota sebagai fitur, maka kita butuh data panjang dan lebar mahkota untuk membuat prediksi. Jadi, kita tinggal masukin data tersebut ke fungsi 'predict' untuk mendapatkan hasil prediksinya. Mantap kan? Cukup mudah dan cepat!

Kita masukkan data panjang dan lebar petal ke sebuah array:
"""

# ╔═╡ 00f9b6c7-51de-421c-9253-9a9f47823c53
new_data = [5.84 3.06 3.76 1.20]

# ╔═╡ 85418996-359f-421f-8fd0-e61f6272f75f
new_data_reshaped = reshape(new_data, (1, length(new_data)))

# ╔═╡ 7f42a7c4-bdfe-425c-8ab8-f7a4281b0b01
knn_final.predict(new_data_reshaped)

# ╔═╡ 32887089-c21c-4c71-9d20-d05cb9ff0502
md"""
## Probability Prediction with New Data
Let's collect more data: three plants of iris share the same petal width, 2.25cm, but are different in the length of the petal: 5.03 cm, 3.85 cm, and 1.77 cm, respectively. We store the new data into a 2D array as follows:
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Images = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
NamedArrays = "86f7a689-2022-50b4-a561-43c23ac3c673"
NearestNeighbors = "b8a86587-4115-5ab1-83bc-aa920d37bbce"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
PyCall = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"
PyPlot = "d330b81b-6aea-500a-939a-2ce795aea3ee"
RDatasets = "ce6b1742-4840-55fa-b093-852dadbb1d8b"
ScikitLearn = "3646fa90-6ef7-5e7e-9f22-8aca16db6324"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"

[compat]
DataFrames = "~1.5.0"
Images = "~0.25.2"
NamedArrays = "~0.9.8"
NearestNeighbors = "~0.4.13"
Plots = "~1.38.12"
PlutoUI = "~0.7.51"
PyCall = "~1.95.1"
PyPlot = "~2.11.1"
RDatasets = "~0.7.7"
ScikitLearn = "~0.7.0"
StatsBase = "~0.33.21"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.0"
manifest_format = "2.0"
project_hash = "d64d1715858e71985f83dba8e7bdced7419bcd66"

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

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "PrecompileTools", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings", "WorkerUtilities"]
git-tree-sha1 = "ed28c86cbde3dc3f53cf76643c2e9bc11d56acc7"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.10"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.CatIndices]]
deps = ["CustomUnitRanges", "OffsetArrays"]
git-tree-sha1 = "a0f80a09780eed9b1d106a1bf62041c2efc995bc"
uuid = "aafaddc9-749c-510e-ac4f-586e18779b91"
version = "0.2.2"

[[deps.CategoricalArrays]]
deps = ["DataAPI", "Future", "Missings", "Printf", "Requires", "Statistics", "Unicode"]
git-tree-sha1 = "1568b28f91293458345dabba6a5ea3f183250a61"
uuid = "324d7699-5711-5eae-9e2f-1d82baa6b597"
version = "0.10.8"

    [deps.CategoricalArrays.extensions]
    CategoricalArraysJSONExt = "JSON"
    CategoricalArraysRecipesBaseExt = "RecipesBase"
    CategoricalArraysSentinelArraysExt = "SentinelArrays"
    CategoricalArraysStructTypesExt = "StructTypes"

    [deps.CategoricalArrays.weakdeps]
    JSON = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
    RecipesBase = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
    SentinelArrays = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
    StructTypes = "856f2bd8-1eba-4b0a-8007-ebc267875bd4"

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

[[deps.Combinatorics]]
git-tree-sha1 = "08c8b6831dc00bfea825826be0bc8336fc369860"
uuid = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
version = "1.0.2"

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

[[deps.Conda]]
deps = ["Downloads", "JSON", "VersionParsing"]
git-tree-sha1 = "e32a90da027ca45d84678b826fffd3110bb3fc90"
uuid = "8f4d0f93-b110-5947-807f-2305c1781a2d"
version = "1.8.0"

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

[[deps.ExprTools]]
git-tree-sha1 = "c1d06d129da9f55715c6c212866f5b1bddc5fa00"
uuid = "e2ba6199-217a-4e67-a87a-7c52f15ade04"
version = "0.1.9"

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

[[deps.FilePathsBase]]
deps = ["Compat", "Dates", "Mmap", "Printf", "Test", "UUIDs"]
git-tree-sha1 = "e27c4ebe80e8699540f2d6c805cc12203b614f12"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.20"

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

[[deps.Ghostscript_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "43ba3d3c82c18d88471cfd2924931658838c9d8f"
uuid = "61579ee1-b43e-5ca0-a5da-69d92c66a64b"
version = "9.55.0+4"

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
git-tree-sha1 = "41f7dfb2b20e7e8bf64f6b6fae98f4d2df027b06"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.9.4"

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
deps = ["FileIO", "ImageCore", "ImageMagick_jll", "InteractiveUtils", "Libdl", "Pkg", "Random"]
git-tree-sha1 = "5bc1cb62e0c5f1005868358db0692c994c3a13c6"
uuid = "6218d12a-5da1-5696-b52f-db25d2ecc6d1"
version = "1.2.1"

[[deps.ImageMagick_jll]]
deps = ["Artifacts", "Ghostscript_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pkg", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "124626988534986113cfd876e3093e4a03890f58"
uuid = "c73af94c-d91f-53ed-93a7-00f77d67a9d7"
version = "6.9.12+3"

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
git-tree-sha1 = "03d1301b7ec885b266c0f816f338368c6c0b81bd"
uuid = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
version = "0.25.2"

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

[[deps.Mocking]]
deps = ["Compat", "ExprTools"]
git-tree-sha1 = "782e258e80d68a73d8c916e55f8ced1de00c2cea"
uuid = "78c3b35d-d492-501b-9361-3d52fe80e533"
version = "0.7.6"

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

[[deps.NamedArrays]]
deps = ["Combinatorics", "DataStructures", "DelimitedFiles", "InvertedIndices", "LinearAlgebra", "Random", "Requires", "SparseArrays", "Statistics"]
git-tree-sha1 = "b84e17976a40cb2bfe3ae7edb3673a8c630d4f95"
uuid = "86f7a689-2022-50b4-a561-43c23ac3c673"
version = "0.9.8"

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

[[deps.PyCall]]
deps = ["Conda", "Dates", "Libdl", "LinearAlgebra", "MacroTools", "Serialization", "VersionParsing"]
git-tree-sha1 = "62f417f6ad727987c755549e9cd88c46578da562"
uuid = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"
version = "1.95.1"

[[deps.PyPlot]]
deps = ["Colors", "LaTeXStrings", "PyCall", "Sockets", "Test", "VersionParsing"]
git-tree-sha1 = "92e7ca803b579b8b817f004e74b205a706d9a974"
uuid = "d330b81b-6aea-500a-939a-2ce795aea3ee"
version = "2.11.1"

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

[[deps.Quaternions]]
deps = ["LinearAlgebra", "Random", "RealDot"]
git-tree-sha1 = "da095158bdc8eaccb7890f9884048555ab771019"
uuid = "94ee1d12-ae83-5a48-8b1c-48b8ff168ae0"
version = "0.7.4"

[[deps.RData]]
deps = ["CategoricalArrays", "CodecZlib", "DataFrames", "Dates", "FileIO", "Requires", "TimeZones", "Unicode"]
git-tree-sha1 = "19e47a495dfb7240eb44dc6971d660f7e4244a72"
uuid = "df47a6cb-8c03-5eed-afd8-b6050d6c41da"
version = "0.8.3"

[[deps.RDatasets]]
deps = ["CSV", "CodecZlib", "DataFrames", "FileIO", "Printf", "RData", "Reexport"]
git-tree-sha1 = "2720e6f6afb3e562ccb70a6b62f8f308ff810333"
uuid = "ce6b1742-4840-55fa-b093-852dadbb1d8b"
version = "0.7.7"

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

[[deps.Rotations]]
deps = ["LinearAlgebra", "Quaternions", "Random", "StaticArrays"]
git-tree-sha1 = "54ccb4dbab4b1f69beb255a2c0ca5f65a9c82f08"
uuid = "6038ab10-8711-5258-84ad-4b1120ba62dc"
version = "1.5.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.ScikitLearn]]
deps = ["Compat", "Conda", "DataFrames", "Distributed", "IterTools", "LinearAlgebra", "MacroTools", "Parameters", "Printf", "PyCall", "Random", "ScikitLearnBase", "SparseArrays", "StatsBase", "VersionParsing"]
git-tree-sha1 = "3df098033358431591827bb86cada0bed744105a"
uuid = "3646fa90-6ef7-5e7e-9f22-8aca16db6324"
version = "0.7.0"

[[deps.ScikitLearnBase]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "7877e55c1523a4b336b433da39c8e8c08d2f221f"
uuid = "6e75b9c4-186b-50bd-896f-2d2496a4843e"
version = "0.5.0"

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
git-tree-sha1 = "d1bf48bfcc554a3761a133fe3a9bb01488e06916"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.21"

[[deps.StringManipulation]]
git-tree-sha1 = "46da2434b41f41ac3594ee9816ce5541c6096123"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.3.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "Pkg", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "5.10.1+6"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

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

[[deps.TimeZones]]
deps = ["Dates", "Downloads", "InlineStrings", "LazyArtifacts", "Mocking", "Printf", "RecipesBase", "Scratch", "Unicode"]
git-tree-sha1 = "a5404eddfee0cf451cabb8ea8846413323712e25"
uuid = "f269a46b-ccf7-5d73-abea-4c690281aa53"
version = "1.9.2"

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

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.VersionParsing]]
git-tree-sha1 = "58d6e80b4ee071f5efd07fda82cb9fbe17200868"
uuid = "81def892-9a0e-5fdd-b105-ffc91e053289"
version = "1.3.0"

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

[[deps.WeakRefStrings]]
deps = ["DataAPI", "InlineStrings", "Parsers"]
git-tree-sha1 = "b1be2855ed9ed8eac54e5caff2afcdb442d52c23"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "1.4.2"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "de67fa59e33ad156a590055375a30b23c40299d3"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "0.5.5"

[[deps.WorkerUtilities]]
git-tree-sha1 = "cd1659ba0d57b71a464a29e64dbc67cfe83d54e7"
uuid = "76eceee3-57b5-4d4a-8e66-0e911cebbf60"
version = "1.6.1"

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
# ╟─8f160e80-f75d-11ed-037b-4d1603fba55d
# ╟─d2483a60-aa2d-4287-9bfe-477f2ff93c72
# ╠═07a4255e-4b73-4fc9-8059-67727789dae1
# ╠═d1cac0d0-5615-4096-bae1-1dca4eef3538
# ╠═a3de3ec7-ea17-4a94-8cd6-cca79fa2a725
# ╟─b9047edc-7c3b-41ed-b356-8a5949b051ee
# ╟─580506b4-33d6-4612-a47f-0f203a066c07
# ╟─c481d00c-1c8f-44d1-9673-00b978d65cf7
# ╟─2d5ee741-4849-4e38-8d3c-95c0bd67e30b
# ╟─1fb09b83-c335-4279-bc35-0d86a09beb6e
# ╠═6c0cd3f2-2dba-452b-8e45-849e34e24397
# ╟─f0e542ef-7f09-4a3f-ab6c-2700a5138fc0
# ╠═07ac9fbc-f60f-4fd5-afb0-2fbbf1071957
# ╟─3558b2bd-f25f-4a90-8712-3bb5ae0e738f
# ╠═a2068e1d-8424-4163-9203-198587291ceb
# ╟─1d273845-9d26-4bf2-b6f6-5cad6dbe533d
# ╟─1caeb827-fc6a-49a2-bb6f-097c720f91dc
# ╠═ccefc503-3bfd-4c17-9e99-07abbc86f889
# ╠═1687eca6-36a7-4fb7-85ae-e6b1f2aafb6e
# ╟─51ca8d59-aa75-4b3f-b7d6-960635bf167b
# ╟─271dcd99-fdc7-4918-9f98-547638aa0a0b
# ╟─3b895a35-2893-4bc5-bf54-be1d0d415c68
# ╠═e8e970a8-e8b1-4214-92ac-25b307241c9a
# ╟─2801bb38-cfb4-46b5-aaea-f19d5cb4cec3
# ╟─231ef95b-547e-404e-9366-ee486ba5478f
# ╟─5fc14e03-3f89-46f6-88bc-070b3d26b8f1
# ╠═9cb7b0f7-9379-4847-892b-f4c64ee3d62f
# ╟─9cc250b2-38a1-40c0-ac5f-28df3472c525
# ╟─5408755c-014c-4a78-99db-6e451cb81de0
# ╠═bfc3c304-7bfb-4ae3-9144-f8d12ee0c12d
# ╟─facfa26e-b5be-44d9-930b-a974f0c0a313
# ╟─55954998-3298-4b75-9f78-0cc72aef7125
# ╠═0bf07e51-4aa9-4dd5-a47c-d0209462d03a
# ╠═4158b26b-0b9d-405b-a8af-00e390530805
# ╟─cd90839c-1e54-4c0a-b44b-13c9cbd26429
# ╟─eeb5a22c-74ab-48ed-a31c-1529b6e472ff
# ╟─d72e8039-47e4-4732-b18f-32ca4ad8e68f
# ╠═f33c17c5-9fa0-496f-bee3-3e8c4ea1e684
# ╟─2fc06331-1613-4c48-9888-cd88658f0579
# ╟─6cc7e533-c49a-4ef7-933c-e18189ac0d49
# ╟─2c72f583-c0b8-455d-a1f7-33d6355d086a
# ╟─bb1eb372-68b8-46ef-a7e1-9a77ca77025c
# ╠═615411e4-dcfc-4ad9-853b-8b05be671d2f
# ╠═0a364111-5d8b-4d3e-80f8-103b556b71e3
# ╟─747e49b4-9295-448f-9018-e56e25555369
# ╠═30bce95f-656d-4382-aba4-f73733aa1e36
# ╟─c9e24a4d-3fa8-4ebb-a03e-7d68f3f9a0d5
# ╠═72603079-c545-4eef-b986-f5518bf409ed
# ╠═b78406ec-385b-42d7-9e57-9beac25f0561
# ╠═0970e48d-4e9f-47be-beef-b120d83bf0c9
# ╟─7462a53a-9e05-4dc3-a1ad-2ccd9b2ebb7c
# ╠═4bf31ddb-015b-4f43-a35e-e0607a103a64
# ╠═a936e05a-26eb-4d76-ac49-b2bfad4bae57
# ╟─9f1cf2c2-a1a6-4d5f-bbe2-11bbf18eda0a
# ╠═819815d6-74a5-4c46-a689-2f7d267bf391
# ╟─338c9a25-459c-4bfd-9ac7-1805d8b91591
# ╠═01d4e401-4a28-4088-bcd1-c9828da9f4dc
# ╟─fc2f493f-ffe0-4964-8fac-2761ea001d36
# ╠═0d7c720a-28ab-4448-976b-bfabeea2fccc
# ╟─02e1e36b-8243-4c82-ab65-0e3649c6b83f
# ╠═beabe24e-f5b5-444a-a082-f9670a138193
# ╠═3c6ef5e6-8f6d-40fb-9adb-3710160f1513
# ╠═5f06af67-c860-4ae1-9268-1a24727c343f
# ╠═ae754d3a-a794-4f07-bc7e-dc0890dab4a8
# ╠═beb863ea-ebc9-4cc0-98f5-c66754a7edd9
# ╟─cbc9212f-3d45-438c-b7cf-0774c1a0a1b4
# ╠═843f09d8-a930-4fb3-81ea-5873cb6257fd
# ╠═ccc977b9-e194-4ee1-9ce6-99d7323004c8
# ╟─ca1c7225-9943-4ae2-a3e5-38d53cbd01cd
# ╠═f7e1e53e-0097-43eb-9efb-77c1e6bd99a8
# ╟─335cfa81-ddb0-4462-b341-fb5d56a769d8
# ╠═8c726c0f-1264-4dda-85ff-a2eef87abd42
# ╟─b2abc829-f6f2-48d5-b93a-40b1bf6b1125
# ╟─58d544f4-58ae-40a0-aac8-fb2dbbe8a03c
# ╠═5cd3c624-1a4c-492e-bb28-ac18b32a15c1
# ╠═1e42e413-fd83-40b8-af0a-a50f38dc43bc
# ╠═4207c0ea-594d-492b-96ca-2accf38b6150
# ╠═e01f3319-6eec-4e68-84e6-2fd19c5c3ac1
# ╠═040e8cb2-4ae2-4d77-8f56-caf1571d329f
# ╟─4d876256-1b0e-415a-b7f1-9015d9113d6e
# ╠═3473835e-a3d4-4c1f-9c62-efa8f9852549
# ╠═29785a52-33c2-4eb1-89c6-4b0a425b824b
# ╠═0abb981a-f8b9-43a2-a0a0-b101f2fbe83f
# ╠═88ad99ec-e3cf-44f5-a187-4921dec3a649
# ╠═bab49bf4-1628-4512-ac8d-3cb4c7af13d9
# ╠═968a4212-62c5-468a-a8cb-7e3bfb760432
# ╟─e3d674dd-ce1b-4971-aa04-470635f52776
# ╟─cc98d7d2-7d00-4667-ac3f-171e23cb33c9
# ╠═c82d886c-4c38-42ca-a10f-7d291f50fdf0
# ╟─39d03ee2-4a15-4937-883a-7e49531e4056
# ╠═0b9ba632-3b1d-47dd-bb74-5b8db194772e
# ╟─83f627ad-5c58-4a36-b27b-b93afcfc875b
# ╠═c4f59d6d-6a30-4ccf-bdc9-1d9ece45d21f
# ╟─e7bf0e2a-e7dc-4d77-a718-9fa9aefeaf7a
# ╟─22f91140-8526-4b6e-a87c-e1fc8039d6c6
# ╠═bad128da-a052-4395-8745-d94347159cd1
# ╠═ca3056b6-40a0-4e58-bb2d-5ad33c07c91a
# ╠═721e2f06-e897-4b21-92c9-f6ae03200ea1
# ╠═ad890540-39aa-450d-b96f-dc3670774023
# ╠═9f0d4f8c-4a3d-4014-9f8c-48e4a4d95102
# ╠═d33d0c9d-cc73-4d92-8942-1db38997c3ab
# ╠═d6119bf9-32ac-4118-8cea-c11125ec070e
# ╠═991cd30c-544d-412a-9964-abb471981c10
# ╠═2360f8b8-4798-44cb-8109-8846b6ca4955
# ╟─b43dc017-f34b-4a36-971a-952c5db815b6
# ╟─3a87ebdf-6d1f-416f-808f-5a42b3a2d5d5
# ╠═00f9b6c7-51de-421c-9253-9a9f47823c53
# ╠═85418996-359f-421f-8fd0-e61f6272f75f
# ╠═7f42a7c4-bdfe-425c-8ab8-f7a4281b0b01
# ╟─32887089-c21c-4c71-9d20-d05cb9ff0502
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
