let default = ""
let one = "one"
let two ="two"

let _ =
	let value = two in
	match value with
	| "" -> print_endline default
	| "one" -> print_endline one
	| "two" -> print_endline two
	| _ as str ->
		print_endline "unknown";
		print_endline str
