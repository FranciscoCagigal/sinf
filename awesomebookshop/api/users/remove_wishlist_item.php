<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');

if($_GET['id']){
	
	try {

		removePublicationWishList($_SESSION['userid'], $_GET['id']);

		$success = "Publicação removida da wishlist";
		
		$response = array('Success' => $success);

	} catch (PDOException $e) {

		$error = "Erro ao remover publicacao da wishlist";
		
		$response = array('Error' => $error);
	}
}
else{
	$error = "Erro ao identificar a publicação";

	$response = array('Error' => $error);
}
echo json_encode($response);
?>
