<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/publications.php');
include_once($BASE_DIR .'database/users.php');
include_once('userInfo.php');

$allPublications = getAllPublications();
$allCategorys = getAllCategorys();

// For test only!!!
// $arrayToSend = "ortogra";
// print_r(testeFullTextSearch($arrayToSend));

$smarty->assign('allCategorys', $allCategorys);
$smarty->assign('allPublications', $allPublications);
$smarty->display('owner/publications.tpl');
?>