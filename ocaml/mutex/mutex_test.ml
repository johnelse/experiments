module Mutex = struct
	include Mutex
	(** execute the function f with the mutex hold *)
	let execute lock f =
		Mutex.lock lock;
		let r = begin try f () with exn -> Mutex.unlock lock; raise exn end; in
		Mutex.unlock lock;
		r
end

let main_mutex = Mutex.create ()

let wait_a_bit () =
	Thread.delay 10.0;
	print_endline "waiting is finished"

let _ =
	print_endline "creating thread";
	Mutex.execute main_mutex
		(fun () -> ignore (Thread.create (fun () -> wait_a_bit ()) ()));
	print_endline "thread created";
	Mutex.execute main_mutex
		(fun () -> print_endline "exiting")
