<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR .'database/users.php');
	
	$nome_cliente = $_GET['nome_cliente'];
	$email_cliente = $_GET['email_cliente'];
	$estado_cliente = $_GET['estado_cliente'];

	if( $nome_cliente == NULL && $email_cliente == NULL && $estado_cliente == "Escolha uma opção" )
		$reply = getAllUsers();

	else if( $nome_cliente != NULL && $email_cliente == NULL && $estado_cliente != "Escolha uma opção" )
		$reply = getUserByNameAndStatus($nome_cliente, $estado_cliente);

	else if( $nome_cliente != NULL && $email_cliente == NULL && $estado_cliente == "Escolha uma opção" )
		$reply = getUserByName($nome_cliente);

	else if( $nome_cliente == NULL && $email_cliente != NULL && $estado_cliente == "Escolha uma opção" )
		$reply = getUserByEmail($email_cliente);

	else if( $nome_cliente == NULL && $email_cliente == NULL && $estado_cliente != "Escolha uma opção" )
		$reply = getUserByStatus($estado_cliente);

	else
		$reply = "NULL";

	echo json_encode($reply);
?>