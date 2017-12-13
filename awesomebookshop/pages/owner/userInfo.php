<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/workers.php');
include_once($BASE_DIR .'database/users.php');
include_once($BASE_DIR .'database/admins.php');

if (!($_SESSION['username']) || !($_SESSION['usertype'] === "owner")) {
	error_log('if');
    $_SESSION['error_messages'][] = 'Erro com a autenticação do funcionário';
    if(($_SESSION['usertype'] === "admin"))
    	header("Location: $BASE_URL" . 'pages/admin/home.php');
    else
    	header("Location: $BASE_URL" . 'pages/home/home.php');
    exit;
}

$username = $_SESSION['username'];

$workerData = getOwnerData($username);

$smarty->assign('workerData', $workerData[0]);
?>