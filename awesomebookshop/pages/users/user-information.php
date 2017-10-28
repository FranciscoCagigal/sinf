<?php
  include_once('../../config/init.php');
  include_once($BASE_DIR .'database/users.php');
  include_once $BASE_DIR . 'database/publications.php';

	if (!$_SESSION['username']) {
    $_SESSION['error_messages'][] = 'Deverá efetuar login para aceder à página solicitada';
    header("Location: $BASE_URL" . 'pages/users/login.php');
    exit;
  }

  if ($_SESSION['usertype'] != 'client') {
    $_SESSION['error_messages'][] = 'Deverá efetuar login com uma conta de cliente para aceder à página solicitada';
    header("Location: $BASE_URL");
    exit;
  }

  $username = $_SESSION['username'];
  
  $userdata = getUserAllData($username);

  $birthdate = explode('-', $userdata[0]['datanascimento']);

  $birthyear = $birthdate[0];
  $str = $birthdate[1];
  $birthmonth = ltrim($str, '0');
  $birthday = $birthdate[2];
  
  $smarty->assign('DAY_ARRAY', array_combine(range(1,31),range(1,31)));
  $smarty->assign('MONTH_ARRAY', array_combine(range(1,12),range(1,12)));
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
  $smarty->assign('YEAR_ARRAY', array_combine(range(1976,2006),range(1976,2006)));

  $smarty->assign('BIRTH_DAY', $birthday);
  $smarty->assign('BIRTH_MONTH', $birthmonth);
  $smarty->assign('BIRTH_YEAR', $birthyear);

  $smarty->assign('GENDER_ARRAY', array(
                                       'Masculino' => 'Masculino',
                                       'Feminino' => 'Feminino'));

  $smarty->assign('USER_DATA', $userdata[0]);

  $clientid = $_SESSION['userid'];
  
  $publicationsusercart = getUserPublicationsCart($clientid);

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
  
  $smarty->assign('PUBLICATIONSUSERCART', $publicationsusercart);
  $smarty->display('users/user-information.tpl');
?>