<?php
  include_once('../../config/init.php');
  include_once($BASE_DIR .'database/users.php');

  $orders = getUserOrderList($_SESSION['userid']);  
  
  $count = count($orders);

  echo json_encode($count);
?>
