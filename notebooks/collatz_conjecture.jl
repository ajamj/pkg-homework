function to_int(n)
	"""
    to_int(n)

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
	try
		if (isa(n, String))
			if occursin(".0",n)
				n = parse(Float16, n)
				n = convert(Int, n)
			#elseif occursin("0im", n)
			#	n = parse(Complex, n)
			#	n = real(n)
			#	println(n)
			#elseif occursin("//", n)
			#	n = parse(Rational, n)
			elseif !occursin(".",n)
				n = parse(Int, n)
				return n
			end
		end
		if ((n isa Float16 || n isa Float32 || n isa Float64) && isinteger(n) && n>0)
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

function collatz_conjecture(n)
    """
    Collatz Conjecture Function
    Input: n = bilangan bulat positif
    Output: dictionary dengan keys: number, steps, dan sequence.

    Jika n ganjil, kali 3 dan tambah 1 -> n = 3n+1
    Jika n genap, bagi 2 -> n = n/2

    Contoh: n = 5
    Sequence: 5, 16, 8, 4, 2, 1
    Total steps: 5
    """
    if typeof(n) != Int
        n = to_int(n)
    end
    if n > 0
        steps = 0
        sequence = [n]
        while n > 1
            if isodd(n)
                n = 3*n + 1
            else
                n = n÷2
            end
            push!(sequence, n)
            steps += 1
        end
        return Dict("number" => sequence[1], "steps" => steps, "sequence" => sequence)
    else
        error("ERROR: Masukan harus berupa bilangan bulat positif atau yang semisal.")
    end
end


dict = collatz_conjecture(5)