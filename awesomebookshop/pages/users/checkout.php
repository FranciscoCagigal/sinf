<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');
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

$username = $_SESSION['username'];

$userdata = getUserAllData($username);
$smarty->assign('USER_DATA', $userdata[0]);

$publicationscart = getUserPublicationsCart($clientid);

if(!$publicationscart){
	$_SESSION['error_messages'][] = 'Não possui produtos no carrinho. Deverá adicionar produtos ao carrinho para aceder à página solicitada';
	header("Location: $BASE_URL");
	exit;
}

$carddate = explode('/', $userdata[0]['validade']);

if(count($carddate)==3){

$cardday = $carddate[0];
$cardmonth = $carddate[1];
$cardyear = $carddate[2];

$smarty->assign('cardday', $cardday);
$smarty->assign('cardmonth', $cardmonth);
$smarty->assign('cardyear', $cardyear);

}else{
	$smarty->assign('cardday', 0);
	$smarty->assign('cardmonth', 0);
	$smarty->assign('cardyear', 0);
}



$cartsubtotal = getUserCartSubtotal($clientid);

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

$smarty->assign('publicationscart', $publicationscart);
$smarty->assign('PUBLICATIONSUSERCART', $publicationscart);
$smarty->assign('qtOptions', array_combine(range(1,10),range(1,10)));
$smarty->assign('cartsubtotal', $cartsubtotal[0]['subtotal']);
$smarty->display('users/checkout.tpl');
?>