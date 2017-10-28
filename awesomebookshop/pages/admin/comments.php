<?php
  include_once('../../config/init.php');
  include_once($BASE_DIR .'database/comments.php');
  include_once('userInfo.php');
  
  $allcomments = getAllComments();

  $smarty->assign('allcomments', $allcomments);
  $smarty->display('admin/comments.tpl');
?>