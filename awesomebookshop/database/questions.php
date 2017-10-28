<?php

function getAllQuestions(){
	global $conn;
	$stmt = $conn->prepare("SELECT *
							FROM perguntautilizador
							ORDER BY data DESC");
	$stmt->execute();
	return $stmt->fetchAll();
}

function updateQuestionStatus($id){
	global $conn;
	$stmt = $conn->prepare("UPDATE perguntautilizador
							SET respondido = NOT respondido
							WHERE perguntautilizadorid = ?");
    $stmt->execute(array($id));
    return $stmt->fetch();
}

function getQuestionsByUserNameAndStatus($nome_utilizador, $estadoPergunta){
	global $conn;
	$stmt = $conn->prepare("SELECT *
							FROM perguntautilizador
							WHERE LOWER(nome) like '%'||?||'%'
							AND respondido = ?
							ORDER BY data DESC");

	$stmt->execute(array(strtolower($nome_utilizador),$estadoPergunta));
	return $stmt->fetchAll();
}

function getQuestionsByUserEmailAndStatus($email_utilizador, $estadoPergunta){
	global $conn;
	$stmt = $conn->prepare("SELECT *
							FROM perguntautilizador
							WHERE LOWER(email) = ?
							AND respondido = ?
							ORDER BY data DESC");

	$stmt->execute(array(strtolower($email_utilizador),$estadoPergunta));
	return $stmt->fetchAll();
}

function getQuestionsByUserName($nome_utilizador){
	global $conn;
	$stmt = $conn->prepare("SELECT *
							FROM perguntautilizador
							WHERE LOWER(nome) like '%'||?||'%'
							ORDER BY data DESC");

	$stmt->execute(array(strtolower($nome_utilizador)));
	return $stmt->fetchAll();
}

function getQuestionsByUserEmail($email_utilizador){
	global $conn;
	$stmt = $conn->prepare("SELECT *
							FROM perguntautilizador
							WHERE LOWER(email) = ?
							ORDER BY data DESC");

	$stmt->execute(array(strtolower($email_utilizador)));
	return $stmt->fetchAll();
}

function getQuestionsByStatus($estadoPergunta){
	global $conn;
	$stmt = $conn->prepare("SELECT *
							FROM perguntautilizador
							WHERE respondido = ?
							ORDER BY data DESC");
	$stmt->execute(array($estadoPergunta));
	return $stmt->fetchAll();
}

function insertQuestion($nome, $email, $mensagem){
	
	global $conn;
	
	$stmt = $conn->prepare("INSERT INTO perguntautilizador (nome, email, mensagem)
							VALUES (?, ?, ?)");
	$stmt->execute(array($nome, $email, $mensagem));
}
?>