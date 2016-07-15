let find f map default feature =
	try f (List.assoc feature map)
	with _ -> default
let string = find (fun x -> x)

let get_hvm_serial_bust other_config platform =
	if ((string platform "" "hvm_serial") = "none") then Some (string platform "none" "hvm_serial")
	else if ((string other_config "" "hvm_serial") = "none") then Some (string platform "none" "hvm_serial")
	else Some (string platform "pty" "hvm_serial")

let run f other_config platform =
	match f other_config platform with
	| Some str -> Printf.printf "Some %s\n%!" str
	| None -> print_endline "None"

let () =
	run get_hvm_serial_bust [] [];
	run get_hvm_serial_bust ["hvm_serial", "none"] [];
	run get_hvm_serial_bust ["hvm_serial", "tcp:1.2.3.4:7001"] []
