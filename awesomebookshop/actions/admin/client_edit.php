<?php
include_once '../../config/init.php';
include_once $BASE_DIR . 'database/users.php';

$username = strip_tags($_POST['client_username']);

$datanascimento = strip_tags($_POST['datanascimento']);
$pieces = explode('-', $datanascimento);
$diaNasc = $pieces[2];
$mesNasc = $pieces[1];
$anoNasc = $pieces[0];

$codigopostal = strip_tags($_POST['codigopostal']);
$pieces = explode('-', $codigopostal);
$cod1 = $pieces[0];
$cod2 = $pieces[1];

$newuserinformation = array(
    'nome'       => strip_tags($_POST['nome']),
    'genero'     => strip_tags($_POST['genero']),
    'diaNasc'    => $diaNasc,
    'mesNasc'    => $mesNasc,
    'anoNasc'    => $anoNasc,
    'morada'     => strip_tags($_POST['morada']),
    'localidade' => strip_tags($_POST['localidade']),
    'cod1'       => $cod1,
    'cod2'       => $cod2,
    'pais'       => strip_tags($_POST['pais']),
    'telefone'   => strip_tags($_POST['telefone']),
    'email'      => strip_tags($_POST['email']),
    'nif'        => strip_tags($_POST['nif']),
    'username'   => strip_tags($_POST['username']),
);

try {
    $userdata = getUserAllData($username);
    
    updateUserInformation($username, $userdata, $newuserinformation);

} catch (PDOException $e) {

    if (strpos($e->getMessage(), 'cliente_email_key') !== false ) {
        $_SESSION['error_messages'][] = 'Já existe um utilizador com o Email introduzido';
    } else if (strpos($e->getMessage(), 'cliente_nif_key') !== false ) {
        $_SESSION['error_messages'][] = 'Já existe um utilizador com o NIF introduzido';
    } else if (strpos($e->getMessage(), 'cliente_username_key') !== false) {
        $_SESSION['error_messages'][] = 'Já existe um utilizador com o Username introduzido';
    } else {
        $_SESSION['error_messages'][] = 'Erro ao editar o cliente';
    }

    $_SESSION['form_values'] = $_POST;
    header("Location: $BASE_URL" . 'pages/admin/client_edit.php?username=' . $username);
    exit;
}
$_SESSION['success_messages'][] = 'Cliente editado com sucesso';
header("Location: $BASE_URL" . 'pages/admin/clients.php');
?>