<?php
  include_once('../../config/init.php');
  include_once($BASE_DIR .'database/workers.php');

  if (!$_POST['nome'] || !$_POST['genero'] || !$_POST['datanascimento'] || !$_POST['morada'] || !$_POST['localidade'] || !$_POST['codigopostal'] || ($_POST['pais'] === "Escolha um País") || !$_POST['email'] || !$_POST['username'] || !$_POST['password'] || !$_POST['telefone'] || !$_POST['nif'] || !$_POST['cartaocidadao']) {
    error_log('if');
    $_SESSION['error_messages'][] = 'Todos os campos são de preenchimento obrigatório';
    $_SESSION['form_values'] = $_POST;
    header("Location: $BASE_URL" . 'pages/admin/worker_add.php');
    exit;
  }

  if (!preg_match("/[0-9]{4}-[0-9]{3}/", $_POST['codigopostal'])) {
    error_log('if');
    $_SESSION['error_messages'][] = 'Erro no código postal - Tem de introduzir no formato: XXXX-XXX';
    $_SESSION['form_values'] = $_POST;
    header("Location: $BASE_URL" . 'pages/admin/worker_add.php');
    exit;
  }

  $nome = strip_tags($_POST['nome']);
  $genero = strip_tags($_POST['genero']);
  $datanascimento = strip_tags($_POST['datanascimento']);
  $morada = strip_tags($_POST['morada']);
  $localidade = strip_tags($_POST['localidade']);
  $codigopostal = strip_tags($_POST['codigopostal']);
  $pais = strip_tags($_POST['pais']);
  $telefone = strip_tags($_POST['telefone']);
  $email = strip_tags($_POST['email']);
  $nif = strip_tags($_POST['nif']);
  $cartaocidadao = strip_tags($_POST['cartaocidadao']);
  $username = strip_tags($_POST['username']);
  $password = strip_tags($_POST['password']);

  $pieces = explode('/', $datanascimento);
  $diaNasc = $pieces[1];
  $mesNasc = $pieces[0];
  $anoNasc = $pieces[2];

  $pieces = explode('-', $codigopostal);
  $cod1 = $pieces[0];
  $cod2 = $pieces[1];

  $currentDate = date('Y-m-d H:i:s');

  try {

    createWorker($nome, $genero, $diaNasc, $mesNasc, $anoNasc, $morada, $localidade, $cod1, $cod2, $pais, $currentDate, $telefone, $email, $nif, $cartaocidadao, $username, $password);
    
  } catch (PDOException $e) {
  
    if (strpos($e->getMessage(), 'funcionario_cartaocidadao_key') !== false) {
      $_SESSION['error_messages'][] = 'Já existe um funcionário com o cartão de cidadao introduzido';
    }
    else if (strpos($e->getMessage(), 'funcionario_email_key') !== false) {
      $_SESSION['error_messages'][] = 'Já existe um funcionário com o email introduzido';
    }
    else if (strpos($e->getMessage(), 'funcionario_nif_key') !== false) {
      $_SESSION['error_messages'][] = 'Já existe um funcionário com o nif introduzido';
    }
    else if (strpos($e->getMessage(), 'funcionario_username_key') !== false) {
      $_SESSION['error_messages'][] = 'Já existe um funcionário com o username introduzido';
    }
    else $_SESSION['error_messages'][] = 'Erro ao adicionar o funcionário';

    $_SESSION['form_values'] = $_POST;
    header("Location: $BASE_URL" . 'pages/admin/worker_add.php');
    exit;

  }
  $_SESSION['success_messages'][] = 'Funcionario registado com sucesso';  
  header("Location: $BASE_URL" . 'pages/admin/workers.php');
?>