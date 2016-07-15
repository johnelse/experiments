module type Handler = sig
	type t
	val get: unit -> t
	val process: t -> unit
end

module Int: Handler = struct
	type t = int
	let get () = 5
	let process _ = ()
end

module String: Handler = struct
	type t = string
	let get () = "hi there"
	let process _ = ()
end

module MakeHandler = functor (X: Handler) -> struct
	let handle () =
		let x = X.get () in
		X.process x
end

module IntHandler = MakeHandler(Int)
module StringHandler = MakeHandler(String)

let _ =
	IntHandler.handle ();
	StringHandler.handle ();
