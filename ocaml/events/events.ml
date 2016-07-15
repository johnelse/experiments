(* http://ocamlunix.forge.ocamlcore.org/threads.html *)

module Mutex = struct
	include Mutex
	(** execute the function f with the mutex held *)
	let execute lock f =
		Mutex.lock lock;
		let r = begin try f () with exn -> Mutex.unlock lock; raise exn end; in
		Mutex.unlock lock;
		r
end

let print_mutex = Mutex.create ()
let chan: (string Event.channel)  = Event.new_channel ()

let rec printer () =
	let input = Event.sync (Event.receive chan) in
	print_endline input;
	printer ()

let _ =
	let _ = Thread.create printer () in
	while true do
		Event.sync (Event.send chan "hello");
		print_endline "erk";
		Thread.delay 1.0
	done
