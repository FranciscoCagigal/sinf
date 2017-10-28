<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR .'database/orders.php');
	
	$lastDate = $_GET['lastDate'];
	$firstDate = $_GET['firstDate'];
	$flag = $_GET['flag'];

	$best5Orders = getBest5OrdersByDate($firstDate,$lastDate);
	$todayOrders = getTodayOrders($lastDate);


	foreach ($best5Orders as &$key) {
		$nrEncomendasHoje = 0;
		foreach ($todayOrders as $key2) {
			if($key['nomecliente'] === $key2['nomecliente'])
				$nrEncomendasHoje++;
		}
		$key['nrEncomendasHoje'] = $nrEncomendasHoje;
	}

	if($flag === "top5orders")
		$reply = $best5Orders;
	else
		$reply = getLast5Orders($firstDate,$lastDate);

	echo json_encode($reply);
?>