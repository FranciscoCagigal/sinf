<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/questions.php');  

if (!$_POST['nome'] || !$_POST['email'] || !$_POST['mensagem']) {
  
  $_SESSION['error_messages'][] = 'Todos os campos são de preenchimento obrigatório';
  $_SESSION['form_values'] = $_POST;
  header("Location: $BASE_URL" . 'pages/common/contacts.php');
  exit;
}

$nome = strip_tags($_POST['nome']);
$email = strip_tags($_POST['email']);
$mensagem = strip_tags($_POST['mensagem']);

try {

  insertQuestion($nome, $email, $mensagem);
  
} catch (PDOException $e) {
  
  $_SESSION['error_messages'][] = 'Erro ao enviar mensagem';

  $_SESSION['form_values'] = $_POST;
  header("Location: $BASE_URL" . 'pages/common/contacts.php');
  exit;
}

$_SESSION['success_messages'][] = 'Mensagem enviada com sucesso';  
header("Location: $BASE_URL");
?>