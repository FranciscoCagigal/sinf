<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR .'database/users.php');

	$reply = getAllCountriesAllInfo();

	echo json_encode($reply);
?>