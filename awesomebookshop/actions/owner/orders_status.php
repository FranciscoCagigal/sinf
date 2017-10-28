<?php
include_once '../../config/init.php';
include_once $BASE_DIR . 'database/orders.php';

$order_id = strip_tags($_POST['order_id']);

if(!(isset($_POST['estadoencomenda']))){
	$_SESSION['success_messages'][] = 'Estado da encomenda sem alteração';
	header("Location: $BASE_URL" . 'pages/owner/orders.php');
	exit;
}

$new_order_status = strip_tags($_POST['estadoencomenda']);

$atual_order_status = getOrderStatus($order_id);

if ($atual_order_status['estado'] === $new_order_status) {
    $_SESSION['error_messages'][] = 'Novo estado da encomenda é igual ao atual';
    header("Location: $BASE_URL" . 'pages/owner/order.php?id=' . urlencode($order_id));
    exit;
}

try {
    
    updateOrderStatus($order_id, $new_order_status);

} catch (PDOException $e) {

    $_SESSION['error_messages'][] = 'Erro ao editar o estado da encomenda';
    header("Location: $BASE_URL" . 'pages/owner/order.php?id=' . urlencode($order_id));
    exit;
}
$_SESSION['success_messages'][] = 'Estado da encomenda mudado com sucesso';
header("Location: $BASE_URL" . 'pages/owner/orders.php');
?>