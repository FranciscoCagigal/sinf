<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');  
include_once($BASE_DIR .'database/publications.php');  

if(array_key_exists('userid',$_SESSION)) {

	if($_SESSION['usertype'] == 'client'){
		$clientid = $_SESSION['userid'];

		$publicationsusercart = getUserPublicationsCart($clientid);

		$smarty->assign('PUBLICATIONSUSERCART', $publicationsusercart);

		$username = $_SESSION['username'];

		$userdata = getUserAllData($username);
		$smarty->assign('USER_DATA', $userdata[0]);
	}
}

$eightnewpublications = getNewPublications(8);
$fivenewpublications = getNewPublications(5);
$fivemostsellpublications = getMostSellPublications(5);
$commentedpublications = getCommentedPublications(4);

$dayscommented = array();

$monthscommented = array();

$yearscommented = array();

foreach ($commentedpublications as $commentedpublication) {
	$timestamp = $commentedpublication['data'];
	$timestampparsed = explode(' ', $timestamp);
	$date = $timestampparsed[0];
	$dateparsed = explode('-', $date);
	$dayscommented[] = $dateparsed[2];
	$monthscommented[] = $dateparsed[1];
	$yearscommented[] = $dateparsed[0];
}

$smarty->assign('dayscommented', $dayscommented);
$smarty->assign('monthscommented', $monthscommented);
$smarty->assign('yearscommented', $yearscommented);

$arterandompublication = getRandomPublicationsBySubcategory('Arte', 'Livros', 1);
$desportorandompublication = getRandomPublicationsBySubcategory('Desporto e Lazer', 'Livros', 1);
$direitorandompublication = getRandomPublicationsBySubcategory('Direito', 'Livros', 1);
$engenhariarandompublication = getRandomPublicationsBySubcategory('Engenharia', 'Livros', 1);
$gestaorandompublication = getRandomPublicationsBySubcategory('Gestao', 'Livros', 1);
$historiarandompublication = getRandomPublicationsBySubcategory('Historia', 'Livros', 1);

$randompublications = getRandomPublications(2);

$smarty->assign('eightnewpublications', $eightnewpublications);
$smarty->assign('fivenewpublications', $fivenewpublications);
$smarty->assign('fivemostsellpublications', $fivemostsellpublications);
$smarty->assign('commentedpublications', $commentedpublications);

$smarty->assign('arterandompublication', $arterandompublication[0]);
$smarty->assign('desportorandompublication', $desportorandompublication[0]);
$smarty->assign('direitorandompublication', $direitorandompublication[0]);
$smarty->assign('engenhariarandompublication', $engenhariarandompublication[0]);
$smarty->assign('gestaorandompublication', $gestaorandompublication[0]);
$smarty->assign('historiarandompublication', $historiarandompublication[0]);

$subcategoriasLivros = getAllSubCategorysByCategoryName('Livros');
$subcategoriasLivrosEscolares = getAllSubCategorysByCategoryName('Livros Escolares');
$subcategoriasApoioEscolar = getAllSubCategorysByCategoryName('Apoio Escolar');
$subcategoriasRevistas = getAllSubCategorysByCategoryName('Revistas');
$subcategoriasDicionarios = getAllSubCategorysByCategoryName('Dicionarios e Enciclopedias');
$subcategoriasGuiasEMapas = getAllSubCategorysByCategoryName('Guias Turisticos e Mapas');

$smarty->assign('subcategoriasLivros', $subcategoriasLivros);
$smarty->assign('subcategoriasLivrosEscolares', $subcategoriasLivrosEscolares);
$smarty->assign('subcategoriasApoioEscolar', $subcategoriasApoioEscolar);
$smarty->assign('subcategoriasRevistas', $subcategoriasRevistas);
$smarty->assign('subcategoriasDicionarios', $subcategoriasDicionarios);
$smarty->assign('subcategoriasGuiasEMapas', $subcategoriasGuiasEMapas);

$smarty->assign('randompublications', $randompublications);

$smarty->display('home/home.tpl');
?>
