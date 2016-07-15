exception Break

let lines_fold_loop f start input =
	let accumulator = ref start in
	let running = ref true in
	while !running do
		let line =
			try Some (input_line input)
			with End_of_file -> None
		in
		match line with
		| Some line ->
			begin
				try accumulator := (f !accumulator line)
				with Break -> running := false
			end
		| None ->
				running := false
	done;
	!accumulator

let lines_fold_rec f start input =
	let rec fold accumulator =
		let line =
			try Some (input_line input)
			with End_of_file -> None in
		match line with
		| Some line -> (try fold (f accumulator line) with Break -> accumulator)
		(*| Some line -> fold (f accumulator line)*)
		| None -> accumulator in
	fold start

let lines_iter f = lines_fold_loop (fun () line -> ignore(f line)) ()

let write_lines n chan =
	for i = 1 to n do
		output_string chan (Printf.sprintf "%d - here is some output.\n" i);
	done

let _ =
	let fd_in, fd_out = Unix.pipe () in
	print_endline "Forking.";
	let result = Unix.fork () in
	if result = 0 then begin
		(* Child - writer. *)
		Unix.close fd_in;
		write_lines 1000000000 (Unix.out_channel_of_descr fd_out);
		Unix.shutdown fd_out Unix.SHUTDOWN_SEND
	end else begin
		(* Parent - reader. *)
		Unix.close fd_out;
		print_endline "Starting to read from pipe.";
		let in_channel = Unix.in_channel_of_descr fd_in in
		begin
			try
				lines_iter
					(fun line -> print_endline line)
					in_channel
			with e ->
				print_endline (Printf.sprintf "Caught exception %s" (Printexc.to_string e))
		end;
		print_endline "Done."
	end
