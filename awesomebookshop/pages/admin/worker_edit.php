<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/workers.php');
include_once($BASE_DIR .'database/users.php');
include_once('userInfo.php');

if (!($_GET['username']) || !checkIfWorkerExists($_GET['username'])) {
	error_log('if');
	$_SESSION['error_messages'][] = 'Erro com o username do Funcionário';
	header("Location: $BASE_URL" . 'pages/admin/workers.php');
	exit;
}

$username = $_GET['username'];
$userdata = getWorkersAllData($username);
$countries = getAllCountriesAllInfo();

$smarty->assign('countries',$countries);
$smarty->assign('workerdata',$userdata[0]);
$smarty->display('admin/worker_edit.tpl');
?>