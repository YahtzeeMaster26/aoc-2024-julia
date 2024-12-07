function parseinput()
	string = filter(x -> x != '\r', read("day7.txt", String))

	split(string, "\n") .|> x -> split(x, ": ") |>
	pair -> (parse.(Int, pair[1]), parse.(Int, split(pair[2], " ")))
end

function allopcombinations(len, allowedops)::Vector{Vector{Function}}
	if len == 1
		allowedops .|> x -> [x]
	else
		reduce(vcat, allopcombinations(len - 1, allowedops) .|>
			list -> allowedops .|> op -> vcat([op], list))
	end
end

function reducewithops(list, ops)
	acc = list[1]
	idx = 2
	for op in ops
		acc = op(acc, list[idx])
		idx += 1
	end
	acc
end

function checkpossible(result, list, allowedops)
	opss = allopcombinations(length(list) - 1, allowedops)
	any(==(result), reducewithops.(Ref(list), opss))
end

solve(input, allowedops) = sum(pair -> pair[1],
	filter(pair -> checkpossible(pair[1], pair[2], allowedops), input))

concatdigits(x, y) = convert(Int, x * 10 ^ ceil(log10(max(y + 1, 1))) + y)

input = parseinput()


println(solve(input, [+, *]))
println(solve(input, [+, *, concatdigits]))