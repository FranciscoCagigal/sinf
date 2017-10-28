<?php
include_once '../../config/init.php';
include_once $BASE_DIR . 'database/workers.php';

$username = $_GET['username'];

$atual_worker_status = getWorkerStatus($username);

if ($atual_worker_status['ativo'] == 1)
	$new_worker_status = "FALSE";
else
	$new_worker_status = "TRUE";

try {

    updateWorkerStatus($username, $new_worker_status);

} catch (PDOException $e) {
    
    $_SESSION['error_messages'][] = 'Erro na edição do estado do funcionario';
    header("Location: $BASE_URL" . 'pages/admin/workers.php');
    exit;
}

$_SESSION['success_messages'][] = 'Estado do funcionario modificado com sucesso';
header("Location: $BASE_URL" . 'pages/admin/workers.php');
?>