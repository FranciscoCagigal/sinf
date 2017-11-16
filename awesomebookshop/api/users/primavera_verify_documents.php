<?php
	
	include_once('../../config/init.php');
	include_once($BASE_DIR .'database/users.php');
	include_once($BASE_DIR .'database/orders.php');
	
	$json = file_get_contents("php://input");
	
	$input = iconv('UTF-8', 'UTF-8//IGNORE', utf8_encode($json));
	$object = json_decode($input);

	$array = json_decode(json_encode($object), True);
	 
	foreach($array as $documento){
		$numdoc = $documento['NumDoc'];
		$numdocorigem = $documento['NumDocOrigem'];
		$file = $documento['Ficheiro'];
		$doctype = $documento['TipoDoc'];
		$docserie = $documento['Serie'];
		
		$userid = get_clientid_by_orderid($numdocorigem);
		
		switch($doctype){
			case 'FA': 
				$estado = "Processada";
				$file_path = 'C:/xampp/htdocs/sinf/awesomebookshop/documentos/cliente_' . $userid . '/faturas/';
				
				if(!file_exists($file_path)) 
					mkdir($file_path, 0777, true);
				
				file_put_contents($file_path . 'fa' . $docserie . '_'. $numdoc . '.pdf', base64_decode($file));
				
				set_primaverafatura_id($docserie, $numdoc, $numdocorigem, $estado);
				break;
				
			case 'RE': 
				$estado = "Paga";
				$file_path = 'C:/xampp/htdocs/sinf/awesomebookshop/documentos/cliente_' . $userid . '/recibos/';
				
				if(!file_exists($file_path)) 
					mkdir($file_path, 0777, true);
				
				file_put_contents($file_path . 're' . $docserie . '_'. $numdoc . '.pdf', base64_decode($file));
				
				set_primaverarecibo_id($docserie, $numdoc, $numdocorigem, $estado);	
				break;
				
			case 'NC': 
			
				$userid = get_client_by_invoiceid($numdocorigem);
				$estado = "Cancelada";
				
				$file_path = 'C:/xampp/htdocs/sinf/awesomebookshop/documentos/cliente_' . $userid . '/notas_credito/';
				
				if(!file_exists($file_path)) 
					mkdir($file_path, 0777, true);
				
				file_put_contents($file_path . 'nc' . $docserie . '_'. $numdoc . '.pdf', base64_decode($file));
				
				set_primaveranotacredito_id($docserie, $numdoc, $numdocorigem, $estado);	
				break;
		}
	}
?>