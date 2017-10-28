<?php
include_once '../../config/init.php';
include_once $BASE_DIR . 'database/questions.php';

$comment_id = $_GET['id'];

try {

    updateQuestionStatus($comment_id);

} catch (PDOException $e) {
    
    $_SESSION['error_messages'][] = 'Erro na edição do estado da pergunta';

    header("Location: $BASE_URL" . 'pages/owner/questions.php');
    exit;
}

$_SESSION['success_messages'][] = 'Estado da pergunta modificada com sucesso';
header("Location: $BASE_URL" . 'pages/owner/questions.php');
?>