open Bigarray

let _ =
	let a = Array1.create Bigarray.char Bigarray.c_layout 26 in
	for i = 0 to 25 do
		Array1.set a i (Char.chr (i + 65))
	done;
	let s = Marshal.to_string a [] in
	print_endline s
