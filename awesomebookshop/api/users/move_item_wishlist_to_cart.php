<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');

if($_GET['id']){
	
	$quantity = 1;

	try{
		movePublicationWishListToCart($_SESSION['userid'], $_GET['id'], $quantity);
		
		$success = "Publicação adicionada ao carrinho";
		
		$response = array('Success' => $success); 

	}catch (PDOException $e) {
		
		if (strpos($e->getMessage(), 'pk_publicacaocarrinho') !== false){
			
			$error = "Publicação já existe no carrinho";

			$response = array('Error' => $error);
		} 
		else{

			$error = "Erro ao remover publicação da wishlist";

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