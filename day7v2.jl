function parseinput()
	string = filter(x -> x != '\r', read("day7.txt", String))

	split(string, "\n") .|> x -> split(x, ": ") |>
	pair -> (parse.(Int, pair[1]), parse.(Int, split(pair[2], " ")))
end

popslice(x) = view(x, 1:(length(x)-1))

function trysolve1(result, operands)
	if length(operands) == 1  return result == operands[1]  end

	rightval = last(operands)

	quo = result ÷ rightval # integer division

	quo * rightval == result && trysolve1(quo, popslice(operands)) ||
		result - rightval > 0 && trysolve1(result - rightval, popslice(operands))
end

function trysolve2(result, operands)
	if length(operands) == 1  return result == operands[1]  end

	rightval = last(operands)

	quo = result ÷ rightval # integer division
	if quo * rightval == result && trysolve2(quo, popslice(operands))
		return true
	end
	if result - rightval > 0 && trysolve2(result - rightval, popslice(operands))
		return true
	end

	postfixexponent = ceil(log10(max(rightval + 1, 1)))
	if postfixexponent < 0  return false  end # can't convert 0.1 etc. to ints
	lengthfactor = convert(Int, 10 ^ postfixexponent)
	prefix = result ÷ lengthfactor

	prefix * lengthfactor + rightval == result && trysolve2(prefix, popslice(operands))
end

solve1(input) = sum(pair -> pair[1], filter(pair -> trysolve1(pair...), input))
solve2(input) = sum(pair -> pair[1], filter(pair -> trysolve2(pair...), input))

input = parseinput()
@time println("part 1 run 1 ", solve1(input))
@time println("part 1 run 2 ", solve1(input))
@time println("part 1 run 3 ", solve1(input))
@time println("part 1 run 4 ", solve1(input))
@time println("part 2 run 1 ", solve2(input))
@time println("part 2 run 2 ", solve2(input))
@time println("part 2 run 3 ", solve2(input))
@time println("part 2 run 4 ", solve2(input))