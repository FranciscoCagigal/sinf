<?php
include_once '../../config/init.php';
include_once $BASE_DIR . 'database/admins.php';

$username = $_GET['username'];

$atual_admin_status = getAdminStatus($username);

if ($atual_admin_status['ativo'] == 1)
	$new_admin_status = "FALSE";
else
	$new_admin_status = "TRUE";

try {

    updateAdminStatus($username, $new_admin_status);

} catch (PDOException $e) {
    
    $_SESSION['error_messages'][] = 'Erro na edição do administrador';

    header("Location: $BASE_URL" . 'pages/admin/clients.php');
    exit;
}

$_SESSION['success_messages'][] = 'Estado do administrador modificado com sucesso';
header("Location: $BASE_URL" . 'pages/admin/admins.php');
?>