<?php

	include_once '../../config/init.php';
	include_once $BASE_DIR . 'database/publications.php';
	
	$json = file_get_contents("php://input");
	
	$input = iconv('UTF-8', 'UTF-8//IGNORE', utf8_encode($json));
	
	//$input = mb_convert_encoding($input, "UTF-16", "Windows-1252");
	
	$object = json_decode($input);

	$array = json_decode(json_encode($object), True);
	 
	foreach($array as $artigo){
		
		error_log(print_r($artigo,true));
		
		if(primavera_checkIfPublicationExists($artigo['CodArtigo']))
			primavera_update_artigo($artigo);
		else{
			
			$titulo = $artigo['Nome'];
			$descricao = $artigo['DescArtigo'];
			$autorId = $getAutorIDByName($artigo['Autor']);
			$editoraId = checkIfBrandExists($artigo['Editora']);
			$categoriaid = getCategoryIdByName($artigo['Categoria']);
			$subCategoriaId = getSubCategoryIdByName($artigo['SubCategoria'], $categoriaid);
			$datapublicacao = '2017-01-01';
			$stock = 0;
			$paginas = 0;
			$preco = $artigo['Preco'];
			$precopromocional = $artigo['PrecoPromocional'];
			$peso = 0;
			$codigobarras = '';
			$novidade = TRUE;
			$isbn = '';
			$edicao = '';
			$periodicidade = 'Semanal';
			$block3 = NULL;
			$block4 = NULL;
			
			if(!$autorId){
				$autorId = createAutorOnlyWithName($artigo['Autor']);
			}
			
			createPublication($titulo, $descricao, $autorId, $editoraId, $subCategoriaId, $datapublicacao, $stock, $peso, $paginas, $preco, $precopromocional, $codigobarras, $novidade, $isbn, $edicao, $periodicidade, $block3, $block4);
		}
	}
	
	echo 'ok';
?>