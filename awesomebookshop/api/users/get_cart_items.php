<?php
  include_once('../../config/init.php');
  include_once($BASE_DIR .'database/users.php');

  $publicationscart = getUserPublicationsCart($_SESSION['userid']);  
  
  $count = count($publicationscart);
  
  echo json_encode($count);
?>
