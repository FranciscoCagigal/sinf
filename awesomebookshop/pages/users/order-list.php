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

$username = $_SESSION['username'];

$userdata = getUserData($username);

$orders = getUserOrderList($userdata[0]['clienteid']);

$primaveraclientorders = primaveraGetClientOrders();

foreach($primaveraclientorders as $primaveraorder){
	foreach($orders as $key => $order){
	error_log($primaveraorder['NumDoc'].' = '.$order['primaveraencomendaid']);
		if($primaveraorder['NumDoc'] == $order['primaveraencomendaid']){
			
			switch($primaveraorder['Estado']){
				case 'P' : $orders[$key]['estado'] = 'Em processamento';
				break;
				case 'T' : $orders[$key]['estado'] = 'Processada';
				break;
				case 'E' : $orders[$key]['estado'] = 'Enviada';
				break;
			}
		}
	}
		
}

error_log(print_r($primaveraclientorders, true));

$clientid = $_SESSION['userid'];

$publicationsusercart = getUserPublicationsCart($clientid);

$days = array();

$months = array();

$years = array();

$orderspublications = array();

foreach ($orders as $order) {
  $timestamp = $order['data'];
  $timestampparsed = explode(' ', $timestamp);
  $date = $timestampparsed[0];
  $dateparsed = explode('-', $date);
  $days[] = $dateparsed[2];
  $months[] = $dateparsed[1];
  $years[] = $dateparsed[0];
  
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

$smarty->assign('orders', $orders);
$smarty->assign('days', $days);
$smarty->assign('months', $months);
$smarty->assign('years', $years);
$smarty->assign('orderspublications', $orderspublications);
$smarty->assign('PUBLICATIONSUSERCART', $publicationsusercart);
$smarty->display('users/order-list.tpl');
?>
