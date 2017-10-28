<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR .'database/comments.php');

	$nome_cliente = $_GET['nome_cliente'];
	$email_cliente = $_GET['email_cliente'];
	$nome_publicacao = $_GET['nome_publicacao'];
	$comments = $_GET['comments'];

	//TODO COMMENTS
	if( $nome_cliente == NULL && $email_cliente == NULL && $nome_publicacao == NULL && $comments == NULL)
		$reply = getAllComments();

	else if ( $nome_cliente != NULL && $email_cliente == NULL && $nome_publicacao != NULL )
		$reply = getCommentsByClientNamePublicationName($nome_cliente, $nome_publicacao);

	else if ( $nome_cliente == NULL && $email_cliente != NULL && $nome_publicacao != NULL )
		$reply = getCommentsByClientEmailPublicationName($email_cliente, $nome_publicacao);

	else if( $nome_cliente != NULL && $email_cliente == NULL && $nome_publicacao == NULL )
		$reply = getCommentsByClientName($nome_cliente);

	else if( $nome_cliente == NULL && $email_cliente != NULL && $nome_publicacao == NULL )
		$reply = getCommentsByClientEmail($email_cliente);

	else if( $nome_cliente == NULL && $email_cliente == NULL && $nome_publicacao != NULL )
		$reply = getCommentsByPublicationName($nome_publicacao);

	else if( $comments != NULL )
		$reply = getCommentsByComment($comments);
	
	else
		$reply = "NULL";

	echo json_encode($reply);
?>