### A Pluto.jl notebook ###
# v0.19.25

using Markdown
using InteractiveUtils

# ╔═╡ b7c1d819-4532-4277-bc01-6357538a6ea3
using Pkg

# ╔═╡ 27122160-fc0c-485a-8565-448ef3ab0797
Pkg.add("BenchmarkTools")

# ╔═╡ 881a660e-6996-4e37-aa5b-60a4542edc3f
Pkg.add("PyCall")

# ╔═╡ b42c3f38-4c52-44e1-955e-e2a6ce972941
Pkg.add("Conda")

# ╔═╡ 4b9f66bb-7817-4274-b573-341f15be2a71
using BenchmarkTools  

# ╔═╡ de88855d-1f0d-41bb-985b-141ee2429c1c
begin
	using Libdl
	C_code = """
	#include <stddef.h>
	double c_sum(size_t n, double *X) {
	    double s = 0.0;
	    for (size_t i = 0; i < n; ++i) {
	        s += X[i];
	    }
	    return s;
	}
	"""
	
	const Clib = tempname()   # make a temporary file
	
	
	# compile to a shared library by piping C_code to gcc
	# (works only if you have gcc installed):
	
	open(`gcc -fPIC -O3 -msse3 -xc -shared -o $(Clib * "." * Libdl.dlext) -`, "w") do f
	    print(f, C_code) 
	end
	
	# define a Julia function that calls the C function:
	c_sum(X::Array{Float64}) = ccall(("c_sum", Clib), Float64, (Csize_t, Ptr{Float64}), length(X), X)
end

# ╔═╡ 384d03f3-433f-4465-883c-61cffceb78c2
using Plots

# ╔═╡ f12e5a75-6045-421a-8e12-39a060d7bd1b
using Statistics # bring in statistical support for standard deviations

# ╔═╡ 5a5d70ae-5c11-4b79-908a-dd111a585a68
using PyCall

# ╔═╡ 3cf20d97-0ec9-46aa-b9b7-f60773f45017
using Conda

# ╔═╡ a4553f60-ef91-11ed-2378-c1db41212254
md"""
# Julia is fast

Very often, benchmarks are used to compare languages.  These benchmarks can lead to long discussions, first as to exactly what is being benchmarked and secondly what explains the differences.  These simple questions can sometimes get more complicated than you at first might imagine.

The purpose of this notebook is for you to see a simple benchmark for yourself.
"""

# ╔═╡ 55c0e4ee-361f-4bbe-8135-60d98a3160e5
md"""
# Outline of this notebook

- Define the sum function
- Implementations and benchmarking of sum in:
    1. C hand-written
    2. C hand-written with -ffast-math
    3. Python built-in
    4. Python numpy
    5. Python hand-written
    6. Fortran hand-written
    7. Fortran with Ofast
    8. Julia built-in
    9. Julia hand-written
    10. Julia with SIMD
- Summary of benchmarks
"""

# ╔═╡ 41683285-7bc2-4092-8b1f-070b7f1e1112
md"""
# `sum`: An easy enough function to understand
"""

# ╔═╡ bf9f691e-cca7-464e-8335-4dd1f77de409
md"""
Consider the  **sum** function `sum(a)`, which computes

$\mathrm{sum}(a) = \sum_{i=1}^n a_i,$

where $n$ is the length of `a`.
"""

# ╔═╡ 05b54418-e7c4-4280-83cc-1656f428a86d
a = rand(10^7) # 1D vector of random numbers, uniform on [0,1)

# ╔═╡ 34fb9ca4-751f-417a-9e9a-6ab7b3e298ce
sum(a)

# ╔═╡ a89dc104-1d2a-41da-9d08-f213559bb1c2
md"""
The expected result is 0.5 * 10^7, since the mean of each entry is 0.5
"""

# ╔═╡ b31eb7a3-f934-4623-9501-a2b69b3e3fa2
md"""
# Benchmarking a few ways in a few languages
"""

# ╔═╡ 41355af8-563d-4929-82bd-09751c83ee6f
@time sum(a)

# ╔═╡ 308b9385-0902-4f0b-9287-e6532bc01068
@time sum(a)

# ╔═╡ 199d92a1-8844-4e27-8240-962d3c275016
@time sum(a)

# ╔═╡ b0cda634-a4ff-4a18-be31-5bf424069246
md"""
The `@time` macro can yield noisy results, so it's not our best choice for benchmarking!

Luckily, Julia has a `BenchmarkTools.jl` package to make benchmarking easy and accurate:
"""

# ╔═╡ b4167c22-aaf2-4076-b4a8-dcda1ef8865e
md"""
#  1. The C language

C is often considered the gold standard: difficult on the human, nice for the machine. Getting within a factor of 2 of C is often satisfying. Nonetheless, even within C, there are many kinds of optimizations possible that a naive C writer may or may not get the advantage of.

The current author does not speak C, so he does not read the cell below, but is happy to know that you can put C code in a Julia session, compile it, and run it. Note that the tripple quote wrap a multi-line string.
"""

# ╔═╡ 00d040a9-34d8-4c0a-91bf-a3135333e890
c_sum(a)

# ╔═╡ b28f4d0f-afbf-41e9-aeda-ad8b6420862a
😍 = [1 2 4]

# ╔═╡ e6b9d662-cd0a-4450-a13d-aba5d9e47068
c_sum(a) ≈ sum(a) # type \approx and then <TAB> to get the ≈ symbolb

# ╔═╡ 1ec43f63-e0a4-4800-af6f-485d24b777bb
c_sum(a) - sum(a)  

# ╔═╡ e95f1662-cb36-45b1-95e4-0db2149281e5
≈  # alias for the `isapprox` function

# ╔═╡ 0017b44b-d5b1-4a3d-be4e-258f7b0f792d
c_bench = @benchmark c_sum($a)

# ╔═╡ 4bb6f59c-8808-47b8-bfac-44879a3ed70f
println("C: Fastest time was $(minimum(c_bench.times) / 1e6) msec")

# ╔═╡ 3deb941a-d382-4b43-af72-d1b8ed86f177
d = Dict()  # a "dictionary", i.e. an associative array

# ╔═╡ f0dace67-6e9b-4206-901b-f7e8f05659a2
d["C"] = minimum(c_bench.times) / 1e6  # in milliseconds

# ╔═╡ c388b8b9-88ca-48d1-95f8-81e9bc4ecf8f
d

# ╔═╡ ff94b0d0-0c1c-4ccf-be30-03bffd590354
Pkg.add("Plots")

# ╔═╡ 35777942-f5d3-4da4-93b1-ebb322358b41
gr()

# ╔═╡ d8d2e093-3e65-4bbc-a1df-c06e42487ea1
t = c_bench.times / 1e6 # times in milliseconds

# ╔═╡ 4e6170d2-cdeb-40af-81c2-b736218b5223
m, σ = minimum(t), std(t)

# ╔═╡ 0708f051-80bf-4613-bbae-e816e3354cd6
histogram(t, bins=500,
    xlim=(m - 0.01, m + σ),
    xlabel="milliseconds", ylabel="count", label="")

# ╔═╡ 24a39c4c-bfea-4236-9a53-91b1073a4de4
md"""
# 2. C with -ffast-math

If we allow C to re-arrange the floating point operations, then it'll vectorize with SIMD (single instruction, multiple data) instructions.
"""

# ╔═╡ e80cf7fe-9fe9-44f3-a2d4-794120d21419
begin
	const Clib_fastmath = tempname()   # make a temporary file
	
	# The same as above but with a -ffast-math flag added
	open(`gcc -fPIC -O3 -msse3 -xc -shared -ffast-math -o $(Clib_fastmath * "." * Libdl.dlext) -`, "w") do f
	    print(f, C_code) 
	end
	
	# define a Julia function that calls the C function:
	c_sum_fastmath(X::Array{Float64}) = ccall(("c_sum", Clib_fastmath), Float64, (Csize_t, Ptr{Float64}), length(X), X)
end

# ╔═╡ b59db834-e0b2-4bd5-87b6-67ab6ddac415
c_fastmath_bench = @benchmark $c_sum_fastmath($a)

# ╔═╡ 799f7d6f-7037-4301-a0b1-291d82266591
d["C -ffast-math"] = minimum(c_fastmath_bench.times) / 1e6  # in milliseconds

# ╔═╡ 0d19797c-6799-4374-8907-0cb5f5ebdf18
md"""
# 3. Python's built in `sum` 
"""

# ╔═╡ 13a85fb7-9e40-4fb2-b821-f6ebc810ae79
# get the Python built-in "sum" function:
pysum = pybuiltin("sum")

# ╔═╡ c077a142-e981-4e07-9e5f-5278ac997e73
pysum(a)

# ╔═╡ c6bd81d9-ad04-4683-84a6-d69325edf82b
pysum(a) ≈ sum(a)

# ╔═╡ 442a1b0c-42d0-4cdb-99eb-c8e336dfdb49
py_list_bench = @benchmark $pysum($a)

# ╔═╡ 48b72a2d-2ac7-471a-b40a-90b3052c2ea6
d["Python built-in"] = minimum(py_list_bench.times) / 1e6

# ╔═╡ 53498029-6b38-42ac-8d59-acfb953d40be
d

# ╔═╡ b8a6c2bc-1880-4bdc-bd4f-c7b54cb7e7be
md"""
# 4. Python: `numpy` 

## Takes advantage of hardware "SIMD", but only works when it works.

`numpy` is an optimized C library, callable from Python.
It may be installed within Julia as follows:
"""

# ╔═╡ b9db0e64-2939-48ad-bbc3-0dcaae6f408b
Conda.add("numpy")

# ╔═╡ d4396a72-2ee9-434a-9257-a39be9bb7458
numpy_sum = pyimport("numpy")["sum"]

# ╔═╡ d68d07f8-df74-4f3e-b2d6-6029adebdc63
py_numpy_bench = @benchmark $numpy_sum($a)

# ╔═╡ 1efb73e6-7f2e-48bd-a56a-1ca809e157e2
numpy_sum(a)

# ╔═╡ 15877e19-ffde-42c4-8b6d-0b7aede9da39
numpy_sum(a) ≈ sum(a)

# ╔═╡ c7d4a77d-9667-4943-9265-20cffdcb415b
d["Python numpy"] = minimum(py_numpy_bench.times) / 1e6

# ╔═╡ bdb58896-4ac9-4785-87ed-aa55913e7ca9
d

# ╔═╡ 2483622d-5795-42e8-b150-621fbc843cae
md"""
# 5. Python, hand-written 
"""

# ╔═╡ 265c78d7-1fd4-4bc8-b372-cd2097ca77a7
begin
	py"""
	def py_sum(A):
	    s = 0.0
	    for a in A:
	        s += a
	    return s
	"""
	
	sum_py = py"py_sum"
end

# ╔═╡ 3c98dd60-0678-4abe-945e-ed2c63113c3e
py_hand = @benchmark $sum_py($a)

# ╔═╡ b712063d-3c51-4749-acbf-e78911bfeb46
sum_py(a)

# ╔═╡ 0b429ef4-ac0c-48b7-8d2a-06ac792cdc25
sum_py(a) ≈ sum(a)

# ╔═╡ 821f00ca-78e2-49eb-8392-fa5ddd7dddad
d["Python hand-written"] = minimum(py_hand.times) / 1e6

# ╔═╡ defa1bcb-f7d7-406c-aed4-b1926a452940
d

# ╔═╡ fa8e24bd-8ea1-408f-9418-53552442d9e0
md"""
# 6. Fortran 
"""

# ╔═╡ 40fc29d8-1ad4-40d3-9a3d-cfe84a46b834
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

# ╔═╡ 1e1bfe37-d5d1-4bbf-805f-f3ada8f24cec
begin
	const Fortrancode = raw"/tmp/test.f90"
	const Fortranlib = raw"/tmp/test.so"   # make a temporary file
	
	# compile to a shared library by piping Fortran_code to gfortran
	# (works only if you have gfortran installed):
	open("$Fortrancode","w") do f
	    print(f, Fortran_code)
	end
end

# ╔═╡ a0123e52-e207-426b-b7c2-d794b5731b7a
begin
	run(`gfortran -shared -O3 -fPIC $Fortrancode -o $Fortranlib`)
	
	# define a Julia function that calls the Fortran function:
	fortran_sum(X::Array{Float64}) = ccall((:__m_MOD_fortran_sum, Fortranlib),
	    Float64,(Ref{Int64},Ptr{Float64}),length(X),X)
end

# ╔═╡ 6d538261-1ff4-4219-acfe-31425a121cab
fortran_sum(a) ≈ sum(a)

# ╔═╡ 8917b678-b826-4495-ad1d-9ed9bc509591
fortran_bench = @benchmark $fortran_sum($a)

# ╔═╡ 95666d3d-b5e0-43a1-8b43-3c77e3fcf45a
d["Fortran"] = minimum(fortran_bench.times) / 1e6  # in milliseconds

# ╔═╡ 9356a6c3-4371-4107-b290-1ddd40b32aff
d

# ╔═╡ 922ebb22-8537-49f4-ad27-322acea9b489
md"""
# 7. Fortran -Ofast
"""

# ╔═╡ b63a9e9c-cac6-47fa-af95-f8ba99efef29
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

# ╔═╡ df5fdaa1-e401-4259-a7e7-978a27420b0e
fortran_fastmath_bench = @benchmark $fortran_sum_fastmath($a)

# ╔═╡ 7c66d97a-b7b3-4e6a-b9b2-9d7eac53180e
d["Fortran -ffast-math"] = minimum(fortran_fastmath_bench.times) / 1e6  # in milliseconds

# ╔═╡ 2b7f411e-fbb0-4268-9f22-a8c1a265c02f
d

# ╔═╡ a49a0821-35cf-48db-b0fa-dfa699e0fc22
md"""
# 8. Julia (built-in) 

## Written directly in Julia, not in C!
"""

# ╔═╡ 8ca98bb2-f0ba-412d-b49a-d4d5c521a205
@which sum(a)

# ╔═╡ 97c140cd-c9a0-4b21-9e78-06c149c35f55
j_bench = @benchmark sum($a)

# ╔═╡ 58265ba5-2d7e-48b3-8a93-8c78e86e60e1
d["Julia built-in"] = minimum(j_bench.times) / 1e6

# ╔═╡ 6a9c7f4d-5daf-4b24-b1a4-64f318fd2105
d

# ╔═╡ 25575c4d-b2c1-4d30-8ad3-c99a30a8a350
md"""
# 9. Julia (hand-written) 
"""

# ╔═╡ cc167c9e-fd42-4234-bc73-4d02e3e70322
function mysum(A)   
    s = 0.0 # s = zero(eltype(a))
    for a in A
        s += a
    end
    s
end

# ╔═╡ 84f1f940-87b4-4578-a02a-f0a8487832a6
j_bench_hand = @benchmark mysum($a)

# ╔═╡ 0e2d4e7e-418f-4b86-81d9-4f7b6993875b
d["Julia hand-written"] = minimum(j_bench_hand.times) / 1e6

# ╔═╡ 326f9ec7-6ea1-48c0-b657-56497cbfb63d
d

# ╔═╡ 15f1046e-7155-4610-9747-08d4630ef3f3
md"""
# 10. Julia (hand-written w. simd) 
"""

# ╔═╡ 4f0af23f-ac6b-4025-ac92-f1ff31c66e3e
function mysum_simd(A)   
    s = 0.0 # s = zero(eltype(A))
    @simd for a in A
        s += a
    end
    s
end

# ╔═╡ 01711483-7d8b-41a7-ab63-0c1f0cd33092
j_bench_hand_simd = @benchmark mysum_simd($a)

# ╔═╡ 2093190a-e861-42a0-aaea-d2114f42d1b7
mysum_simd(a)

# ╔═╡ 122ef676-4750-4c6e-9d0a-ffd8038b7830
d["Julia hand-written simd"] = minimum(j_bench_hand_simd.times) / 1e6

# ╔═╡ 37e88421-4164-4c9d-8fae-da99f6ca3cdf
d

# ╔═╡ 9f6412cc-e489-4bf6-83a0-621a43c0ad37
md"""
# Summary
"""

# ╔═╡ 77d326b3-69f9-44eb-8c39-b4b35013e074
for (key, value) in sort(collect(d), by=last)
    println(rpad(key, 25, "."), lpad(round(value; digits=1), 6, "."))
end

# ╔═╡ Cell order:
# ╟─a4553f60-ef91-11ed-2378-c1db41212254
# ╟─55c0e4ee-361f-4bbe-8135-60d98a3160e5
# ╟─41683285-7bc2-4092-8b1f-070b7f1e1112
# ╟─bf9f691e-cca7-464e-8335-4dd1f77de409
# ╠═05b54418-e7c4-4280-83cc-1656f428a86d
# ╠═34fb9ca4-751f-417a-9e9a-6ab7b3e298ce
# ╟─a89dc104-1d2a-41da-9d08-f213559bb1c2
# ╟─b31eb7a3-f934-4623-9501-a2b69b3e3fa2
# ╠═41355af8-563d-4929-82bd-09751c83ee6f
# ╠═308b9385-0902-4f0b-9287-e6532bc01068
# ╠═199d92a1-8844-4e27-8240-962d3c275016
# ╟─b0cda634-a4ff-4a18-be31-5bf424069246
# ╠═b7c1d819-4532-4277-bc01-6357538a6ea3
# ╠═27122160-fc0c-485a-8565-448ef3ab0797
# ╠═4b9f66bb-7817-4274-b573-341f15be2a71
# ╟─b4167c22-aaf2-4076-b4a8-dcda1ef8865e
# ╠═de88855d-1f0d-41bb-985b-141ee2429c1c
# ╠═00d040a9-34d8-4c0a-91bf-a3135333e890
# ╠═b28f4d0f-afbf-41e9-aeda-ad8b6420862a
# ╠═e6b9d662-cd0a-4450-a13d-aba5d9e47068
# ╠═1ec43f63-e0a4-4800-af6f-485d24b777bb
# ╠═e95f1662-cb36-45b1-95e4-0db2149281e5
# ╠═0017b44b-d5b1-4a3d-be4e-258f7b0f792d
# ╠═4bb6f59c-8808-47b8-bfac-44879a3ed70f
# ╠═3deb941a-d382-4b43-af72-d1b8ed86f177
# ╠═f0dace67-6e9b-4206-901b-f7e8f05659a2
# ╠═c388b8b9-88ca-48d1-95f8-81e9bc4ecf8f
# ╠═ff94b0d0-0c1c-4ccf-be30-03bffd590354
# ╠═384d03f3-433f-4465-883c-61cffceb78c2
# ╠═35777942-f5d3-4da4-93b1-ebb322358b41
# ╠═f12e5a75-6045-421a-8e12-39a060d7bd1b
# ╠═d8d2e093-3e65-4bbc-a1df-c06e42487ea1
# ╠═4e6170d2-cdeb-40af-81c2-b736218b5223
# ╠═0708f051-80bf-4613-bbae-e816e3354cd6
# ╟─24a39c4c-bfea-4236-9a53-91b1073a4de4
# ╠═e80cf7fe-9fe9-44f3-a2d4-794120d21419
# ╠═b59db834-e0b2-4bd5-87b6-67ab6ddac415
# ╠═799f7d6f-7037-4301-a0b1-291d82266591
# ╟─0d19797c-6799-4374-8907-0cb5f5ebdf18
# ╠═881a660e-6996-4e37-aa5b-60a4542edc3f
# ╠═5a5d70ae-5c11-4b79-908a-dd111a585a68
# ╠═13a85fb7-9e40-4fb2-b821-f6ebc810ae79
# ╠═c077a142-e981-4e07-9e5f-5278ac997e73
# ╠═c6bd81d9-ad04-4683-84a6-d69325edf82b
# ╠═442a1b0c-42d0-4cdb-99eb-c8e336dfdb49
# ╠═48b72a2d-2ac7-471a-b40a-90b3052c2ea6
# ╠═53498029-6b38-42ac-8d59-acfb953d40be
# ╟─b8a6c2bc-1880-4bdc-bd4f-c7b54cb7e7be
# ╠═b42c3f38-4c52-44e1-955e-e2a6ce972941
# ╠═3cf20d97-0ec9-46aa-b9b7-f60773f45017
# ╠═b9db0e64-2939-48ad-bbc3-0dcaae6f408b
# ╠═d4396a72-2ee9-434a-9257-a39be9bb7458
# ╠═d68d07f8-df74-4f3e-b2d6-6029adebdc63
# ╠═1efb73e6-7f2e-48bd-a56a-1ca809e157e2
# ╠═15877e19-ffde-42c4-8b6d-0b7aede9da39
# ╠═c7d4a77d-9667-4943-9265-20cffdcb415b
# ╠═bdb58896-4ac9-4785-87ed-aa55913e7ca9
# ╟─2483622d-5795-42e8-b150-621fbc843cae
# ╠═265c78d7-1fd4-4bc8-b372-cd2097ca77a7
# ╠═3c98dd60-0678-4abe-945e-ed2c63113c3e
# ╠═b712063d-3c51-4749-acbf-e78911bfeb46
# ╠═0b429ef4-ac0c-48b7-8d2a-06ac792cdc25
# ╠═821f00ca-78e2-49eb-8392-fa5ddd7dddad
# ╠═defa1bcb-f7d7-406c-aed4-b1926a452940
# ╟─fa8e24bd-8ea1-408f-9418-53552442d9e0
# ╠═40fc29d8-1ad4-40d3-9a3d-cfe84a46b834
# ╠═1e1bfe37-d5d1-4bbf-805f-f3ada8f24cec
# ╠═a0123e52-e207-426b-b7c2-d794b5731b7a
# ╠═6d538261-1ff4-4219-acfe-31425a121cab
# ╠═8917b678-b826-4495-ad1d-9ed9bc509591
# ╠═95666d3d-b5e0-43a1-8b43-3c77e3fcf45a
# ╠═9356a6c3-4371-4107-b290-1ddd40b32aff
# ╠═922ebb22-8537-49f4-ad27-322acea9b489
# ╠═b63a9e9c-cac6-47fa-af95-f8ba99efef29
# ╠═df5fdaa1-e401-4259-a7e7-978a27420b0e
# ╠═7c66d97a-b7b3-4e6a-b9b2-9d7eac53180e
# ╠═2b7f411e-fbb0-4268-9f22-a8c1a265c02f
# ╟─a49a0821-35cf-48db-b0fa-dfa699e0fc22
# ╠═8ca98bb2-f0ba-412d-b49a-d4d5c521a205
# ╠═97c140cd-c9a0-4b21-9e78-06c149c35f55
# ╠═58265ba5-2d7e-48b3-8a93-8c78e86e60e1
# ╠═6a9c7f4d-5daf-4b24-b1a4-64f318fd2105
# ╟─25575c4d-b2c1-4d30-8ad3-c99a30a8a350
# ╠═cc167c9e-fd42-4234-bc73-4d02e3e70322
# ╠═84f1f940-87b4-4578-a02a-f0a8487832a6
# ╠═0e2d4e7e-418f-4b86-81d9-4f7b6993875b
# ╠═326f9ec7-6ea1-48c0-b657-56497cbfb63d
# ╠═15f1046e-7155-4610-9747-08d4630ef3f3
# ╠═4f0af23f-ac6b-4025-ac92-f1ff31c66e3e
# ╠═01711483-7d8b-41a7-ab63-0c1f0cd33092
# ╠═2093190a-e861-42a0-aaea-d2114f42d1b7
# ╠═122ef676-4750-4c6e-9d0a-ffd8038b7830
# ╠═37e88421-4164-4c9d-8fae-da99f6ca3cdf
# ╟─9f6412cc-e489-4bf6-83a0-621a43c0ad37
# ╠═77d326b3-69f9-44eb-8c39-b4b35013e074
