readinput() = filter(x -> x != '\r', read("day3.txt", String))

solve1(input) =
	sum(
		eachmatch(r"mul\((\d+),(\d+)\)", input)
		.|> x -> parse(Int, x[1]) * parse(Int, x[2]))

function solve2(input)
	active = true
	sum = 0
	for m in eachmatch(r"(mul)\((\d+),(\d+)\)|(do)\(\)|(don't)\(\)", input)
		if !isnothing(m[1])
			if active  sum += parse(Int, m[2]) * parse(Int, m[3])  end
		elseif !isnothing(m[4])
			active = true
		elseif !isnothing(m[5])
			active = false
		end
	end

	sum
end

input = readinput()
println(solve1(input))
println(solve2(input))
