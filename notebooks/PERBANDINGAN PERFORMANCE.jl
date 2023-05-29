### A Pluto.jl notebook ###
# v0.19.25

using Markdown
using InteractiveUtils

# ╔═╡ 5e7b6a45-4f22-48cb-b229-679139aee9db
using BenchmarkTools

# ╔═╡ 9c4122d0-73d4-4023-ad4e-637cf938e320
using LinearAlgebra

# ╔═╡ 5a0f9470-fd68-11ed-2803-bb5d9ca81a3f
md"""# Tugas Perbandingan Performance
"""

# ╔═╡ 37377e32-1ae2-4b5f-bdda-a7d4d18c6205
function julia_optimized_collatz_conjecture(n)
    if n > 0
        sequence = Vector{Int}(undef, 1000000)
        sequence[1] = n
        length = 1
        @inbounds for i in 2:1000000
            if isodd(n)
                n = 3n + 1
            else
                n = n÷2
            end
            sequence[i] = n
            length = i
            n == 1 && break
        end
        return Dict("number" => sequence[1], "steps" => length, "sequence" => sequence[1:length])
    else
        println("ERROR: Masukan harus berupa bilangan bulat positif atau yang semisal.")
    end
end

# ╔═╡ ad7366a2-a105-4ae3-ac9d-3f413a37bd57
function python_collatz_conjecture(n)
    py"""
    def py_collatz_conjecture(n):
        sequence = [n]
        while n > 1:
            if n % 2 == 0:
                n = n // 2
            else:
                n = 3 * n + 1
            sequence.append(n)
        return {"number": sequence[0], "steps": len(sequence), "sequence": sequence}
    """
    return py"py_collatz_conjecture"(n)
end

# ╔═╡ 9fa7822b-144c-4554-bd25-8b30c9013f9f
nl = 10

# ╔═╡ 8844cb9a-db74-4170-ad6a-e610935e2e59
@benchmark julia_optimized_collatz_conjecture(n

# ╔═╡ 9f455182-4ea5-400c-815d-038cac54d8d1
begin
const libcollatz = "./collatz.so"

function fortran_collatz_conjecture(n::Int, sequence::Vector{Int32}, length::Ref{Int32})
    ccall((:fortran_collatz_conjecture_, libcollatz), Cvoid,
        (Cint, Ptr{Int32}, Ref{Int32}), n, sequence, length)
end

n = 27
sequence = Vector{Int32}(undef, 1000000)
length = Ref{Int32}(0)

fortran_collatz_conjecture(n, sequence, length)

println("Collatz sequence:")
for i in 1:length[]
    println(sequence[i])
end


end

# ╔═╡ 7d164836-862c-44a7-8bca-1eaa90b1d310
function julia_collatz_conjecture(n)
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
        println("ERROR: Masukan harus berupa bilangan bulat positif atau yang semisal.")
    end
end

# ╔═╡ b04ac2ef-0c99-4505-a5a1-ee8d0a12e868
@benchmark julia_collatz_conjecture(n)

# ╔═╡ 4740b32d-ef78-415b-9439-c5a31e06509c
@benchmark c_collatz_conjecture(n)

# ╔═╡ a2494d67-f3f7-4f92-a951-36d583033860
@benchmark c_collatz_conjecture_ffastmath(n)

# ╔═╡ 63b1863d-e0d0-4220-a413-33acc5babfa1
@benchmark fortran_collatz_conjecture(n)

# ╔═╡ a7eb93eb-a3a3-49f5-84d1-c0155b60db3e
# ╠═╡ disabled = true
#=╠═╡
begin
using Libdl
const Clib2 = tempname() # create a temporary file

C_code = """
#include <stdio.h>
#include <stdlib.h>

struct CResult {
    int number;
    int steps;
    int* sequence;
};

struct CResult c_collatz_conjecture(int n) {
    struct CResult result;
    result.sequence = (int*)malloc((n + 1) * sizeof(int));
    int index = 0;
    result.sequence[index++] = n;

    while (n > 1) {
        if (n % 2 == 1) {
            n = 3 * n + 1;
        } else {
            n = n / 2;
        }
        result.sequence[index++] = n;
    }

    result.number = result.sequence[0];
    result.steps = index;

    return result;
}
"""

# Compile C code to a shared library using GCC
open(`gcc -fPIC -O3 -msse3 -xc -shared -o $(Clib2 * "." * Libdl.dlext) -`, "w") do f
    print(f, C_code)
end

# Define the CResult struct using Ref
struct CResult
    number::Cint
    steps::Cint
    sequence::Ptr{Cint}
end

function c_lang(n)
    c_result = ccall((:c_collatz_conjecture, Clib2), CResult, (Cint,), n)
    sequence = unsafe_wrap(Vector{Cint}, c_result.sequence, c_result.steps)
    result_dict = Dict(
        "number" => c_result.number,
        "steps" => c_result.steps,
        "sequence" => Vector{Int}(sequence)
    )
    ccall(:free, Cvoid, (Ptr{Cint},), c_result.sequence)
    return result_dict
end
end
  ╠═╡ =#

# ╔═╡ 031e3ce7-33f5-4f2f-9582-2c6f55357890
begin
using Libdl
const Clib2 = tempname() # create a temporary file

C_code = """
#include <stdio.h>
#include <stdlib.h>

struct CResult {
    int number;
    int steps;
    int* sequence;
};

struct CResult c_collatz_conjecture(int n) {
    struct CResult result;
    result.sequence = (int*)malloc((n + 1) * sizeof(int));
    int index = 0;
    result.sequence[index++] = n;

    while (n > 1) {
        if (n % 2 == 1) {
            n = 3 * n + 1;
        } else {
            n = n / 2;
        }
        result.sequence[index++] = n;
    }

    result.number = result.sequence[0];
    result.steps = index;

    return result;
}
"""

# Compile C code to a shared library using GCC with -ffast-math
open(`gcc -fPIC -O3 -msse3 -xc -shared -ffast-math -o $(Clib2 * "." * Libdl.dlext) -`, "w") do f
    print(f, C_code)
end

# Define the CResult struct using Ref
struct CResult
    number::Cint
    steps::Cint
    sequence::Ptr{Cint}
end

function c_lang(n)
    c_result = ccall((:c_collatz_conjecture, Clib2), CResult, (Cint,), n)
    sequence = unsafe_wrap(Vector{Cint}, c_result.sequence, c_result.steps)
    result_dict = Dict(
        "number" => c_result.number,
        "steps" => c_result.steps,
        "sequence" => Vector{Int}(sequence)
    )
    ccall(:free, Cvoid, (Ptr{Cint},), c_result.sequence)
    return result_dict
end
end


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
Libdl = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[compat]
BenchmarkTools = "~1.3.2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.0"
manifest_format = "2.0"
project_hash = "2172b06dcd47c96720db32ad016a3e324c113947"

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
# ╟─5a0f9470-fd68-11ed-2803-bb5d9ca81a3f
# ╠═5e7b6a45-4f22-48cb-b229-679139aee9db
# ╠═9c4122d0-73d4-4023-ad4e-637cf938e320
# ╠═7d164836-862c-44a7-8bca-1eaa90b1d310
# ╠═37377e32-1ae2-4b5f-bdda-a7d4d18c6205
# ╠═a7eb93eb-a3a3-49f5-84d1-c0155b60db3e
# ╠═031e3ce7-33f5-4f2f-9582-2c6f55357890
# ╠═ad7366a2-a105-4ae3-ac9d-3f413a37bd57
# ╠═9fa7822b-144c-4554-bd25-8b30c9013f9f
# ╠═b04ac2ef-0c99-4505-a5a1-ee8d0a12e868
# ╠═4740b32d-ef78-415b-9439-c5a31e06509c
# ╠═a2494d67-f3f7-4f92-a951-36d583033860
# ╠═63b1863d-e0d0-4220-a413-33acc5babfa1
# ╠═8844cb9a-db74-4170-ad6a-e610935e2e59
# ╠═9f455182-4ea5-400c-815d-038cac54d8d1
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002