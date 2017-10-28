<?php
include_once '../../config/init.php';
include_once $BASE_DIR . 'database/users.php';

$username = $_GET['username'];

$atual_client_status = getClientStatus($username);

if ($atual_client_status['ativo'] == 1)
	$new_client_status = "FALSE";
else
	$new_client_status = "TRUE";

try {

    updateClientStatus($username, $new_client_status);

} catch (PDOException $e) {
    
    $_SESSION['error_messages'][] = 'Erro na edição do cliente';
    header("Location: $BASE_URL" . 'pages/admin/clients.php');
    exit;
}

$_SESSION['success_messages'][] = 'Estado do cliente modificado com sucesso';
header("Location: $BASE_URL" . 'pages/admin/clients.php');
?>