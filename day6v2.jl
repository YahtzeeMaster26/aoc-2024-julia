function parseinput()
	string = filter(x -> x != '\r', read("day6.txt", String))

	matrix = permutedims(reduce(hcat, split(string, "\n") .|> x -> split(x, "")))

	guardpos = findfirst(==("^"), matrix)
	(guardpos, matrix .|> x -> if x == "#" 1 else 0 end)
end

@enum Direction up down left right

function Base.to_index(dir::Direction)
	if dir == up  1
	elseif dir == down  2
	elseif dir == left  3
	elseif dir == right  4
	end
end

# damn column major ordering
Base.:+(i::CartesianIndex, dir::Direction) =
	i + [CartesianIndex(-1, 0), CartesianIndex(1, 0), CartesianIndex(0, -1), CartesianIndex(0, 1)][dir]

function rotate(dir::Direction)
	if dir == up  right
	elseif dir == right  down
	elseif dir == down  left
	elseif dir == left  up
	end
end


function solve1(guardpos, matrix)
	guardspeed = up
	visited = matrix .|> _ -> [false, false, false, false]

	while !visited[guardpos][guardspeed]
		visited[guardpos][guardspeed] = true

		if !isassigned(matrix, guardpos + guardspeed)  break  end

		while matrix[guardpos + guardspeed] == 1
			guardspeed = rotate(guardspeed)
		end

		guardpos += guardspeed
	end

	count(x -> x[1] || x[2] || x[3] || x[4], visited)
end


function doesloop(guardpos, matrix)
	guardspeed = up
	visited = matrix .|> _ -> [false, false, false, false]

	while !visited[guardpos][guardspeed]
		visited[guardpos][guardspeed] = true

		if !isassigned(matrix, guardpos + guardspeed)  return false  end

		while matrix[guardpos + guardspeed] == 1
			guardspeed = rotate(guardspeed)
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