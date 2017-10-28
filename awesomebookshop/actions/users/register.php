<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');  
if (!$_POST['nome'] || !$_POST['genero'] || !$_POST['diaNasc'] || !$_POST['mesNasc'] || !$_POST['anoNasc'] || !$_POST['morada'] || !$_POST['localidade'] || !$_POST['cod1'] || !$_POST['cod2'] || !$_POST['pais'] || !$_POST['email'] || !$_POST['username'] || !$_POST['password']) {
  
  $_SESSION['error_messages'][] = 'Todos os campos são de preenchimento obrigatório';
  $_SESSION['form_values'] = $_POST;
  header("Location: $BASE_URL" . 'pages/users/register.php');
  exit;
}
$nome = strip_tags($_POST['nome']);
$genero = strip_tags($_POST['genero']);
$diaNasc = strip_tags($_POST['diaNasc']);
$mesNasc = strip_tags($_POST['mesNasc']);
$anoNasc = strip_tags($_POST['anoNasc']);
$morada = strip_tags($_POST['morada']);
$localidade = strip_tags($_POST['localidade']);
$cod1 = strip_tags($_POST['cod1']);
$cod2 = strip_tags($_POST['cod2']);
$pais = strip_tags($_POST['pais']);
$telefone = strip_tags($_POST['telefone']);
$email = strip_tags($_POST['email']);
$nif = strip_tags($_POST['nif']);
$username = strip_tags($_POST['username']);
$password = strip_tags($_POST['password']);
try {
  createUser($nome, $genero, $diaNasc, $mesNasc, $anoNasc, $morada, $localidade, $cod1, $cod2, $pais+1, $telefone, $email, $nif, $username, $password);
  
} catch (PDOException $e) {
  
  if (strpos($e->getMessage(), 'cliente_email_key') !== false) {
    $_SESSION['error_messages'][] = 'Já existe um utilizador com o email introduzido';
  }
  else if(strpos($e->getMessage(), 'cliente_nif_key') !== false){
    $_SESSION['error_messages'][] = 'Já existe um utilizador com o NIF introduzido';
  }
  else if(strpos($e->getMessage(), 'cliente_username_key') !== false){
    $_SESSION['error_messages'][] = 'Já existe um utilizador com o username introduzido';
  }
  else $_SESSION['error_messages'][] = 'Erro ao criar utilizador';
  $_SESSION['form_values'] = $_POST;
  header("Location: $BASE_URL" . 'pages/users/register.php');
  exit;
}
$_SESSION['username'] = $username;
$userdata = getUserData($username);
$userid = $userdata[0]['clienteid'];
$_SESSION['userid'] = $userid;
$_SESSION['usertype'] = 'client';
$_SESSION['success_messages'][] = 'Utilizador registado com sucesso';  
header("Location: $BASE_URL");
?>