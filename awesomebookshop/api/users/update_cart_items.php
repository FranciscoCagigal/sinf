<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');

if($_GET['id']){

	if($_GET['value'] != 0){

		try{
			updateCartItems($_SESSION['userid'], $_GET['id'], $_GET['value']);  

			$success = "Publicação atualizada com sucesso";

			$response = array('Success' => $success);

		}catch (PDOException $e) {

			if (strpos($e->getMessage(), 'ck_publicacaocarrinho_quantidade') !== false){

				$error = "Quantidade deve ser igual ou superior a uma unidade";

				$response = array('Error' => $error);
			} 
			else{

				$error = "Erro ao atualizar a publicação no carrinho";

				$response = array('Error' => $error);
			}
		}
	}
	else{

		try{
			removeCartItem($_SESSION['userid'], $_GET['id']);

			$success = "Publicação removida do carrinho";

			$response = array('Success' => $success);

		}catch (PDOException $e) {

			$error = "Erro ao remover a publicação do carrinho";

			$response = array('Error' => $error);
		}
	}
}
else{
	$error = "Erro ao identificar a publicação";

	$response = array('Error' => $error);
}

echo json_encode($response);
?>
