# this is necessary to post my solutions on discord - there seems to be a
#  recently introduced bug where tab indentation in file previews isn't shown
# also, discord doesn't have a text preview for .jl files
write("tts7.txt", replace(read("day7.jl", String), "\t" => "  "))
