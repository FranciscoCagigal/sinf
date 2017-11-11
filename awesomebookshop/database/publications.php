<?php

function checkIfPublicationExists($id){
	global $conn;
	$stmt = $conn->prepare("SELECT publicacaoid
							FROM publicacao
							WHERE publicacaoid = ?");
	$stmt->execute(array($id));

	return ($stmt->fetch() !== false);
}

function getAllPublications(){
	global $conn;
	$stmt = $conn->prepare("SELECT publicacao.*, autor.nome AS nome_autor
							FROM autor
							RIGHT JOIN autorpublicacao
							ON autorpublicacao.autorid = autor.autorid
							RIGHT JOIN publicacao
							ON publicacao.publicacaoid = autorpublicacao.publicacaoid
							ORDER BY publicacao.publicacaoid");
	$stmt->execute();
	return $stmt->fetchAll();
}

function getURLPublication($id){
	global $conn;
	$stmt = $conn->prepare("SELECT url
							FROM imagem
							WHERE publicacaoid = ?");
	$stmt->execute(array($id));
	return $stmt->fetchAll();
}

function getPublicationData($id)
{
	global $conn;
    $stmt = $conn->prepare("SELECT publicacao.*, imagem.url, editora.nome AS nome_editora, autor.nome AS nome_autor, autor.autorid as id_autor, subcategoria.subcategoriaid as id_subcategoria, subcategoria.nome as nome_subcategoria, categoria.nome as nome_categoria, categoria.categoriaid as id_categoria
                            FROM autor
							RIGHT JOIN autorpublicacao
							ON autor.autorid = autorpublicacao.autorid 
							RIGHT JOIN publicacao
							ON autorpublicacao.publicacaoid = publicacao.publicacaoid 
							RIGHT JOIN editora
							ON editora.editoraid = publicacao.editoraid 
							RIGHT JOIN imagem
							ON imagem.publicacaoid = publicacao.publicacaoid
                            RIGHT JOIN subcategoria
                            ON subcategoria.subcategoriaid = publicacao.subcategoriaid
                            RIGHT JOIN categoria
                            ON subcategoria.categoriaid = categoria.categoriaid
                            WHERE publicacao.publicacaoid = ?");
    $stmt->execute(array($id));
    return $stmt->fetchAll();
}

function getPublicationDataSearchPublicationName($nome_livro)
{
	global $conn;
    $stmt = $conn->prepare("SELECT publicacao.*, editora.nome AS nome_editora, autor.nome AS nome_autor, autor.autorid as id_autor, subcategoria.subcategoriaid as id_subcategoria, subcategoria.nome as nome_subcategoria, categoria.nome as nome_categoria, categoria.categoriaid as id_categoria
                            FROM autor
							RIGHT JOIN autorpublicacao
							ON autor.autorid = autorpublicacao.autorid 
							RIGHT JOIN publicacao
							ON autorpublicacao.publicacaoid = publicacao.publicacaoid 
							RIGHT JOIN editora
							ON editora.editoraid = publicacao.editoraid
                            RIGHT JOIN subcategoria
                            ON subcategoria.subcategoriaid = publicacao.subcategoriaid
                            RIGHT JOIN categoria
                            ON subcategoria.categoriaid = categoria.categoriaid
                            WHERE (LOWER(publicacao.titulo) like '%'||?||'%')
                            ORDER BY publicacao.publicacaoid");
    $stmt->execute(array(strtolower($nome_livro)));
    return $stmt->fetchAll();
}

function testeFullTextSearch($nome_livro)
{
	global $conn;
    $stmt = $conn->prepare("SELECT publicacao.*, editora.nome AS nome_editora, autor.nome AS nome_autor, autor.autorid as id_autor, subcategoria.subcategoriaid as id_subcategoria, subcategoria.nome as nome_subcategoria, categoria.nome as nome_categoria, categoria.categoriaid as id_categoria, imagem.url
                            FROM autor
							RIGHT JOIN autorpublicacao
							ON autor.autorid = autorpublicacao.autorid 
							RIGHT JOIN publicacao
							ON autorpublicacao.publicacaoid = publicacao.publicacaoid 
							RIGHT JOIN editora
							ON editora.editoraid = publicacao.editoraid
							RIGHT JOIN imagem
							ON imagem.publicacaoid = publicacao.publicacaoid
                            RIGHT JOIN subcategoria
                            ON subcategoria.subcategoriaid = publicacao.subcategoriaid
                            RIGHT JOIN categoria
                            ON subcategoria.categoriaid = categoria.categoriaid
                            WHERE to_tsvector(publicacao.titulo) @@ to_tsquery(?||':*') OR to_tsvector(publicacao.descricao) @@ to_tsquery(?||':*')
                            ORDER BY publicacao.publicacaoid");
    $stmt->execute(array($nome_livro,$nome_livro));
    return $stmt->fetchAll();
}

function getPublicationDataSearchAutorName($nome_autor)
{
	global $conn;
    $stmt = $conn->prepare("SELECT publicacao.*, editora.nome AS nome_editora, autor.nome AS nome_autor, autor.autorid as id_autor, subcategoria.subcategoriaid as id_subcategoria, subcategoria.nome as nome_subcategoria, categoria.nome as nome_categoria, categoria.categoriaid as id_categoria
                            FROM autor
							RIGHT JOIN autorpublicacao
							ON autor.autorid = autorpublicacao.autorid 
							RIGHT JOIN publicacao
							ON autorpublicacao.publicacaoid = publicacao.publicacaoid 
							RIGHT JOIN editora
							ON editora.editoraid = publicacao.editoraid
                            RIGHT JOIN subcategoria
                            ON subcategoria.subcategoriaid = publicacao.subcategoriaid
                            RIGHT JOIN categoria
                            ON subcategoria.categoriaid = categoria.categoriaid
                            WHERE (LOWER(autor.nome) like '%'||?||'%')
                            ORDER BY publicacao.publicacaoid");
    $stmt->execute(array(strtolower($nome_autor)));
    return $stmt->fetchAll();
}

function getPublicationDataSearchEditorName($nome_editora)
{
	global $conn;
    $stmt = $conn->prepare("SELECT publicacao.*, editora.nome AS nome_editora, autor.nome AS nome_autor, autor.autorid as id_autor, subcategoria.subcategoriaid as id_subcategoria, subcategoria.nome as nome_subcategoria, categoria.nome as nome_categoria, categoria.categoriaid as id_categoria
                            FROM autor
							RIGHT JOIN autorpublicacao
							ON autor.autorid = autorpublicacao.autorid 
							RIGHT JOIN publicacao
							ON autorpublicacao.publicacaoid = publicacao.publicacaoid 
							RIGHT JOIN editora
							ON editora.editoraid = publicacao.editoraid
                            RIGHT JOIN subcategoria
                            ON subcategoria.subcategoriaid = publicacao.subcategoriaid
                            RIGHT JOIN categoria
                            ON subcategoria.categoriaid = categoria.categoriaid
                            WHERE (LOWER(editora.nome) like '%'||?||'%')
                            ORDER BY publicacao.publicacaoid");
    $stmt->execute(array(strtolower($nome_editora)));
    return $stmt->fetchAll();
}

function getPublicationDataSearchCat($categoriaid, $subcategoriaid)
{
	global $conn;
    $stmt = $conn->prepare("SELECT publicacao.*, editora.nome AS nome_editora, autor.nome AS nome_autor, autor.autorid as id_autor, subcategoria.subcategoriaid as id_subcategoria, subcategoria.nome as nome_subcategoria, categoria.nome as nome_categoria, categoria.categoriaid as id_categoria
                            FROM autor
							RIGHT JOIN autorpublicacao
							ON autor.autorid = autorpublicacao.autorid 
							RIGHT JOIN publicacao
							ON autorpublicacao.publicacaoid = publicacao.publicacaoid 
							RIGHT JOIN editora
							ON editora.editoraid = publicacao.editoraid
                            RIGHT JOIN subcategoria
                            ON subcategoria.subcategoriaid = publicacao.subcategoriaid
                            RIGHT JOIN categoria
                            ON subcategoria.categoriaid = categoria.categoriaid
                            WHERE categoria.categoriaid = ? OR subcategoria.subcategoriaid = ?
                            ORDER BY publicacao.publicacaoid");
    $stmt->execute(array($categoriaid,$subcategoriaid));
    return $stmt->fetchAll();
}

function getPublicationDataSearchByCatOnly($categoriaid)
{
    global $conn;
    $stmt = $conn->prepare("SELECT publicacao.*, imagem.url, editora.nome AS nome_editora, autor.nome AS nome_autor, autor.autorid as id_autor, subcategoria.subcategoriaid as id_subcategoria, subcategoria.nome as nome_subcategoria, categoria.nome as nome_categoria, categoria.categoriaid as id_categoria
                            FROM autor
                            RIGHT JOIN autorpublicacao
                            ON autor.autorid = autorpublicacao.autorid 
                            RIGHT JOIN publicacao
                            ON autorpublicacao.publicacaoid = publicacao.publicacaoid 
                            RIGHT JOIN editora
                            ON editora.editoraid = publicacao.editoraid
                            RIGHT JOIN imagem
                            ON imagem.publicacaoid = publicacao.publicacaoid
                            RIGHT JOIN subcategoria
                            ON subcategoria.subcategoriaid = publicacao.subcategoriaid
                            RIGHT JOIN categoria
                            ON subcategoria.categoriaid = categoria.categoriaid
                            WHERE categoria.categoriaid = ? 
                            ORDER BY publicacao.publicacaoid");
    $stmt->execute(array($categoriaid));
    return $stmt->fetchAll();
}
function getPublicationDataSearchCat_AND($categoriaid, $subcategoriaid)
{
	global $conn;
    $stmt = $conn->prepare("SELECT publicacao.*, imagem.url, editora.nome AS nome_editora, autor.nome AS nome_autor, autor.autorid as id_autor, subcategoria.subcategoriaid as id_subcategoria, subcategoria.nome as nome_subcategoria, categoria.nome as nome_categoria, categoria.categoriaid as id_categoria
                            FROM autor
							RIGHT JOIN autorpublicacao
							ON autor.autorid = autorpublicacao.autorid 
							RIGHT JOIN publicacao
							ON autorpublicacao.publicacaoid = publicacao.publicacaoid 
							RIGHT JOIN editora
							ON editora.editoraid = publicacao.editoraid
							RIGHT JOIN imagem
							ON imagem.publicacaoid = publicacao.publicacaoid
                            RIGHT JOIN subcategoria
                            ON subcategoria.subcategoriaid = publicacao.subcategoriaid
                            RIGHT JOIN categoria
                            ON subcategoria.categoriaid = categoria.categoriaid
                            WHERE categoria.categoriaid = ? AND subcategoria.subcategoriaid = ?
                            ORDER BY publicacao.publicacaoid");
    $stmt->execute(array($categoriaid,$subcategoriaid));
    return $stmt->fetchAll();
}
function getPublicationDataSearchByCatOnly_promotion($categoriaid)
{
    global $conn;
    $stmt = $conn->prepare("SELECT publicacao.*, imagem.url, editora.nome AS nome_editora, autor.nome AS nome_autor, autor.autorid as id_autor, subcategoria.subcategoriaid as id_subcategoria, subcategoria.nome as nome_subcategoria, categoria.nome as nome_categoria, categoria.categoriaid as id_categoria
                            FROM autor
                            RIGHT JOIN autorpublicacao
                            ON autor.autorid = autorpublicacao.autorid 
                            RIGHT JOIN publicacao
                            ON autorpublicacao.publicacaoid = publicacao.publicacaoid 
                            RIGHT JOIN editora
                            ON editora.editoraid = publicacao.editoraid
                            RIGHT JOIN imagem
                            ON imagem.publicacaoid = publicacao.publicacaoid
                            RIGHT JOIN subcategoria
                            ON subcategoria.subcategoriaid = publicacao.subcategoriaid
                            RIGHT JOIN categoria
                            ON subcategoria.categoriaid = categoria.categoriaid
                            WHERE categoria.categoriaid = ? 
                            AND publicacao.precopromocional < publicacao.preco
                            ORDER BY publicacao.publicacaoid");
    $stmt->execute(array($categoriaid));
    return $stmt->fetchAll();
}
function getPublicationDataSearchCat_promotion($categoriaid, $subcategoriaid)
{
	global $conn;
    $stmt = $conn->prepare("SELECT publicacao.*, imagem.url, editora.nome AS nome_editora, autor.nome AS nome_autor, autor.autorid as id_autor, subcategoria.subcategoriaid as id_subcategoria, subcategoria.nome as nome_subcategoria, categoria.nome as nome_categoria, categoria.categoriaid as id_categoria
                            FROM autor
							RIGHT JOIN autorpublicacao
							ON autor.autorid = autorpublicacao.autorid 
							RIGHT JOIN publicacao
							ON autorpublicacao.publicacaoid = publicacao.publicacaoid 
							RIGHT JOIN editora
							ON editora.editoraid = publicacao.editoraid
							RIGHT JOIN imagem
							ON imagem.publicacaoid = publicacao.publicacaoid
                            RIGHT JOIN subcategoria
                            ON subcategoria.subcategoriaid = publicacao.subcategoriaid
                            RIGHT JOIN categoria
                            ON subcategoria.categoriaid = categoria.categoriaid
                            WHERE categoria.categoriaid = ? 
                            AND subcategoria.subcategoriaid = ?
                            AND publicacao.precopromocional < publicacao.preco
                            ORDER BY publicacao.publicacaoid");
    $stmt->execute(array($categoriaid,$subcategoriaid));
    return $stmt->fetchAll();
}
function getPublicationDataSearchCat_prom_minAndMaxPrice($categoriaid, $subcategoriaid, $min_price, $max_price)
{
	global $conn;
    $stmt = $conn->prepare("SELECT publicacao.*, imagem.url, editora.nome AS nome_editora, autor.nome AS nome_autor, autor.autorid as id_autor, subcategoria.subcategoriaid as id_subcategoria, subcategoria.nome as nome_subcategoria, categoria.nome as nome_categoria, categoria.categoriaid as id_categoria
                            FROM autor
							RIGHT JOIN autorpublicacao
							ON autor.autorid = autorpublicacao.autorid 
							RIGHT JOIN publicacao
							ON autorpublicacao.publicacaoid = publicacao.publicacaoid 
							RIGHT JOIN editora
							ON editora.editoraid = publicacao.editoraid
							RIGHT JOIN imagem
							ON imagem.publicacaoid = publicacao.publicacaoid
                            RIGHT JOIN subcategoria
                            ON subcategoria.subcategoriaid = publicacao.subcategoriaid
                            RIGHT JOIN categoria
                            ON subcategoria.categoriaid = categoria.categoriaid
                            WHERE categoria.categoriaid = ? 
                            AND subcategoria.subcategoriaid = ?
                            AND publicacao.precopromocional < publicacao.preco
                            AND (publicacao.preco >= ? AND publicacao.preco <= ?)
                            ORDER BY publicacao.publicacaoid");
    $stmt->execute(array($categoriaid,$subcategoriaid, $min_price, $max_price));
    return $stmt->fetchAll();
}

function getPublicationsBySubcategory($subcategory_name, $category_name)
{
	global $conn;
    $stmt = $conn->prepare("SELECT publicacao.*, imagem.url, editora.nome AS nome_editora, autor.nome AS nome_autor, autor.autorid as id_autor, subcategoria.subcategoriaid as id_subcategoria, subcategoria.nome as nome_subcategoria, categoria.nome as nome_categoria, categoria.categoriaid as id_categoria
                            FROM autor
							RIGHT JOIN autorpublicacao
							ON autor.autorid = autorpublicacao.autorid 
							RIGHT JOIN publicacao
							ON autorpublicacao.publicacaoid = publicacao.publicacaoid 
							RIGHT JOIN editora
							ON editora.editoraid = publicacao.editoraid 
							RIGHT JOIN imagem
							ON imagem.publicacaoid = publicacao.publicacaoid
                            RIGHT JOIN subcategoria
                            ON subcategoria.subcategoriaid = publicacao.subcategoriaid
                            RIGHT JOIN categoria
                            ON subcategoria.categoriaid = categoria.categoriaid
                            WHERE subcategoria.nome = ? AND categoria.nome = ?");
    $stmt->execute(array($subcategory_name, $category_name));
    return $stmt->fetchAll();
}

function getPublicationDataSearchPublicationNameAndSubcategory($nome_editora, $subcategoria)
{
	global $conn;
    $stmt = $conn->prepare("SELECT publicacao.*, editora.nome AS nome_editora, autor.nome AS nome_autor, autor.autorid as id_autor, subcategoria.subcategoriaid as id_subcategoria, subcategoria.nome as nome_subcategoria, categoria.nome as nome_categoria, categoria.categoriaid as id_categoria
                            FROM autor
							RIGHT JOIN autorpublicacao
							ON autor.autorid = autorpublicacao.autorid 
							RIGHT JOIN publicacao
							ON autorpublicacao.publicacaoid = publicacao.publicacaoid 
							RIGHT JOIN editora
							ON editora.editoraid = publicacao.editoraid
                            RIGHT JOIN subcategoria
                            ON subcategoria.subcategoriaid = publicacao.subcategoriaid
                            RIGHT JOIN categoria
                            ON subcategoria.categoriaid = categoria.categoriaid
                            WHERE (LOWER(editora.nome) like '%'||?||'%') AND subcategoria.subcategoriaid = ?
                            ORDER BY publicacao.publicacaoid");
    $stmt->execute(array(strtolower($nome_editora), $subcategoria));
    return $stmt->fetchAll();
}

function getAllSubCategorys(){
	global $conn;
    $stmt = $conn->prepare("SELECT subcategoria.*, categoria.nome as nome_categoria
							FROM subcategoria
							LEFT JOIN categoria
							ON subcategoria.categoriaid = categoria.categoriaid");
    $stmt->execute(array());
    return $stmt->fetchAll();
}

function getAllSubCategorysById($categoryId){
    global $conn;
    $stmt = $conn->prepare("SELECT subcategoria.*, categoria.nome as nome_categoria
                            FROM subcategoria
                            LEFT JOIN categoria
                            ON subcategoria.categoriaid = categoria.categoriaid
                            WHERE categoria.categoriaid = ? ");
    $stmt->execute(array($categoryId));
    return $stmt->fetchAll();
}

function getAllAutors(){
	global $conn;
    $stmt = $conn->prepare("SELECT autorid, nome
							FROM autor
							WHERE autorid != 6
							ORDER BY nome");
    $stmt->execute(array());
    return $stmt->fetchAll();
}

function verifyEditoraIfExists($nomeEditora){
	global $conn;

    $stmt = $conn->prepare("SELECT editoraid
                            FROM editora 
                            WHERE nome = ?");
    $stmt->execute(array($nomeEditora));
    $result = $stmt->fetch();

    if($result){
      $editoraID = $result['editoraid'];
    }
    else{
      $stmt = $conn->prepare("INSERT INTO editora (nome) VALUES (?)");
      $stmt->execute(array($nomeEditora));
      $editoraID = $conn->lastInsertId('editora_editoraid_seq');
    }
    return $editoraID;
}

function getAllCategorys(){
	global $conn;
    $stmt = $conn->prepare("SELECT *
							FROM categoria
							ORDER BY categoriaid");
    $stmt->execute(array());
    return $stmt->fetchAll();
}

function getAllSubCategorysByCategory($categoriaId){
	global $conn;
    $stmt = $conn->prepare("SELECT subcategoria.*
							FROM subcategoria
							JOIN categoria
							ON subcategoria.categoriaid = categoria.categoriaid
                            WHERE categoria.categoriaid = ?");
    $stmt->execute(array($categoriaId));
    return $stmt->fetchAll();
}

function getAllSubCategorysByCategoryName($categoria_nome){
	global $conn;
    $stmt = $conn->prepare("SELECT subcategoria.*
							FROM subcategoria
							JOIN categoria
							ON subcategoria.categoriaid = categoria.categoriaid
                            WHERE categoria.nome = ?");
    $stmt->execute(array($categoria_nome));
    return $stmt->fetchAll();
}

function getCategoryNameById($id){
	global $conn;
    $stmt = $conn->prepare("SELECT nome
							FROM categoria
                            WHERE categoriaid = ?");
    $stmt->execute(array($id));
    $result = $stmt->fetch();
    return $result['nome'];
}

function getCategoryIdByName($categoryname){
	global $conn;
    $stmt = $conn->prepare("SELECT categoriaid
							FROM categoria
                            WHERE nome = ?");
    $stmt->execute(array($categoryname));
    $result = $stmt->fetch();
    return $result['categoriaid'];
}

function getSubcategoryNameById($categoriaID,$subcategoriaID){
	global $conn;
	$stmt = $conn->prepare("SELECT subcategoria.nome
                            FROM subcategoria
                            JOIN categoria
                            ON subcategoria.categoriaid = categoria.categoriaid
                            WHERE subcategoria.subcategoriaid = ? AND categoria.categoriaid = ?");
    $stmt->execute(array($subcategoriaID, $categoriaID));
    $result = $stmt->fetch();
    return $result['nome'];
}

function getSubCategoryIdByName($subcategoryname, $categoriaid){
	global $conn;
    $stmt = $conn->prepare("SELECT subcategoriaid
							FROM subcategoria
                            WHERE nome = ? AND categoriaid = ? ");
    $stmt->execute(array($subcategoryname, $categoriaid));
    $result = $stmt->fetch();
    return $result['subcategoriaid'];
}

function createPublication($titulo, $descricao, $autorId, $editoraId, $subCategoriaId, $datapublicacao, $stock, $peso, $paginas, $preco, $precopromocional, $codigobarras, $novidade, $isbn, $edicao, $periodicidade, $block3, $block4){
	global $conn, $urlImagem;
	$conn->beginTransaction();

	try {
		//CHECK PUBLICACAO ALREADY EXISTS
		$stmt = $conn->prepare("SELECT *
								FROM publicacao 
								WHERE codigobarras = ?");
		$stmt->execute(array($codigobarras));
		$result = $stmt->fetch();

		if($result){
			die('Publicação já existe!');
		}
		else{
			$stmt = $conn->prepare("INSERT INTO publicacao (editoraid, subcategoriaid, titulo, datapublicacao, codigobarras, descricao, paginas, peso, preco, precopromocional, novidade, stock, edicao, periodicidade, isbn) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");


			$stmt->execute(array($editoraId, $subCategoriaId, $titulo, $datapublicacao, $codigobarras, $descricao, $paginas, $peso, $preco, $precopromocional, $novidade, $stock, $edicao, $periodicidade, $isbn));

			$publicacaoID = $conn->lastInsertId('publicacao_publicacaoid_seq');


			//need to create a new autorpublicacao values after insert a new publication
			$stmt = $conn->prepare("INSERT INTO autorpublicacao (publicacaoid, autorid) VALUES (?,?)");
			$stmt->execute(array($publicacaoID, $autorId));

    		//need to create a new imagem values after insert a new publication
			$urlImagem = "images/publications/" . $block3 . "/" . $block4 . "/" . $publicacaoID .".jpeg";

			$stmt = $conn->prepare("INSERT INTO imagem (publicacaoid, nome, url) VALUES (?,?,?)");
			$stmt->execute(array($publicacaoID, $titulo, $urlImagem));

		}
		$conn->commit();
		return $urlImagem;

	}catch(Exception $e){
		error_log($e->getMessage());
		$conn->rollBack();
		throw $e;
	}

}

function updateURL($publication_id, $titulo, $urlImagem){
	global $conn;

	$stmt = $conn->prepare("UPDATE imagem
	                     	SET url = ?, nome = ?
	                    	WHERE publicacaoid = ?");
	$stmt->execute(array($urlImagem, $titulo, $publication_id));
}

function updateAutorPublicacao($autorId, $publication_id){
	global $conn;

	$stmt = $conn->prepare("UPDATE autorpublicacao
	                     	SET autorid = ?
	                    	WHERE publicacaoid = ?");
	$stmt->execute(array($autorId, $publication_id));
}

function updateSubCategoryPublicacao($subCategoriaId, $publication_id){
	global $conn;

	$stmt = $conn->prepare("UPDATE publicacao
	                     	SET subcategoriaid = ?
	                    	WHERE publicacaoid = ?");
	$stmt->execute(array($subCategoriaId, $publication_id));
}


function updatePublication($titulo, $descricao, $editoraId, $datapublicacao, $stock, $peso, $paginas, $preco, $precopromocional, $codigobarras, $novidade, $isbn, $edicao, $periodicidade, $publication_id){
	global $conn;
	$conn->beginTransaction();

	try {
		$stmt = $conn->prepare("UPDATE publicacao
								SET editoraid = ?, titulo = ?, datapublicacao = ?, codigobarras = ?, descricao = ?, paginas = ?, peso = ?, preco = ?, precopromocional = ?, novidade = ?, stock = ?, edicao = ?, periodicidade = ?, isbn = ?
								WHERE publicacaoid = ?");


		$stmt->execute(array($editoraId, $titulo, $datapublicacao, $codigobarras, $descricao, $paginas, $peso, $preco, $precopromocional, $novidade, $stock, $edicao, $periodicidade, $isbn, $publication_id));

		$conn->commit();

	}catch(Exception $e){
		error_log($e->getMessage());
		$conn->rollBack();
		throw $e;
	}
}

function getNewPublications($number){
	
	global $conn;

    $stmt = $conn->prepare("SELECT publicacao.*, imagem.url, avg(comentario.classificacao) as classificacao, count(publicacaoencomenda.encomendaid) as numvendas
                            FROM publicacao
							LEFT JOIN imagem
							ON imagem.publicacaoid = publicacao.publicacaoid
							LEFT JOIN comentario
							ON comentario.publicacaoid = publicacao.publicacaoid
							LEFT JOIN publicacaoencomenda
							ON publicacaoencomenda.publicacaoid = publicacao.publicacaoid
                            WHERE publicacao.novidade = ?
                            GROUP BY publicacao.publicacaoid, imagem.url
                            ORDER BY random()
                            LIMIT ?");
    $stmt->execute(array(TRUE, $number));
	
	return $stmt->fetchAll();
}

function getMostSellPublications($number){
	
	global $conn;

    $stmt = $conn->prepare("SELECT publicacao.*, imagem.url, avg(comentario.classificacao) as classificacao, count(publicacaoencomenda.encomendaid) as numvendas
                            FROM publicacao
							LEFT JOIN imagem
							ON imagem.publicacaoid = publicacao.publicacaoid
							LEFT JOIN comentario
							ON comentario.publicacaoid = publicacao.publicacaoid
							LEFT JOIN publicacaoencomenda
							ON publicacaoencomenda.publicacaoid = publicacao.publicacaoid
                            GROUP BY publicacao.publicacaoid, imagem.url
                            ORDER BY numvendas DESC
                            LIMIT ?");
    $stmt->execute(array($number));
	
	return $stmt->fetchAll();
}

function getCommentedPublications($number){
	
	global $conn;

    $stmt = $conn->prepare("SELECT publicacao.*, imagem.url, comentario.texto, comentario.data, subcategoria.nome as nome_subcategoria, categoria.nome as nome_categoria, cliente.nome as nome_cliente, avg(comentario.classificacao) as classificacao, count(publicacaoencomenda.encomendaid) as numvendas, count(comentario.comentarioid) as comentarios
                            FROM publicacao
							LEFT JOIN imagem
							ON imagem.publicacaoid = publicacao.publicacaoid
							LEFT JOIN comentario
							ON comentario.publicacaoid = publicacao.publicacaoid
							LEFT JOIN publicacaoencomenda
							ON publicacaoencomenda.publicacaoid = publicacao.publicacaoid
							LEFT JOIN subcategoria
                            ON subcategoria.subcategoriaid = publicacao.subcategoriaid
                            LEFT JOIN categoria
                            ON subcategoria.categoriaid = categoria.categoriaid
                            LEFT JOIN cliente
                            ON cliente.clienteid = comentario.clienteid
                            GROUP BY publicacao.publicacaoid, imagem.url, comentario.texto, comentario.data, subcategoria.nome, categoria.nome, nome_cliente
                            HAVING count(comentario.comentarioid)>0
                            LIMIT ?");
    $stmt->execute(array($number));
	
	return $stmt->fetchAll();
}

function getRandomPublicationsBySubcategory($subcategory_name, $category_name, $number){
	
	global $conn;
    
    $stmt = $conn->prepare("SELECT publicacao.*, imagem.url, editora.nome AS nome_editora, autor.nome AS nome_autor, autor.autorid as id_autor, subcategoria.subcategoriaid as id_subcategoria, subcategoria.nome as nome_subcategoria, categoria.nome as nome_categoria, categoria.categoriaid as id_categoria
                            FROM autor
							RIGHT JOIN autorpublicacao
							ON autor.autorid = autorpublicacao.autorid 
							RIGHT JOIN publicacao
							ON autorpublicacao.publicacaoid = publicacao.publicacaoid 
							RIGHT JOIN editora
							ON editora.editoraid = publicacao.editoraid 
							RIGHT JOIN imagem
							ON imagem.publicacaoid = publicacao.publicacaoid
                            RIGHT JOIN subcategoria
                            ON subcategoria.subcategoriaid = publicacao.subcategoriaid
                            RIGHT JOIN categoria
                            ON subcategoria.categoriaid = categoria.categoriaid
                            WHERE subcategoria.nome = ? AND categoria.nome = ?
    						ORDER BY random()
                            LIMIT ?");

    $stmt->execute(array($subcategory_name, $category_name, $number));
    
    return $stmt->fetchAll();
}

function getRandomRecomendationPublications($subcategory_name, $category_name, $number, $id){
	
	global $conn;
    
    $stmt = $conn->prepare("SELECT * 
                            FROM (SELECT DISTINCT publicacao.*, imagem.url, subcategoria.subcategoriaid as id_subcategoria, subcategoria.nome as nome_subcategoria, categoria.nome as nome_categoria, categoria.categoriaid as id_categoria, avg(comentario.classificacao) as classificacao
                            FROM publicacao 
							RIGHT JOIN imagem
							ON imagem.publicacaoid = publicacao.publicacaoid
                            RIGHT JOIN subcategoria
                            ON subcategoria.subcategoriaid = publicacao.subcategoriaid
                            RIGHT JOIN categoria
                            ON subcategoria.categoriaid = categoria.categoriaid
                            LEFT JOIN comentario
                            ON comentario.publicacaoid = publicacao.publicacaoid
                            WHERE subcategoria.nome = ? AND categoria.nome = ? AND publicacao.publicacaoid != ?
    						GROUP BY publicacao.publicacaoid, imagem.url, comentario.texto, comentario.data, subcategoria.nome, categoria.nome, subcategoria.subcategoriaid, categoria.categoriaid) as foo
    						ORDER BY random()
                            LIMIT ?");

    $stmt->execute(array($subcategory_name, $category_name, $id, $number));
    
    return $stmt->fetchAll();
}

function getRandomPublications($number){
	
	global $conn;

    $stmt = $conn->prepare("SELECT publicacao.*, imagem.url, avg(comentario.classificacao) as classificacao
                            FROM publicacao
							LEFT JOIN imagem
							ON imagem.publicacaoid = publicacao.publicacaoid
							LEFT JOIN comentario
							ON comentario.publicacaoid = publicacao.publicacaoid
                            GROUP BY publicacao.publicacaoid, imagem.url
                            ORDER BY random()
                            LIMIT ?");
    $stmt->execute(array($number));
	
	return $stmt->fetchAll();
}

function getNPromotionalPublications($number){
	
	global $conn;

    $stmt = $conn->prepare("SELECT publicacao.*, imagem.url, avg(comentario.classificacao) as classificacao, count(publicacaoencomenda.encomendaid) as numvendas, autor.nome as nome_autor
                            FROM publicacao
							LEFT JOIN imagem
							ON imagem.publicacaoid = publicacao.publicacaoid
							LEFT JOIN comentario
							ON comentario.publicacaoid = publicacao.publicacaoid
							LEFT JOIN publicacaoencomenda
							ON publicacaoencomenda.publicacaoid = publicacao.publicacaoid
							LEFT JOIN autorpublicacao
							ON publicacao.publicacaoid = autorpublicacao.publicacaoid
							LEFT JOIN autor
							ON autor.autorid = autorpublicacao.autorid
                            WHERE publicacao.precopromocional < publicacao.preco
                            GROUP BY publicacao.publicacaoid, imagem.url, autor.nome
                            ORDER BY random()
                            LIMIT ?");
    $stmt->execute(array($number));
	
	return $stmt->fetchAll();
}

function primaveraGetProductInfo($id){
	global $PRIMAVERA_API;
				
	$url = $PRIMAVERA_API . 'artigos/' . $id;
		
	$ch = curl_init();
		
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		
	$output = curl_exec($ch);
		
	curl_close($ch);
		
	return json_decode($output,true);
}

function primaveraGetAllProducts(){
	global $PRIMAVERA_API;
		
	$url = $PRIMAVERA_API . 'artigos';
		
	$ch = curl_init();
		
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		
	$output = curl_exec($ch);
		
	curl_close($ch);
		
	return json_decode($output,true);
}

function getArmazensPublicacaoStock($publicationid){
	
	global $conn;

    $stmt = $conn->prepare("SELECT armazempublicacao.armazemid, armazempublicacao.stock
                            FROM armazempublicacao
                            WHERE armazempublicacao.publicacaoid = ?");
    $stmt->execute(array($publicationid));
	
	return $stmt->fetchAll();
}

function primavera_checkIfPublicationExists($primaveraid){
	global $conn;
	$stmt = $conn->prepare("SELECT 1
							FROM publicacao
							WHERE primaveraid = ?");
	$stmt->execute(array($primaveraid));

	return ($stmt->fetch() !== false);
}

function primavera_update_artigo($artigo){
	
	global $conn;
	
	$stmt = $conn->prepare("SELECT publicacaoid
							FROM publicacao
							WHERE primaveraid = ?");
	$stmt->execute(array($artigo['CodArtigo']));
	
	$publicacaoid = $stmt->fetch()['publicacaoid'];
	
	$stmt = $conn->prepare("SELECT categoriaid
							FROM categoria
							WHERE nome = ?");
	$stmt->execute(array($artigo['Categoria']));
	
	$categoriaid = $stmt->fetch()['categoriaid'];
	
	$stmt = $conn->prepare("SELECT subcategoriaid
							FROM subcategoria
							WHERE nome = ? AND categoriaid = ?");
	$stmt->execute(array($artigo['SubCategoria'], $categoriaid));
	
	$subcategoriaid = $stmt->fetch()['subcategoriaid'];
	
	$stmt = $conn->prepare("SELECT editoraid
							FROM editora
							WHERE nome = ?");
	$stmt->execute(array($artigo['Editora']));
	
	$editoraid = $stmt->fetch()['editoraid'];
	
	$stmt = $conn->prepare("SELECT autorid
							FROM autor
							WHERE nome = ?");
	$stmt->execute(array($artigo['Autor']));
	
	$autorid = $stmt->fetch()['autorid'];
	
	$stmt = $conn->prepare("UPDATE autorpublicacao
	                     	SET autorid = ?
	                    	WHERE publicacaoid = ?");
	$stmt->execute(array($autorid, $publicacaoid));
	
	$stmt = $conn->prepare("UPDATE publicacao
	                     	SET titulo = ?, descricao = ?, preco = ?, precopromocional = ?, subcategoriaid = ?, editoraid = ?
	                    	WHERE primaveraid = ?");
	$stmt->execute(array($artigo['Nome'], $artigo['DescArtigo'], $artigo['Preco'], $artigo['PrecoPromocional'], $subcategoriaid, $editoraid, $artigo['CodArtigo']));
}

function getAutorIDByName($autorname){
	
	global $conn;
	
	$stmt = $conn->prepare("SELECT autorid
							FROM autor
							WHERE nome = ?");
	$stmt->execute(array($autorname));
	
	return $stmt->fetch();
}

function createAutorOnlyWithName($autorname){
	
	global $conn;
	
	$stmt = $conn->prepare("INSERT INTO autor(nome)
							VALUES (?) ");
	$stmt->execute(array($autorname));
	
    $autorID = $conn->lastInsertId('autor_autorid_seq');
	
	return $autorID;
}
?>