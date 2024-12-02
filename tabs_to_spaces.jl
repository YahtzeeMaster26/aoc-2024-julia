# this is necessary to post my solutions on discord - there seems to be a
#  recently introduced bug where tab indentation in file previews is'nt shown
# also, discord doesn't have a text preview for .jl files
write("tabs_to_spaces_out.txt", replace(read("day2.jl", String), "\t" => "  "))
