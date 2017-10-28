<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR .'database/workers.php');
	
	$nome_funcionario = $_GET['nome_funcionario'];
	$email_funcionario = $_GET['email_funcionario'];
	$data_admissao = $_GET['data_admissao'];
	$estado_funcionario = $_GET['estado_funcionario'];

	if($nome_funcionario == null && $email_funcionario == null && $data_admissao == null && $estado_funcionario == "Escolha uma opção")
		$reply = getAllWorkers(); 

	else if($nome_funcionario != null && $email_funcionario == null && $data_admissao != null && $estado_funcionario != "Escolha uma opção")
		$reply = getWorkerByNameAdmissionDateAndStatus($nome_funcionario, $data_admissao, $estado_funcionario); 

	else if($nome_funcionario != null && $email_funcionario == null && $data_admissao == null && $estado_funcionario != "Escolha uma opção")
		$reply = getWorkerByNameAndStatus($nome_funcionario, $estado_funcionario); 

	else if($nome_funcionario == null && $email_funcionario == null && $data_admissao != null && $estado_funcionario != "Escolha uma opção")
		$reply = getWorkerByAdmissionDateAndStatus($data_admissao, $estado_funcionario); 

	else if($nome_funcionario != null && $email_funcionario == null && $data_admissao == null && $estado_funcionario == "Escolha uma opção")
		$reply = getWorkerByName($nome_funcionario); 

	else if($nome_funcionario == null && $email_funcionario != null && $data_admissao == null && $estado_funcionario == "Escolha uma opção")
		$reply = getWorkerByEmail($email_funcionario); 

	else if($nome_funcionario == null && $email_funcionario == null && $data_admissao != null && $estado_funcionario == "Escolha uma opção")
		$reply = getWorkerByAdmissionDate($data_admissao); 

	else if($nome_funcionario == null && $email_funcionario == null && $data_admissao == null && $estado_funcionario != "Escolha uma opção")
		$reply = getWorkerByStatus($estado_funcionario); 

	else
		$reply = "NULL";

	echo json_encode($reply);
?>