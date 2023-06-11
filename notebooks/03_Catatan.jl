### A Pluto.jl notebook ###
# v0.19.25

using Markdown
using InteractiveUtils

# ╔═╡ fc150ed3-1142-4a4a-b859-fb71f3b708b9
using Pkg

# ╔═╡ f1c3ecc6-0644-41a8-a42e-b6e00ef7c424
Pkg.add("PlutoUI")

# ╔═╡ 4ebab3c0-1bd2-4042-b19c-889fe35ae08c
Pkg.add("BenchmarkTools")

# ╔═╡ fcc13e5f-cec3-45cb-9a3a-720c3922b98b
Pkg.add("PyCall")

# ╔═╡ 2f49aebe-6e6a-4b25-8a27-20437b7b4932
Pkg.add("Conda")

# ╔═╡ 3bfbb235-ca41-4dc2-9e80-ec5a36c911a9
using PlutoUI

# ╔═╡ 8a1e3340-e403-4e39-a038-6e715a7100fa
using BenchmarkTools

# ╔═╡ 05bea96b-5677-44b5-bcd8-330ac15fce9a
begin
	using Libdl
	C_code = """
	#include <stddef.h>
	double c_sum(size_t n, double *X){
		double s = 0.0;
		for (size_t i = 0; i < n; ++i){
			s += X[i];
		}
		return s;
	}
	"""
	const Clib = tempname() # make a temp file

	# compile to a share library by piping C_code to GCC
	# (work only if you have gcc isntalled):
	
	open(`gcc -fPIC -O3 -msse3 -xc -shared -o $(Clib * "." * Libdl.dlext) -`, "w") do f
		print(f, C_code)
	end

	c_sum(X::Array{Float64}) = ccall(("c_sum", Clib), Float64, (Csize_t, Ptr{Float64}), length(X), X)
end

# ╔═╡ fb6cb4fc-64e5-404a-bc4a-4b7b1fa9d613
using PyCall

# ╔═╡ 357d5106-efb7-11ed-0baa-8b2c959350b3
md"""
# Pertemuan 3 Pasca UTS
"""

# ╔═╡ 79f4afdc-6df3-4578-9354-2938ed7eef37
TableOfContents()

# ╔═╡ 5c6f9261-9337-4268-b4e8-830dcd5f0845
md"""
## Persiapan
1. Instal julia di WSL Ubuntu. Klik [https://julialang-s3.julialang.org/bin/linux/x64/1.9/julia-1.9.0-linux-x86_64.tar.gz](https://julialang-s3.julialang.org/bin/linux/x64/1.9/julia-1.9.0-linux-x86_64.tar.gz) untuk mengunduh Julia versi 1.9.0 di WSL Ubuntu.
2. Simpan berkas hasil unduh di direktori WSL Ubuntu agar lebih mudah. Misalnya di folder `/home/julia/`.
3. Ekstrak berkas hasil unduhan. Bisa diekstrak dengan WinRAR di Windows atau dengan perintah pada terminal. Jika ingin mengekstrak dengan terminal, pastikan sudah masuk ke dalam direktori tempat menyimpan berkas Julia:
	cd julia/
4. Lalu, masukkan perintah:
	tar -xvf julia-1.9.0-linux-x86_64.tar.gz
5. Masuk ke dalam folder hasil ekstrak melalui terminal:
	cd julia-1.9.0/
	cd bin/
6. Jalankan Julia:
	./julia
7. Tambahkan paket Pluto:
	using Pkg
	Pkg.add("Pluto")
8. Tunggu sampai proses penambahan paket selesai. Jika sudah selesai, jalankan Pluto:
	using Pluto
	Pluto.run()
"""

# ╔═╡ fc395c24-aa93-4a66-a5e7-de9e213c5809
md"""
### Fungsi `sum`
"""

# ╔═╡ d1e99b0e-4513-4949-99c0-9e32a79cb299
a = rand(10^7)

# ╔═╡ 96887402-34a4-4fbd-bd44-ea834fa5ffa1
sum(a)

# ╔═╡ e2469c1f-7ba1-453a-9d60-a44ffda75d7c
md"""
### Benchmark
"""

# ╔═╡ f672dd06-e011-4574-a472-f65ac12a1294
@time sum(a)

# ╔═╡ a6a4a54a-0353-48b3-9441-1be57e8c8c54
@time sum(a)

# ╔═╡ ce5fdde0-ea91-4cf3-acf9-973068136670
@time sum(a)

# ╔═╡ 5109411c-7a48-4b86-911c-af37263c97a7
md"""
## 1. The C Language
"""

# ╔═╡ 8f2d4a7c-b9ec-4d10-8982-29dcd3f76fdd
c_sum(a)

# ╔═╡ 195ed2ca-06d0-4c6c-abf0-bf8c6b249462
c_sum(a) ≈ sum(a)

# ╔═╡ 594e14a4-4072-4568-9b07-c476cbefdc8b
c_sum(a) - sum(a)

# ╔═╡ d124b4d5-39d7-4a75-b028-e86ee9fd274b
≈ # alias for the `isapprox` function

# ╔═╡ 49d9a65e-e95a-4445-8e71-1a237f66fc7b
c_bench = @benchmark c_sum($a)

# ╔═╡ ef062f99-95cf-4ff3-83c7-8be7a6a72209
println("C: Fastest time was $(minimum(c_bench.times)/1e6) msec")

# ╔═╡ 3184aefd-5112-4bc8-8a4d-f11bbc411a87
d = Dict()

# ╔═╡ 40fed45d-529e-4988-8d36-24c5a0ab0168
d["C"] =minimum(c_bench.times)/1e6 #in miliseconds

# ╔═╡ bc88ffcb-f38a-4419-9975-ef3e1762bcf3
d

# ╔═╡ 0d3e0acc-bfd2-42b3-bee9-e480668be1ce
md"""
## 2. C with -ffast-math
"""

# ╔═╡ 3b364862-183b-4af1-b66c-1b6cfc1c6bb0
begin
	const Clib_fastmath = tempname() # make a temp file
	
	open(`gcc -fPIC -O3 -msse3 -xc -shared -ffast-math -o $(Clib_fastmath * "." * Libdl.dlext) -`, "w") do f
		print(f, C_code)
	end

	c_sum_fastmath(X::Array{Float64}) = ccall(("c_sum", Clib_fastmath), Float64, (Csize_t, Ptr{Float64}), length(X), X)
end

# ╔═╡ 88fd2168-d5ca-43de-8a1e-6da1ac396bf5
c_fastmath_bench = @benchmark c_sum($a)

# ╔═╡ 36ca15d0-624b-47fa-84fd-550b2823bccf
d["C Fastmath"] = minimum(c_fastmath_bench.times)/1e6 #in miliseconds

# ╔═╡ a3c60d9a-3228-40cc-9eba-6ff90d0a8d3f
d

# ╔═╡ 97eeb785-1f7b-4bdd-85cf-42a4c330357f
md"""
## 3. Python's built in `sum`
"""

# ╔═╡ ad78d76a-e06b-4c43-b3cd-3d0e9f18d024
pysum = pybuiltin("sum")

# ╔═╡ c71f3d43-d98d-4974-941e-526536de95f2
pysum(a)

# ╔═╡ 20d60c5f-94eb-4982-8b19-f64c0890b3ad
pysum(a) ≈ sum(a)

# ╔═╡ d080ee74-4f16-4a5a-9864-6186f509fbe5
py_list_bench = @benchmark $pysum($a)

# ╔═╡ aba47fb5-4058-43b1-8d89-593f6c1bfb65
d["Python built-in sum"] = minimum(py_list_bench.times)/1e6 #in miliseconds

# ╔═╡ a50d5f48-a630-4de8-8d68-dff3eaad10d8
d

# ╔═╡ 85e24f8e-5f07-4bef-9d1f-ce5aaafe2771
md"""
## 4. Numpy
"""

# ╔═╡ cd953b31-a48e-4a2c-b9b7-6b6a1bcf35fc
numpy_sum = pyimport("numpy")["sum"]

# ╔═╡ fed3502f-7081-4ad5-a9df-ceec245bb663
py_numpy_bench = @benchmark $numpy_sum($a)

# ╔═╡ 18868198-8aa0-4542-a76d-d5b8c33cfada
d["Python NumPy sum"] = minimum(py_numpy_bench.times)/1e6 #in miliseconds

# ╔═╡ 84f8b869-7eae-41f1-be75-8e551e3b9e7a
d

# ╔═╡ ee5c5fae-9275-4e8f-9ffd-78c7ebac57c5
md"""
## 5. Python writen hand
"""

# ╔═╡ 2e0ff736-3bec-4815-9acc-65fc9f478509
begin
	py"""
	def py_sum(A):
		s = 0.0
		for a in A:
			s+= a
		return s
	"""
	sum_py = py"py_sum"
end

# ╔═╡ 0b8906fe-7cc5-49f8-be09-3b90f48e9a69
sum_py(a)

# ╔═╡ b99e4a41-79e4-4df4-ae5c-86d6788c6312
sum_py(a) ≈ sum(a)

# ╔═╡ 417d1678-50ff-48b1-8bef-dd02a541c152
sum_py_bench = @benchmark $sum_py($a)

# ╔═╡ d0d26251-8b40-475b-ad2d-30ab819b0ec0
d["Python writen hand sum"] = minimum(sum_py_bench.times)/1e6 #in miliseconds

# ╔═╡ eccbfadd-17c1-4cd6-bb31-d88457043273
d

# ╔═╡ b8b96145-ecb0-4a4a-bca1-4775b8d18915
md"""
## 6. Julia `sum`
"""

# ╔═╡ 381cd748-1dff-4b1b-9135-47a566fe3df1
sum(a)

# ╔═╡ 4b0e6906-a4c2-4dcf-bd7c-de0e7af375a2
julia_sum_bench = @benchmark $sum($a)

# ╔═╡ 37eb46d3-21bc-42f5-9fec-0a8ab7cda7ab
d["Julia sum"] = minimum(julia_sum_bench.times)/1e6 #in miliseconds

# ╔═╡ bc4a551d-41aa-4e1d-8ac0-8fa883e9d4ac
d

# ╔═╡ 08fd2611-9e52-4d84-b901-ab53107408e1
md"""
## 7. Julia writen hand
"""

# ╔═╡ 174a2850-48cf-45f1-8e03-826db0ec2532
function new_sum(list)
	x = 0
	for i in list
		x += i
	end
	return x
end

# ╔═╡ 228cadaf-353a-4f58-b3ae-7511b005cb55
new_sum(a)

# ╔═╡ 80c3d9e1-0801-478d-912d-daedd250f5d5
julia_writen_bench = @benchmark $new_sum($a)

# ╔═╡ fd47fde0-2115-4494-b4cb-3dac74dda536
d["Julia writen sum"] = minimum(julia_writen_bench.times)/1e6 #in miliseconds

# ╔═╡ cab4aa99-1a59-4988-91ae-6252e599edc4
d

# ╔═╡ 5300c0de-5a04-4433-a607-53983a2e51ea
md"""
## 8. Julia simd
"""

# ╔═╡ 0bc5b66b-284b-4936-9eea-1f4d5c8aca85
function simd_sum(list)
	x = 0
	@simd for i in list
		x += i
	end
	return x
end

# ╔═╡ dcf6933c-ac8f-45ef-ac5a-7fd62d996e8e
simd_sum(a)

# ╔═╡ 8a668596-6e05-4f6c-9596-1abaf10df806
julia_simd_bench = @benchmark $simd_sum($a)

# ╔═╡ 959effb8-5cc4-4f58-abfc-f679ec82cf51
d["Julia sum with simd"] = minimum(julia_simd_bench.times)/1e6 #in miliseconds

# ╔═╡ 804ce46e-49ee-482d-81b2-bfe7bb2f0366
d

# ╔═╡ 03c05c81-08cb-4ed4-93d3-42914c1bf076
md"""
## 9. Fortran
"""

# ╔═╡ 814a40a8-5fee-48f8-aa70-9925279f1c95
begin
	#using Libdl
	Fortran_code = """
	module m 
	contains
	real*8 function fortran_sum(n,X)
	    implicit none
	    integer*8, intent(in) :: n
	    real*8, dimension(n), intent(in) :: X
	    integer :: i
	
	    fortran_sum = 0.0
	    do i = 1,n
	        fortran_sum = fortran_sum + X(i)
	    end do
	end function fortran_sum
	end module m
	"""
end

# ╔═╡ 9a2ef5bd-a68f-4aa2-b178-546b161a142f
begin
	const Fortrancode = raw"/tmp/test.f90"
	const Fortranlib = raw"/tmp/test.so"   # make a temporary file
	
	# compile to a shared library by piping Fortran_code to gfortran
	# (works only if you have gfortran installed):
	open("$Fortrancode","w") do f
	    print(f, Fortran_code)
	end
end

# ╔═╡ d49a6441-8478-4a71-81cd-e34960417f01
begin
	run(`gfortran -shared -O3 -fPIC $Fortrancode -o $Fortranlib`)
	
	# define a Julia function that calls the Fortran function:
	fortran_sum(X::Array{Float64}) = ccall((:__m_MOD_fortran_sum, Fortranlib),
	    Float64,(Ref{Int64},Ptr{Float64}),length(X),X)
end

# ╔═╡ c40629da-d7aa-42b9-8e3c-86d1af99c681
fortran_sum(a) ≈ sum(a)

# ╔═╡ 6db4178c-ee36-4f0a-8853-27deadabc9d5
fortran_bench = @benchmark $fortran_sum($a)

# ╔═╡ 3f0fe950-a66e-488d-a363-2def111844bf
d["Fortran"] = minimum(fortran_bench.times) / 1e6  # in milliseconds

# ╔═╡ 38bd8f61-3991-4509-b623-2779f30c68ee
d

# ╔═╡ a8a60dea-0225-44d3-8948-4586b276da3f
md"""
## 10. Fortran -Ofast
"""

# ╔═╡ e59abc3d-48fc-42bc-9969-9fc8df202858
begin
	const Fortrancode2 = raw"/tmp/test.f90"
	const Fortranlib_fastmath = raw"/tmp/test_fast.so"   # make a temporary file
	
	# The same as above but with a -ffast-math flag added
	open("$Fortrancode","w") do f
	    print(f, Fortran_code)
	end
	run(`gfortran -shared -Ofast -fPIC -funroll-loops -ffast-math $Fortrancode -o $Fortranlib_fastmath`)
	
	# define a Julia function that calls the Fortran function:
	fortran_sum_fastmath(X::Array{Float64}) = ccall((:__m_MOD_fortran_sum, Fortranlib_fastmath),
	    Float64,(Ref{Int64},Ptr{Float64}),length(X),X)
end

# ╔═╡ 10914177-6fbe-46c6-a557-47f59ffde4d3
fortran_fastmath_bench = @benchmark $fortran_sum_fastmath($a)

# ╔═╡ 01cd49dc-60ef-4906-af1b-213ce36aabfd
d["Fortran -ffast-math"] = minimum(fortran_fastmath_bench.times) / 1e6  # in milliseconds

# ╔═╡ d2bd096e-dbf4-48a6-8c5e-e98827c2e997
d

# ╔═╡ aecdddf9-894d-47d9-a1ff-3219456924dd
md"""
## Perbandingan Kecepatan
"""

# ╔═╡ 008d9743-9819-4dea-a38a-0a4b3d8b795f
# Mengurutkan pasangan kunci-nilai berdasarkan nilai-nilainya
sorted_dict = sort(collect(d), by = x -> x[2])

# ╔═╡ 9bb17a59-d197-4318-8881-aa3d0d99435e
for (index, (kunci, nilai)) in enumerate(collect(sorted_dict))
    println("$index. $kunci: $nilai ms")
end

# ╔═╡ Cell order:
# ╟─357d5106-efb7-11ed-0baa-8b2c959350b3
# ╠═f1c3ecc6-0644-41a8-a42e-b6e00ef7c424
# ╠═3bfbb235-ca41-4dc2-9e80-ec5a36c911a9
# ╠═79f4afdc-6df3-4578-9354-2938ed7eef37
# ╟─5c6f9261-9337-4268-b4e8-830dcd5f0845
# ╟─fc395c24-aa93-4a66-a5e7-de9e213c5809
# ╠═d1e99b0e-4513-4949-99c0-9e32a79cb299
# ╠═96887402-34a4-4fbd-bd44-ea834fa5ffa1
# ╟─e2469c1f-7ba1-453a-9d60-a44ffda75d7c
# ╠═f672dd06-e011-4574-a472-f65ac12a1294
# ╠═a6a4a54a-0353-48b3-9441-1be57e8c8c54
# ╠═ce5fdde0-ea91-4cf3-acf9-973068136670
# ╠═fc150ed3-1142-4a4a-b859-fb71f3b708b9
# ╠═4ebab3c0-1bd2-4042-b19c-889fe35ae08c
# ╠═8a1e3340-e403-4e39-a038-6e715a7100fa
# ╟─5109411c-7a48-4b86-911c-af37263c97a7
# ╠═05bea96b-5677-44b5-bcd8-330ac15fce9a
# ╠═8f2d4a7c-b9ec-4d10-8982-29dcd3f76fdd
# ╠═195ed2ca-06d0-4c6c-abf0-bf8c6b249462
# ╠═594e14a4-4072-4568-9b07-c476cbefdc8b
# ╠═d124b4d5-39d7-4a75-b028-e86ee9fd274b
# ╠═49d9a65e-e95a-4445-8e71-1a237f66fc7b
# ╠═ef062f99-95cf-4ff3-83c7-8be7a6a72209
# ╠═3184aefd-5112-4bc8-8a4d-f11bbc411a87
# ╠═40fed45d-529e-4988-8d36-24c5a0ab0168
# ╠═bc88ffcb-f38a-4419-9975-ef3e1762bcf3
# ╟─0d3e0acc-bfd2-42b3-bee9-e480668be1ce
# ╠═3b364862-183b-4af1-b66c-1b6cfc1c6bb0
# ╠═88fd2168-d5ca-43de-8a1e-6da1ac396bf5
# ╠═36ca15d0-624b-47fa-84fd-550b2823bccf
# ╠═a3c60d9a-3228-40cc-9eba-6ff90d0a8d3f
# ╟─97eeb785-1f7b-4bdd-85cf-42a4c330357f
# ╠═fcc13e5f-cec3-45cb-9a3a-720c3922b98b
# ╠═fb6cb4fc-64e5-404a-bc4a-4b7b1fa9d613
# ╠═ad78d76a-e06b-4c43-b3cd-3d0e9f18d024
# ╠═c71f3d43-d98d-4974-941e-526536de95f2
# ╠═20d60c5f-94eb-4982-8b19-f64c0890b3ad
# ╠═d080ee74-4f16-4a5a-9864-6186f509fbe5
# ╠═aba47fb5-4058-43b1-8d89-593f6c1bfb65
# ╠═a50d5f48-a630-4de8-8d68-dff3eaad10d8
# ╟─85e24f8e-5f07-4bef-9d1f-ce5aaafe2771
# ╠═2f49aebe-6e6a-4b25-8a27-20437b7b4932
# ╠═cd953b31-a48e-4a2c-b9b7-6b6a1bcf35fc
# ╠═fed3502f-7081-4ad5-a9df-ceec245bb663
# ╠═18868198-8aa0-4542-a76d-d5b8c33cfada
# ╠═84f8b869-7eae-41f1-be75-8e551e3b9e7a
# ╟─ee5c5fae-9275-4e8f-9ffd-78c7ebac57c5
# ╠═2e0ff736-3bec-4815-9acc-65fc9f478509
# ╠═0b8906fe-7cc5-49f8-be09-3b90f48e9a69
# ╠═b99e4a41-79e4-4df4-ae5c-86d6788c6312
# ╠═417d1678-50ff-48b1-8bef-dd02a541c152
# ╠═d0d26251-8b40-475b-ad2d-30ab819b0ec0
# ╠═eccbfadd-17c1-4cd6-bb31-d88457043273
# ╟─b8b96145-ecb0-4a4a-bca1-4775b8d18915
# ╠═381cd748-1dff-4b1b-9135-47a566fe3df1
# ╠═4b0e6906-a4c2-4dcf-bd7c-de0e7af375a2
# ╠═37eb46d3-21bc-42f5-9fec-0a8ab7cda7ab
# ╟─bc4a551d-41aa-4e1d-8ac0-8fa883e9d4ac
# ╟─08fd2611-9e52-4d84-b901-ab53107408e1
# ╠═174a2850-48cf-45f1-8e03-826db0ec2532
# ╠═228cadaf-353a-4f58-b3ae-7511b005cb55
# ╠═80c3d9e1-0801-478d-912d-daedd250f5d5
# ╠═fd47fde0-2115-4494-b4cb-3dac74dda536
# ╠═cab4aa99-1a59-4988-91ae-6252e599edc4
# ╟─5300c0de-5a04-4433-a607-53983a2e51ea
# ╠═0bc5b66b-284b-4936-9eea-1f4d5c8aca85
# ╠═dcf6933c-ac8f-45ef-ac5a-7fd62d996e8e
# ╠═8a668596-6e05-4f6c-9596-1abaf10df806
# ╠═959effb8-5cc4-4f58-abfc-f679ec82cf51
# ╠═804ce46e-49ee-482d-81b2-bfe7bb2f0366
# ╟─03c05c81-08cb-4ed4-93d3-42914c1bf076
# ╠═814a40a8-5fee-48f8-aa70-9925279f1c95
# ╠═9a2ef5bd-a68f-4aa2-b178-546b161a142f
# ╠═d49a6441-8478-4a71-81cd-e34960417f01
# ╠═c40629da-d7aa-42b9-8e3c-86d1af99c681
# ╠═6db4178c-ee36-4f0a-8853-27deadabc9d5
# ╠═3f0fe950-a66e-488d-a363-2def111844bf
# ╠═38bd8f61-3991-4509-b623-2779f30c68ee
# ╟─a8a60dea-0225-44d3-8948-4586b276da3f
# ╠═e59abc3d-48fc-42bc-9969-9fc8df202858
# ╠═10914177-6fbe-46c6-a557-47f59ffde4d3
# ╠═01cd49dc-60ef-4906-af1b-213ce36aabfd
# ╠═d2bd096e-dbf4-48a6-8c5e-e98827c2e997
# ╟─aecdddf9-894d-47d9-a1ff-3219456924dd
# ╠═008d9743-9819-4dea-a38a-0a4b3d8b795f
# ╠═9bb17a59-d197-4318-8881-aa3d0d99435e
