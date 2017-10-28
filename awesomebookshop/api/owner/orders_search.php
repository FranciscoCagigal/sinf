<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR .'database/orders.php');

	$nome_cliente = $_GET['nome_cliente'];
	$email_cliente = $_GET['email_cliente'];
	$id_encomenda = $_GET['id_encomenda'];
	$estadoencomenda = $_GET['estadoencomenda'];


	if($nome_cliente == NULL && $email_cliente == NULL && $id_encomenda == NULL && $estadoencomenda == "Escolha uma opção")
		$reply = getAllOrders();
	else if($nome_cliente != NULL && $estadoencomenda != "Escolha uma opção")
		$reply = getOrdersByClientNameAndStatus($nome_cliente, $estadoencomenda);
	else if($email_cliente != NULL && $estadoencomenda != "Escolha uma opção")
		$reply = getOrdersByClientEmailAndStatus($email_cliente, $estadoencomenda);
	else if($nome_cliente != NULL)
		$reply = getOrdersByClientName($nome_cliente);
	else if($email_cliente != NULL)
		$reply = getOrdersByClientEmail($email_cliente);
	else if($id_encomenda != NULL)
		$reply = getOrdersByOrderId($id_encomenda);
	else if($estadoencomenda != "Escolha uma opção")
		$reply = getOrdersByStatus($estadoencomenda);
	else
		$reply = "NULL";

	echo json_encode($reply);
?>