<?php
include_once('../../config/init.php');
include_once('userInfo.php');
include_once($BASE_DIR .'database/orders.php');
include_once($BASE_DIR .'database/users.php');
include_once($BASE_DIR .'database/publications.php');

$publicationsNumber = count(getAllPublications());

$allOrders = getAllOrders();

$totalValueOfOrders = 0;

foreach ($allOrders as $key) {
	$totalValueOfOrders += $key['total'];
}

$totalNumberOfClients = count(getAllUsers());

$totalNumberOfOrders = count($allOrders);


$lastDate = date('Y-m-d');
$firstDate = strtotime($lastDate . '-7 day');
$firstDate = date('Y-m-d',$firstDate);

$best5Orders = getBest5OrdersByDate($firstDate,$lastDate);
$todayOrders = getTodayOrders($lastDate);


foreach ($best5Orders as &$key) {
	$nrEncomendasHoje = 0;
	foreach ($todayOrders as $key2) {
		if($key['nomecliente']===$key2['nomecliente'])
			$nrEncomendasHoje++;
	}
	$key['nrEncomendasHoje'] = $nrEncomendasHoje;
}


$getLast5Orders = getLast5Orders($firstDate,$lastDate);


$infoHome = array(
	'publicationsNumber' 	=> $publicationsNumber,
	'totalValueOfOrders' 	=> $totalValueOfOrders,
	'totalNumberOfClients' 	=> $totalNumberOfClients,
	'totalNumberOfOrders'	=> $totalNumberOfOrders,
	'best5Orders'			=> $best5Orders,
	'todayOrders'			=> $todayOrders,
	'getLast5Orders'		=> $getLast5Orders
	);

$smarty->assign('infoHome',$infoHome);
$smarty->display('owner/home.tpl');
?>