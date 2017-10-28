<?php

function getAllComments(){
	global $conn;
	$stmt = $conn->prepare("SELECT comentario.*, cliente.nome, publicacao.titulo
							FROM comentario
							JOIN cliente
							ON cliente.clienteid = comentario.clienteid
							JOIN publicacao
							ON publicacao.publicacaoid = comentario.publicacaoid
							ORDER BY comentario.comentarioid ");
	$stmt->execute();
	return $stmt->fetchAll();
}

function getCommentsByDate($firstDate,$todayDate){
  global $conn;
  $stmt = $conn->prepare("SELECT *
                          FROM comentario
                          WHERE data::date >= ? AND data::date <= ?
                          ORDER BY comentarioid ASC");
  $stmt->execute(array($firstDate,$todayDate));
  return $stmt->fetchAll();
}

function getLast5CommentsByDate($firstDate,$todayDate){
  global $conn;
  $stmt = $conn->prepare("SELECT comentario.data, comentario.texto, cliente.nome
						  FROM comentario
						  JOIN cliente
						  on cliente.clienteid = comentario.clienteid
						  WHERE data::date >= ? AND data::date <= ?
						  ORDER BY comentario.data DESC
						  LIMIT 5");
  
  $stmt->execute(array($firstDate,$todayDate));
  return $stmt->fetchAll();
}

function deleteComment($idcomment){
	global $conn;
	$stmt = $conn->prepare("DELETE FROM comentario
							WHERE comentarioid = ?");
	$stmt->execute(array($idcomment));
	return $stmt->fetchAll();
}

function getCommentsByClientNamePublicationName($nomeCliente, $nomePublicacao){
	global $conn;
	$stmt = $conn->prepare("SELECT comentario.*, cliente.nome, publicacao.titulo
							FROM comentario
							JOIN cliente
							ON cliente.clienteid = comentario.clienteid
							JOIN publicacao
							ON publicacao.publicacaoid = comentario.publicacaoid
							WHERE LOWER(cliente.nome) like '%'||?||'%'
							AND LOWER(publicacao.titulo) like '%'||?||'%'
							ORDER BY comentario.comentarioid ");

	$stmt->execute(array(strtolower($nomeCliente), strtolower($nomePublicacao)));
	return $stmt->fetchAll();
}

function getCommentsByClientEmailPublicationName($emailCliente, $nomePublicacao){
	global $conn;
	$stmt = $conn->prepare("SELECT comentario.*, cliente.nome, publicacao.titulo
							FROM comentario
							JOIN cliente
							ON cliente.clienteid = comentario.clienteid
							JOIN publicacao
							ON publicacao.publicacaoid = comentario.publicacaoid
							WHERE LOWER(cliente.email) = ?
							AND LOWER(publicacao.titulo) like '%'||?||'%'
							ORDER BY comentario.comentarioid ");

	$stmt->execute(array(strtolower($emailCliente), strtolower($nomePublicacao)));
	return $stmt->fetchAll();
}

function getCommentsByClientName($nomeCliente){
	global $conn;
	$stmt = $conn->prepare("SELECT comentario.*, cliente.nome, publicacao.titulo
							FROM comentario
							JOIN cliente
							ON cliente.clienteid = comentario.clienteid
							JOIN publicacao
							ON publicacao.publicacaoid = comentario.publicacaoid
							WHERE LOWER(cliente.nome) like '%'||?||'%'
							ORDER BY comentario.comentarioid ");

	$stmt->execute(array(strtolower($nomeCliente)));
	return $stmt->fetchAll();
}

function getCommentsByClientEmail($emailCliente){
	global $conn;
	$stmt = $conn->prepare("SELECT comentario.*, cliente.nome, publicacao.titulo
							FROM comentario
							JOIN cliente
							ON cliente.clienteid = comentario.clienteid
							JOIN publicacao
							ON publicacao.publicacaoid = comentario.publicacaoid
							WHERE LOWER(cliente.email) = ? ");

	$stmt->execute(array(strtolower($emailCliente)));
	return $stmt->fetchAll();
}

function getCommentsByPublicationName($nomePublicacao){
	global $conn;
	$stmt = $conn->prepare("SELECT comentario.*, cliente.nome, publicacao.titulo
							FROM comentario
							JOIN cliente
							ON cliente.clienteid = comentario.clienteid
							JOIN publicacao
							ON publicacao.publicacaoid = comentario.publicacaoid
							WHERE LOWER(publicacao.titulo) like '%'||?||'%' 
							ORDER BY comentario.comentarioid ");

	$stmt->execute(array(strtolower($nomePublicacao)));
	return $stmt->fetchAll();
}

function getCommentsByPublicationId($publicacaoid){
	global $conn;
	$stmt = $conn->prepare("SELECT count(*) as comentarios, avg(comentario.classificacao) as classificacao
							FROM comentario
							JOIN cliente
							ON cliente.clienteid = comentario.clienteid
							JOIN publicacao
							ON publicacao.publicacaoid = comentario.publicacaoid
							WHERE comentario.publicacaoid = ?
							GROUP BY comentario.publicacaoid");

	$stmt->execute(array($publicacaoid));
	return $stmt->fetchAll();
}

function getCommentsAutorAndTextByPublicationId($publicacaoid){
	global $conn;
	$stmt = $conn->prepare("SELECT cliente.nome, comentario.classificacao, comentario.texto
							FROM comentario
							JOIN cliente
							ON cliente.clienteid = comentario.clienteid
							JOIN publicacao
							ON publicacao.publicacaoid = comentario.publicacaoid
							WHERE comentario.publicacaoid = ?");

	$stmt->execute(array($publicacaoid));
	return $stmt->fetchAll();
}

function getCommentsByComment($comments){
	global $conn;
	$stmt = $conn->prepare("SELECT comentario.*, cliente.nome, publicacao.titulo
							FROM comentario
							JOIN cliente
							ON cliente.clienteid = comentario.clienteid
							JOIN publicacao
							ON publicacao.publicacaoid = comentario.publicacaoid
							WHERE LOWER(comentario.texto) like '%'||?||'%'
							ORDER BY comentario.comentarioid ");
	$stmt->execute(array(strtolower($comments)));
	return $stmt->fetchAll();
}

function insertComment($clientid, $publicacaoid, $classificacao, $texto){
	global $conn;
	$stmt = $conn->prepare("INSERT INTO comentario (clienteid, publicacaoid, classificacao, texto)
							VALUES (?, ?, ?, ?)");
	$stmt->execute(array($clientid, $publicacaoid, $classificacao, $texto));
}
?>