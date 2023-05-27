### A Pluto.jl notebook ###
# v0.19.25

using Markdown
using InteractiveUtils

# ╔═╡ dc6a52a2-f5b3-11ed-1aad-6b4046fd2c33
md"""
Fungsi validasi.
Fungsi operasi conjecture.
"""

# ╔═╡ 42e10319-69ec-41e6-8eb7-9ce63e64f150
md"""
Jika bukan string, lakukan cek lebih lanjut.
Jika string, parse.
"""

# ╔═╡ 3b3f8c1b-f75b-4220-ba2d-f5ad989d81b3
function is_string(n)
	if typeof(n) == String
        return true
	end
end

# ╔═╡ 0e02bc2c-7a0f-4f9a-a82c-dae71db0bc27
function get_int(n::Float64)
	return convert(Int, n)
end

# ╔═╡ c2679ad8-fb42-4543-a6b2-2f6c3d5ac9f6
function get_int(n::Complex)
	return real(n)
end

# ╔═╡ 2db7e487-010e-4575-a1ef-679a3d0489a9
get_int(2.0)

# ╔═╡ b963f9ac-5996-439e-a3e2-ccfac01d4f17


# ╔═╡ 547e8681-5e82-416a-bfbe-5c02866b8370
typeof("10.3")

# ╔═╡ 48b74516-aa84-486c-a19e-a8975aab0d7a
isinteger("2.0")

# ╔═╡ 012d5542-a268-4913-bf0b-28cf1e0154a5
x = "3//2"

# ╔═╡ e979f480-4974-436c-840b-069bfa46adf5
begin
function Base.parse(::Type{Rational{Int}}, x::AbstractString)
    ms, ns = split(x, '/', keep=false)
    m = parse(Int, ms)
    n = parse(Int, ns)
    return m//n
end

parse(Rational{Int}, x)
end

# ╔═╡ a8d41296-0ddb-401b-bb8c-d33cd9343d94
function to_not_string(n)
	try
	if occursin("im", n) && typeof(parse(Complex{Float64}, n))==Complex
		return parse(Complex{Float64}, n)
	elseif occursin(".", n) && typeof(parse(Float64, n))==Float64# Float
		return parse(Float64, n)
	elseif typeof(parse(Int, n))==Int
		return parse(Int, n)
	end
	catch
		error("Tipe data string tidak valid.")
	end
end

# ╔═╡ fc0d8379-5698-42e2-9c3f-1817c196a0db
to_not_string("2.0")

# ╔═╡ ec461312-23d4-4ad0-8c5c-6c1efed37e7d
function is_valid(n)
	if is_string(n)
		to_not_string(n)
	end
	if !isinteger(n)
		return false
	end
	if typeof(n) != Int
		n = get_int(n)
	end
	if n!>0
		return false
	end
	if typeof(n) == Int
		return n
	end
	return n
end

# ╔═╡ 84fac722-0352-40e5-ac61-e4c0679de759
function collatz_conjecture(n)
    try
		println(typeof(is_valid(n)))
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
	catch
        error("ERROR: Masukan harus berupa bilangan bulat positif atau yang semisal.")
    end
end

# ╔═╡ db013781-6fc0-40dc-9139-382ad13bd839
collatz_conjecture("2.0")

# ╔═╡ 50c0f424-06a1-4df5-9131-7ce9475140bf
begin
str_int = "10"
parsed_int = parse(Int, str_int)
println(parsed_int)  # Output: 10

str_float = "10.0"
parsed_float = parse(Float64, str_float)
println(parsed_float)  # Output: 10.0

str_complex = "23+2im"
parsed_complex = parse(Complex{Float64}, str_complex)
println(parsed_complex)  # Output: 23.0 + 2.0im

str_rational = "23//2"
parsed_rational = tryparse(Rational, str_rational)
println(parsed_rational)  # Output: 23//2

end

# ╔═╡ 24523fcf-7c49-4b23-9e07-d23ec29364d5
rationalize(convert(Float64, eval(parse("4//7"))))

# ╔═╡ a4c02ad7-7038-48e8-97a8-2749316c015d
parse(Rational{Int}, x)

# ╔═╡ 991eb0b3-d879-4cb2-8b02-a334ca8e9c69
begin
str_compl = "23+23im"
parsed_compl= parse(Complex{Float64}, str_compl)
end

# ╔═╡ 1f7d4dc9-8a93-409d-9e35-dbc7c7f7e5bd
typeof(23)!=String

# ╔═╡ Cell order:
# ╟─dc6a52a2-f5b3-11ed-1aad-6b4046fd2c33
# ╟─42e10319-69ec-41e6-8eb7-9ce63e64f150
# ╠═3b3f8c1b-f75b-4220-ba2d-f5ad989d81b3
# ╠═a8d41296-0ddb-401b-bb8c-d33cd9343d94
# ╠═fc0d8379-5698-42e2-9c3f-1817c196a0db
# ╠═0e02bc2c-7a0f-4f9a-a82c-dae71db0bc27
# ╠═c2679ad8-fb42-4543-a6b2-2f6c3d5ac9f6
# ╠═2db7e487-010e-4575-a1ef-679a3d0489a9
# ╠═ec461312-23d4-4ad0-8c5c-6c1efed37e7d
# ╠═db013781-6fc0-40dc-9139-382ad13bd839
# ╠═84fac722-0352-40e5-ac61-e4c0679de759
# ╠═b963f9ac-5996-439e-a3e2-ccfac01d4f17
# ╠═50c0f424-06a1-4df5-9131-7ce9475140bf
# ╠═547e8681-5e82-416a-bfbe-5c02866b8370
# ╠═48b74516-aa84-486c-a19e-a8975aab0d7a
# ╠═24523fcf-7c49-4b23-9e07-d23ec29364d5
# ╠═012d5542-a268-4913-bf0b-28cf1e0154a5
# ╠═e979f480-4974-436c-840b-069bfa46adf5
# ╠═a4c02ad7-7038-48e8-97a8-2749316c015d
# ╠═991eb0b3-d879-4cb2-8b02-a334ca8e9c69
# ╠═1f7d4dc9-8a93-409d-9e35-dbc7c7f7e5bd
