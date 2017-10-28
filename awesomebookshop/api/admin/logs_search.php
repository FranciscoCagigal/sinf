<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR .'database/logs.php');

	$nome_utilizador = $_GET['nome_utilizador'];
	$username_utilizador = $_GET['username_utilizador'];
	$startDate = $_GET['startDate'];
	$endDate = $_GET['endDate'];

	if( $nome_utilizador == NULL && $username_utilizador == NULL && $startDate == NULL && $endDate == NULL )
		$reply = getAllLogs(); 

	else if( $nome_utilizador != NULL && $username_utilizador == NULL && $startDate != NULL && $endDate != NULL)
		$reply = getLogsByNameAndDate($nome_utilizador, $startDate, $endDate);

	else if( $nome_utilizador == NULL && $username_utilizador != NULL && $startDate != NULL && $endDate != NULL)
		$reply = getLogsByUsernameAndDate($username_utilizador, $startDate, $endDate);

	else if( $nome_utilizador != NULL && $username_utilizador == NULL && $startDate == NULL && $endDate == NULL)
		$reply = getLogsByName($nome_utilizador);

	else if( $nome_utilizador == NULL && $username_utilizador != NULL && $startDate == NULL && $endDate == NULL)
		$reply = getLogsByUsername($username_utilizador); 

	else if( $nome_utilizador == NULL && $username_utilizador == NULL && $startDate != NULL && $endDate != NULL)
		$reply = getLogsByLoginDate($startDate, $endDate); 

	else
		$reply = "NULL";

	echo json_encode($reply);
?>