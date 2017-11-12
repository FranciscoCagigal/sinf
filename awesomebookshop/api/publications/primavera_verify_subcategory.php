<?php

	include_once '../../config/init.php';
	include_once $BASE_DIR . 'database/publications.php';
	
	$json = file_get_contents("php://input");
	
	$input = iconv('UTF-8', 'UTF-8//IGNORE', utf8_encode($json));
	
	//$input = mb_convert_encoding($input, "UTF-16", "Windows-1252");
	
	$object = json_decode($input);

	$array = json_decode(json_encode($object), True);
	 
	foreach($array as $subcategory){
		
		//error_log(print_r($subcategory,true));
		
		if(($subcategoriaid = checkIfSubCategoryExists($subcategory['CodFamilia'], $subcategory['CodSubFamilia']))!=False)
			update_subcategoria($subcategoriaid, $subcategory['Nome']);
		else{
			$categoriaid = checkIfCategoryExists($subcategory['CodFamilia']);
			create_subcategoria($subcategory['CodFamilia'], $categoriaid, $subcategory['CodSubFamilia'], $subcategory['Nome']);
		}
	}
	
	echo 'ok';
?>