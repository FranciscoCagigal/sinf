<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');
include_once($BASE_DIR .'database/orders.php');
include_once $BASE_DIR . 'database/publications.php';

if (!$_SESSION['username']) {
	$_SESSION['error_messages'][] = 'Deverá efetuar login para aceder à página solicitada';
	header("Location: $BASE_URL" . 'pages/users/login.php');
	exit;
}

if ($_SESSION['usertype'] != 'client') {
	$_SESSION['error_messages'][] = 'Deverá efetuar login com uma conta de cliente para aceder à página solicitada';
	header("Location: $BASE_URL");
	exit;
}

$clientid = $_SESSION['userid'];

$publicationsusercart = getUserPublicationsCart($clientid);

$orderid = $_GET['id'];

if(!checkUserHasOrder($clientid, $orderid)){
	$_SESSION['error_messages'][] = 'Apenas pode consultar o conteúdo das suas encomendas';
	header("Location: $BASE_URL" . 'pages/users/order-list.php');
	exit;
}

$orderpublications = getOrderPublications($orderid);

$eightnewpublications = getNewPublications(8);
$smarty->assign('eightnewpublications', $eightnewpublications);

$subcategoriasLivros = getAllSubCategorysByCategoryName('Livros');
$subcategoriasLivrosEscolares = getAllSubCategorysByCategoryName('Livros Escolares');
$subcategoriasApoioEscolar = getAllSubCategorysByCategoryName('Apoio Escolar');
$subcategoriasRevistas = getAllSubCategorysByCategoryName('Revistas');
$subcategoriasDicionarios = getAllSubCategorysByCategoryName('Dicionarios e Enciclopedias');
$subcategoriasGuiasEMapas = getAllSubCategorysByCategoryName('Guias Turisticos e Mapas');

$smarty->assign('subcategoriasLivros', $subcategoriasLivros);
$smarty->assign('subcategoriasLivrosEscolares', $subcategoriasLivrosEscolares);
$smarty->assign('subcategoriasApoioEscolar', $subcategoriasApoioEscolar);
$smarty->assign('subcategoriasRevistas', $subcategoriasRevistas);
$smarty->assign('subcategoriasDicionarios', $subcategoriasDicionarios);
$smarty->assign('subcategoriasGuiasEMapas', $subcategoriasGuiasEMapas);

$smarty->assign('PUBLICATIONSUSERCART', $publicationsusercart);
$smarty->assign('orderpublications', $orderpublications);
$smarty->assign('orderid', $orderid);
$smarty->display('users/order-publications.tpl');
?>
