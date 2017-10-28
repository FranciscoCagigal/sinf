<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/logs.php');
include_once('userInfo.php');

$allLogsSearch = getAllLogsSearch();

$smarty->assign('allLogsSearch', $allLogsSearch);
$smarty->display('admin/logs_search.tpl');
?>