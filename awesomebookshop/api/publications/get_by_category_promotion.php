<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/publications.php');

$subcat_name = $_GET['subcat_name'];
$cat_name = $_GET['cat_name'];

if($subcat_name == NULL && $cat_name == NULL)
	$pubs = "NULL";

else if($subcat_name == NULL && $cat_name != NULL)
	$pubs = getPublicationDataSearchByCatOnly_promotion($cat_name);

else
	$pubs = getPublicationDataSearchCat_promotion($cat_name, $subcat_name);


echo json_encode($pubs);
?>