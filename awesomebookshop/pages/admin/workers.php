<?php
  include_once('../../config/init.php');
  include_once($BASE_DIR .'database/workers.php');
  include_once('userInfo.php');
  
  $allWorkers = getAllWorkers();

  $smarty->assign('allWorkers', $allWorkers);
  $smarty->display('admin/workers.tpl');
?>