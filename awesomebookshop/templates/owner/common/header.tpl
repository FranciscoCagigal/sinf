<!DOCTYPE html>
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <!-- Meta, title, CSS, favicons, etc. -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <title>Owner Dashboard | AwesomeBookShop</title>

  <!-- Bootstrap -->
  <link href="{$BASE_URL}vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link href="{$BASE_URL}vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <!-- NProgress -->
  <link href="{$BASE_URL}vendors/nprogress/nprogress.css" rel="stylesheet">
  <!-- iCheck -->
  <link href="{$BASE_URL}vendors/iCheck/skins/flat/green.css" rel="stylesheet">

  <!-- bootstrap-progressbar -->
  <link href="{$BASE_URL}vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet">
  <!-- JQVMap -->
  <link href="{$BASE_URL}vendors/jqvmap/dist/jqvmap.min.css" rel="stylesheet"/>
  <!-- bootstrap-daterangepicker -->
  <link href="{$BASE_URL}vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">

  <!-- Custom Theme Style -->
  <link href="{$BASE_URL}css/owner/custom.min.css" rel="stylesheet">

</head>

<body class="nav-md">
  {foreach $ERROR_MESSAGES as $error}
  <div class="alert alert-danger alert-dismissible" role="alert">
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
      <span aria-hidden="true">&times;</span>
    </button>
    <strong>{$error}</strong>
  </div><!-- end alert -->
  {/foreach}

  {foreach $SUCCESS_MESSAGES as $success}
  <div class="alert alert-success alert-dismissible" role="alert">
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
      <span aria-hidden="true">&times;</span>
    </button>
    <strong>{$success}</strong>
  </div><!-- end alert -->
  {/foreach}
  <div class="container body">
    <div class="main_container">
      <div class="col-md-3 left_col">
        <div class="left_col scroll-view">
          <div class="navbar nav_title" style="border: 0;">
            <a href="{$BASE_URL}pages/owner/home.php" class="site_title"><i class="fa fa-book"></i> <span>Funcionário</span></a>
          </div>

          <div class="clearfix"></div>

          <!-- menu profile quick info -->
          <div class="profile clearfix">
            <div class="profile_pic">
              <img src="{$BASE_URL}images/owner/user.png" alt="..." class="img-circle profile_img">
            </div>
            <div class="profile_info">
              <span>Bem vindo,</span>
              <h2>{$workerData.nome}</h2>
            </div>
          </div>
          <!-- /menu profile quick info -->

          <br />

          <!-- sidebar menu -->
          <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
            <div class="menu_section">
              <h3>Geral</h3>
              <ul class="nav side-menu">
                <li><a><i class="fa fa-home"></i> Páginas <span class="fa fa-chevron-down"></span></a>
                  <ul class="nav child_menu">
                    <li><a href="{$BASE_URL}pages/owner/home.php">Página Inicial</a></li>
                    <li><a href="{$BASE_URL}pages/owner/orders.php">Encomendas</a></li>
                    <li><a href="{$BASE_URL}pages/owner/publications.php">Publicações</a></li>
                    <li><a href="{$BASE_URL}pages/owner/questions.php">Perguntas Utilizador</a></li>
                  </ul>
                </li>
              </ul>
            </div>
          </div>
          <!-- /sidebar menu -->

        </div>
      </div>

      <!-- top navigation -->
      <div class="top_nav">
        <div class="nav_menu">
          <nav>
            <div class="nav toggle">
              <a id="menu_toggle"><i class="fa fa-bars"></i></a>
            </div>

            <ul class="nav navbar-nav navbar-right">
              <li class="">
                <a href="{$BASE_URL}javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                  <img src="{$BASE_URL}images/owner/user.png" alt="" id="nomeUser">{$workerData.nome}</img>
                  <span class=" fa fa-angle-down" ></span>
                </a>
                <ul class="dropdown-menu dropdown-usermenu pull-right">
                  <li><a href="{$BASE_URL}pages/home/home.php"><i class="fa fa-home pull-right"></i> Home Page</a></li>
                  <li><a href="{$BASE_URL}actions/users/logout.php"><i class="fa fa-sign-out pull-right"></i> Sair</a></li>
                </ul>
              </ul>
            </li>
          </ul>
        </nav>
      </div>
    </div>
        <!-- /top navigation -->