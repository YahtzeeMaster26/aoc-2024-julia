function parseinput()
	string = filter(x -> x != '\r', read("day4.txt", String))

	# it is fine to not transpose this
	reduce(hcat, split(string, "\n") .|> x -> split(x, ""))
end

makeline(x) = CartesianIndex(x) |> x -> [x .* 0, x .* 1, x .* 2, x .* 3]

xmaslines = [
	makeline((-1, -1)), makeline((-1, 0)), makeline((-1, 1)),
	makeline((0, -1)), makeline((0, 1)),
	makeline((1, -1)), makeline((1, 0)), makeline((1, 1)),
]

hasline(matrix, line) = all(x -> isassigned(matrix, x), line)
xmasline(matrix, line) = hasline(matrix, line) &&
	(line .|> x -> getindex(matrix, x)) == ["X", "M", "A", "S"]

solve1(matrix) = sum(xmaslines .|> line ->
	count(CartesianIndices(matrix) .|> i -> xmasline(matrix, line .+ i)))

xmaslines2 = [
	[(0, 0), (2, 0), (1, 1), (0, 2), (2, 2)],
	[(2, 0), (2, 2), (1, 1), (0, 0), (0, 2)],
	[(2, 2), (0, 2), (1, 1), (2, 0), (0, 0)],
	[(0, 2), (0, 0), (1, 1), (2, 2), (2, 0)],
] .|> line -> CartesianIndex.(line)

xmasline2(matrix, line) = hasline(matrix, line) &&
	(line .|> x -> getindex(matrix, x)) == ["M", "M", "A", "S", "S"]
solve2(matrix) = sum(xmaslines2 .|> line ->
	count(CartesianIndices(matrix) .|> i -> xmasline2(matrix, line .+ i)))

input = parseinput()
println(solve1(input))
println(solve2(input))