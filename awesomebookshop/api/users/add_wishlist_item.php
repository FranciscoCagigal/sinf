<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');

if (!$_SESSION['username']) {
	$error = "Deverá efetuar login para adicionar a publicação à wishlist";

	$response = array('Error' => $error);

	echo json_encode($response);
}
else{
	if($_GET['id']){

		try{
			insertPublicationWishList($_SESSION['userid'], $_GET['id']);

			$success = "Publicação adicionada à wishlist";

			$response = array('Success' => $success); 

		}catch (PDOException $e) {

			if (strpos($e->getMessage(), 'pk_publicacaowishlist') !== false){

				$error = "Publicação já existe na wishlist";

				$response = array('Error' => $error);
			} 
			else{

				$error = "Erro ao adicionar publicação à wishlist";

				$response = array('Error' => $error);
			}
		}

		echo json_encode($response);
	}
}
?>