<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');
include_once($BASE_DIR .'database/orders.php');

if (!$_SESSION['username'] || !$_GET['id']) {
  $_SESSION['error_messages'][] = 'Deverá efetuar login para aceder à página solicitada';
  header("Location: $BASE_URL" . 'pages/users/login.php');
  exit;
}

if ($_SESSION['usertype'] != 'client') {
  $_SESSION['error_messages'][] = 'Deverá efetuar login com uma conta de cliente para aceder à página solicitada';
  header("Location: $BASE_URL");
  exit;
}

$encomendaid = $_GET['id'];
$clienteid = $_SESSION['userid'];
$clientorders = getOrdersByClientId($clienteid);

$get_permission = false;

foreach($clientorders as $order){
	if($order['primaveraencomendaid'] == $encomendaid){
		$get_permission = true;
		break;
	}
}

if($get_permission){
	primavera_get_fatura($_GET['id'], $_SESSION['userid']);

	$file = 'C:/xampp/htdocs/sinf/awesomebookshop/documentos/cliente_' .  $_SESSION['userid']. '/faturas/fa2017_' . $_GET['id'] . '.pdf';

	$filename = 'fa2017_' . $_GET['id'] . '.pdf';

	header('Content-type: application/pdf');
	header('Content-Disposition: inline; filename="' . $filename . '"');
	header('Content-Transfer-Encoding: binary');
	header('Content-Length: ' . filesize($file));
	header('Accept-Ranges: bytes');

	@readfile($file);
}else  header("Location: $BASE_URL");
?>
