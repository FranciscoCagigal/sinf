<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/comments.php');  

if (!$_POST['nome'] || !$_POST['email'] || !$_POST['comentario'] || !$_POST['classificacao']) {
  
  $_SESSION['error_messages'][] = 'Todos os campos são de preenchimento obrigatório';
  $_SESSION['form_values'] = $_POST;
  header('Location: ' . $_SERVER['HTTP_REFERER']);
  exit;
}

$clientid = $_SESSION['userid'];

$nome = strip_tags($_POST['nome']);
$email = strip_tags($_POST['email']);
$publicacaoid = strip_tags($_POST['publicacaoid']);
$classificacao = strip_tags($_POST['classificacao']);
$comentario = strip_tags($_POST['comentario']);

try {

  insertComment($clientid, $publicacaoid, $classificacao, $comentario);
  
} catch (PDOException $e) {
  
  $_SESSION['error_messages'][] = 'Erro ao enviar comentario';

  $_SESSION['form_values'] = $_POST;
  header('Location: ' . $_SERVER['HTTP_REFERER']);
  exit;
}

$_SESSION['success_messages'][] = 'Comentario enviado com sucesso';  
header('Location: ' . $_SERVER['HTTP_REFERER']);
?>