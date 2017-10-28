<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/logs.php');
include_once('userInfo.php');

$allLogs = getAllLogs();

if($allLogs){
	foreach ($allLogs as &$log) {
		$nomeparsed = trim($log['nome'], '(),"');
		$log['nome'] = $nomeparsed;
	}
}


$smarty->assign('allLogs', $allLogs);
$smarty->display('admin/logs_clients.tpl');
?>