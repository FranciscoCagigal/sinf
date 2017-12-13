<?php
include_once('../../config/init.php');
include_once('userInfo.php');
include_once($BASE_DIR .'database/orders.php');
include_once($BASE_DIR .'database/users.php');
include_once($BASE_DIR .'database/publications.php');
include_once($BASE_DIR .'database/comments.php');
include_once($BASE_DIR .'database/logs.php');

$todayDate = date('Y-m-d');
$firstDate = strtotime($todayDate . '-7 day');
$firstDate = date('Y-m-d',$firstDate);

$nrOfLastClients = count(getUsersByDate($firstDate,$todayDate));

$nrOfLastComments = count(getCommentsByDate($firstDate,$todayDate));

$nrOfLastLogs = count(getlogsByDate($firstDate,$todayDate));

$nrOfLastOrders = count(getOrdersByDate($firstDate,$todayDate));

$getLast5CommentsByDate = getLast5CommentsByDate($firstDate,$todayDate);

$getBest5UsersOrdersByDate = getBest5UsersOrdersByDate($firstDate,$todayDate);

$getBest5UsersOrdersCountByDate = getBest5UsersOrdersCountByDate($firstDate,$todayDate);

$getBest5PublicationsOrdersByDate = getBest5PublicationsOrdersByDate($firstDate,$todayDate);

$getViews5Publications = getBestViews5Publications($firstDate,$todayDate);

$infoHome = array(
	'nrOfLastClients' 					=> $nrOfLastClients,
	'nrOfLastComments' 					=> $nrOfLastComments,
	'nrOfLastLogs' 						=> $nrOfLastLogs,
	'nrOfLastOrders' 					=> $nrOfLastOrders,
	'getLast5CommentsByDate' 			=> $getLast5CommentsByDate,
	'getBest5UsersOrdersByDate' 		=> $getBest5UsersOrdersByDate,
	'getBest5PublicationsOrdersByDate' 	=> $getBest5PublicationsOrdersByDate,
	'getViews5Publications' => $getViews5Publications,
	'getBest5UsersOrdersCountByDate' => $getBest5UsersOrdersCountByDate
	);

$smarty->assign('infoHome',$infoHome);
$smarty->display('admin/home.tpl');
?>