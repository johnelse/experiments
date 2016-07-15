(* Alternatively:
 * - add the canvas element to the HTML, and give it an ID
 * - get the canvas with get_element_by_id
 * - coerce the element into a canvas with Js.coerce *)

let _ =
	let doc = Dom_html.document in
	let canvas = Dom_html.createCanvas doc in
	canvas##width <- 100;
	canvas##height <- 100;
	Dom.appendChild (doc##body) canvas;
	Graphics_js.open_canvas canvas;
	Graphics_js.lineto 100 100
