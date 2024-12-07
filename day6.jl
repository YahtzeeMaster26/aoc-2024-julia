function parseinput()
	string = filter(x -> x != '\r', read("day6.txt", String))

	matrix = permutedims(reduce(hcat, split(string, "\n") .|> x -> split(x, "")))

	guardpos = findfirst(==("^"), matrix)
	(guardpos, matrix .|> x -> if x == "#" 1 else 0 end)
end

# damn column major ordering
const UP = CartesianIndex(-1, 0)
const DOWN = CartesianIndex(1, 0)
const LEFT = CartesianIndex(0, -1)
const RIGHT = CartesianIndex(0, 1)
function solve1(guardpos, matrix)
	guardspeed = UP

	visited = matrix .|> _ -> Dict(UP => false, DOWN => false, LEFT => false, RIGHT => false)

	while !visited[guardpos][guardspeed]
		visited[guardpos][guardspeed] = true

		if !isassigned(matrix, guardpos + guardspeed)  break  end

		while matrix[guardpos + guardspeed] == 1
			guardspeed = Dict(UP => RIGHT, RIGHT => DOWN, DOWN => LEFT, LEFT => UP)[guardspeed]
		end

		guardpos += guardspeed
	end

	count(x -> x[UP] || x[DOWN] || x[LEFT] || x[RIGHT], visited)
end

function doesloop(guardpos, matrix)
	guardspeed = UP

	visited = matrix .|> _ -> Dict(UP => false, DOWN => false, LEFT => false, RIGHT => false)

	while !visited[guardpos][guardspeed]
		visited[guardpos][guardspeed] = true

		if !isassigned(matrix, guardpos + guardspeed)  return false  end

		while matrix[guardpos + guardspeed] == 1
			guardspeed = Dict(UP => RIGHT, RIGHT => DOWN, DOWN => LEFT, LEFT => UP)[guardspeed]
		end

		guardpos += guardspeed
	end

	true
end

solve2(guardpos, matrix) = count(CartesianIndices(matrix)) do i
	m = deepcopy(matrix)
	setindex!(m, 1, i)
	doesloop(guardpos, m)
end

input = parseinput()
println(solve1(input[1], input[2]))
println(solve2(input[1], input[2]))