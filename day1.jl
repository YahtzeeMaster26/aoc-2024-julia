function parseinput()
	string = filter(x -> x != '\r', read("day1.txt", String))

	pairs = split(string, "\n") .|> x -> parse.(Int, split(x, "   "))

	(map(x -> x[1], pairs), map(x -> x[2], pairs))
end

solve1(left, right) = sum(abs.(left .- right))

# alternatively,
#  solve2(left, right) = sum(left .|> l -> sum(filter(r -> l == r, right)))
#  but that is a less efficient algorithm.
# still i am not really satisfied by this
function solve2(left, right)
	li = 1
	ri = 1

	sum = 0

	while li <= lastindex(left)
		num = left[li]

		while ri <= lastindex(right) && right[ri] < num  ri += 1  end

		(li0, ri0) = (li, ri)
		while li <= lastindex(left) && left[li] == num  li += 1  end
		while ri <= lastindex(right) && right[ri] == num  ri += 1  end
		sum += (li - li0) * (ri - ri0) * num
	end

	sum
end



(left, right) = sort.(parseinput())
println(solve1(left, right))
println(solve2(left, right))