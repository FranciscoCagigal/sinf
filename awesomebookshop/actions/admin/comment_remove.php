<?php
include_once '../../config/init.php';
include_once $BASE_DIR . 'database/comments.php';

$idcomment = $_GET['id'];

try {

    deleteComment($idcomment);

} catch (PDOException $e) {
	
    $_SESSION['error_messages'][] = 'Erro ao remover o comentário';
    header("Location: $BASE_URL" . 'pages/admin/comments.php');
    exit;
}

$_SESSION['success_messages'][] = 'Publicação removida com sucesso';
header("Location: $BASE_URL" . 'pages/admin/comments.php');
?>