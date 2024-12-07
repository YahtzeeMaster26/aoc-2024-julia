function parseinput()
	string = filter(x -> x != '\r', read("day5.txt", String))

	x = split(string, "\n\n")

	(
		(split(x[1], "\n") .|> x -> parse.(Int, split(x, "|"))) .|>
			pair -> (pair[1], pair[2]),
		split(x[2], "\n") .|> x -> parse.(Int, split(x, ",")),
	)
end

checksequence(rules, sequence) = all(rules) do rule
	!(rule[1] in sequence) || !(rule[2] in sequence) ||
	(findfirst(==(rule[1]), sequence) < findfirst(==(rule[2]), sequence))
end

median(x) = x[(length(x) + 1) ÷ 2]

input = parseinput()
println(sum(median, filter(x -> checksequence(input[1], x), input[2])))
println(sum(median, sort.(
	filter(x -> !checksequence(input[1], x), input[2]);
	lt = (x, y) -> (x, y) in input[1]
)))