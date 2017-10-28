<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR .'database/logs.php');

	$expressao = $_GET['expressao'];
	$startDate = $_GET['startDate'];
	$endDate = $_GET['endDate'];

	if( $expressao == NULL  && $startDate == NULL && $endDate == NULL )
		$reply = getAllLogsSearch(); 

	else if( $expressao != NULL  && $startDate != NULL && $endDate != NULL)
		$reply = getLogsByExpressionAndDate($expressao, $startDate, $endDate);

	else if( $expressao != NULL  && $startDate == NULL && $endDate == NULL)
		$reply = getLogsByExpression($expressao);

	else if( $expressao == NULL  && $startDate != NULL && $endDate != NULL)
		$reply = getLogsByDateEx($startDate, $endDate); 

	else
		$reply = "NULL";

	echo json_encode($reply);
?>