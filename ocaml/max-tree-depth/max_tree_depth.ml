#!/usr/bin/env ocaml

type node = {
  left: node option;
  right: node option;
}

let max_tree_depth =
  let rec max_tree_depth' acc = function
    | {left = None; right = None} -> acc + 1
    | {left = Some left_tree; right = None} -> max_tree_depth' (acc + 1) left_tree
    | {left = None; right = Some right_tree} -> max_tree_depth' (acc + 1) right_tree
    | {left = Some left_tree; right = Some right_tree} ->
      max (max_tree_depth' (acc + 1) left_tree) (max_tree_depth' (acc + 1) right_tree)
  in
  max_tree_depth' 0

let print_int i =
  Printf.printf "%d\n%!" i

let () =
  let leaf = {left = None; right = None} in
  print_int (max_tree_depth {left = None; right = None});
  print_int (max_tree_depth {left = Some leaf; right = None});
  print_int (max_tree_depth {left = None; right = Some leaf});
  print_int (max_tree_depth {left = Some leaf; right = Some leaf});
