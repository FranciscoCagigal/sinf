<?php

	$json = file_get_contents("php://input");
	
	$input = iconv('UTF-8', 'UTF-8//IGNORE', utf8_encode($json));
	$object = json_decode($input);

	$array = json_decode(json_encode($object), True);
	 
	foreach($array as $artigo){
		error_log($artigo['StkAtual']);
	} 
?>