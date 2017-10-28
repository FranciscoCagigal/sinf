<?php 

function getAllLogs(){
    global $conn;
    $stmt = $conn->prepare("SELECT DISTINCT login.*, (administrador.nome, cliente.nome, funcionario.nome) as nome
                            FROM login
                            LEFT JOIN administrador
                            ON administrador.administradorid = login.administradorid
                            LEFT JOIN cliente
                            ON cliente.clienteid = login.clienteid
                            LEFT JOIN funcionario
                            ON funcionario.funcionarioid = login.funcionarioid
                            ORDER BY login.loginid");
    $stmt->execute();
    return $stmt->fetchAll();
}

function getlogsByDate($firstDate,$todayDate){
    global $conn;
    $stmt = $conn->prepare("SELECT *
                            FROM login
                            WHERE data::date >= ? AND data::date <= ?");
    $stmt->execute(array($firstDate,$todayDate));
    return $stmt->fetchAll();
}


function getLogsByNameAndDate($nomeUtilizador, $startDate, $endDate){
    global $conn;

    $stmt = $conn->prepare("SELECT DISTINCT login.*, (administrador.nome, cliente.nome, funcionario.nome) as nome
                            FROM login
                            LEFT JOIN administrador
                            ON administrador.administradorid = login.administradorid
                            LEFT JOIN cliente
                            ON cliente.clienteid = login.clienteid
                            LEFT JOIN funcionario
                            ON funcionario.funcionarioid = login.funcionarioid
                            WHERE (login.data::date >= ? AND login.data::date <= ?)
                            AND ( LOWER(administrador.nome) like '%'||?||'%'
                            OR LOWER(cliente.nome) like '%'||?||'%'
                            OR LOWER(funcionario.nome) like '%'||?||'%' )
                            ORDER BY login.loginid ");
    $stmt->execute(array($startDate, $endDate, strtolower($nomeUtilizador), strtolower($nomeUtilizador), strtolower($nomeUtilizador)));
    return $stmt->fetchAll();
}

function getLogsByUsernameAndDate($usernameUtilizador, $startDate, $endDate){
    global $conn;

    $stmt = $conn->prepare("SELECT DISTINCT login.*, (administrador.nome, cliente.nome, funcionario.nome) as nome
                            FROM login
                            LEFT JOIN administrador
                            ON administrador.administradorid = login.administradorid
                            LEFT JOIN cliente
                            ON cliente.clienteid = login.clienteid
                            LEFT JOIN funcionario
                            ON funcionario.funcionarioid = login.funcionarioid
                            WHERE (login.data::date >= ?) AND (login.data::date <= ?)
                            AND ( LOWER(cliente.username) = ?
                            OR LOWER(funcionario.username) = ?
                            OR LOWER(administrador.username) = ? )
                            ORDER BY login.loginid");
    $stmt->execute(array($startDate, $endDate, strtolower($usernameUtilizador),strtolower($usernameUtilizador),strtolower($usernameUtilizador)));
    return $stmt->fetchAll();
}

function getLogsByName($nomeUtilizador){
    global $conn;
    $stmt = $conn->prepare("SELECT DISTINCT login.*, (administrador.nome, cliente.nome, funcionario.nome) as nome
                            FROM login
                            LEFT JOIN administrador
                            ON administrador.administradorid = login.administradorid
                            LEFT JOIN cliente
                            ON cliente.clienteid = login.clienteid
                            LEFT JOIN funcionario
                            ON funcionario.funcionarioid = login.funcionarioid
                            WHERE LOWER(administrador.nome) like '%'||?||'%'
                            OR LOWER(cliente.nome) like '%'||?||'%'
                            OR LOWER(funcionario.nome) like '%'||?||'%'
                            ORDER BY login.loginid");
    $stmt->execute(array(strtolower($nomeUtilizador),strtolower($nomeUtilizador),strtolower($nomeUtilizador)));
    return $stmt->fetchAll();
}


function getLogsByUsername($usernameUtilizador){
    global $conn;

    $stmt = $conn->prepare("SELECT DISTINCT login.*, (administrador.nome, cliente.nome, funcionario.nome) as nome
                            FROM login
                            LEFT JOIN administrador
                            ON administrador.administradorid = login.administradorid
                            LEFT JOIN cliente
                            ON cliente.clienteid = login.clienteid
                            LEFT JOIN funcionario
                            ON funcionario.funcionarioid = login.funcionarioid
                            WHERE LOWER(cliente.username) = ?
                            OR LOWER(funcionario.username) = ?
                            OR LOWER(administrador.username) = ?
                            ORDER BY login.loginid");
    $stmt->execute(array(strtolower($usernameUtilizador),strtolower($usernameUtilizador),strtolower($usernameUtilizador)));
    return $stmt->fetchAll();
}


function getLogsByLoginDate($startDate, $endDate){
    global $conn;
    $stmt = $conn->prepare("SELECT DISTINCT login.*, (administrador.nome, cliente.nome, funcionario.nome) as nome
                            FROM login
                            LEFT JOIN administrador
                            ON administrador.administradorid = login.administradorid
                            LEFT JOIN cliente
                            ON cliente.clienteid = login.clienteid
                            LEFT JOIN funcionario
                            ON funcionario.funcionarioid = login.funcionarioid
                            WHERE (login.data::date >= ? AND login.data::date <= ?)
                            ORDER BY login.loginid ");
    $stmt->execute(array($startDate, $endDate));
    return $stmt->fetchAll();
}

function getAllLogsSearch(){
    global $conn;
    $stmt = $conn->prepare("SELECT expressao, COUNT (LOWER(expressao)) as conta
                            FROM pesquisa
                            GROUP BY expressao
                            ORDER BY conta desc");
    $stmt->execute();
    return $stmt->fetchAll();
}

function getLogsByExpressionAndDate($expressao, $startDate, $endDate){
    global $conn;

    $stmt = $conn->prepare("SELECT expressao, COUNT (LOWER(expressao)) as conta
                            FROM pesquisa
                            WHERE data::date >= ? AND data::date <= ? 
                            AND LOWER(expressao) = ?
                            GROUP BY expressao
                            ORDER BY conta desc");
    $stmt->execute(array($startDate, $endDate, strtolower($expressao)));
    return $stmt->fetchAll();
}

function getLogsByExpression($expressao){
    global $conn;

    $stmt = $conn->prepare("SELECT expressao, COUNT (LOWER(expressao)) as conta
                            FROM pesquisa
                            WHERE LOWER(expressao) = ?
                            GROUP BY expressao
                            ORDER BY conta desc");
    $stmt->execute(array(strtolower($expressao)));
    return $stmt->fetchAll();
}

function getLogsByDateEx($startDate, $endDate){
    global $conn;
    $stmt = $conn->prepare("SELECT expressao, COUNT (LOWER(expressao)) as conta
                            FROM pesquisa
                            WHERE data::date >= ? AND data::date <= ? 
                            GROUP BY expressao
                            ORDER BY conta desc");
    $stmt->execute(array($startDate, $endDate));
    return $stmt->fetchAll();
}

function insertAdminLog($id){
    
    global $conn;
    
    $stmt = $conn->prepare("INSERT INTO login (administradorid)
                            VALUES (?)");
    
    $stmt->execute(array($id));
}

function insertOwnerLog($id){
    
    global $conn;
    
    $stmt = $conn->prepare("INSERT INTO login (funcionarioid)
                            VALUES (?)");
    
    $stmt->execute(array($id));
}

function insertClientLog($id){
    
    global $conn;
    
    $stmt = $conn->prepare("INSERT INTO login (clienteid)
                            VALUES (?)");
    
    $stmt->execute(array($id));
}

function insertExpressionSearched($expression){
    
    global $conn;
    
    $stmt = $conn->prepare("INSERT INTO pesquisa (expressao)
                            VALUES (?)");
    
    $stmt->execute(array($expression));
}
?>