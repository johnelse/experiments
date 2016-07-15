(* A demonstration of OCaml Exception Backtrace Decapitation *)
(* Author: Jonathan Knowles <jonathan.knowles@eu.citrix.com> *)

exception Foo
exception Bar

type ('a, 'b) result = Success of 'a | Failure of 'b

let try_finally f g =
	let fr = try Success (f ()) with e -> Failure (e) in
	let gr = try Success (g ()) with e -> Failure (e) in
	match fr, gr with
	| Success fr, Success () -> fr
	| Success fr, Failure ge -> raise ge
	| Failure fe, Success () -> raise fe
	| Failure fe, Failure ge -> raise ge

let e1 () = print_endline "e1-start"; raise Foo; print_endline "e1-end"
let d1 () = print_endline "d1-start"; e1 ();     print_endline "d1-end"
let c1 () = print_endline "c1-start"; d1 ();     print_endline "c1-end"
let b1 () = print_endline "b1-start"; c1 ();     print_endline "b1-end"
let a1 () = print_endline "a1-start"; b1 ();     print_endline "a1-end"

let e2 () = print_endline "e2-start"; raise Bar; print_endline "e2-end"
let d2 () = print_endline "d2-start"; e2 ();     print_endline "d2-end"
let c2 () = print_endline "c2-start"; d2 ();     print_endline "c2-end"
let b2 () = print_endline "b2-start"; c2 ();     print_endline "b2-end"
let a2 () = print_endline "a2-start"; b2 ();     print_endline "a2-end"

let f () =
	print_endline "f-start";
	try_finally
		(fun () ->     a1 ()             )
		(fun () -> try a2 () with _ -> ());
	print_endline "f-end"

let e () = print_endline "e-start"; f (); print_endline "e-end"
let d () = print_endline "d-start"; e (); print_endline "d-end"
let c () = print_endline "c-start"; d (); print_endline "c-end"
let b () = print_endline "b-start"; c (); print_endline "b-end"
let a () = print_endline "a-start"; b (); print_endline "a-end"

let _ =
	Printexc.record_backtrace true;
	try
		a ()
	with e ->
		(* Here, we should get a complete backtrace X for e: *)
		(*     where X = [a, ..., e, f, a1, ..., e1]         *)
		(* Instead, we get a decapitated backtrace Y for e:  *)
		(*     where Y = [a, ..., e, f]                      *)
		let exception_backtrace = Printexc.get_backtrace () in
		let exception_name = Printexc.to_string e in
		Printf.printf
			("%s\n%s")
			(exception_name)
			(exception_backtrace)


