<?php
include_once '../../config/init.php';
include_once $BASE_DIR . 'database/admins.php';
include_once $BASE_DIR . 'database/users.php';

$username = strip_tags($_POST['admin_username']);

$datanascimento = strip_tags($_POST['datanascimento']);
$pieces = explode('-', $datanascimento);
$diaNasc = $pieces[2];
$mesNasc = $pieces[1];
$anoNasc = $pieces[0];

$atividade = strip_tags($_POST['atividade']);

  if($atividade === "Ativo")
    $atividade = 1;
  else
    $atividade = 0;

$newuserinformation = array(
    'nome'          => strip_tags($_POST['nome']),
    'genero'        => strip_tags($_POST['genero']),
    'diaNasc'       => $diaNasc,
    'mesNasc'       => $mesNasc,
    'anoNasc'       => $anoNasc,
    'pais'          => strip_tags($_POST['pais']),
    'username'      => strip_tags($_POST['username']),
    'atividade'     => $atividade,
);



try {
    
    $userdata = getAdminAllData($username);

    updateAdminInformation($username, $userdata, $newuserinformation);


} catch (PDOException $e) {

    if (strpos($e->getMessage(), 'administrador_username_key') !== false) {
        $_SESSION['error_messages'][] = 'Já existe um administrador com o username introduzido';
    } else {
        $_SESSION['error_messages'][] = 'Erro na edição do administrador';
    }

    $_SESSION['form_values'] = $_POST;
    header("Location: $BASE_URL" . 'pages/admin/admin_edit.php?username=' . $username);
    exit;
}
$_SESSION['success_messages'][] = 'Administrador editado com sucesso';
header("Location: $BASE_URL" . 'pages/admin/admins.php');
?>