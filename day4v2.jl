function parseinput()
	string = filter(x -> x != '\r', read("day4.txt", String))

	reduce(hcat, split(string, "\n") .|> x -> split(x, ""))
end

hasindices(matrix, indices) = all(isassigned.(Ref(matrix), indices))
wordmatches(matrix, expected) = hasindices(matrix, first.(expected)) &&
	all(expected .|> i_c -> getindex(matrix, i_c[1]) == i_c[2])
countinstances(matrix, expectedfrom) = sum(CartesianIndices(matrix) .|>
	i -> count(wordmatches.(Ref(matrix), expectedfrom(i))))

function expectedfrom1(i)
	line(x, y) = CartesianIndex(x, y) |> x -> [x .* 0, x .* 1, x .* 2, x .* 3]

	[
		line(-1, -1), line(-1, 0), line(-1, 1), line(0, -1),
		line(0, 1), line(1, -1), line(1, 0), line(1, 1)
	] .|> line -> zip(line .+ i, ["X", "M", "A", "S"])
end

function expectedfrom2(i)
	base = [(0, 0), (0, 2), (1, 1), (2, 2), (2, 0)] .|> CartesianIndex

	# indexing a vector with a permutation returns the result of the permutation
	getindex.(Ref(base), [[1, 2, 3, 4, 5], [2, 4, 3, 5, 1], [4, 5, 3, 1, 2], [5, 1, 3, 2, 4]]) .|>
		pattern -> zip(pattern .+ i, ["M", "M", "A", "S", "S"])
end

input = parseinput()
println("part 1: ", countinstances(input, expectedfrom1))
println("part 2: ", countinstances(input, expectedfrom2))