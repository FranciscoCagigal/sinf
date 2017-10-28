<?php
  include_once('../../config/init.php');
  include_once($BASE_DIR .'database/users.php');

  $cartsubtotal = getUserCartSubtotal($_SESSION['userid']);
    
  echo json_encode($cartsubtotal);
?>
