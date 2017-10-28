<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/publications.php');

$oneRandomNewPublication = getNewPublications(1);
$smarty->assign('oneRandomNewPublication', $oneRandomNewPublication[0]);

$getNPromotionalPublications = getNPromotionalPublications(5);

foreach ($getNPromotionalPublications as &$publications) {
	if(!$publications['nome_autor'])
		$publications['nome_autor'] = "Sem autor";
}

$smarty->assign('def_pubs', $getNPromotionalPublications);


$all_publications = getAllPublications();

$subcategory = getAllSubCategorys();

$category = getAllCategorys();

$smarty->assign('publication', $all_publications[0]);

$smarty->assign('subcategory', $subcategory);

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

$smarty->display('publications/publications-promotion.tpl');

?>