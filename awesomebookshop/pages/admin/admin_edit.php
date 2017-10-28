<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/admins.php');
include_once($BASE_DIR .'database/users.php');
include_once('userInfo.php');

if (!($_GET['username']) || !checkIfAdminExists($_GET['username'])) {
	error_log('if');
    $_SESSION['error_messages'][] = 'Erro com o username do Administrador';
    header("Location: $BASE_URL" . 'pages/admin/admins.php');
    exit;
}

$username = $_GET['username'];
$userdata = getAdminAllData($username);
$countries = getAllCountriesAllInfo();

$smarty->assign('countries',$countries);
$smarty->assign('admindata',$userdata[0]);
$smarty->display('admin/admin_edit.tpl');
?>