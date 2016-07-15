let echo fd =
	let chars = 128 in
	let buf = String.create chars in
	Unix.read fd buf 0 chars;
	Unix.write fd buf 0 chars;
	Unix.close fd

let _ =
	let localhost = Unix.inet_addr_of_string "127.0.0.1" in
	let port = 80 in
	let addr = Unix.ADDR_INET(localhost, port) in
	print_endline "listening";
	while true do
		print_endline "waiting for connection"
	done
