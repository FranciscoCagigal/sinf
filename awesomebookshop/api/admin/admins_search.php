<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR .'database/admins.php');
	
	$nome_administrador = $_GET['nome_administrador'];
	$username_administrador = $_GET['username_administrador'];
	$data_cessacao = $_GET['data_cessacao'];
	$estado_administrador = $_GET['estado_administrador'];

	if($nome_administrador == NULL && $username_administrador == NULL && $data_cessacao == null && $estado_administrador == "Escolha uma opção")
		$reply = getAllAdmins();

	else if($nome_administrador != NULL && $username_administrador == NULL && $data_cessacao == null && $estado_administrador != "Escolha uma opção")
		$reply = getAdminByNameAndStatus($nome_administrador, $estado_administrador);

	else if($nome_administrador != NULL && $username_administrador == NULL && $data_cessacao == null && $estado_administrador == "Escolha uma opção")
		$reply = getAdminByName($nome_administrador);

	else if($nome_administrador == NULL && $username_administrador != NULL && $data_cessacao == null && $estado_administrador == "Escolha uma opção")
		$reply = getAdminByUsername($username_administrador);

	else if($nome_administrador == NULL && $username_administrador == NULL && $data_cessacao != null && $estado_administrador == "Escolha uma opção")
		$reply = getAdminByCessationDate($data_cessacao);

	else if($nome_administrador == NULL && $username_administrador == NULL && $data_cessacao == null && $estado_administrador != "Escolha uma opção")
		$reply = getAdminByAdminStatus($estado_administrador);

	else
		$reply = "NULL";

	echo json_encode($reply);
?>