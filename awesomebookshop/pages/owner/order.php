<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/orders.php');
include_once('userInfo.php');

if (!($_GET['id']) || !checkIfOrderExists($_GET['id'])) {
	error_log('if');
    $_SESSION['error_messages'][] = 'Erro com o id da encomenda';
    header("Location: $BASE_URL" . 'pages/owner/orders.php');
    exit;
}

$orderid = $_GET['id'];

$orderData = getOrderData($orderid);
$orderFactAddData = getOrderFactAddData($orderid);

$smarty->assign('orderData',$orderData);
$smarty->assign('orderFactAddData',$orderFactAddData);
$smarty->display('owner/order.tpl');
?>