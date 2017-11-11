<?php

//CREATE USER
function createUser($nome, $genero, $diaNasc, $mesNasc, $anoNasc, $morada, $localidade, $cod1, $cod2, $pais, $telefone, $email, $nif, $username, $password) {
  global $conn;
  $conn->beginTransaction();
  try{
    
    //CHECK LOCALIDADE ALREADY EXISTS
    $stmt = $conn->prepare("SELECT *
                            FROM localidade 
                            WHERE nome = ?");
    $stmt->execute(array($localidade));
    $result = $stmt->fetch();
    
    if($result){
      $localidadeID = $result['localidadeid'];
    }
    else{
      //INSERT INTO LOCALIDADE
      $stmt = $conn->prepare("INSERT INTO localidade (paisid, nome) VALUES (?, ?)");
      $stmt->execute(array($pais, $localidade));
      $localidadeID = $conn->lastInsertId('localidade_localidadeid_seq');
    }
    //CHECK CODIGO_POSTAL ALREADY EXISTS
    $stmt = $conn->prepare("SELECT *
                            FROM codigopostal 
                            WHERE cod1 = ? AND cod2 = ?");
    $stmt->execute(array($cod1, $cod2));
    $result = $stmt->fetch();
    
    if($result){
      $codPostalID = $result['codigopostalid'];
    }
    else{
      //INSERT INTO CODIGO_POSTAL
      $stmt = $conn->prepare("INSERT INTO codigopostal (localidadeid, cod1, cod2) VALUES (?, ?, ?)");
      $stmt->execute(array($localidadeID, $cod1, $cod2));
      $codPostalID = $conn->lastInsertId('codigopostal_codigopostalid_seq');
    }
      //INSERT INTO CLIENTE
    $stmt = $conn->prepare("INSERT INTO cliente (paisid, nome, genero, datanascimento, username, password, telefone, email, nif) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $datanasc = sprintf("%02d/%02d/%04d",$diaNasc,$mesNasc,$anoNasc);
    $stmt->execute(array($pais, $nome, $genero, $datanasc, $username, sha1($password), $telefone, $email, $nif));
    $clienteID = $conn->lastInsertId('cliente_clienteid_seq');
    //INSERT INTO MORADA
    $stmt = $conn->prepare("INSERT INTO morada (codigopostalid, rua) VALUES (?, ?)");
    $stmt->execute(array($codPostalID, $morada));
    $moradaID = $conn->lastInsertId('morada_moradaid_seq');
    //INSERT INTO MORADA_FATURACAO
    $stmt = $conn->prepare("INSERT INTO moradafaturacao (moradaid, clienteid) VALUES (?, ?)");
    $stmt->execute(array($moradaID, $clienteID));
      //INSERT INTO MORADA_ENVIO
    $stmt = $conn->prepare("INSERT INTO moradaenvio (moradaid, clienteid) VALUES (?, ?)");
    $stmt->execute(array($moradaID, $clienteID));
    $defaultwishlist = 'wishlist';
    //INSERT INTO WISHLIST
    $stmt = $conn->prepare("INSERT INTO wishlist (clienteid, nome) VALUES (?, ?)");
    $stmt->execute(array($clienteID, $defaultwishlist));
    $conn->commit();
  }catch(Exception $e){
    error_log($e->getMessage());
    $conn->rollBack();
    throw $e;
  }
}

//CREATE AUTOR
function createAutor($paisId, $nomeAutor, $genero, $datanascimento, $biografia){
  global $conn;

  $conn->beginTransaction();

  try{

    //CHECK AUTOR ALREADY EXISTS
    $stmt = $conn->prepare("SELECT *
                            FROM autor 
                            WHERE nome = ? AND datanascimento = ?");
    $stmt->execute(array($nomeAutor, $datanascimento));
    $result = $stmt->fetch();

      //INSERT INTO AUTOR
    $stmt = $conn->prepare("INSERT INTO autor (paisid, nome, genero, datanascimento, biografia) VALUES (?, ?, ?, ?, ?)");

    $stmt->execute(array($paisId, $nomeAutor, $genero, $datanascimento, $biografia));

    $autorID = $conn->lastInsertId('autor_autorid_seq');
    

    $conn->commit();

    return $autorID;
  }catch(Exception $e){

    error_log($e->getMessage());

    $conn->rollBack();

    throw $e;
  }
}

//LOGIN VERIFICATION
function isClientLoginCorrect($username, $password) {

  global $conn;
  
  $stmt = $conn->prepare("SELECT * 
                          FROM cliente 
                          WHERE username = ? AND password = ?");
  
  $stmt->execute(array($username, sha1($password)));
  
  return $stmt->fetch() == true;
}

function isOwnerLoginCorrect($username, $password) {

  global $conn;
  
  $stmt = $conn->prepare("SELECT * 
                          FROM funcionario 
                          WHERE username = ? AND password = ?");
  
  $stmt->execute(array($username, sha1($password)));
  
  return $stmt->fetch() == true;
}

function isAdminLoginCorrect($username, $password) {

  global $conn;
  
  $stmt = $conn->prepare("SELECT * 
                          FROM administrador 
                          WHERE username = ? AND password = ?");
  
  $stmt->execute(array($username, sha1($password)));
  
  return $stmt->fetch() == true;
}

//GET USER DATA

function getUserDataById($id) {

  global $conn;

  $stmt = $conn->prepare("SELECT cliente.*, pais.nome
                          FROM cliente
						  JOIN pais
						  ON cliente.paisid = pais.paisid
                          WHERE ClienteID = ?");

  $stmt->execute(array($id));

  return $stmt->fetch();
}

function getUserData($username) {

  global $conn;

  $stmt = $conn->prepare("SELECT * 
                          FROM cliente
                          WHERE username = ?");

  $stmt->execute(array($username));

  return $stmt->fetchAll();
}

function getWorkerData($username) {

  global $conn;

  $stmt = $conn->prepare("SELECT * 
                          FROM funcionario
                          WHERE username = ?");

  $stmt->execute(array($username));

  return $stmt->fetchAll();
}

function getAdminData($username) {

  global $conn;

  $stmt = $conn->prepare("SELECT * 
                          FROM administrador
                          WHERE username = ?");

  $stmt->execute(array($username));

  return $stmt->fetchAll();
}

//GET USER ORDER LIST
function getUserOrderList($clienteid) {

  global $conn;

  $stmt = $conn->prepare("SELECT encomenda.encomendaid, encomenda.primaveraencomendaid, encomenda.clienteid, encomenda.moradafaturacaoid, encomenda.moradaenvioid, encomenda.informacaofaturacaoid, encomenda.data, informacaofaturacao.portes, informacaofaturacao.total, metodopagamento.tipo, morada.*, codigopostal.*, localidade.nome 
                          FROM informacaofaturacao
                          RIGHT JOIN encomenda
                          ON informacaofaturacao.informacaofaturacaoid = encomenda.informacaofaturacaoid
                          LEFT JOIN metodopagamento
                          ON informacaofaturacao.metodopagamentoid = metodopagamento.metodopagamentoid
                          LEFT JOIN morada
                          ON morada.moradaid = encomenda.moradafaturacaoid
                          LEFT JOIN codigopostal
                          ON morada.codigopostalid = codigopostal.codigopostalid
                          LEFT JOIN localidade
                          ON localidade.localidadeid = codigopostal.localidadeid
                          WHERE encomenda.clienteid = ?");

  $stmt->execute(array($clienteid));

  return $stmt->fetchAll();
}

//GET USER ORDER LIST
function checkUserHasOrder($clienteid, $encomendaid) {

  global $conn;

  $stmt = $conn->prepare("SELECT encomenda.* 
                          FROM encomenda
                          WHERE encomenda.clienteid = ? AND encomenda.encomendaid = ?");

  $stmt->execute(array($clienteid, $encomendaid));

  return ($stmt->fetch() !== false);
}

//GET USER PUBLICATIONS ON CART
function getUserPublicationsCart($clienteid) {

  global $conn;
  
  $stmt = $conn->prepare("SELECT publicacao.publicacaoid, publicacao.primaveraid, publicacao.titulo, publicacaocarrinho.quantidade, publicacao.preco, imagem.url, subcategoria.nome AS nome_subcategoria, categoria.nome AS nome_categoria
                          FROM cliente
                          JOIN carrinho
                          ON cliente.carrinhoid = carrinho.carrinhoid 
                          JOIN publicacaocarrinho
                          ON publicacaocarrinho.carrinhoid = carrinho.carrinhoid 
                          JOIN publicacao
                          ON publicacao.publicacaoid = publicacaocarrinho.publicacaoid 
                          JOIN imagem
                          ON imagem.publicacaoid = publicacaocarrinho.publicacaoid
                          JOIN subcategoria
                          ON publicacao.subcategoriaid = subcategoria.subcategoriaid 
                          JOIN categoria
                          ON categoria.categoriaid = subcategoria.categoriaid
                          WHERE cliente.clienteid = ?");
  
  $stmt->execute(array($clienteid));
  
  return $stmt->fetchAll();
}

//GET USER CART SUBTOTAL
function getUserCartSubtotal($clienteid) {

  global $conn;
  
  $stmt = $conn->prepare("SELECT subtotal
                          FROM carrinho
                          WHERE carrinhoid = ?");
  
  $stmt->execute(array($clienteid));
  
  return $stmt->fetchAll();
}

//INSERT PUBLICATION ON CART
function insertCartPublication($carrinhoid, $publicacaoid, $quantidade) {

  global $conn;
  
  $stmt = $conn->prepare("INSERT INTO publicacaocarrinho
                          VALUES (?, ?, ?)");
  
  $stmt->execute(array($publicacaoid, $carrinhoid, $quantidade));
}

//UPDATE QUANTITY ON PUBLICATION CART
function updateCartItems($carrinhoid, $publicacaoid, $quantidade) {

  global $conn;
  
  $stmt = $conn->prepare("UPDATE publicacaocarrinho
                          SET quantidade = ?
                          WHERE carrinhoid = ? AND publicacaoid = ?");
  
  $stmt->execute(array($quantidade, $carrinhoid, $publicacaoid));
}

//REMOVE PUBLICATION FROM CART
function removeCartItem($carrinhoid, $publicacaoid) {

  global $conn;
  
  $stmt = $conn->prepare("DELETE FROM publicacaocarrinho
                          WHERE carrinhoid = ? AND publicacaoid = ?");
  
  $stmt->execute(array($carrinhoid, $publicacaoid));
}

//PUBLICATION ON CART VERIFICATION
function isPublicationOnCart($carrinhoid, $publicacaoid) {

  global $conn;
  
  $stmt = $conn->prepare("SELECT * 
                          FROM publicacaocarrinho 
                          WHERE publicacaoid = ? AND carrinhoid = ?");
  
  $stmt->execute(array($publicacaoid, $carrinhoid));
  
  return $stmt->fetch() == true;
}

//GET PUBLICATIONS ON WISHLIST
function getUserPublicationsWishList($clienteid) {

  global $conn;
  
  $stmt = $conn->prepare("SELECT cliente.clienteid, publicacao.publicacaoid, publicacao.titulo, publicacao.preco, imagem.url, subcategoria.nome AS nome_subcategoria, categoria.nome AS nome_categoria
                          FROM wishlist
                          JOIN cliente
                          ON wishlist.clienteid = cliente.clienteid 
                          JOIN publicacaowishlist
                          ON publicacaowishlist.wishlistid = wishlist.wishlistid 
                          JOIN publicacao
                          ON publicacao.publicacaoid = publicacaowishlist.publicacaoid 
                          JOIN imagem
                          ON imagem.publicacaoid = publicacao.publicacaoid
                          JOIN subcategoria
                          ON publicacao.subcategoriaid = subcategoria.subcategoriaid 
                          JOIN categoria
                          ON categoria.categoriaid = subcategoria.categoriaid
                          WHERE cliente.clienteid = ?");
  
  $stmt->execute(array($clienteid));
  
  return $stmt->fetchAll();
}

//INSERT PUBLICATION ON WISHLIST
function insertPublicationWishList($clienteid, $publicacaoid) {

  global $conn;
  
  $stmt = $conn->prepare("INSERT INTO publicacaowishlist
                          VALUES ((SELECT wishlist.wishlistid
                          FROM wishlist
                          WHERE wishlist.clienteid = ?), ?)");
  
  $stmt->execute(array($clienteid, $publicacaoid));
}

//REMOVE PUBLICATION FROM WISHLIST
function removePublicationWishList($clienteid, $publicacaoid) {

  global $conn;
  
  $stmt = $conn->prepare("DELETE FROM publicacaowishlist
                          WHERE publicacaowishlist.publicacaoid = ? AND publicacaowishlist.wishlistid = (SELECT wishlist.wishlistid
                          FROM wishlist
                          WHERE wishlist.clienteid = ?)");
  
  $stmt->execute(array($publicacaoid, $clienteid));
}

//MOVE PUBLICATION FROM WISHLIST TO CART
function movePublicationWishListToCart($clienteid, $publicacaoid, $quantidade) {

  global $conn;
  
  $conn->beginTransaction();

  try{

    //INSERT PUBLICATION ON CART
    $stmt = $conn->prepare("INSERT INTO publicacaocarrinho
      VALUES (?, ?, ?)");
    $stmt->execute(array($publicacaoid, $clienteid, $quantidade));

    //REMOVE PUBLICATION FROM WISHLIST
    $stmt = $conn->prepare("DELETE FROM publicacaowishlist
                            WHERE publicacaowishlist.publicacaoid = ? AND publicacaowishlist.wishlistid = (SELECT wishlist.wishlistid
                            FROM wishlist
                            WHERE wishlist.clienteid = ?)");
    $stmt->execute(array($publicacaoid, $clienteid));

    $conn->commit();
  }catch(Exception $e){

    error_log($e->getMessage());

    $conn->rollBack();

    throw $e;
  }
}

//GET ALL CLIENTS
function getAllUsers(){
  global $conn;
  
  $stmt = $conn->prepare("SELECT * 
                          FROM cliente
                          ORDER BY cliente.clienteid");
  $stmt->execute();
  
  return $stmt->fetchAll();
}

function getUserAllData($username) {
  global $conn;

  $stmt = $conn->prepare("SELECT cliente.*, cliente.clienteid as cliente_id, morada.rua, codigopostal.*, pais.paisid, pais.nome AS nomePais, localidade.localidadeid, localidade.nome AS nomeLocalidade, cartaocreditocliente.numero as numerocartao, cartaocreditocliente.*
    FROM cliente
    LEFT JOIN moradafaturacao
    ON moradafaturacao.clienteid = cliente.clienteid
    LEFT JOIN morada
    ON moradafaturacao.moradaid = morada.moradaid
    LEFT JOIN codigopostal
    ON  codigopostal.codigopostalid = morada.codigopostalid
    LEFT JOIN localidade
    ON localidade.localidadeid = codigopostal.localidadeid
    LEFT JOIN pais
    ON pais.paisid = localidade.paisid
    LEFT JOIN cartaocreditocliente
    ON cartaocreditocliente.clienteid = cliente.clienteid
    WHERE cliente.username = ?");
  $stmt->execute(array($username));

  return $stmt->fetchAll();
}

//CLIENT STATUS VERIFICATION
function getClientStatus($username){
  global $conn;
  $stmt = $conn->prepare("SELECT ativo
                          FROM cliente
                          WHERE username = ?");
  $stmt->execute(array($username));
  return $stmt->fetch();
}

//UPDATE CLIENT STATUS
function updateClientStatus($username, $estado){
  global $conn;

  if ($estado == "FALSE") {
    $currentDate = date('Y-m-d H:i:s');
    $stmt = $conn->prepare("UPDATE cliente
                            SET datacancelamento = ?, ativo = ?
                            WHERE username = ?");
    $stmt->execute(array($currentDate, $estado, $username));
  } else {
    $datacancelamento = NULL;
    $stmt = $conn->prepare("UPDATE cliente
                            SET datacancelamento = ?, ativo = ?
                            WHERE username = ?");
    $stmt->execute(array($datacancelamento, $estado, $username));
  }

  $stmt = $conn->prepare("UPDATE cliente
                          SET ativo = ? 
                          WHERE username = ?");
  $stmt->execute(array($estado, $username));
}

//PAIS EXIST VERIFICATION
function verifyPaisIfExists($nomePais){
  global $conn;

  $stmt = $conn->prepare("SELECT *
                          FROM pais 
                          WHERE nome = ?");
  $stmt->execute(array($nomePais));
  $result = $stmt->fetch();

  if($result){
    $paisID = $result['paisid'];
  }
  else{
    $stmt = $conn->prepare("INSERT INTO pais (nome) 
      VALUES (?)");
    $stmt->execute(array($nomePais));
    $paisID = $conn->lastInsertId('pais_paisid_seq');
  }
  return $paisID;
}

//UPDATE CLIENT INFORMATION

function primavera_update_user($user_data, $clienteID){
  global $PRIMAVERA_API;
    
  $data['CodCliente'] = $user_data[0]['cliente_id'];	
  $data['NomeCliente'] = $user_data[0]['nome'];
  $data['Morada'] = $user_data[0]['rua']; 
  $data['NumContribuinte'] = $user_data[0]['nif'];
  $data['Email'] = $user_data[0]['email'];
  $data['Pais'] = $user_data[0]['nomepais'];
  $data['Localidade'] = $user_data[0]['nomelocalidade'];
  
  $cod1 = $user_data[0]['cod1'];
  $cod2 = $user_data[0]['cod2'];
  $codigoPostal = $cod1 . '-' . $cod2;
  
  $content = json_encode($data);
  $url = $PRIMAVERA_API . 'clientes/' . $clienteID;  
  
  $ch = curl_init($url);
  curl_setopt($ch, CURLOPT_HEADER, false);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($ch, CURLOPT_HTTPHEADER, array("Content-type: application/json"));
  curl_setopt($ch, CURLOPT_POST, true);
  curl_setopt($ch, CURLOPT_POSTFIELDS, $content);
  $json_response = curl_exec($ch);
  $status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
  error_log($url);
  error_log($status);
  error_log(json_decode($json_response, true));
  
  curl_close($ch);    
}


function updateUserInformation($username, $userdata, $newuserinformation) {

  global $conn;

  $conn->beginTransaction();

  try{

    $paisID = $userdata[0]['paisid'];
    $pais = $newuserinformation['pais']; 

    if (!($userdata[0]['nomepais'] === $pais)) {
      //CHECK PAIS ALREADY EXISTS
      $stmt = $conn->prepare("SELECT *
                              FROM pais 
                              WHERE nome = ?");
      $stmt->execute(array($pais));
      $result = $stmt->fetch();

      if($result){
        $paisID = $result['paisid'];
      }
      else{
      //INSERT INTO PAIS
        $stmt = $conn->prepare("INSERT INTO pais (nome) 
          VALUES (?)");
        $stmt->execute(array($pais));
        $paisID = $conn->lastInsertId('pais_paisid_seq');
      }

      //UPDATE INTO PAIS
      $stmt = $conn->prepare("UPDATE cliente
                              SET paisid = ? 
                              WHERE username = ?");
      $stmt->execute(array($paisID, $username));

    }
    
    $localidade = $newuserinformation['localidade'];
    $localidadeID = $userdata[0]['localidadeid'];

    if (!($userdata[0]['nomelocalidade'] === $localidade)) {

      //CHECK LOCALIDADE ALREADY EXISTS
      $stmt = $conn->prepare("SELECT *
                              FROM localidade 
                              WHERE nome = ?");
      $stmt->execute(array($localidade));
      $result = $stmt->fetch();

      if($result){
        $localidadeID = $result['localidadeid'];
      }
      else{
      //INSERT INTO LOCALIDADE
        $stmt = $conn->prepare("INSERT INTO localidade (paisid, nome) 
          VALUES (?, ?)");
        $stmt->execute(array($paisID, $localidade));
        $localidadeID = $conn->lastInsertId('localidade_localidadeid_seq');
      }

      //GET CODPOSTAL ID
      $stmt = $conn->prepare("SELECT codigopostal.codigopostalid, cliente.clienteid
                              FROM moradaenvio
                              JOIN morada
                              ON moradaenvio.moradaid = morada.moradaid 
                              JOIN cliente
                              ON moradaenvio.clienteid = cliente.clienteid 
                              JOIN codigopostal
                              ON morada.codigopostalid = codigopostal.codigopostalid
                              WHERE cliente.username = ?");
      $stmt->execute(array($username));
      $result = $stmt->fetch();

      $codPostalID = $result['codigopostalid'];

      //UPDATE INTO CODPOSTAL
      $stmt = $conn->prepare("UPDATE codigopostal
                              SET localidadeid = ? 
                              WHERE codigopostalid = ?");
      $stmt->execute(array($localidadeID, $codPostalID));
    }

    $cod1 = $newuserinformation['cod1'];
    $cod2 = $newuserinformation['cod2'];

    if (!($userdata[0]['cod1'] === $cod1) || !($userdata[0]['cod2'] === $cod2)){

      //CHECK CODIGO_POSTAL ALREADY EXISTS
      $stmt = $conn->prepare("SELECT *
                              FROM codigopostal 
                              WHERE cod1 = ? AND cod2 = ?");
      $stmt->execute(array($cod1, $cod2));
      $result = $stmt->fetch();

      if($result){
        $codPostalID = $result['codigopostalid'];
      }
      else{
      //INSERT INTO CODIGO_POSTAL
        $stmt = $conn->prepare("INSERT INTO codigopostal (localidadeid, cod1, cod2) 
          VALUES (?, ?, ?)");
        $stmt->execute(array($localidadeID, $cod1, $cod2));
        $codPostalID = $conn->lastInsertId('codigopostal_codigopostalid_seq');
      }

      //GET MORADA ID
      $stmt = $conn->prepare("SELECT morada.moradaid
                              FROM morada
                              JOIN codigopostal
                              ON morada.codigopostalid = codigopostal.codigopostalid 
                              JOIN moradaenvio
                              ON morada.moradaid = moradaenvio.moradaid 
                              JOIN cliente
                              ON cliente.clienteid = moradaenvio.clienteid
                              WHERE cliente.username = ?");
      $stmt->execute(array($username));
      $result = $stmt->fetch();

      $moradaID = $result['moradaid'];

      //UPDATE INTO MORADA
      $stmt = $conn->prepare("UPDATE morada
                              SET codigopostalid = ? 
                              WHERE moradaid = ?");
      $stmt->execute(array($codPostalID, $moradaID));
    }

    $morada = $newuserinformation['morada'];

    if (!($userdata[0]['rua'] === $morada)){

      //GET MORADA ID
      $stmt = $conn->prepare("SELECT morada.moradaid
                              FROM morada
                              JOIN codigopostal
                              ON morada.codigopostalid = codigopostal.codigopostalid 
                              JOIN moradaenvio
                              ON morada.moradaid = moradaenvio.moradaid 
                              JOIN cliente
                              ON cliente.clienteid = moradaenvio.clienteid
                              WHERE cliente.username = ?");
      $stmt->execute(array($username));
      $result = $stmt->fetch();

      $moradaID = $result['moradaid'];

      //UPDATE INTO MORADA
      $stmt = $conn->prepare("UPDATE morada
                              SET rua = ? 
                              WHERE moradaid = ?");
      $stmt->execute(array($morada, $moradaID));
    }

    $nome = $newuserinformation['nome'];
    $genero = $newuserinformation['genero'];
    $diaNasc = $newuserinformation['diaNasc'];
    $mesNasc = $newuserinformation['mesNasc'];
    $anoNasc = $newuserinformation['anoNasc'];
    $telefone = $newuserinformation['telefone'];
    $email = $newuserinformation['email'];
    $nif = $newuserinformation['nif'];

    $birthdate = explode('-', $userdata[0]['datanascimento']);

    $birthyear = $birthdate[0];
    $str = $birthdate[1];
    $birthmonth = ltrim($str, '0');
    $birthday = $birthdate[2];

    if (!($userdata[0]['nome'] === $nome) || !($userdata[0]['genero'] === $genero) || !($birthday === $diaNasc) || !($birthmonth === $mesNasc) || !($birthyear === $anoNasc) || !($userdata[0]['telefone'] === $telefone) || !($userdata[0]['email'] === $email) || !($userdata[0]['nif'] === $nif)){

      $stmt = $conn->prepare("UPDATE cliente 
                              SET nome = ?, genero = ?, datanascimento = ?, telefone = ?, email = ?, nif = ? 
                              WHERE cliente.username = ?");

      $datanasc = sprintf("%02d/%02d/%04d",$diaNasc,$mesNasc,$anoNasc);

      $stmt->execute(array($nome, $genero, $datanasc, $telefone, $email, $nif, $username));
    }
	
	$id = getUserData($username)[0]['clienteid'];
	
	if ((!($userdata[0]['nome'] === $nome) || !($userdata[0]['email'] === $email) || !($userdata[0]['nif'] === $nif) || !($userdata[0]['rua'] === $morada))&& primavera_user_exists(id)!=''){
		
		primavera_update_user($newuserinformation,$id);
	}	

    $conn->commit();

  }catch(Exception $e){

    error_log($e->getMessage());

    $conn->rollBack();

    throw $e;
  }
}

//UPDATE CLIENT PASSWORD
function updateUserPassword($username, $newpassword){

  global $conn;

  $stmt = $conn->prepare("UPDATE cliente 
                          SET password = ?
                          WHERE username = ?");
  $stmt->execute(array(sha1($newpassword),$username));
  
  return $stmt->fetchAll();
}

//GET USER BY REGISTER DATE
function getUsersByDate($firstDate,$todayDate){
  global $conn;
  $stmt = $conn->prepare("SELECT *
                          FROM cliente
                          WHERE dataregisto::date >= ? AND dataregisto::date <= ?");
  $stmt->execute(array($firstDate,$todayDate));
  return $stmt->fetchAll();
}

//GET USER BY NAME AND STATUS
function getUserByNameAndStatus($nomeCliente, $estadoCliente){

  global $conn;

  $stmt = $conn->prepare("SELECT *
                          FROM cliente
                          WHERE LOWER(nome) like '%'||?||'%'
                          AND ativo = ?
                          ORDER BY clienteid ASC");

  $stmt->execute(array(strtolower($nomeCliente), $estadoCliente));
  
  return $stmt->fetchAll();
}

//GET USER BY NAME
function getUserByName($nomeCliente){

  global $conn;

  $stmt = $conn->prepare("SELECT *
                          FROM cliente
                          WHERE LOWER(nome) like '%'||?||'%'");

  $stmt->execute(array(strtolower($nomeCliente)));
  
  return $stmt->fetchAll();
}

//GET USER BY EMAIL
function getUserByEmail($emailCliente){

  global $conn;

  $stmt = $conn->prepare("SELECT *
                          FROM cliente
                          WHERE LOWER(email) = ?");

  $stmt->execute(array(strtolower($emailCliente)));
  
  return $stmt->fetchAll();
}

//GET USER BY STATUS
function getUserByStatus($estadoCliente){

  global $conn;

  $stmt = $conn->prepare("SELECT *
                          FROM cliente
                          WHERE ativo = ?
                          ORDER BY clienteid ASC");
  
  $stmt->execute(array($estadoCliente));
  
  return $stmt->fetchAll();
}

//CLIENT EXISTS VERIFICATION
function checkIfUserExists($username){
  global $conn;
  $stmt = $conn->prepare("SELECT username
                          FROM cliente
                          WHERE username = ?");
  $stmt->execute(array($username));

  return ($stmt->fetch() !== false);
}

function getAllCountries(){
  
  global $conn;
  
  $stmt = $conn->prepare("SELECT nome
                          FROM pais");
  $stmt->execute();

  return $stmt->fetchAll();
}

function getAllCountriesAllInfo(){
  
  global $conn;
  
  $stmt = $conn->prepare("SELECT *
                          FROM pais");
  $stmt->execute();

  return $stmt->fetchAll();
}

function checkIfUserBoughtPublication($clienteid, $publicacaoid){
  
  global $conn;
  
  $stmt = $conn->prepare("SELECT DISTINCT publicacaoencomenda.publicacaoid
                          FROM encomenda
                          JOIN cliente
                          ON encomenda.clienteid = cliente.clienteid 
                          JOIN publicacaoencomenda
                          ON publicacaoencomenda.encomendaid = encomenda.encomendaid 
                          JOIN publicacao
                          ON publicacao.publicacaoid = publicacaoencomenda.publicacaoid
                          WHERE cliente.clienteid = ? AND publicacao.publicacaoid = ?");
  
  $stmt->execute(array($clienteid, $publicacaoid));

  return ($stmt->fetch() !== false);
}

function checkIfUserCommentedPublication($clienteid, $publicacaoid){
  
  global $conn;
  
  $stmt = $conn->prepare("SELECT cliente.clienteid, publicacao.publicacaoid
                          FROM cliente
                          JOIN comentario
                          ON cliente.clienteid = comentario.clienteid 
                          JOIN publicacao
                          ON publicacao.publicacaoid = comentario.publicacaoid
                          WHERE cliente.clienteid = ? AND publicacao.publicacaoid = ?");
  
  $stmt->execute(array($clienteid, $publicacaoid));

  return ($stmt->fetch() !== false);
}

function primavera_get_fatura($id, $userid){
	
	$dir = 'C:/xampp/htdocs/sinf/awesomebookshop/documentos/cliente_' . $userid. '/faturas/';
	$filename = 'C:/xampp/htdocs/sinf/awesomebookshop/documentos/cliente_' . $userid. '/faturas/fa2017_' . $id . '.pdf';
	
	if(!is_dir($dir))
		mkdir($dir , 0777, true);
	
	if (!file_exists($filename)) {
		
		global $PRIMAVERA_API;

		$url = $PRIMAVERA_API . 'Ficheiros/'.$id;
		$ch = curl_init($url);
	  
		curl_setopt($ch, CURLOPT_HEADER, false);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_HTTPHEADER, array("Content-type: application/json"));
	  
		$json_response = curl_exec($ch);
		$status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
	  
		curl_close($ch);
		
		file_put_contents('C:/xampp/htdocs/sinf/awesomebookshop/documentos/cliente_' . $userid . '/faturas/fa2017_' . $id . '.pdf', base64_decode(json_decode($json_response, true)));
	
	}
	
	return ;
}

function primavera_user_exists($id){
  
  global $PRIMAVERA_API;
  
  $url = $PRIMAVERA_API . 'clientes/' + $id;
  $ch = curl_init($url);
  
  curl_setopt($ch, CURLOPT_HEADER, false);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($ch, CURLOPT_HTTPHEADER, array("Content-type: application/json"));
  
  $json_response = curl_exec($ch);
  $status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
  
  curl_close($ch);
  
  return json_decode($json_response, true);
}

function primavera_insert_user($id,$username,$morada){
  
  global $PRIMAVERA_API;
  $user_data=getUserAllData($username);
  
  error_log(print_r($user_data,true));
  
  $data['CodCliente'] = $user_data[0]['cliente_id'];	
  $data['NomeCliente'] = $user_data[0]['nome'];
  $data['Morada'] = $user_data[0]['rua']; 
  $data['NumContribuinte'] = $user_data[0]['nif'];
  $data['Email'] = $user_data[0]['email'];
  $data['Pais'] = $user_data[0]['nomepais'];
  $data['Localidade'] = $user_data[0]['nomelocalidade'];
  
  $cod1 = $user_data[0]['cod1'];
  $cod2 = $user_data[0]['cod2'];
  $codigoPostal = $cod1 . '-' . $cod2;
  
  $data['CodigoPostal'] = $codigoPostal;
  $content = json_encode($data);
  $url = $PRIMAVERA_API . 'clientes/';
  
  
  $ch = curl_init($url);
  curl_setopt($ch, CURLOPT_HEADER, false);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($ch, CURLOPT_HTTPHEADER, array("Content-type: application/json"));
  curl_setopt($ch, CURLOPT_POST, true);
  curl_setopt($ch, CURLOPT_POSTFIELDS, $content);
  
  $json_response = curl_exec($ch);
  $status = curl_getinfo($ch, CURLINFO_HTTP_CODE);

  error_log($json_response);
  error_log($status);
  
  curl_close($ch);
}

function primavera_insert_order($clienteid, $publicationscart){
  global $PRIMAVERA_API;
  
  $data['Entidade'] = $clienteid;
  $data['Serie'] = '2017';
  
  $i = 0;
  
  foreach($publicationscart as $publication){
	$data['LinhasDoc'][$i] = array('CodArtigo' => $publication['primaveraid'], 'Quantidade' => $publication['quantidade'], 'PrecoUnitario' => $publication['preco']);
	$i++;
  }
		
  $content = json_encode($data);
  $url = $PRIMAVERA_API . 'DocVenda';
  
  $ch = curl_init($url);
  curl_setopt($ch, CURLOPT_HEADER, false);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($ch, CURLOPT_HTTPHEADER, array("Content-type: application/json"));
  curl_setopt($ch, CURLOPT_POST, true);
  curl_setopt($ch, CURLOPT_POSTFIELDS, $content);
  
  $json_response = curl_exec($ch);
  $status = curl_getinfo($ch, CURLINFO_HTTP_CODE);

  error_log($json_response);
  error_log($status);
  
  curl_close($ch);
}

function insertOrder($clienteid, $username, $orderinformationf, $orderinformatione, $publicationscart){
  
  global $conn;

  $conn->beginTransaction();
  
  try{
    
    //LOCALIDADE FATURACAO
    $localidadef = $orderinformationf['localidade'];

    //CHECK LOCALIDADE ALREADY EXISTS
    $stmt = $conn->prepare("SELECT *
                            FROM localidade 
                            WHERE nome = ?");
    $stmt->execute(array($localidadef));
    $result = $stmt->fetch();

    if($result){
      $localidadefID = $result['localidadeid'];
    }else{
      //INSERT INTO LOCALIDADE
      $paisID = 193;

      $stmt = $conn->prepare("INSERT INTO localidade (paisid, nome) 
                              VALUES (?, ?)");
      $stmt->execute(array($paisID, $localidadef));

      $localidadefID = $conn->lastInsertId('localidade_localidadeid_seq');
    }

    //LOCALIDADE ENVIO
    $localidadee = $orderinformatione['localidade'];

    //CHECK LOCALIDADE ALREADY EXISTS
    $stmt = $conn->prepare("SELECT *
                            FROM localidade 
                            WHERE nome = ?");
    $stmt->execute(array($localidadee));
    $result = $stmt->fetch();

    if($result){
      $localidadeeID = $result['localidadeid'];
    }else{
      //INSERT INTO LOCALIDADE
      $paisID = 193;

      $stmt = $conn->prepare("INSERT INTO localidade (paisid, nome) 
                              VALUES (?, ?)");
      $stmt->execute(array($paisID, $localidadee));

      $localidadeeID = $conn->lastInsertId('localidade_localidadeid_seq');
    }

    //CODIGOPOSTAL FATURACAO
    $cod1f = $orderinformationf['cod1'];
    $cod2f = $orderinformationf['cod2'];

    //CHECK CODIGO_POSTAL ALREADY EXISTS
    $stmt = $conn->prepare("SELECT *
                            FROM codigopostal 
                            WHERE cod1 = ? AND cod2 = ?");
    $stmt->execute(array($cod1f, $cod2f));
    $result = $stmt->fetch();

    if($result){
      $codPostalfID = $result['codigopostalid'];
    }
    else{
      //INSERT INTO CODIGO_POSTAL
      $stmt = $conn->prepare("INSERT INTO codigopostal (localidadeid, cod1, cod2) 
                              VALUES (?, ?, ?)");
      $stmt->execute(array($localidadefID, $cod1f, $cod2f));
      $codPostalfID = $conn->lastInsertId('codigopostal_codigopostalid_seq');
    }

    //CODIGOPOSTAL ENVIO
    $cod1e = $orderinformatione['cod1'];
    $cod2e = $orderinformatione['cod2'];

    //CHECK CODIGO_POSTAL ALREADY EXISTS
    $stmt = $conn->prepare("SELECT *
                            FROM codigopostal 
                            WHERE cod1 = ? AND cod2 = ?");
    $stmt->execute(array($cod1e, $cod2e));
    $result = $stmt->fetch();

    if($result){
      $codPostaleID = $result['codigopostalid'];
    }
    else{
      //INSERT INTO CODIGO_POSTAL
      $stmt = $conn->prepare("INSERT INTO codigopostal (localidadeid, cod1, cod2) 
                              VALUES (?, ?, ?)");
      $stmt->execute(array($localidadeeID, $cod1e, $cod2e));
      $codPostaleID = $conn->lastInsertId('codigopostal_codigopostalid_seq');
    }

    //MORADA FATURACAO
    $moradaf = $orderinformationf['morada'];

    //GET MORADA ID
    $stmt = $conn->prepare("SELECT morada.moradaid
                            FROM morada
                            WHERE morada.codigopostalid = ? AND morada.rua = ?");
    $stmt->execute(array($codPostalfID, $moradaf));
    $result = $stmt->fetch();

    if($result){
      $moradafID = $result['moradaid'];
    }
    else{
      //INSERT INTO MORADA
      $stmt = $conn->prepare("INSERT INTO morada (codigopostalid, rua) 
                              VALUES (?, ?)");
      $stmt->execute(array($codPostalfID, $moradaf));

      $moradafID = $conn->lastInsertId('morada_moradaid_seq');
    }

    //MORADA FATURACAO
    $moradae = $orderinformatione['morada'];

    //GET MORADA ID
    $stmt = $conn->prepare("SELECT morada.moradaid
                            FROM morada
                            WHERE morada.codigopostalid = ? AND morada.rua = ?");
    $stmt->execute(array($codPostaleID, $moradae));
    $result = $stmt->fetch();

    if($result){
      $moradaeID = $result['moradaid'];
    }
    else{
      //INSERT INTO MORADA
      $stmt = $conn->prepare("INSERT INTO morada (codigopostalid, rua) 
                              VALUES (?, ?)");
      $stmt->execute(array($codPostaleID, $moradae));

      $moradaeID = $conn->lastInsertId('morada_moradaid_seq');
    }

    //INSERT ENCOMENDA
    $stmt = $conn->prepare("INSERT INTO encomenda (clienteID,moradaFaturacaoID,moradaEnvioID)
                            VALUES (?, ?, ?)");
    $stmt->execute(array($clienteid, $moradafID, $moradaeID));

    $encomendaID = $conn->lastInsertId('encomenda_encomendaid_seq');

    //GET INFORMACAOFATURACAO ID
    $stmt = $conn->prepare("SELECT encomenda.informacaofaturacaoid
                            FROM encomenda
                            WHERE encomenda.encomendaid = ?");
    $stmt->execute(array($encomendaID));
    $result = $stmt->fetch();

    $informacaofaturacaoid = $result['informacaofaturacaoid'];

    $metodopagamento = $orderinformationf['metodopagamento'];

    //GET METODOPAGAMENTO ID
    $stmt = $conn->prepare("SELECT metodopagamento.metodopagamentoid
                            FROM metodopagamento
                            WHERE metodopagamento.tipo = ?");
    $stmt->execute(array($metodopagamento));
    $result = $stmt->fetch();

    $metodopagamentoid = $result['metodopagamentoid'];

    //UPDATE INFORMACAOPAGAMENTO
    $stmt = $conn->prepare("UPDATE informacaofaturacao
                            SET metodopagamentoid = ?
                            WHERE informacaofaturacaoid = ?");
    $stmt->execute(array($metodopagamentoid, $informacaofaturacaoid));

    $numerocartao = $orderinformationf['numerocartao'];
    $array = array($orderinformationf['mm'], $orderinformationf['yy']);
    $validade = implode("/", $array);
    $cvv = $orderinformationf['cvv'];

    if($metodopagamento == 'Visa'){

      $stmt = $conn->prepare("INSERT INTO cartaocredito(cartaocreditoid,tipo,numero,validade,cvv)
                              VALUES (?, ?, ?, ?, ?)");
      $stmt->execute(array($informacaofaturacaoid, $metodopagamento, $numerocartao, $validade, $cvv));
    }

    foreach ($publicationscart as $publication) {

      insertPublicacaoEncomenda($publication['publicacaoid'], $encomendaID);
      removeCartItem($clienteid ,$publication['publicacaoid']);
    }

     $conn->commit();

  }catch(Exception $e){

    error_log($e->getMessage());

    $conn->rollBack();

    throw $e;
  }
  
  if(primavera_user_exists($clienteid)==''){
	  primavera_insert_user($clienteid,$username,$moradae);
  }
  
  primavera_insert_order($clienteid, $publicationscart);
  
}

function insertPublicacaoEncomenda($publicationid, $idencomenda){
  
  global $conn;
  
  $stmt = $conn->prepare("INSERT INTO publicacaoencomenda (publicacaoID,encomendaID)
                          VALUES (?, ?)");
  
  $stmt->execute(array($publicationid, $idencomenda));
}
?>