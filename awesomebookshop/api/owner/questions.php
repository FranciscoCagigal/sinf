<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR .'database/questions.php');

	$nome_utilizador = $_GET['nome_utilizador'];
	$email_utilizador = $_GET['email_utilizador'];
	$estadoPergunta = $_GET['estadoPergunta'];


	if($nome_utilizador == NULL && $email_utilizador == NULL && $estadoPergunta === "Escolha uma opção")
		$reply = getAllQuestions();

	else if($nome_utilizador != NULL && $estadoPergunta !== "Escolha uma opção")
		$reply = getQuestionsByUserNameAndStatus($nome_utilizador, $estadoPergunta);

	else if($email_utilizador != NULL && $estadoPergunta !== "Escolha uma opção")
		$reply = getQuestionsByUserEmailAndStatus($email_utilizador, $estadoPergunta);

	else if($nome_utilizador != NULL)
		$reply = getQuestionsByUserName($nome_utilizador);

	else if($email_utilizador != NULL)
		$reply = getQuestionsByUserEmail($email_utilizador);

	else if($estadoPergunta !== "Escolha uma opção")
		$reply = getQuestionsByStatus($estadoPergunta);

	else
		$reply = "NULL";

	echo json_encode($reply);
?>