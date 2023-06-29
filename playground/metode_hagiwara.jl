### A Pluto.jl notebook ###
# v0.19.26

using Markdown
using InteractiveUtils

# ╔═╡ b2b0429b-e52c-479d-9189-84df884939ea
import Pkg; Pkg.add("MLJLinearModels")

# ╔═╡ b55aaf90-038f-11ee-3c91-c770fc9dc5b0
using Plots, PlutoUI, CSV, DataFrames, MLJ

# ╔═╡ 5e8d65a8-9b1d-419a-a268-9865e0fe2ad0
using ScientificTypes

# ╔═╡ dd8753f0-8b3e-49fc-b7b6-701e07e557f7
data = CSV.read("data_hagiwara.csv", DataFrame)


# ╔═╡ bb50b882-9ee4-45de-8ae4-c5674e7e071c
x_sp1 = 0

# ╔═╡ 7bbd7dc4-ad7a-4aae-a321-8407629f1326
x_sp2 = 11

# ╔═╡ b68abc8d-be31-4278-90bb-c7f0b7d45ffa
x_sp3 = 22

# ╔═╡ 773127c4-23b3-4cce-88c5-f11da084ba3f
function obj(sp_a, sp_b)
end

# ╔═╡ a625015f-f427-40da-8773-3411bc92918b
function get_eq(data, sp)
	sb_x = data[!, :sp1]
end

# ╔═╡ 280d2969-a4d2-45b2-ae8b-ee172bbb76ea
sb_x = data[!, :x_loc]

# ╔═╡ 0d0f9ca2-75f1-40e2-82b2-96f6d38204de
sp1 = data[!, :sp1]

# ╔═╡ 57691467-d2e5-4f79-8b96-9ae9ad407bb4
scatter(sb_x,sp1)

# ╔═╡ 119b9dc0-e833-40fc-9e23-832b8a5853c0
batas_lapisan = 0.025

# ╔═╡ 917f0289-5e06-4633-91f9-7914e66e4acb
sp1_greater = data[data[:, :sp1] .> 0.025, :]

# ╔═╡ 81752d5b-3e9a-4026-9a05-933a7c02577e
sp1_less_equal = data[data[:, :sp1] .<= 0.025, :]

# ╔═╡ fda5c9e8-a197-4b50-b1c9-6daf5a98d4d3
data_less = sp1_less_equal[:, [:x_loc, :sp1]]

# ╔═╡ 1b851a79-13c7-445a-9c9c-8625f20866a3
md""" Error dari sini"""

# ╔═╡ c69fb6f2-5f7e-4ecd-b847-b3ad9b8b9667
data1 = table(x=data_less.x_loc, y=data_less.sp1)

# ╔═╡ 784d3429-0da0-4f2e-beb6-c7b89f7b6203
import ScientificTypes: Continuous

# ╔═╡ d3d957b1-bf6a-4726-9626-98c661303bb5
schema = Schema(data_less[:, :x_loc] = Continuous, data_less[:, :sp1] = Continuous)

# ╔═╡ 5c3588fe-73e2-4bae-b26f-ba9ab33756e5
@load LinearRegressor pkg=MLJLinearModels

# ╔═╡ 9a5c8a11-84df-43ad-b2ff-436b3890195a
model = MLJLinearModels.LinearRegressor() 

# ╔═╡ 8ad2f36d-4726-41cb-adcc-b88edcdf1524
machine = machine(model, data_less[:, :x_loc], data_less[:, :sp1])

# ╔═╡ Cell order:
# ╠═b55aaf90-038f-11ee-3c91-c770fc9dc5b0
# ╠═dd8753f0-8b3e-49fc-b7b6-701e07e557f7
# ╠═bb50b882-9ee4-45de-8ae4-c5674e7e071c
# ╠═7bbd7dc4-ad7a-4aae-a321-8407629f1326
# ╠═b68abc8d-be31-4278-90bb-c7f0b7d45ffa
# ╠═773127c4-23b3-4cce-88c5-f11da084ba3f
# ╠═a625015f-f427-40da-8773-3411bc92918b
# ╠═280d2969-a4d2-45b2-ae8b-ee172bbb76ea
# ╠═0d0f9ca2-75f1-40e2-82b2-96f6d38204de
# ╠═57691467-d2e5-4f79-8b96-9ae9ad407bb4
# ╠═119b9dc0-e833-40fc-9e23-832b8a5853c0
# ╠═917f0289-5e06-4633-91f9-7914e66e4acb
# ╠═81752d5b-3e9a-4026-9a05-933a7c02577e
# ╠═fda5c9e8-a197-4b50-b1c9-6daf5a98d4d3
# ╟─1b851a79-13c7-445a-9c9c-8625f20866a3
# ╠═c69fb6f2-5f7e-4ecd-b847-b3ad9b8b9667
# ╠═5e8d65a8-9b1d-419a-a268-9865e0fe2ad0
# ╠═784d3429-0da0-4f2e-beb6-c7b89f7b6203
# ╠═d3d957b1-bf6a-4726-9626-98c661303bb5
# ╠═b2b0429b-e52c-479d-9189-84df884939ea
# ╠═5c3588fe-73e2-4bae-b26f-ba9ab33756e5
# ╠═9a5c8a11-84df-43ad-b2ff-436b3890195a
# ╠═8ad2f36d-4726-41cb-adcc-b88edcdf1524
