<?php 


function checkIfWorkerExists($username){
  global $conn;
  $stmt = $conn->prepare("SELECT username
                          FROM funcionario
                          WHERE username = ?");
  $stmt->execute(array($username));

  return ($stmt->fetch() !== false);
}

function createWorker($nome, $genero, $diaNasc, $mesNasc, $anoNasc, $morada, $localidade, $cod1, $cod2, $paisID, $currentDate, $telefone, $email, $nif, $cartaocidadao, $username, $password) {

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
      $stmt->execute(array($paisID, $localidade));
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

    //CHECK MORADA ALREADY EXISTS
    $stmt = $conn->prepare("SELECT *
                            FROM morada 
                            WHERE rua = ?");
    $stmt->execute(array($morada));
    $result = $stmt->fetch();
    
    if($result){
      $moradaID = $result['moradaid'];
    }
    else{
      //INSERT INTO MORADA
      $stmt = $conn->prepare("INSERT INTO morada (codigopostalid, rua) VALUES (?, ?)");
      $stmt->execute(array($codPostalID, $morada));
      $moradaID = $conn->lastInsertId('morada_moradaid_seq');
    }
    
    //CHECK FUNCIONARIO ALREADY EXISTS
    $stmt = $conn->prepare("SELECT *
                            FROM funcionario 
                            WHERE username = ? OR email = ? OR nif = ?");
    $stmt->execute(array($username, $email, $nif));
    $result = $stmt->fetch();


      //INSERT INTO FUNCIONARIO
      $stmt = $conn->prepare("INSERT INTO funcionario (paisid, moradaid, nome, genero, datanascimento, username, password, dataadmissao, telefone, email, nif, cartaocidadao) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

      $datanasc = sprintf("%04d-%02d-%02d",$anoNasc,$mesNasc,$diaNasc);

      $stmt->execute(array($paisID, $moradaID, $nome, $genero, $datanasc, $username, sha1($password), $currentDate, $telefone, $email, $nif, $cartaocidadao));
      

    $conn->commit();
  }catch(Exception $e){

    error_log($e->getMessage());

    $conn->rollBack();

    throw $e;
  }
}

function updateWorkerInformation($username, $userdata, $newuserinformation) {

  global $conn;

  $conn->beginTransaction();

  try{

    $paisID = $userdata[0]['paisid'];
    $pais = $newuserinformation['pais']; 

    if (!($paisID === $pais)) {

      //UPDATE INTO PAIS
      $stmt = $conn->prepare("UPDATE funcionario
                              SET paisid = ? 
                              WHERE username = ?");
      $stmt->execute(array($pais, $username));

    }
    
    $localidade = $newuserinformation['localidade'];
    $localidadeID = $userdata[0]['localidadeid'];

    if (!($userdata[0]['nomelocalidade'] === $localidade) || !($paisID === $pais)) {

      //CHECK LOCALIDADE ALREADY EXISTS
      $stmt = $conn->prepare("SELECT *
                              FROM localidade 
                              WHERE nome = ?");
      $stmt->execute(array($localidade));
      $result = $stmt->fetch();

      if($result){
        $localidadeID = $result['localidadeid'];
      }
      else {
        //INSERT INTO LOCALIDADE
        $stmt = $conn->prepare("INSERT INTO localidade (paisid, nome) 
                                VALUES (?, ?)");
        $stmt->execute(array($pais, $localidade));
        $localidadeID = $conn->lastInsertId('localidade_localidadeid_seq');
      }

      if(!($paisID === $pais)){
        $stmt = $conn->prepare("INSERT INTO localidade (paisid, nome) 
                                VALUES (?, ?)");
        $stmt->execute(array($pais, $localidade));
        $localidadeID = $conn->lastInsertId('localidade_localidadeid_seq');
      }

      //GET CODPOSTAL ID
      $stmt = $conn->prepare("SELECT codigopostal.codigopostalid, funcionario.funcionarioid
                              FROM funcionario
                              JOIN morada
                              ON funcionario.moradaid = morada.moradaid 
                              JOIN codigopostal
                              ON morada.codigopostalid = codigopostal.codigopostalid
                              WHERE funcionario.username = ?");
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
      $stmt = $conn->prepare("SELECT funcionario.moradaid
                              FROM funcionario
                              WHERE funcionario.username = ?");
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
      $stmt = $conn->prepare("SELECT funcionario.moradaid
                              FROM funcionario
                              WHERE funcionario.username = ?");
      $stmt->execute(array($username));
      $result = $stmt->fetch();

      $moradaID = $result['moradaid'];

      //UPDATE INTO MORADA
      $stmt = $conn->prepare("UPDATE morada
                              SET rua = ? 
                              WHERE moradaid = ?");
      $stmt->execute(array($morada, $moradaID));
    }

   
    $atividade = $newuserinformation['atividade'];
    //Check atividade
    if (!($userdata[0]['ativo'] == $atividade) && $atividade == FALSE) {
      $currentDate = date('Y-m-d H:i:s');
      $stmt = $conn->prepare("UPDATE funcionario
                              SET datacessacao = ?, ativo = ?
                              WHERE username = ?");
      $stmt->execute(array($currentDate, $atividade, $username));
    } else if(!($userdata[0]['ativo'] == $atividade) && $atividade == TRUE) {
      $datacessacao = NULL;
      $dataadmissao = date('Y-m-d H:i:s');
      $stmt = $conn->prepare("UPDATE funcionario
                              SET datacessacao = ?, dataadmissao = ?, ativo = ?
                              WHERE username = ?");
      $stmt->execute(array($datacessacao, $dataadmissao, $atividade, $username));
    }

    $nome = $newuserinformation['nome'];
    $genero = $newuserinformation['genero'];
    $diaNasc = $newuserinformation['diaNasc'];
    $mesNasc = $newuserinformation['mesNasc'];
    $anoNasc = $newuserinformation['anoNasc'];
    $telefone = $newuserinformation['telefone'];
    $email = $newuserinformation['email'];
    $nif = $newuserinformation['nif'];
    $cartaocidadao = $newuserinformation['cartaocidadao'];
    

    $birthdate = explode('-', $userdata[0]['datanascimento']);

    $birthyear = $birthdate[0];
    $str = $birthdate[1];
    $birthmonth = ltrim($str, '0');
    $birthday = $birthdate[2];

    if (!($userdata[0]['nome'] === $nome) || !($userdata[0]['genero'] === $genero) || !($birthday === $diaNasc) || !($birthmonth === $mesNasc) || !($birthyear === $anoNasc) || !($userdata[0]['telefone'] === $telefone) || !($userdata[0]['email'] === $email) || !($userdata[0]['nif'] === $nif) || !($userdata[0]['cartaocidadao'] === $cartaocidadao)){

      $stmt = $conn->prepare("UPDATE funcionario 
                              SET nome = ?, genero = ?, datanascimento = ?, telefone = ?, email = ?, nif = ?, cartaocidadao = ?
                              WHERE funcionario.username = ?");

      $datanasc = sprintf("%04d-%02d-%02d",$anoNasc,$mesNasc,$diaNasc);

      $stmt->execute(array($nome, $genero, $datanasc, $telefone, $email, $nif, $cartaocidadao, $username));
    }

    $conn->commit();

  }catch(Exception $e){

    error_log($e->getMessage());

    $conn->rollBack();

    throw $e;
  }
}

function getAllWorkers(){
  global $conn;
  $stmt = $conn->prepare("SELECT *
                          FROM funcionario
                          ORDER BY funcionarioid");
  $stmt->execute();
  return $stmt->fetchAll();
}

function getWorkersAllData($username) {
  global $conn;
  $stmt = $conn->prepare("SELECT funcionario.*, morada.rua, codigopostal.*, pais.nome AS nomePais, localidade.nome AS nomeLocalidade
                          FROM funcionario
                          JOIN morada
                          ON morada.moradaid = funcionario.moradaid
                          JOIN codigopostal
                          ON codigopostal.codigopostalid = morada.codigopostalid
                          JOIN localidade
                          ON localidade.localidadeid = codigopostal.localidadeid
                          JOIN pais
                          ON pais.paisid = localidade.paisid
                          WHERE funcionario.username = ?");
  $stmt->execute(array($username));
  return $stmt->fetchAll();
}

function getWorkerStatus($username){
  global $conn;
    $stmt = $conn->prepare("SELECT ativo
                            FROM funcionario
                            WHERE username = ?");
    $stmt->execute(array($username));
    return $stmt->fetch();
}

function updateWorkerStatus($username, $estado){
  global $conn;


  if ($estado == "FALSE") {
    $currentDate = date('Y-m-d H:i:s');
    $stmt = $conn->prepare("UPDATE funcionario
                            SET datacessacao = ?, ativo = ?
                            WHERE username = ?");
    $stmt->execute(array($currentDate, $estado, $username));
  } else {
    $datacessacao = NULL;
    $dataadmissao = date('Y-m-d H:i:s');
    $stmt = $conn->prepare("UPDATE funcionario
                            SET datacessacao = ?, dataadmissao = ?, ativo = ?
                            WHERE username = ?");
    $stmt->execute(array($datacessacao, $dataadmissao, $estado, $username));
  }

  $stmt = $conn->prepare("UPDATE funcionario
                        SET ativo = ? 
                        WHERE username = ?");
  $stmt->execute(array($estado, $username));
}

function getWorkerByNameAdmissionDateAndStatus($nomeFuncionario, $dataAdmissao, $estadoFuncionario){
    global $conn;

    $stmt = $conn->prepare("SELECT *
                            FROM funcionario
                            WHERE LOWER(nome) like '%'||?||'%'
                            AND dataadmissao::date = ?
                            AND ativo = ?
                            ORDER BY funcionarioid");

    $stmt->execute(array(strtolower($nomeFuncionario), $dataAdmissao, $estadoFuncionario));
    return $stmt->fetchAll();
}

function getWorkerByNameAndStatus($nomeFuncionario, $estadoFuncionario){
    global $conn;

    $stmt = $conn->prepare("SELECT *
                            FROM funcionario
                            WHERE LOWER(nome) like '%'||?||'%'
                            AND ativo = ?
                            ORDER BY funcionarioid");

    $stmt->execute(array(strtolower($nomeFuncionario), $estadoFuncionario));
    return $stmt->fetchAll();
}
function getWorkerByAdmissionDateAndStatus($dataAdmissao, $estadoFuncionario){
    global $conn;

    $stmt = $conn->prepare("SELECT *
                            FROM funcionario
                            WHERE dataadmissao::date = ?
                            AND ativo = ?
                            ORDER BY funcionarioid");

    $stmt->execute(array($dataAdmissao, $estadoFuncionario));
    return $stmt->fetchAll();
}

function getWorkerByName($nomeFuncionario){
    global $conn;

    $stmt = $conn->prepare("SELECT *
                            FROM funcionario
                            WHERE LOWER(nome) like '%'||?||'%'
                            ORDER BY funcionarioid");

    $stmt->execute(array(strtolower($nomeFuncionario)));
    return $stmt->fetchAll();
}

function getWorkerByEmail($emailFuncionario){
    global $conn;

    $stmt = $conn->prepare("SELECT *
                            FROM funcionario
                            WHERE LOWER(email) = ?
                            ORDER BY funcionarioid");

    $stmt->execute(array(strtolower($emailFuncionario)));
    return $stmt->fetchAll();
}

function getWorkerByAdmissionDate($dataAdmissao){
    global $conn;

    $stmt = $conn->prepare("SELECT *
                            FROM funcionario
                            WHERE dataadmissao::date = ?
                            ORDER BY funcionarioid");

    $stmt->execute(array($dataAdmissao));
    return $stmt->fetchAll();
}

function getWorkerByStatus($estadoFuncionario){
    global $conn;

    $stmt = $conn->prepare("SELECT *
                            FROM funcionario
                            WHERE ativo = ?
                            ORDER BY funcionarioid");

    $stmt->execute(array($estadoFuncionario));
    return $stmt->fetchAll();
}

function getOwnerData($username) {

  global $conn;

  $stmt = $conn->prepare("SELECT * 
                          FROM funcionario
                          WHERE username = ?");

  $stmt->execute(array($username));

  return $stmt->fetchAll();
}

?>