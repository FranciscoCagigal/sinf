<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR .'database/orders.php');
	include_once($BASE_DIR .'database/comments.php');

	$lastDate = $_GET['lastDate'];
	$firstDate = $_GET['firstDate'];
	$flag = $_GET['flag'];

	if($flag === "top_comentarios"){
		$reply = getLast5CommentsByDate($firstDate,$lastDate);
	}else if($flag === "top_usuarios"){
		$reply = getBest5UsersOrdersByDate($firstDate,$lastDate);
	}else if($flag === "top_visitas"){
		$reply = getBestViews5Publications($firstDate,$lastDate);
	}else if($flag === "top_encomendas"){
		$reply = getBest5UsersOrdersCountByDate($firstDate,$lastDate);
	}else {
		$reply = getBest5PublicationsOrdersByDate($firstDate,$lastDate);
	}

	echo json_encode($reply);
?>