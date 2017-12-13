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

$pontos_cliente = getClientPoints($clientid);
$smarty->assign('pontos_cliente', $pontos_cliente['pontos']);

$orders = getUserLast5OrderList($clientid);

$publicationsusercart = getUserPublicationsCart($clientid);

$days = array();

$months = array();

$years = array();

$orderspublications = array();

$fmt = new NumberFormatter( 'pt_PT', NumberFormatter::CURRENCY );

foreach ($orders as $key => $order) {
  $timestamp = $order['data'];
  $timestampparsed = explode(' ', $timestamp);
  $date = $timestampparsed[0];
  $dateparsed = explode('-', $date);
  $days[] = $dateparsed[2];
  $months[] = $dateparsed[1];
  $years[] = $dateparsed[0];
  
  $orders[$key]['total'] = $fmt->formatCurrency($orders[$key]['total'], "EUR");
  $orders[$key]['iva'] = $fmt->formatCurrency($orders[$key]['iva'], "EUR");
  $orders[$key]['valorportes'] = $fmt->formatCurrency($orders[$key]['portes'], "EUR");
  
  $orderid = $order['encomendaid'];
  $orderpublications = getOrderPublications($orderid);
  $orderspublications[] = count($orderpublications);
}

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

$smarty->assign('userid', $clientid);
$smarty->assign('orders', $orders);
$smarty->assign('days', $days);
$smarty->assign('months', $months);
$smarty->assign('years', $years);
$smarty->assign('orderspublications', $orderspublications);

$smarty->assign('PUBLICATIONSUSERCART', $publicationsusercart);

$smarty->display('users/my-account.tpl');
?>
