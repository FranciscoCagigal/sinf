<?php

	include_once '../../config/init.php';
	include_once $BASE_DIR . 'database/publications.php';
	
	$json = file_get_contents("php://input");
	
	$input = iconv('UTF-8', 'UTF-8//IGNORE', utf8_encode($json));
	$object = json_decode($input);
	
	$array = json_decode(json_encode($object), True);
	 
	foreach($array as $artigo){
		
		error_log(print_r($artigo,True));
		update_stocks_artigo($artigo['CodArtigo'], $artigo['Armazem'], $artigo['Stock']);
	} 
	
	echo 'ok';
?>