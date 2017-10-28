<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/publications.php');
include_once($BASE_DIR .'database/users.php');

if (!$_POST['titulo'] || !$_POST['editora'] || !$_POST['datapublicacao'] || !$_POST['stock'] || !$_POST['peso'] || !$_POST['preco']){
  error_log('if');
  $_SESSION['error_messages'][] = 'Os campos com * são de preenchimento obrigatório';
  $_SESSION['form_values'] = $_POST;
  if(!$_POST['codigobarras']){
    $codigobarras = rand(999999999,999999999999);
    $_SESSION['form_values']['codigobarras'] = $codigobarras;
  }
  header("Location: $BASE_URL" . 'pages/owner/publication_add.php');
  exit;
}

  //Generate rand number for codigobarras if empty
if(!$_POST['codigobarras'])
  $codigobarras = rand(999999999,999999999999);
else
  $codigobarras = strip_tags($_POST['codigobarras']);

$titulo           = strip_tags($_POST['titulo']);
$descricao        = strip_tags($_POST['descricao']);
$autorId          = strip_tags($_POST['autor']);
$editora          = strip_tags($_POST['editora']);
$categoriaId      = strip_tags($_POST['categoria']);
$subCategoriaId   = strip_tags($_POST['subcategoria']);
$datapublicacao   = strip_tags($_POST['datapublicacao']);
$stock            = strip_tags($_POST['stock']);
$peso             = strip_tags($_POST['peso']);
$paginas          = strip_tags($_POST['nrpaginas']);
$preco            = strip_tags($_POST['preco']);
$precopromocional = strip_tags($_POST['precopromocional']);
$novidade         = strip_tags($_POST['novidade']);
$isbn             = strip_tags($_POST['isbn']);
$edicao           = strip_tags($_POST['edicao']);
$periodicidade    = strip_tags($_POST['periodicidade']);


if(!($descricao))
  $descricao = NULL;
if(!($paginas))
  $paginas = 0;
if(!($precopromocional))
  $precopromocional = $preco;
if(!($isbn))
  $isbn = NULL;
if(!($edicao))
  $edicao = NULL;
if($periodicidade === "Escolha uma opção")
  $periodicidade = NULL;

$pieces = explode('/', $datapublicacao);
$diaPub = $pieces[1];
$mesPub = $pieces[0];
$anoPub = $pieces[2];
$datapublicacao = sprintf("%04d-%02d-%02d",$anoPub,$mesPub,$diaPub);

$categoria = getCategoryNameById($categoriaId);

if($categoria === "Livros")
  $block3 = "books";
else if($categoria === "Livros Escolares")
  $block3 = "educationbooks";
else if($categoria === "Apoio Escolar")
  $block3 = "supporteducationbooks";
else if($categoria === "Revistas")
  $block3 = "magazines";
else if($categoria === "Dicionarios e Enciclopedias")
  $block3 = "dictionaries";
else if($categoria === "Guias Turisticos e Mapas")
  $block3 = "turisticguides";
else
  $block3 ="outros";

$subcategoria = getSubcategoryNameById($categoriaId, $subCategoriaId);

$block4 = preg_replace('/\s+/', '_', $subcategoria);
$block4 = preg_replace("/,+/", '', $block4);
$block4 = preg_replace("/ç+/", 'c', $block4);
$block4 = preg_replace("/ã+/", 'a', $block4);

if($autorId == "novoAutor"){
  if (!$_POST['nomeAutor'] || !$_POST['datanascimento'] || !$_POST['paisAutor']){
    error_log('if');
    $_SESSION['error_messages'][] = 'Os campos com * são de preenchimento obrigatório';
    $_SESSION['form_values'] = $_POST;
    header("Location: $BASE_URL" . 'pages/owner/publication_add.php');
    exit;
  }

  $nomeAutor      = strip_tags($_POST['nomeAutor']);
  $biografia      = strip_tags($_POST['biografia']);
  $genero         = strip_tags($_POST['genero']);
  $datanascimento = strip_tags($_POST['datanascimento']);
  $paisId      = strip_tags($_POST['paisAutor']);

  if(!isset($biografia))
    $biografia = "N/A";

  if (!preg_match("/^(0[1-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1])\/[0-9]{4}$/",$datanascimento)){
    error_log('if');
    $_SESSION['error_messages'][] = 'Data invalida do autor, formato correto: MM/DD/YYYY';
    $_SESSION['form_values'] = $_POST;
    header("Location: $BASE_URL" . 'pages/owner/publication_add.php');
    exit;
  }

  $pieces = explode('/', $datanascimento);
  $diaNasc = $pieces[1];
  $mesNasc = $pieces[0];
  $anoNasc = $pieces[2];
  $datanascimento = sprintf("%04d-%02d-%02d",$anoNasc,$mesNasc,$diaNasc);

  try {
    
    $autorId = createAutor($paisId, $nomeAutor, $genero, $datanascimento, $biografia);

  } catch (PDOException $e) {

    if (strpos($e->getMessage(), 'autor_nome_key') !== false) {
      $_SESSION['error_messages'][] = 'Autor duplicado';
      $_SESSION['field_errors']['nome'] = 'Autor já existe';
    }
    else $_SESSION['error_messages'][] = 'Erro ao criar o autor';

    $_SESSION['form_values'] = $_POST;
    header("Location: $BASE_URL" . 'pages/owner/publication_add.php');
    exit;
  }
}

  //Verify Editora and return id, if not exists add it
$editoraId = verifyEditoraIfExists($editora);

try {

  $url = createPublication($titulo, $descricao, $autorId, $editoraId, $subCategoriaId, $datapublicacao, $stock, $peso, $paginas, $preco, $precopromocional, $codigobarras, $novidade, $isbn, $edicao, $periodicidade, $block3, $block4);

  uploadFile($url);

} catch (PDOException $e) {

  if (strpos($e->getMessage(), 'publicacao_codigobarras_key') !== false) {
    $_SESSION['error_messages'][] = 'Publicação duplicada';
    $_SESSION['field_errors']['publicacao'] = 'Código de barras escolhido já existe';
  }
  else if (strpos($e->getMessage(), 'ck_publicacao_precopromocional') !== false) {
    $_SESSION['error_messages'][] = 'Erro no preço promocional';
    $_SESSION['field_errors']['publicacao'] = 'Preço promocional não pode ser superior ao preço normal';
  }
  else $_SESSION['error_messages'][] = 'Erro ao criar a publicação';

  $_SESSION['form_values'] = $_POST;
  header("Location: $BASE_URL" . 'pages/owner/publication_add.php');
  exit;
}
$_SESSION['success_messages'][] = 'Publicação adicionada com sucesso';  
header("Location: $BASE_URL" . 'pages/owner/publications.php');


function uploadFile($url){
  if(($_FILES['fileUpload'])){
    $path = ('../../' . $url);
    move_uploaded_file($_FILES['fileUpload']['tmp_name'], $path);
   }
}
?>
