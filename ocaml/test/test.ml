let loop n =
	for x = 1 to n do
    print_endline "abc"
	done

let switch flag =
	if flag then
		print_endline "yep"
	else
		print_endline "nope"

let abc () = 3 * (4 + 5)

let _ =
  print_int (abc ());
  print_newline ();
  print_endline "woo";
  loop 5;
  switch true;
