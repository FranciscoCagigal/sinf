<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');

if (!$_SESSION['username']) {
	$error = "Deverá efetuar login para adicionar a publicação ao carrinho";

	$response = array('Error' => $error);

	echo json_encode($response);
}
else{
	if($_GET['id'] && $_GET['value']){

		try{
			insertCartPublication($_SESSION['userid'], $_GET['id'], $_GET['value']);

			$success = "Publicação adicionada ao carrinho";

			$response = array('Success' => $success); 

		}catch (PDOException $e) {

			if (strpos($e->getMessage(), 'pk_publicacaocarrinho') !== false){

				$error = "Publicação já existe no carrinho";

				$response = array('Error' => $error);
			} 
			else{

				$error = "Erro ao adicionar publicação no carrinho";

				$response = array('Error' => $error);
			}
		}

		echo json_encode($response);
	}
}
?>