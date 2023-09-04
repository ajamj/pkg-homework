### A Pluto.jl notebook ###
# v0.19.26

using Markdown
using InteractiveUtils

# ╔═╡ f96935d3-e41f-4c85-a167-c375e18c7348
# ╠═╡ disabled = true
#=╠═╡
using Plots
  ╠═╡ =#

# ╔═╡ fc726416-0715-41bc-9198-139347fb1fe3
using GLMakie

# ╔═╡ 245fdf8f-0c72-4d24-bf35-8b14a7939869
md"""
# UJIAN AKHIR SEMESTER (UAS) GENAP 2022/2023
Mata Kuliah: Pemrograman Komputer Geofisika\
Nama: Ajam Jamaludin\
NIM: 19/445602/PA/19426\
"""

# ╔═╡ 2f355bc6-1146-11ee-2a34-a9a439017154
md"""
## Soal
Anda diminta untuk mengimplementasikan persamaan untuk menghitung nilai potensial gravitasi pada suatu titik amat yang berada pada suatu koordinat kartesian $$(U(x, y, z))$$ menggunakan bahasa Julia dengan kemampuan komputasi paralel (CPU atau GPU).\
\
Nilai potensial gravitasi pada suatu titik akibat suatu volume anomali dirumuskan dengan persamaan di bawah ini:

$$U(x,y,z)=G\sum_{V}\frac{\rho(\xi,\eta,\zeta)d\xi\, d\eta\, d\zeta}{((\xi-x)^2+(\eta-y)^2+(\zeta-z)^2)^{\frac{1}{2}}}$$
Keterangan:
$$G$$ adalah konstanta gravitasi universal\
$$\rho$$ adalah densitas sebagai fungsi spasial $$\xi,\eta,\zeta$$\
$$V$$ adalah volume anomali\
"""

# ╔═╡ 884ce133-6395-4668-85d5-e1c82f89c0a6
md"""
Gambar di bawah ini menjelaskan ilustrasi suatu medium, dimana di dalamnya terdapat suatu massa yang dikarakterisasikan dengan suatu distribusi densitas
$$\rho(\xi,\eta,\zeta)$$
"""

# ╔═╡ 0c1b1761-bff7-4c04-97cc-370928c7f334
md"""
![gambar ilustrasi](https://github.com/ajamj/ajamj.github.io/blob/main/img/gambar1.png?raw=true)
"""

# ╔═╡ 5baa0c2b-041a-44ce-aad3-d7901508e7aa
md"""
Buatkan suatu fungsi yang dapat menghitung nilai potensial gravitasi berdasarkan persamaan di atas! Gunakan bahasa pemrograman Julia dan manfaatkan pemrograman paralel. Anda dapat memilih untuk paralelisasi menggunakan CPU ataupun GPU. Uji kode yang sudah anda buat dengan anomali berbentuk sederhana (kubus, bola, dan silinder vertikal) dengan titik amat berada di satu bidang permukaan.
"""

# ╔═╡ 9bae94a4-42a3-4ea7-9d48-5974c65b4a69
md"""
## Pembahasan

"""

# ╔═╡ 441f353f-08cf-4922-b0f5-534a08371a3a
G = 6.67430e-11 # N m^2 kg^-2

# ╔═╡ 8f3da368-063d-4bec-9adb-02c09cb01f82
function gravitational_potential(x, y, z, volume, density)
    potential = 0.0
    
    for (ξ, η, ζ) in volume
        distance = sqrt((ξ - x)^2 + (η - y)^2 + (ζ - z)^2)
        potential += density(ξ, η, ζ) / distance
    end
    
    potential *= G
    return potential
end


# ╔═╡ ded0c908-e19f-4f40-8c21-4802f07fcf5f
function density(ξ, η, ζ)
    return 1.0  # Menggunakan densitas massa konstan
end

# ╔═╡ ecb726eb-6139-4bc4-87af-32a79f90bc9f
function sphere_volume(radius)
    volume = []
    num_points = 100  # Jumlah titik yang digunakan untuk mengaproksimasi bola
    
    phi_step = π / num_points
    theta_step = 2π / num_points
    
    for phi in 0:phi_step:π
        for theta in 0:theta_step:2π
            x = radius * sin(phi) * cos(theta)
            y = radius * sin(phi) * sin(theta)
            z = radius * cos(phi)
            push!(volume, (x, y, z))
        end
    end
    
    return volume
end

# ╔═╡ aeb46eea-2cb1-455e-9b69-5e47c20d7bf1
function cube_volume(a)
    volume = []
    for x in 0:a
        for y in 0:a
            for z in 0:a
                push!(volume, (x, y, z))
            end
        end
    end
    return volume
end

# ╔═╡ cada5b35-62a1-469f-a929-a011681512e2
function cylinder_volume(radius, height, num_points)
    volume = []
    theta_step = 2π / num_points
    
    for theta in 0:theta_step:2π
        for z in 0:height/num_points:height
            x = radius * cos(theta)
            y = radius * sin(theta)
            push!(volume, (x, y, z))
        end
    end
    return volume
end

# ╔═╡ fd576ef9-b732-4a1e-bc0d-be00bb5eab11
#=╠═╡
function plot_sphere(radius)
    volume = sphere_volume(radius)
    x = [point[1] for point in volume]
    y = [point[2] for point in volume]
    z = [point[3] for point in volume]
    
    scene = Scene()
    scatter!(scene, x, y, z, markersize = 0.2, color = :blue)
    xlabel!(scene, "X")
    ylabel!(scene, "Y")
    zlabel!(scene, "Z")
    title!(scene, "3D Sphere")
    
    display(scene)
end
  ╠═╡ =#

# ╔═╡ 62b9448f-68a5-4b6d-b529-516bd9dfc75b
volume = sphere_volume(5)

# ╔═╡ 752d175c-954e-4bff-bd1d-dd43c9d26fe5
#=╠═╡
plot_sphere(5)
  ╠═╡ =#

# ╔═╡ ef1aa806-be37-448c-bd0f-fb0f54647a81
#=╠═╡
potential = gravitational_potential(5, 0, 0, volume, density)
  ╠═╡ =#

# ╔═╡ 32530d71-4867-4844-a2fa-6bb5d88015b6
#=╠═╡
gravitational_potential(0, 0, 5, volume, density)
  ╠═╡ =#

# ╔═╡ Cell order:
# ╟─245fdf8f-0c72-4d24-bf35-8b14a7939869
# ╟─2f355bc6-1146-11ee-2a34-a9a439017154
# ╟─884ce133-6395-4668-85d5-e1c82f89c0a6
# ╟─0c1b1761-bff7-4c04-97cc-370928c7f334
# ╟─5baa0c2b-041a-44ce-aad3-d7901508e7aa
# ╟─9bae94a4-42a3-4ea7-9d48-5974c65b4a69
# ╠═f96935d3-e41f-4c85-a167-c375e18c7348
# ╠═fc726416-0715-41bc-9198-139347fb1fe3
# ╠═441f353f-08cf-4922-b0f5-534a08371a3a
# ╠═8f3da368-063d-4bec-9adb-02c09cb01f82
# ╠═ded0c908-e19f-4f40-8c21-4802f07fcf5f
# ╠═ecb726eb-6139-4bc4-87af-32a79f90bc9f
# ╠═aeb46eea-2cb1-455e-9b69-5e47c20d7bf1
# ╠═cada5b35-62a1-469f-a929-a011681512e2
# ╠═fd576ef9-b732-4a1e-bc0d-be00bb5eab11
# ╠═62b9448f-68a5-4b6d-b529-516bd9dfc75b
# ╠═752d175c-954e-4bff-bd1d-dd43c9d26fe5
# ╠═ef1aa806-be37-448c-bd0f-fb0f54647a81
# ╠═32530d71-4867-4844-a2fa-6bb5d88015b6
