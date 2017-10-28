<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');

if($_GET['id']){
	
	try {

		removeCartItem($_SESSION['userid'], $_GET['id']);

		$success = "Publicação removida do carrinho";
		
		$response = array('Success' => $success);

	} catch (PDOException $e) {
		error_log(print_r($e->getMessage(), true));
		$error = "Erro ao remover publicacao do carrinho";
		
		$response = array('Error' => $error);
	}
}
else{
	$error = "Erro ao identificar a publicação";

	$response = array('Error' => $error);
}
echo json_encode($response);
?>
