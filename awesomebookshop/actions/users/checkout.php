<?php
include_once '../../config/init.php';
include_once $BASE_DIR . 'database/users.php';

if (!$_SESSION['username']) {
	$_SESSION['error_messages'][] = 'Deverá efetuar login para aceder à página solicitada';
	header("Location: $BASE_URL");
	exit;
}

if (!$_POST['nomef'] || !$_POST['nomee'] || !$_POST['moradaf'] || !$_POST['moradae'] || !$_POST['localidadef'] || !$_POST['localidadee'] || !$_POST['codigopostalf'] || !$_POST['codigopostale'] || !$_POST['email'] || !$_POST['metodopagamento']) {

	$_SESSION['error_messages'][] = 'Não preencheu todos os campos de preenchimento obrigatório';
	$_SESSION['form_values']      = $_POST;
	header("Location: $BASE_URL" . 'pages/users/checkout.php');
	exit;
}

$clienteid = $_SESSION['userid'];
$username = $_SESSION['username'];

$publicationscart = getUserPublicationsCart($clienteid);

/*$could_proceed = checkProductsPrice($publicationscart);

if(!$could_proceed){
	$_SESSION['error_messages'][] = 'Alguns preços foram atualizados. Reveja a encomenda';

	header("Location: $BASE_URL" . 'pages/users/checkout.php');
	exit;
}*/


$codpostalf = explode('-', strip_tags($_POST['codigopostalf']));

$cod1f = $codpostalf[0];
$cod2f = $codpostalf[1];

if (strip_tags($_POST['codigopostalf']) == strip_tags($_POST['codigopostale'])) {
	$cod1e = $cod1f;
	$cod2e = $cod2f;
} else {
	$codpostale = explode('-', strip_tags($_POST['codigopostale']));

	$cod1e = $codpostale[0];
	$cod2e = $codpostale[1];
}

$orderinformationf = array(
	'nome'         => strip_tags($_POST['nomef']),
	'morada'       => strip_tags($_POST['moradaf']),
	'localidade'   => strip_tags($_POST['localidadef']),
	'cod1'        => $cod1f,
	'cod2'        => $cod2f,
	'telefone'     => strip_tags($_POST['telefone']),
	'email'        => strip_tags($_POST['email']),
	'nif'          => strip_tags($_POST['nif']),
	'metodopagamento'   => strip_tags($_POST['metodopagamento']),
	'nomecartao'   => strip_tags($_POST['nomecartao']),
	'numerocartao' => strip_tags($_POST['numerocartao']),
	'mm'           => strip_tags($_POST['mm']),
	'yy'           => strip_tags($_POST['yy']),
	'cvv'          => strip_tags($_POST['cvv'])
	);

if((strip_tags($_POST['nomef']) == strip_tags($_POST['nomee'])) && (strip_tags($_POST['moradaf']) == strip_tags($_POST['moradae'])) && (strip_tags($_POST['localidadef']) == strip_tags($_POST['localidadee'])) && (strip_tags($_POST['codigopostalf']) == strip_tags($_POST['codigopostale']))) {

	$orderinformatione = $orderinformationf;

} else {
	$orderinformatione = array(
		'nome'       => strip_tags($_POST['nomee']),
		'morada'     => strip_tags($_POST['moradae']),
		'localidade' => strip_tags($_POST['localidadee']),
		'cod1'      => $cod1e,
		'cod2'      => $cod2e
		);
}

try {

	insertOrder($clienteid, $username, $orderinformationf, $orderinformatione, $publicationscart);

} catch (PDOException $e) {

	$_SESSION['error_messages'][] = 'Erro ao inserir encomenda';

	header("Location: $BASE_URL" . 'pages/users/checkout.php');
	exit;
}

$_SESSION['success_messages'][] = 'Encomenda inserida com sucesso';
header("Location: $BASE_URL");
?>