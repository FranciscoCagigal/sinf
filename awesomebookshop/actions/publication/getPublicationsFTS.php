<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/publications.php');
include_once($BASE_DIR .'database/logs.php');

if (!$_POST['searchpublication']) {
  
  $_SESSION['error_messages'][] = 'Deve preencher a caixa de pesquisa para encontrar as publicações pretendidas';
  
  $_SESSION['form_values'] = $_POST;
  header('Location: ' . $_SERVER['HTTP_REFERER']);
  exit;
}

$valor = strip_tags($_POST['searchpublication']);

$getPublicationFTS = testeFullTextSearch($valor);

insertExpressionSearched($valor);

foreach ($getPublicationFTS as &$publications) {
	if(!$publications['nome_autor'])
		$publications['nome_autor'] = "Sem autor";
}

if ($getPublicationFTS){
	$smarty->assign('def_pubs', $getPublicationFTS);
}
$all_publications = getAllPublications();

$smarty->assign('publication', $all_publications[0]);

$subcategory = getAllSubCategorys();
$smarty->assign('subcategory', $subcategory);

$category = getAllCategorys();

$smarty->assign('category', $category);

$eightnewpublications = getNewPublications(8);
$smarty->assign('eightnewpublications', $eightnewpublications);
$oneRandomNewPublication = getNewPublications(1);
$smarty->assign('oneRandomNewPublication', $oneRandomNewPublication[0]);

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

$smarty->display('publications/publication-list.tpl');

?>