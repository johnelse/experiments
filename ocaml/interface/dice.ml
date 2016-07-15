let roll sides = Random.int sides

let rec roll_n acc n sides =
  match n with
  | 0 -> []
  | _ -> roll_n ((roll sides)::acc) (n-1) sides
