<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/publications.php');
include_once($BASE_DIR .'database/users.php');

if (!$_GET['cat']) {
	$_SESSION['error_messages'][] = 'Undefined filter identifier';
	header("Location: $BASE_URL");
	exit;
}
else {
	$default_cat_id = $_GET['cat'];

	$def_pubs = getPublicationDataSearchByCatOnly($default_cat_id);

	$def_subcat_array = getAllSubCategorysById($default_cat_id);

	$smarty->assign('def_cat', $default_cat_id);

	$smarty->assign('def_pubs', $def_pubs);

	$smarty->assign('def_subcat_array', $def_subcat_array);
}


if(array_key_exists('username', $_SESSION)){
	if ($_SESSION['usertype'] == 'client') {
		$clientid = $_SESSION['userid'];
		$publicationscart = getUserPublicationsCart($clientid);
		$smarty->assign('publicationscart', $publicationscart);
		$smarty->assign('PUBLICATIONSUSERCART', $publicationscart);
	}
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

$smarty->display('publications/publicationListByCat.tpl');
?>