<?php

	include_once '../../config/init.php';
	include_once $BASE_DIR . 'database/publications.php';
	
	$json = file_get_contents("php://input");
	
	$input = iconv('UTF-8', 'UTF-8//IGNORE', utf8_encode($json));
	
	//$input = mb_convert_encoding($input, "UTF-16", "Windows-1252");
	
	$object = json_decode($input);

	$array = json_decode(json_encode($object), True);
	 
	foreach($array as $brand){
		
		error_log(print_r($brand,true));
		
		if(($editoraid = checkIfBrandExists($brand['CodMarca']))!=False)
			update_editora($editoraid, $brand['Nome']);
		else{
			create_editora($brand['Marca'], $brand['Nome']);
		}
	}
	
	echo 'ok';
?>