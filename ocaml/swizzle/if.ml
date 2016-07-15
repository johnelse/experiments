let get_compatibility_name software_version =
	if List.mem_assoc "PRODUCT_BRAND" software_version then
		Some (List.assoc "PRODUCT_BRAND" software_version)
	else if List.mem_assoc "PLATFORM_NAME" software_version then
		Some (List.assoc "PLATFORM_NAME" software_version)
	else
		None

let _ =
	let my_software_version = [
		"PLATFORM_VERSION", "XCP";
		"BUILD", "50000";
	] in
	let master_software_version = [
		"PRODUCT_BRAND", "XenServer";
		"PLATFORM_VERSION", "XCP";
		"BUILD", "50000";
	] in
	let my_name = get_compatibility_name my_software_version in
	let master_name = get_compatibility_name master_software_version in
	print_endline "My name:";
	print_endline (match my_name with Some x -> x | None -> "None");
	print_endline "Master name:";
	print_endline (match master_name with Some x -> x | None -> "None");

