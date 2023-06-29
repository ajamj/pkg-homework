### A Pluto.jl notebook ###
# v0.19.22

using Markdown
using InteractiveUtils

# ╔═╡ 9f4f2e92-f418-400b-b58b-d345380615ac
using CUDA

# ╔═╡ 2525a692-dd06-49c6-89a2-21c7cc17c294
using BenchmarkTools

# ╔═╡ 4d9036d7-97b9-4908-be24-427b7869b437
# use cuBLAS for matrix multiplication
using LinearAlgebra

# ╔═╡ dfafe91a-07c7-4cfc-922b-db8ed2573e0f
# use cuFFT for FFT
using CUDA.CUFFT

# ╔═╡ 159ea7a0-0320-11ee-3d9f-dfa465d48aad
md"""
## GPU Programming

- `CUDA.jl` for NVIDIA GPUs
- `AMDGPU.jl` for AMD GPUs
- `oneAPI.jl` for Intel GPUs

`CUDA.jl` is the most mature, `AMDGPU.jl` is somewhat behind but still ready for general use, while `oneAPI.jl` is still under heavy development.

NVIDIA still dominates the HPC accelerator market and we will focus here on using `CUDA.jl` - the API of `AMDGPU.jl` is however completely analogous and translation between the two is straightforward.

`CUDA.jl` offers both user-friendly high-level abstractions that require very little programming effort and a lower level approach for writing kernels for fine-grained control.
"""

# ╔═╡ 0ba7a84f-774b-423e-8440-3f4d26ae7aeb
md"""
### Setup

Installing `CUDA.jl`:

	using Pkg
	Pkg.add("CUDA")
"""

# ╔═╡ 722198bb-e607-4c2b-a790-ce9e495070f5
md"""
To use the Julia GPU stack, one needs to have NVIDIA drivers installed and the CUDA toolkit to go with the drivers. Supercomputers with NVIDIA GPUs will already have both. For installation on other workstations one can follow the instructions from NVIDIA to install the drivers, and let Julia automatically install the correct version of the toolkit upon the first import: `using CUDA`.
"""

# ╔═╡ 05649715-9519-43f4-8e1e-02f4a648a333
md"""
## GPU vs CPUs

We first briefly discuss the hardware differences between GPUs and CPUs. This will help us understand the rationale behind the GPU programming methods described later.

![CPU vs GPU](https://static.freemake.com/blog/wp-content/uploads/2013/11/cpu-vs-gpu.png)
*A comparison of CPU and GPU architectures. A CPU has a complex core structure and packs several cores on a single chip. GPU cores are very simple in comparison and they share data, allowing to pack more cores on a single chip.*

Some key aspects of GPUs that need to be kept in mind:
- The large number of compute elements on a GPU (in the thousands) can enable extreme scaling for data parallel tasks (single-program multiple-data, SPMD)
- GPUs have their own memory. This means that data needs to be transfered to and from the GPU during the execution of a program.
- Cores in a GPU are arranged into a particular structure. At the highest level they are divided into “streaming multiprocessors” (SMs). Some of these details are important when writing own GPU kernels.

"""

# ╔═╡ 0a3c7e16-19fc-44f1-95d5-47881bb8712a
md"""
### SIMD vs SPMD

- SIMD is vectorization at the instruction level - each CPU instruction processes multiple data elements.
- SPMD is a much higher level abstraction where processes or programs are split across multiple processors and operate on different subsets of the data.
"""

# ╔═╡ e1ff419a-4572-43b7-92f4-b83bb32c9beb
md"""
## The array interface

GPU programming with Julia can be as simple as using `CuArray` (`ROCArray` for AMD) instead of regular `Base.Array` arrays. The `CuArray` type closely resembles `Base.Array` which enables us to write generic code which works on both types.

The following code copies an array to the GPU and executes a simple operation on the GPU:
"""

# ╔═╡ b713fbd0-ebfd-47d7-8edb-1477b0109744
A_GPU = CuArray([1,2,3,4])

# ╔═╡ e7b1e4d5-b51d-4fa9-92ac-69ab5edfe0ee
A_GPU .+= 1; # what does `.+=` means?

# ╔═╡ 86153e36-b803-4a8e-a2aa-7d4c9476f5f6
md"""
The GPU array will be stored at your GPU memory. In order to move an array back from the GPU to the CPU is simple:
"""

# ╔═╡ 08bcf88d-621b-4de9-81a4-8ff3bf006d01
A_CPU = Array(A_GPU);

# ╔═╡ 6c8af824-81b9-4edb-9248-3801e1406ed9
md"""
However, the overhead of copying data to the GPU makes such simple calculations very slow.

Let’s have a look at a more realistic example: matrix multiplication. We create two random arrays, one on the CPU and one on the GPU, and compare the performance:
"""

# ╔═╡ 0d67d7d1-f2fd-49b2-8994-2eb2a9f8eca6
A = rand(2^8, 2^8)

# ╔═╡ b0fcdd9c-f7dd-45de-b42d-0a1731915444
A_d = CUDA.rand(2^8, 2^8)

# ╔═╡ 2ff1c087-6ab9-49ea-b54e-7912bd6d6be5
begin
	@btime A*A;
	@btime A_d*A_d;
end

# ╔═╡ 862730af-388a-4d81-ad82-76fa74435ffb
md"""
Normally, there should be a dramatic speedup!
"""

# ╔═╡ 1892cd1e-03e4-4853-aac1-c8a5c90b70f6
md"""
### Vendor libraries

The NVIDIA libraries contain precompiled kernels for common operations like matrix multiplication (**cuBLAS**), fast Fourier transforms (**cuFFT**), linear solvers (**cuSOLVER**), etc. These kernels are wrapped in `CUDA.jl` and can be used directly with `CuArrays`:
"""

# ╔═╡ ecc7e873-97b2-470f-b7c2-f33d5c561c8d
# create a 100x100 Float32 random array
C = CUDA.rand(100, 100)

# ╔═╡ 1d033b2e-ab9d-4f11-a54c-a9a59352b304
# create a 100x100 uninitialized array
D = CuArray{Float32, 2}(undef, 100, 100)

# ╔═╡ 938ce63f-2551-421c-83dd-6c6da66df632
mul!(D, C, C)

# ╔═╡ 641000f4-6146-4e39-84ff-8ba089b90d48
md"""
Am = d

m = d / A
"""

# ╔═╡ 33f5fee1-ed53-4551-8e15-f7dec063764b
# solve equation C*x == D
C \ D

# ╔═╡ b66167bb-eb23-4642-8902-d120410ed208
fft(C)

# ╔═╡ a69b31f2-b6f9-4d90-adbd-848d8b5702b7
sizeof(C)

# ╔═╡ de7d98c9-3c23-49bd-800e-b8198653efde
md"""
## Higher-order abstractions

A powerful way to program GPUs with arrays is through Julia’s higher-order array abstractions. The simple element-wise addition we saw above, *`a .+= 1`*, is an example of this, but more general constructs can be created with `broadcast`, `map`, `reduce`, `accumulate` etc.
"""

# ╔═╡ 93d49c7e-2d49-4656-a5fa-ae70d7a4c6c9
begin
	# broadcast
	broadcast(C) do x
	    x += 1
	end
end

# ╔═╡ 480e350b-1f7a-4a7e-80e5-6e62988e9df0
begin
	#map
	map(C) do x
	    x + 1
	end
end

# ╔═╡ b56ae45b-05bd-4abe-a62f-0ebad6be8f7f
#reduce
reduce(+, C)

# ╔═╡ 178ab8b7-26f9-46f8-8965-1f070c701c79
#accumulate
accumulate(+, C)

# ╔═╡ e16387fd-73e4-4b4d-a0c4-9cbff619a841
md"""
Both `broadcast` and `map` apply a function to their arguments. The difference between the two is how they treat multidimensional arrays.

`broadcast` does an element-wise application of the given function. If the two array arguments have the same dimensions, the pairing of elements is similar to `map`

`map` tries to zip the arrays column first, creating an iterator of tuples, which are used as arguments to the given function.
"""

# ╔═╡ 86ffdca0-6dea-41dc-93e1-10509a7630a4
map(+, [1,2,3,4], [10 20;30 40])

# ╔═╡ 49d1caa6-89ae-47c0-a4a9-3bdeec41309c
broadcast(+, [1,2,3,4], [10 20; 30 40])

# ╔═╡ 2897dac0-5f0f-410d-b5da-9fe35cde66d2
broadcast(+, [1,2,3,4], [10, 20, 30, 40])

# ╔═╡ 9e28696d-ae62-47ca-89f7-baf9ca845089
map(+, [1,2,3,4], [10, 20, 30, 40])

# ╔═╡ df7022c4-a747-4daa-bac2-d7bfbecfdf4b
# broadcast(+, [1,2,3,4], [10 20 30 40]) ? why?

# ╔═╡ 27c9d2e9-01e0-4bde-8b16-d858c7344b0e
md"""
### Porting sqrt_sum
"""

# ╔═╡ 3e9c2377-3e86-470f-be70-cf188ca32cf9
function sqrt_sum(A)
    s = zero(eltype(A))
    for i in eachindex(A)
        @inbounds s += sqrt(A[i])
    end
    return s
end

# ╔═╡ de29eeab-17b1-4e72-9c9c-cfeeb39a53bf
md"""
First the square root should be taken of each element of the array, which we can do with `map(sqrt,A)`. Next we perform a reduction with the `+` operator. Combining these steps:
"""

# ╔═╡ aca4128e-285f-48f9-87a2-a0b9115e1a31
begin
	E = CuArray([1 2 3; 4 5 6; 7 8 9])
	reduce(+, map(sqrt,E))
end

# ╔═╡ 1135ae08-0099-4bd2-8421-3c074bcb5944
md"""
GPU porting complete!
"""

# ╔═╡ 19d3e449-e7dc-45c1-a2aa-8140dc7a4b88
md"""
## Writing your own kernels

Not all algorithms can be made to work with the higher-level abstractions in `CUDA.jl`. In such cases it’s necessary to explicitly write our own GPU kernel.

Let’s take a simple example, adding two vectors:
"""

# ╔═╡ b5e6b609-6971-4f20-9843-839f2419524a
function vadd!(c, a, b)
    for i in 1:length(a)
        @inbounds c[i] = a[i] + b[i]
    end
end

# ╔═╡ 8995fbe9-9b41-4c3c-9bc2-72acc50178bc
begin
	F = zeros(2^16) .+ 5.0
	G = ones(2^16)
	H = similar(G)
end

# ╔═╡ 802890d9-3f39-47b4-8f6b-484040ce63e3
@btime vadd!(H, F, G)

# ╔═╡ 019469ad-e81c-44c4-9d51-c1c08d7990c9
md"""
We can already run this on the GPU with the `@cuda` macro, which will compile `vadd!` into a GPU kernel and launch it:
"""

# ╔═╡ 0e4175bf-9bd8-417e-b69a-ebbde5e81c92
begin
	F_d = CuArray(F)
	G_d = CuArray(G)
	H_d = similar(G_d)
end

# ╔═╡ 2e118baa-76f2-49fe-bab2-8ad6edfdc7ea
@btime @cuda vadd!(H_d, F_d, G_d)

# ╔═╡ dd3c5fdf-81b5-421d-82d5-44b5d2f3d924
md"""
But the performance would be terrible because each thread on the GPU would be performing the same loop. So we have to remove the loop over all elements and instead use the special `threadIdx` and `blockDim` functions, analogous respectively to `threadid` and `nthreads` for multithreading.
"""

# ╔═╡ b48b94ca-b213-434d-8295-1d7ae4ea45be
md"""
![MappingBlocksToSMs](https://cuda.juliagpu.org/stable/tutorials/intro1.png)
"""

# ╔═╡ 30fb5dc9-c647-4c56-a2f7-394c918eabc7
md"""
![Streaming Multiprocessor on NVIDIA GA100](https://developer.download.nvidia.com/devblogs/ga100-full-gpu-128-sms.png)
_full NVIDIA GA100 GPU with 128 Streaming Multiprocessors (SMs) on Ampere Architecture_
"""

# ╔═╡ 08e86c69-b395-42c2-ad86-c88e0300f550
md"""
Then, we can split work between the GPU threads like this:
"""

# ╔═╡ 4a89ca04-1ab5-48e9-bb1e-42eb8681ac63
function vadd_gpu!(c, a, b)
    index = threadIdx().x   # linear indexing, so only use `x`
    stride = blockDim().x
    for i = index:stride:length(a)
        c[i] = a[i] + b[i]
    end
    return
end

# ╔═╡ 5a16abba-7325-4a86-8994-a5480a14c938
# run using 256 threads
@btime @cuda threads=256 vadd_gpu!(H_d, F_d, G_d)

# ╔═╡ 912c52a5-ec8f-48cf-b5e6-36694be8eff1
md"""
But we can parallelize even further. GPUs have a limited number of threads they can run on a single SM, but they also have multiple SMs. To take advantage of them all, we need to run a kernel with multiple blocks:
"""

# ╔═╡ 05f974e3-a38d-4824-a16a-dada75114ce8
function vadd_gpu2!(c, a, b)
    i = threadIdx().x + (blockIdx().x - 1) * blockDim().x
    if i <= length(a)
        c[i] = a[i] + b[i]
    end
    return
end

# ╔═╡ d5fb94f3-86d8-49cf-b139-648fdbcc1db2
# smallest integer larger than or equal to length(A_d)/threads
numblocks = cld(length(F_d), 256)

# ╔═╡ 7a48ca34-2ab0-470d-9d4d-749dc9b22492
# run using 256 threads
@btime @cuda threads=256 blocks=numblocks vadd_gpu2!(H_d, F_d, G_d)

# ╔═╡ c3b4c1b0-cd50-4ae2-ae54-e473119a1bfb
md"""
We have been using 256 GPU threads, but this might not be optimal. The more threads we use the better is the performance, but the maximum number depends both on the GPU and the nature of the kernel. To optimize this choice, we can first create the kernel without launching it, query it for the number of threads supported, and then launch the compiled kernel:
"""

# ╔═╡ 9bf42557-3f3e-4c0b-bb45-832b89f20541
# compile kernel
kernel = @cuda launch=false vadd_gpu2!(H_d, F_d, G_d)

# ╔═╡ 8ec25b42-66b1-4982-9ee4-baebdd119a6d
# extract configuration via occupancy API
config = launch_configuration(kernel.fun)

# ╔═╡ df2b484f-d96d-433f-ae63-9db9c5bfcdcc
# number of threads should not exceed size of array
threads = min(length(A), config.threads)

# ╔═╡ a3ec35fa-c3d7-4db6-97d3-fadc1f72b547
# smallest integer larger than or equal to length(A)/threads
blocks = cld(length(A), threads)

# ╔═╡ 8ca1685c-3898-40ae-8ed4-56f0558534eb
# launch kernel with specific configuration
@btime kernel(H_d, F_d, G_d; threads, blocks)

# ╔═╡ dbb5caae-fa1a-46f7-a541-554c9060b242
md"""
## Creating Julia Package

[Julia Package](https://pkgdocs.julialang.org/v1/creating-packages/)
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
CUDA = "052768ef-5323-5732-b1bb-66c8b64840ba"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[compat]
BenchmarkTools = "~1.3.2"
CUDA = "~4.3.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.0"
manifest_format = "2.0"
project_hash = "b4775d72461ba48155db02dc54ae365be03630bf"

[[deps.AbstractFFTs]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "16b6dbc4cf7caee4e1e75c49485ec67b667098a0"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.3.1"

    [deps.AbstractFFTs.extensions]
    AbstractFFTsChainRulesCoreExt = "ChainRulesCore"

    [deps.AbstractFFTs.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"

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

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Atomix]]
deps = ["UnsafeAtomics"]
git-tree-sha1 = "c06a868224ecba914baa6942988e2f2aade419be"
uuid = "a9b6321e-bd34-4604-b9c9-b65b8de01458"
version = "0.1.0"

[[deps.BFloat16s]]
deps = ["LinearAlgebra", "Printf", "Random", "Test"]
git-tree-sha1 = "dbf84058d0a8cbbadee18d25cf606934b22d7c66"
uuid = "ab4f0b2a-ad5b-11e8-123f-65d77653426b"
version = "0.4.2"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "d9a9701b899b30332bbcb3e1679c41cce81fb0e8"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.3.2"

[[deps.CEnum]]
git-tree-sha1 = "eb4cb44a499229b3b8426dcfb5dd85333951ff90"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.4.2"

[[deps.CUDA]]
deps = ["AbstractFFTs", "Adapt", "BFloat16s", "CEnum", "CUDA_Driver_jll", "CUDA_Runtime_Discovery", "CUDA_Runtime_jll", "CompilerSupportLibraries_jll", "ExprTools", "GPUArrays", "GPUCompiler", "KernelAbstractions", "LLVM", "LazyArtifacts", "Libdl", "LinearAlgebra", "Logging", "Preferences", "Printf", "Random", "Random123", "RandomNumbers", "Reexport", "Requires", "SparseArrays", "SpecialFunctions", "UnsafeAtomicsLLVM"]
git-tree-sha1 = "beb01266a709235d8d9be1382d695a25f0b75bd3"
uuid = "052768ef-5323-5732-b1bb-66c8b64840ba"
version = "4.3.0"

[[deps.CUDA_Driver_jll]]
deps = ["Artifacts", "JLLWrappers", "LazyArtifacts", "Libdl", "Pkg"]
git-tree-sha1 = "498f45593f6ddc0adff64a9310bb6710e851781b"
uuid = "4ee394cb-3365-5eb0-8335-949819d2adfc"
version = "0.5.0+1"

[[deps.CUDA_Runtime_Discovery]]
deps = ["Libdl"]
git-tree-sha1 = "bcc4a23cbbd99c8535a5318455dcf0f2546ec536"
uuid = "1af6417a-86b4-443c-805f-a4643ffb695f"
version = "0.2.2"

[[deps.CUDA_Runtime_jll]]
deps = ["Artifacts", "CUDA_Driver_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "TOML"]
git-tree-sha1 = "5248d9c45712e51e27ba9b30eebec65658c6ce29"
uuid = "76a88914-d11a-5bdc-97e0-2f5a05c973a2"
version = "0.6.0+0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.2+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.ExprTools]]
git-tree-sha1 = "c1d06d129da9f55715c6c212866f5b1bddc5fa00"
uuid = "e2ba6199-217a-4e67-a87a-7c52f15ade04"
version = "0.1.9"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.GPUArrays]]
deps = ["Adapt", "GPUArraysCore", "LLVM", "LinearAlgebra", "Printf", "Random", "Reexport", "Serialization", "Statistics"]
git-tree-sha1 = "9ade6983c3dbbd492cf5729f865fe030d1541463"
uuid = "0c68f7d7-f131-5f86-a1c3-88cf8149b2d7"
version = "8.6.6"

[[deps.GPUArraysCore]]
deps = ["Adapt"]
git-tree-sha1 = "1cd7f0af1aa58abc02ea1d872953a97359cb87fa"
uuid = "46192b85-c4d5-4398-a991-12ede77f4527"
version = "0.1.4"

[[deps.GPUCompiler]]
deps = ["ExprTools", "InteractiveUtils", "LLVM", "Libdl", "Logging", "Scratch", "TimerOutputs", "UUIDs"]
git-tree-sha1 = "11b2d77f29a85f3649c273a38f6618121c6b1c51"
uuid = "61eb1bfa-7361-4325-ad38-22787b887f55"
version = "0.20.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

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

[[deps.KernelAbstractions]]
deps = ["Adapt", "Atomix", "InteractiveUtils", "LinearAlgebra", "MacroTools", "PrecompileTools", "SparseArrays", "StaticArrays", "UUIDs", "UnsafeAtomics", "UnsafeAtomicsLLVM"]
git-tree-sha1 = "47be64f040a7ece575c2b5f53ca6da7b548d69f4"
uuid = "63c18a36-062a-441e-b654-da1e3ab1ce7c"
version = "0.9.4"

[[deps.LLVM]]
deps = ["CEnum", "LLVMExtra_jll", "Libdl", "Printf", "Unicode"]
git-tree-sha1 = "26a31cdd9f1f4ea74f649a7bf249703c687a953d"
uuid = "929cbde3-209d-540e-8aea-75f648917ca0"
version = "5.1.0"

[[deps.LLVMExtra_jll]]
deps = ["Artifacts", "JLLWrappers", "LazyArtifacts", "Libdl", "TOML"]
git-tree-sha1 = "09b7505cc0b1cee87e5d4a26eea61d2e1b0dcd35"
uuid = "dad2f222-ce93-54a1-a47d-0025e8a3acab"
version = "0.0.21+0"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

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

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "42324d08725e200c23d4dfb549e0d5d89dede2d2"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.10"

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

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "a5aef8d4a6e8d81f171b2bd4be5265b01384c74c"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.10"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.0"

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

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Random123]]
deps = ["Random", "RandomNumbers"]
git-tree-sha1 = "552f30e847641591ba3f39fd1bed559b9deb0ef3"
uuid = "74087812-796a-5b5d-8853-05524746bad3"
version = "1.6.1"

[[deps.RandomNumbers]]
deps = ["Random", "Requires"]
git-tree-sha1 = "043da614cc7e95c703498a491e2c21f58a2b8111"
uuid = "e6cf234a-135c-5ec9-84dd-332b85af5143"
version = "1.5.3"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

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

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

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

[[deps.TimerOutputs]]
deps = ["ExprTools", "Printf"]
git-tree-sha1 = "f548a9e9c490030e545f72074a41edfd0e5bcdd7"
uuid = "a759f4b9-e2f1-59dc-863e-4aeb61b1ea8f"
version = "0.5.23"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnsafeAtomics]]
git-tree-sha1 = "6331ac3440856ea1988316b46045303bef658278"
uuid = "013be700-e6cd-48c3-b4a1-df204f14c38f"
version = "0.2.1"

[[deps.UnsafeAtomicsLLVM]]
deps = ["LLVM", "UnsafeAtomics"]
git-tree-sha1 = "ea37e6066bf194ab78f4e747f5245261f17a7175"
uuid = "d80eeb9a-aca5-4d75-85e5-170c8b632249"
version = "0.1.2"

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
# ╟─159ea7a0-0320-11ee-3d9f-dfa465d48aad
# ╟─0ba7a84f-774b-423e-8440-3f4d26ae7aeb
# ╟─722198bb-e607-4c2b-a790-ce9e495070f5
# ╟─05649715-9519-43f4-8e1e-02f4a648a333
# ╟─0a3c7e16-19fc-44f1-95d5-47881bb8712a
# ╟─e1ff419a-4572-43b7-92f4-b83bb32c9beb
# ╠═9f4f2e92-f418-400b-b58b-d345380615ac
# ╠═b713fbd0-ebfd-47d7-8edb-1477b0109744
# ╠═e7b1e4d5-b51d-4fa9-92ac-69ab5edfe0ee
# ╟─86153e36-b803-4a8e-a2aa-7d4c9476f5f6
# ╠═08bcf88d-621b-4de9-81a4-8ff3bf006d01
# ╟─6c8af824-81b9-4edb-9248-3801e1406ed9
# ╠═2525a692-dd06-49c6-89a2-21c7cc17c294
# ╠═0d67d7d1-f2fd-49b2-8994-2eb2a9f8eca6
# ╠═b0fcdd9c-f7dd-45de-b42d-0a1731915444
# ╠═2ff1c087-6ab9-49ea-b54e-7912bd6d6be5
# ╟─862730af-388a-4d81-ad82-76fa74435ffb
# ╟─1892cd1e-03e4-4853-aac1-c8a5c90b70f6
# ╠═ecc7e873-97b2-470f-b7c2-f33d5c561c8d
# ╠═1d033b2e-ab9d-4f11-a54c-a9a59352b304
# ╠═4d9036d7-97b9-4908-be24-427b7869b437
# ╠═938ce63f-2551-421c-83dd-6c6da66df632
# ╠═641000f4-6146-4e39-84ff-8ba089b90d48
# ╠═33f5fee1-ed53-4551-8e15-f7dec063764b
# ╠═dfafe91a-07c7-4cfc-922b-db8ed2573e0f
# ╠═b66167bb-eb23-4642-8902-d120410ed208
# ╠═a69b31f2-b6f9-4d90-adbd-848d8b5702b7
# ╟─de7d98c9-3c23-49bd-800e-b8198653efde
# ╠═93d49c7e-2d49-4656-a5fa-ae70d7a4c6c9
# ╠═480e350b-1f7a-4a7e-80e5-6e62988e9df0
# ╠═b56ae45b-05bd-4abe-a62f-0ebad6be8f7f
# ╠═178ab8b7-26f9-46f8-8965-1f070c701c79
# ╟─e16387fd-73e4-4b4d-a0c4-9cbff619a841
# ╠═86ffdca0-6dea-41dc-93e1-10509a7630a4
# ╠═49d1caa6-89ae-47c0-a4a9-3bdeec41309c
# ╠═2897dac0-5f0f-410d-b5da-9fe35cde66d2
# ╠═9e28696d-ae62-47ca-89f7-baf9ca845089
# ╠═df7022c4-a747-4daa-bac2-d7bfbecfdf4b
# ╟─27c9d2e9-01e0-4bde-8b16-d858c7344b0e
# ╠═3e9c2377-3e86-470f-be70-cf188ca32cf9
# ╟─de29eeab-17b1-4e72-9c9c-cfeeb39a53bf
# ╠═aca4128e-285f-48f9-87a2-a0b9115e1a31
# ╟─1135ae08-0099-4bd2-8421-3c074bcb5944
# ╟─19d3e449-e7dc-45c1-a2aa-8140dc7a4b88
# ╠═b5e6b609-6971-4f20-9843-839f2419524a
# ╠═8995fbe9-9b41-4c3c-9bc2-72acc50178bc
# ╠═802890d9-3f39-47b4-8f6b-484040ce63e3
# ╟─019469ad-e81c-44c4-9d51-c1c08d7990c9
# ╠═0e4175bf-9bd8-417e-b69a-ebbde5e81c92
# ╠═2e118baa-76f2-49fe-bab2-8ad6edfdc7ea
# ╟─dd3c5fdf-81b5-421d-82d5-44b5d2f3d924
# ╟─b48b94ca-b213-434d-8295-1d7ae4ea45be
# ╟─30fb5dc9-c647-4c56-a2f7-394c918eabc7
# ╟─08e86c69-b395-42c2-ad86-c88e0300f550
# ╠═4a89ca04-1ab5-48e9-bb1e-42eb8681ac63
# ╠═5a16abba-7325-4a86-8994-a5480a14c938
# ╟─912c52a5-ec8f-48cf-b5e6-36694be8eff1
# ╠═05f974e3-a38d-4824-a16a-dada75114ce8
# ╠═d5fb94f3-86d8-49cf-b139-648fdbcc1db2
# ╠═7a48ca34-2ab0-470d-9d4d-749dc9b22492
# ╟─c3b4c1b0-cd50-4ae2-ae54-e473119a1bfb
# ╠═9bf42557-3f3e-4c0b-bb45-832b89f20541
# ╠═8ec25b42-66b1-4982-9ee4-baebdd119a6d
# ╠═df2b484f-d96d-433f-ae63-9db9c5bfcdcc
# ╠═a3ec35fa-c3d7-4db6-97d3-fadc1f72b547
# ╠═8ca1685c-3898-40ae-8ed4-56f0558534eb
# ╟─dbb5caae-fa1a-46f7-a541-554c9060b242
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002