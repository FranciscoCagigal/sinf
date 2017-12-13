<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/publications.php');
include_once('userInfo.php');

if (!($_GET['id']) || !checkIfPublicationExists($_GET['id'])) {
	error_log('if');
    $_SESSION['error_messages'][] = 'Erro com o id da publicação';
    header("Location: $BASE_URL" . 'pages/admin/publications.php');
    exit;
}

$publicationid = $_GET['id'];
$publicationData = getPublicationData($publicationid);
$allCategorys = getAllCategorys();

$allSubCategories = getAllSubCategorysByCategory($publicationData[0]['id_categoria']);
$allAutors = getAllAutors();

$smarty->assign('allAutors', $allAutors);
$smarty->assign('allCategorys', $allCategorys);
$smarty->assign('allSubCategories', $allSubCategories);
$smarty->assign('publicationData',$publicationData[0]);
$smarty->display('admin/publication_edit.tpl');
?>