<?php

function getAllOrders(){
  global $conn;
  $stmt = $conn->prepare("SELECT encomenda.*, cliente.nome as nomecliente, informacaofaturacao.*
                          FROM encomenda
                          JOIN cliente
                          ON cliente.clienteid = encomenda.clienteid
                          JOIN informacaofaturacao
                          ON informacaofaturacao.informacaofaturacaoid = encomenda.informacaofaturacaoid
                          ORDER BY encomenda.encomendaid");
  $stmt->execute();
  return $stmt->fetchAll();
}

function getBest5OrdersByDate($firstDate,$lastDate){
	global $conn;
	$stmt = $conn->prepare("SELECT encomenda.*, cliente.nome as nomecliente, informacaofaturacao.*
		                    FROM encomenda
		                    JOIN cliente
		                    ON cliente.clienteid = encomenda.clienteid
		                    JOIN informacaofaturacao
		                    ON informacaofaturacao.informacaofaturacaoid = encomenda.informacaofaturacaoid
							WHERE encomenda.data::date >= ? AND encomenda.data::date <= ?
		                    ORDER BY informacaofaturacao.total DESC
							LIMIT 5");
	$stmt->execute(array($firstDate,$lastDate));
	return $stmt->fetchAll();
}

function getBest5UsersOrdersByDate($firstDate,$lastDate){
	global $conn;
	$stmt = $conn->prepare("SELECT encomenda.clienteid, SUM(informacaofaturacao.total) AS total, cliente.nome AS nomeCliente
							FROM encomenda
							JOIN informacaofaturacao ON informacaofaturacao.informacaofaturacaoid = encomenda.informacaofaturacaoid
							JOIN cliente ON encomenda.clienteid = cliente.clienteid
							WHERE encomenda.data::date >= ? AND encomenda.data::date <= ?
							GROUP BY encomenda.clienteid, cliente.nome
							ORDER BY total desc
							LIMIT 5");
	$stmt->execute(array($firstDate,$lastDate));
	return $stmt->fetchAll();
}

function getBest5PublicationsOrdersByDate($firstDate,$lastDate){
	global $conn;
	$stmt = $conn->prepare("SELECT SUM(publicacaoencomenda.quantidade) AS quantidade, publicacao.titulo
							FROM publicacaoencomenda
							JOIN publicacao on publicacao.publicacaoid = publicacaoencomenda.publicacaoid
							JOIN encomenda on encomenda.encomendaid = publicacaoencomenda.encomendaid
							WHERE encomenda.data::date >= ? AND encomenda.data::date <= ?
							GROUP BY publicacao.titulo
							ORDER BY quantidade DESC, publicacao.titulo ASC
							LIMIT 5");
	$stmt->execute(array($firstDate,$lastDate));
	return $stmt->fetchAll();
}

function getCartsByDate($firstDate,$lastDate){
	global $conn;
	$stmt = $conn->prepare("SELECT *
							FROM carrinho
							WHERE datacriacao::date >= ? AND datacriacao::date <= ? ");
	$stmt->execute(array($firstDate,$lastDate));
	return $stmt->fetchAll();
}

function getTodayOrders($lastDate){
	global $conn;
	$stmt = $conn->prepare("SELECT encomenda.*, cliente.nome as nomecliente, informacaofaturacao.*
		                    FROM encomenda
		                    JOIN cliente
		                    ON cliente.clienteid = encomenda.clienteid
		                    JOIN informacaofaturacao
		                    ON informacaofaturacao.informacaofaturacaoid = encomenda.informacaofaturacaoid
							WHERE encomenda.data::date = ? 
		                    ORDER BY encomenda.encomendaid");
	$stmt->execute(array($lastDate));
	return $stmt->fetchAll();
}

function getLast5Orders($firstDate,$lastDate){
	global $conn;
	$stmt = $conn->prepare("SELECT encomenda.*, cliente.nome as nomecliente, informacaofaturacao.*, publicacao.titulo AS tituloPublicacao
							FROM encomenda
							JOIN cliente
							ON cliente.clienteid = encomenda.clienteid
							JOIN informacaofaturacao
							ON informacaofaturacao.informacaofaturacaoid = encomenda.informacaofaturacaoid
							JOIN publicacaoencomenda
							ON publicacaoencomenda.encomendaid = encomenda.encomendaid
							JOIN publicacao
							ON publicacao.publicacaoid = publicacaoencomenda.publicacaoid
							WHERE encomenda.data::date >= ? AND encomenda.data::date <= ?
							ORDER BY encomenda.data DESC
							LIMIT 5");
	$stmt->execute(array($firstDate,$lastDate));
	return $stmt->fetchAll();
}

function getOrderData($id)
{
	global $conn;
    $stmt = $conn->prepare("SELECT encomenda.*, cliente.nome as nomecliente, informacaofaturacao.*, publicacaoencomenda.*, morada.rua, codigopostal.*, localidade.nome as nome_localidade, pais.nome as nome_pais, publicacao.titulo, publicacao.publicacaoid, metodopagamento.tipo as metodopagamento
							FROM encomenda
							LEFT JOIN informacaofaturacao
							ON informacaofaturacao.informacaofaturacaoid = encomenda.informacaofaturacaoid
							LEFT JOIN publicacaoencomenda
							ON publicacaoencomenda.encomendaid = encomenda.encomendaid
							LEFT JOIN publicacao
							ON publicacao.publicacaoid = publicacaoencomenda.publicacaoid
							LEFT JOIN moradaenvio
							ON moradaenvio.moradaid = encomenda.moradaenvioid
							LEFT JOIN morada
							ON morada.moradaid = moradaenvio.moradaid
							LEFT JOIN codigopostal
							ON codigopostal.codigopostalid = morada.codigopostalid
							LEFT JOIN localidade
							ON localidade.localidadeid = codigopostal.localidadeid
							LEFT JOIN pais
							ON pais.paisid = localidade.paisid
							LEFT JOIN cliente
							ON cliente.clienteid = encomenda.clienteid
							LEFT JOIN metodopagamento
							ON informacaofaturacao.metodopagamentoid = metodopagamento.metodopagamentoid
							WHERE encomenda.encomendaid = ?");
    $stmt->execute(array($id));
    return $stmt->fetchAll();
}

function getOrderFactAddData($id)
{
	global $conn;
    $stmt = $conn->prepare("SELECT morada.rua, codigopostal.*, localidade.nome as nome_localidade, pais.nome as nome_pais
							FROM encomenda
							LEFT JOIN moradafaturacao
							ON moradafaturacao.moradaid = encomenda.moradafaturacaoid
							LEFT JOIN morada
							ON morada.moradaid = moradafaturacao.moradaid
							LEFT JOIN codigopostal
							ON codigopostal.codigopostalid = morada.codigopostalid
							LEFT JOIN localidade
							ON localidade.localidadeid = codigopostal.localidadeid
							LEFT JOIN pais
							ON pais.paisid = localidade.paisid
							WHERE encomenda.encomendaid = ?");
    $stmt->execute(array($id));
    return $stmt->fetchAll();
}

function getOrderStatus($id){
	global $conn;
    $stmt = $conn->prepare("SELECT estado
							FROM encomenda
							WHERE encomendaid = ?");
    $stmt->execute(array($id));
    return $stmt->fetch();
}

function updateOrderStatus($id, $estado){
	global $conn;

	//check if id exists
	$stmt = $conn->prepare("SELECT *
							FROM encomenda
							WHERE encomendaid = ?");
    $stmt->execute(array($id));
    $result = $stmt->fetch();

    if(!$result){
      	die('Encomenda não existe');
    }
    else{
		$stmt = $conn->prepare("UPDATE encomenda
			                    SET estado = ?
			                    WHERE encomendaid = ?");
		$stmt->execute(array($estado, $id));
	}
}

function getOrdersByClientName($nome_cliente){
	global $conn;
	$stmt = $conn->prepare("SELECT encomenda.*, cliente.nome AS nomecliente, cliente.email AS email_cliente, informacaofaturacao.*
                        	FROM encomenda
                        	JOIN cliente
                        	ON cliente.clienteid = encomenda.clienteid
							JOIN informacaofaturacao
							ON informacaofaturacao.informacaofaturacaoid = encomenda.informacaofaturacaoid
            				WHERE LOWER(cliente.nome) like '%'||?||'%'
            				ORDER BY encomenda.encomendaid");
    $stmt->execute(array(strtolower($nome_cliente)));
    return $stmt->fetchAll();
}

function getOrdersByClientId($id){
	global $conn;
	$stmt = $conn->prepare("SELECT encomenda.*, cliente.nome AS nomecliente, cliente.email AS email_cliente, informacaofaturacao.*
                        	FROM encomenda
                        	JOIN cliente
                        	ON cliente.clienteid = encomenda.clienteid
							JOIN informacaofaturacao
							ON informacaofaturacao.informacaofaturacaoid = encomenda.informacaofaturacaoid
            				WHERE cliente.clienteid = ?
            				ORDER BY encomenda.encomendaid");
    $stmt->execute(array($id));
    return $stmt->fetchAll();
}

function getOrdersByClientEmail($email_cliente){
	global $conn;
	$stmt = $conn->prepare("SELECT encomenda.*, cliente.nome AS nomecliente, cliente.email AS email_cliente, informacaofaturacao.*
                        	FROM encomenda
                        	JOIN cliente
                        	ON cliente.clienteid = encomenda.clienteid
							JOIN informacaofaturacao
							ON informacaofaturacao.informacaofaturacaoid = encomenda.informacaofaturacaoid
            				WHERE LOWER(cliente.email) = ?
            				ORDER BY encomenda.encomendaid");
    $stmt->execute(array(strtolower($email_cliente)));
    return $stmt->fetchAll();
}

function getOrdersByOrderId($id_encomenda){
	global $conn;
	$stmt = $conn->prepare("SELECT encomenda.*, cliente.nome AS nomecliente, cliente.email AS email_cliente, informacaofaturacao.*
                        	FROM encomenda
                        	JOIN cliente
                        	ON cliente.clienteid = encomenda.clienteid
							JOIN informacaofaturacao
							ON informacaofaturacao.informacaofaturacaoid = encomenda.informacaofaturacaoid
            				WHERE encomenda.encomendaid = ?
            				ORDER BY encomenda.encomendaid");
    $stmt->execute(array($id_encomenda));
    return $stmt->fetchAll();
}

function getOrdersByStatus($estadoencomenda){
	global $conn;
	$stmt = $conn->prepare("SELECT encomenda.*, cliente.nome as nomecliente, cliente.email as email_cliente, informacaofaturacao.*
                        	FROM encomenda
                        	JOIN cliente
                        	ON cliente.clienteid = encomenda.clienteid
                        	JOIN informacaofaturacao
                        	ON informacaofaturacao.informacaofaturacaoid = encomenda.informacaofaturacaoid
							WHERE encomenda.estado = ?
							ORDER BY encomenda.encomendaid");
    $stmt->execute(array($estadoencomenda));
    return $stmt->fetchAll();
}

function getOrdersByClientNameAndStatus($nome_cliente, $estadoencomenda){
	global $conn;
	$stmt = $conn->prepare("SELECT encomenda.*, cliente.nome as nomecliente, cliente.email as email_cliente, informacaofaturacao.*
                        	FROM encomenda
                        	JOIN cliente
                        	ON cliente.clienteid = encomenda.clienteid
                        	JOIN informacaofaturacao
                        	ON informacaofaturacao.informacaofaturacaoid = encomenda.informacaofaturacaoid
							WHERE LOWER(cliente.nome) like '%'||?||'%' AND encomenda.estado = ?
							ORDER BY encomenda.encomendaid");
    $stmt->execute(array(strtolower($nome_cliente), $estadoencomenda));
    return $stmt->fetchAll();
}

function getOrdersByClientEmailAndStatus($email_cliente, $estadoencomenda){
	global $conn;
	$stmt = $conn->prepare("SELECT encomenda.*, cliente.nome as nomecliente, cliente.email as email_cliente, informacaofaturacao.*
                        	FROM encomenda
                        	JOIN cliente
                        	ON cliente.clienteid = encomenda.clienteid
                        	JOIN informacaofaturacao
                        	ON informacaofaturacao.informacaofaturacaoid = encomenda.informacaofaturacaoid
							WHERE LOWER(cliente.email) = ? AND encomenda.estado = ?
							ORDER BY encomenda.encomendaid");
    $stmt->execute(array(strtolower($email_cliente), $estadoencomenda));
    return $stmt->fetchAll();
}

function getOrderPublications($order_id){

	global $conn;
    
    $stmt = $conn->prepare("SELECT encomenda.*, informacaofaturacao.*, publicacaoencomenda.*, publicacao.titulo, publicacao.publicacaoid, imagem.url,informacaofaturacao.total
							FROM encomenda
							LEFT JOIN informacaofaturacao
							ON informacaofaturacao.informacaofaturacaoid = encomenda.informacaofaturacaoid
							LEFT JOIN publicacaoencomenda
							ON publicacaoencomenda.encomendaid = encomenda.encomendaid
							LEFT JOIN publicacao
							ON publicacao.publicacaoid = publicacaoencomenda.publicacaoid
							LEFT JOIN imagem
							ON imagem.publicacaoid = publicacao.publicacaoid
							WHERE encomenda.encomendaid = ?");
    
    $stmt->execute(array($order_id));
    
    return $stmt->fetchAll();
}

function checkIfOrderExists($order_id){
	global $conn;
	$stmt = $conn->prepare("SELECT encomendaid
							FROM encomenda
							WHERE encomendaid = ?");
	$stmt->execute(array($order_id));

	return ($stmt->fetch() !== false);
}

function primaveraGetClientOrders(){
	global $PRIMAVERA_API;
		
	$user_id = $_SESSION['userid'];
		
	$url = $PRIMAVERA_API . 'DocVenda/' . $user_id;
		
	$ch = curl_init();
		
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		
	$output = curl_exec($ch);
		
	curl_close($ch);
		
	return json_decode($output,true);
}

function set_primaverafatura_id($docserie, $numdoc, $numdocorigem, $estado){
	global $conn;
	$stmt = $conn->prepare("UPDATE encomenda
							SET primaverafaturaserie = ?, primaverafaturaid = ?, estado = ?
							WHERE primaveraencomendaid = ?");
	$stmt->execute(array($docserie, $numdoc, $estado, $numdocorigem));
}

function set_primaverarecibo_id($docserie, $numdoc, $numdocorigem, $estado){
	global $conn;
	$stmt = $conn->prepare("UPDATE encomenda
							SET primaverareciboserie = ?, primaverareciboid = ?, estado = ?
							WHERE primaverafaturaid = ?");
	$stmt->execute(array($docserie, $numdoc, $estado, $numdocorigem));
}

function set_primaveranotacredito_id($docserie, $numdoc, $numdocorigem, $estado){
	global $conn;
	$stmt = $conn->prepare("UPDATE encomenda
							SET primaveranotacreditoserie = ?, primaveranotacreditoid = ?, estado = ?
							WHERE primaverafaturaid = ?");
	$stmt->execute(array($docserie, $numdoc, $estado, $numdocorigem));
}

function get_clientid_by_orderid($orderid){
	global $conn;
	$stmt = $conn->prepare("SELECT clienteid
							FROM encomenda
							WHERE primaveraencomendaid = ?");
	$stmt->execute(array($orderid));
	
	return $stmt->fetch()['clienteid'];
}

function get_client_by_invoiceid($orderid){
	global $conn;
	$stmt = $conn->prepare("SELECT clienteid
							FROM encomenda
							WHERE primaverafaturaid = ?");
	$stmt->execute(array($orderid));
	
	return $stmt->fetch()['clienteid'];
}
?>
