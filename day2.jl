function parseinput()
	string = filter(x -> x != '\r', read("day2.txt", String))

	split(string, "\n") .|> x -> parse.(Int, split(x, " "))
end

function safe(list)
	diffs = list[1:end-1] - list[2:end]
	all(1 .<= diffs .<= 3) || all(-3 .<= diffs .<= -1)
end

solve1(input) = count(safe, input)

remove(list, i) = [list[1:i-1]; list[i+1:end]]
safetolerant(list) = any(1:length(list) .|> i -> safe(remove(list, i)))

solve2(input) = count(safetolerant, input)

input = parseinput()
println(solve1(input))
println(solve2(input))