<?php
include_once '../../config/init.php';
include_once $BASE_DIR . 'database/users.php';
include_once $BASE_DIR . 'database/publications.php';

if(!array_key_exists('username', $_SESSION)){

	$countries = getAllCountries();

	try{
		$newpublication = getNewPublications(1);
	}catch(PDOException $e){
		$_SESSION['error_messages'][] = 'Erro ao encontrar uma publicação nova';
		header("Location: $BASE_URL");
	}

	$smarty->assign('GENDER_ARRAY', array(
		'Masculino' => 'Masculino',
		'Feminino' => 'Feminino'));

	$smarty->assign('DAY_ARRAY', array_combine(range(1, 31), range(1, 31)));

	$smarty->assign('MONTH_ARRAY', array_combine(range(1, 12), range(1, 12)));

	$smarty->assign('MONTH_NAMES_ARRAY', array(
		'Janeiro',
		'Fevereiro',
		'Março',
		'Abril',
		'Maio',
		'Junho',
		'Julho',
		'Agosto',
		'Setembro',
		'Outubro',
		'Novembro',
		'Dezembro'));

	$smarty->assign('YEAR_ARRAY', array_combine(range(1976, 2006), range(1976, 2006)));

	$eightnewpublications = getNewPublications(8);
	$smarty->assign('eightnewpublications', $eightnewpublications);

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
	
	$smarty->assign('newpublication', $newpublication[0]);
	$smarty->assign('countries', $countries);
	$smarty->display('users/register.tpl');
}
else{
	$_SESSION['error_messages'][] = 'Deverá efetuar logout para aceder à página solicitada';
	header("Location: $BASE_URL");
	exit;
}