<?php
  include_once('../../config/init.php');
  include_once($BASE_DIR .'database/publications.php');

  $allSubCategories = getAllSubCategorysByCategory($_GET['categoria']);

  echo json_encode($allSubCategories);
?>
