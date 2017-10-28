<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/publications.php');
include_once('userInfo.php');

$allCategorys = getAllCategorys();

$categoryId = 1;

$allSubCategories = getAllSubCategorysByCategory($categoryId);
$allAutors = getAllAutors();

$smarty->assign('allCategorys', $allCategorys);
$smarty->assign('allAutors', $allAutors);
$smarty->assign('allSubCategories', $allSubCategories);
$smarty->display('owner/publication_add.tpl');
?>