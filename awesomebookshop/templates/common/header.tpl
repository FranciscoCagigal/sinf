<!DOCTYPE html>
<html lang="pt-pt">
<head>
  <title>AwesomeBookShop - A sua livraria móvel</title>
  <meta charset="utf-8">
  <meta name="description" content="Livraria online">
  <meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;">

  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  
  <!--Favicon-->
  <link rel="shortcut icon" href="{$BASE_URL}images/icons/favicon.ico" type="image/x-icon">
  <link rel="icon" href="{$BASE_URL}images/icons/favicon.ico" type="image/x-icon">
  
  <!-- css files -->
  <link rel="stylesheet" type="text/css" href="{$BASE_URL}css/bootstrap.min.css" />
  <link rel="stylesheet" type="text/css" href="{$BASE_URL}css/font-awesome.min.css" />
  <link rel="stylesheet" type="text/css" href="{$BASE_URL}css/owl.carousel.min.css" />
  <link rel="stylesheet" type="text/css" href="{$BASE_URL}css/owl.theme.default.min.css" />
  <link rel="stylesheet" type="text/css" href="{$BASE_URL}css/animate.css" />
  <link rel="stylesheet" type="text/css" href="{$BASE_URL}css/swiper.css" />
  <link rel="stylesheet" type="text/css" href="{$BASE_URL}css/register.css" />
  <link rel="stylesheet" type="text/css" href="{$BASE_URL}css/login.css" />
  <link rel="stylesheet" type="text/css" href="{$BASE_URL}css/edit-form.css" />
  <link rel="stylesheet" type="text/css" href="{$BASE_URL}css/jquery-confirm.min.css" />
  <link rel="stylesheet" type="text/css" href="{$BASE_URL}css/paymentfont.css" />
  <link rel="stylesheet" type="text/css" href="{$BASE_URL}css/paymentfont.min.css" />

  <!-- this is default skin you can replace that with: dark.css, yellow.css, red.css ect -->
  <link id="pagestyle" rel="stylesheet" type="text/css" href="{$BASE_URL}css/default.css" />
  
  <!-- Google fonts -->
  <link href="https://fonts.googleapis.com/css?family=Roboto:300,300i,400,400i,500,500i,700,700i,900,900i&subset=cyrillic,cyrillic-ext,latin-ext" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:100,300,400,700" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Dosis:200,300,400,500,600,700,800&amp;subset=latin-ext" rel="stylesheet">

  <!-- JavaScript Files -->
  <script type="text/javascript" src="{$BASE_URL}javascript/common/jquery-3.1.1.min.js"></script>
  <script type="text/javascript" src="{$BASE_URL}javascript/common/jquery.scrollTo.js"></script>
  <script type="text/javascript" src="{$BASE_URL}javascript/common/jquery.scrollTo.min.js"></script>
  <script type="text/javascript" src="{$BASE_URL}javascript/common/jquery-confirm.min.js"></script>
  <script type="text/javascript" src="{$BASE_URL}javascript/common/bootstrap.min.js"></script>
  <script type="text/javascript" src="{$BASE_URL}javascript/common/owl.carousel.min.js"></script>
  <script type="text/javascript" src="{$BASE_URL}javascript/common/jquery.downCount.js"></script>
  <script type="text/javascript" src="{$BASE_URL}javascript/common/nouislider.min.js"></script>
  <script type="text/javascript" src="{$BASE_URL}javascript/common/jquery.sticky.js"></script>
  <script type="text/javascript" src="{$BASE_URL}javascript/common/pace.min.js"></script>
  <script type="text/javascript" src="{$BASE_URL}javascript/common/star-rating.min.js"></script>
  <script type="text/javascript" src="{$BASE_URL}javascript/common/wow.min.js"></script>
  <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js"></script>
  <script type="text/javascript" src="{$BASE_URL}javascript/common/gmaps.js"></script>
  <script type="text/javascript" src="{$BASE_URL}javascript/common/swiper.min.js"></script>
  <script type="text/javascript" src="{$BASE_URL}javascript/common/main.js"></script>
  
</head>
<body>

  <body>
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

    <!-- start section -->
    <section class="primary-background">
      <div class="container-fluid">
        <div class="row grid-space-0">
          <div class="col-sm-12">
          </div><!-- end col -->
        </div><!-- end row -->
      </div><!-- end container -->
    </section>
    <!-- end section -->

    <!-- start topBar -->
    <div class="topBar">
      <div class="container">
        <ul class="list-inline pull-left hidden-sm hidden-xs">
          <li><span class="text-primary">Tem alguma dúvida?</span></li>
          <li><i class="fa fa-phone mr-5"></i>+224 567 891</li>
          <li><i class="fa fa-envelope mr-5"></i>apoio@awesomebookshop.pt</li>
        </ul>

        <ul class="topBarNav pull-right">
          <li class="linkdown">
            <a href="javascript:void(0);">
              <i class="fa fa-eur mr-5"></i>
              EUR
              <i class="fa fa-angle-down ml-5"></i>
            </a>
            <ul class="w-100">
              <li><a href="javascript:void(0);"><i class="fa fa-usd mr-5"></i>USD</a></li>
              <li class="active"><a href="javascript:void(0);"><i class="fa fa-eur mr-5"></i>EUR</a></li>
              <li><a href="javascript:void(0);"><i class="fa fa-gbp mr-5"></i>GBP</a></li>
            </ul>
          </li>
          <li class="linkdown">
            <a href="javascript:void(0);">
              <img src="{$BASE_URL}images/flags/flag-pt.jpg" class="mr-5" alt="bandeira portuguesa">
              <span class="hidden-xs">
                Português 
                <i class="fa fa-angle-down ml-5"></i>
              </span>    
            </a>
            <ul class="w-110">
              <li><a href="javascript:void(0);"><img src="{$BASE_URL}images/flags/flag-english.jpg" class="mr-5" alt="bandeira inglesa">English</a></li>
              <li class="active"><a><img src="{$BASE_URL}images/flags/flag-pt.jpg" class="mr-5" alt="bandeira portuguesa">Português</a></li>
            </ul>
          </li>
          {if $USERNAME}
          {include file='common/menu_logged_in.tpl'}
          {else}
          {include file='common/menu_logged_out.tpl'}
          {/if}
          
          <div class="middleBar">
            <div class="container">
              <div class="row table">
                <div class="col-sm-3 vertical-align text-left hidden-xs col-lg-offset-2 col-lg-3">
                  <a href="{$BASE_URL}">
                    <img width="180" src="{$BASE_URL}images/logos/logo_abs_4.png" alt="logotipo" />
                  </a>
                </div><!-- end col -->
                <div class="col-sm-6 vertical-align text-center col-lg-offset-3">
                  <form action="{$BASE_URL}actions/publication/getPublicationsFTS.php" method="post" class="form-horizontal form-label-left input_mask">
                    <label for="searchpublication" alt="caixa de pesquisa" aria-label="pesquisa"> </label>
                    <input type="text" placeholder="Pesquisar" name="searchpublication" id="searchpublication" class="form-control input-md">
                    <button type="submit" class="btn btn-success">Pesquisar</button>
                  </form>
                </div><!-- end col -->
                {if $USERNAME}
                <div class="col-sm-3 vertical-align header-items">
                  <div class="header-item mr-5">
                    <a href="{$BASE_URL}pages/users/wishlist.php" data-toggle="tooltip" data-placement="top" title="Wishlist">
                      <i class="fa fa-heart-o"></i>
                      <sub></sub>
                    </a>
                  </div>
                  <div class="header-item"> </div>
                </div><!-- end col -->
                {/if}
              </div><!-- end  row -->
            </div><!-- end container -->
          </div><!-- end middleBar -->

          <!-- start navbar -->
          <div class="navbar yamm navbar-default">
            <div class="container">
              <div class="navbar-header">
                <button type="button" data-toggle="collapse" data-target="#navbar-collapse-3" class="navbar-toggle" alt="butao navegacao" aria-label="butao navegacao">
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                </button>
                <a href="javascript:void(0);" class="navbar-brand visible-xs">
                  <img src="{$BASE_URL}images/logos/logo_abs_4_micro.png" alt="logo">
                </a>
              </div>
              <div id="navbar-collapse-3" class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                  <!-- Home -->
                  <li class="dropdown active">
                    <a href="{$BASE_URL}">
                      <i class="fa fa-home mr-5"></i>
                      Página inicial
                    </a>
                  </li><!-- end li dropdown -->    
                  <!-- Categorias -->
                  <li class="dropdown yamm-fw">
                    <a href="#" data-toggle="dropdown" class="dropdown-toggle">
                      <i class="fa fa-navicon mr-5"></i>
                      Categorias
                      <i class="fa fa-angle-down ml-5"></i>
                    </a>
                    <ul class="dropdown-menu">
                      <li>
                        <!-- Content container to add padding -->
                        <div class="yamm-content">
                          <div class="row">
                            <ul class="col-sm-3">
                              <li class="title">
                                <h6><a href="{$BASE_URL}pages/publications/publicationListByCat.php?cat=1"><span class="text-primary">Livros</span></a></h6>
                              </li>
                              {foreach $subcategoriasLivros as $publication}
                              <li><a href="{$BASE_URL}pages/publications/publication-list.php?subcat={$publication.nome}&cat=Livros">{$publication.nome}</a></li>
                              {/foreach}
                            </ul><!-- end ul col -->
                            <ul class="col-sm-3">
                              <li class="title">
                                <h6><a href="{$BASE_URL}pages/publications/publicationListByCat.php?cat=2"><span class="text-primary">Livros Escolares</span></a></h6>
                              </li>
                              {foreach $subcategoriasLivrosEscolares as $publication}
                              <li><a href="{$BASE_URL}pages/publications/publication-list.php?subcat={$publication.nome}&cat=Livros Escolares">{$publication.nome}</a></li>
                              {/foreach}
                              <li class="title">
                                <h6><a href="{$BASE_URL}pages/publications/publicationListByCat.php?cat=3"><span class="text-primary">Apoio Escolar</span></a></h6>
                              </li>
                              {foreach $subcategoriasApoioEscolar as $publication}
                              <li><a href="{$BASE_URL}pages/publications/publication-list.php?subcat={$publication.nome}&cat=Apoio Escolar">{$publication.nome}</a></li>
                              {/foreach}
                            </ul><!-- end ul col -->
                            <ul class="col-sm-3">
                              <li class="title">
                                <h6><a href="{$BASE_URL}pages/publications/publicationListByCat.php?cat=4"><span class="text-primary">Revistas</span></a></h6>
                              </li>
                              {foreach $subcategoriasRevistas as $publication}
                              <li><a href="{$BASE_URL}pages/publications/publication-list.php?subcat={$publication.nome}&cat=Revistas">{$publication.nome}</a></li>
                              {/foreach}
                            </ul><!-- end ul col -->
                            <ul class="col-sm-3">
                              <li class="title">
                                <h6><a href="{$BASE_URL}pages/publications/publicationListByCat.php?cat=5"><span class="text-primary">Dicionários e Enciclopédias</span></a></h6>
                                {foreach $subcategoriasDicionarios as $publication}
                                <li><a href="{$BASE_URL}pages/publications/publication-list.php?subcat={$publication.nome}&cat=Dicionarios e Enciclopedias">{$publication.nome}</a></li>
                                {/foreach}
                              </li>
                              <li class="title">
                                <h6><a href="{$BASE_URL}pages/publications/publicationListByCat.php?cat=6"><span class="text-primary">Guias Turísticos e Mapas</span></a></h6>
                                {foreach $subcategoriasGuiasEMapas as $publication}
                                <li><a href="{$BASE_URL}pages/publications/publication-list.php?subcat={$publication.nome}&cat=Guias Turisticos e Mapas">{$publication.nome}</a></li>
                                {/foreach}
                              </li>

                            </ul><!-- end ul col -->
                          </div><!-- end row -->
                        </div><!-- end yamn-content -->
                      </li><!-- end li -->
                    </ul><!-- end ul dropdown-menu -->
                  </li><!-- end li dropdown -->
                  <!-- Novidades -->
                  <li class="dropdown yamm-fw">
                    <a href="#" data-toggle="dropdown" class="dropdown-toggle">
                      <i class="fa fa-star mr-5"></i>
                      Novidades
                      <i class="fa fa-angle-down ml-5"></i>
                    </a>
                    <ul class="dropdown-menu">
                      <li>
                        <div class="yamm-content">
                          <div class="row">
                            {for $var=0 to 3}
                            <div class="col-xs-12 col-sm-3">
                              <a href="{$BASE_URL}pages/publications/publication.php?id={$eightnewpublications.$var.publicacaoid}">
                                <figure class="zoom-out">
                                  <img alt="" src="{$BASE_URL}{$eightnewpublications.$var.url}">
                                </figure>
                              </a>
                            </div><!-- end col -->
                            {/for}
                          </div><!-- end row -->

                          <hr class="spacer-20 no-border">

                          <div class="row">
                            <div class="col-xs-12 col-sm-3">
                              <h6>Novidades</h6>
                              <p>Confira aqui as mais recentes publicações. Fique a par das últimas novidades. Queremos que esteja sempre atualizado!</p>
                              <button type="button" class="btn btn-default round btn-sm">Saiba mais</button>
                            </div><!-- end col -->
                            {for $var=4 to 6}
                            <div class="col-xs-12 col-sm-3">
                              <div class="thumbnail store style1">
                                <div class="header">
                                  <div class="badges">
                                    {if $eightnewpublications.$var.preco != $eightnewpublications.$var.precopromocional}
                                    <span class="product-badge top left white-backgorund text-primary semi-circle">Promoção</span>
                                    {/if}
                                    <span class="product-badge top right text-primary">
                                      {for $val=1 to ($eightnewpublications.$var.classificacao)|floor}
                                      <i class="fa fa-star"></i>
                                      {/for}
                                      {if $eightnewpublications.$var.classificacao}
                                      {if is_numeric($eightnewpublications.$var.classificacao) && (float)(int)$eightnewpublications.$var.classificacao===(float)$eightnewpublications.$var.classificacao}
                                      {else}
                                      <i class="fa fa-star-half-o"></i>
                                      {/if}
                                      {/if}
                                    </span>
                                  </div>
                                  <figure class="layer">
                                    <img src="{$BASE_URL}{$eightnewpublications.$var.url}" alt="">
                                  </figure>
                                  <div class="icons">
                                    <a class="icon semi-circle" data-type="Adicionar à wishlist" data-toggle="tooltip" data-placement="top" title="Adicionar à wishlist" data-id="{$eightnewpublications.$var.publicacaoid}" data-url="{$BASE_URL}pages/publications/publication.php?id={$eightnewpublications.$var.publicacaoid}" data-img="{$BASE_URL}{$eightnewpublications.$var.url}" data-titulo="{$eightnewpublications.$var.titulo}" data-price="{$eightnewpublications.$var.precopromocional}"><i class="fa fa-heart-o"></i></a>
                                    <a class="icon semi-circle" data-type="Adicionar ao carrinho" data-toggle="tooltip" data-placement="top" title="Adicionar ao carrinho" data-id="{$eightnewpublications.$var.publicacaoid}" data-url="{$BASE_URL}pages/publications/publication.php?id={$eightnewpublications.$var.publicacaoid}" data-img="{$BASE_URL}{$eightnewpublications.$var.url}" data-titulo="{$eightnewpublications.$var.titulo}" data-price="{$eightnewpublications.$var.precopromocional}"><i class="fa fa-cart-plus"></i></a>
                                    <a class="icon semi-circle" data-toggle="tooltip" data-placement="top" title="Ver página da publicação"href="{$BASE_URL}pages/publications/publication.php?id={$eightnewpublications.$var.publicacaoid}"><i class="fa fa-search"></i></a>
                                  </div>
                                </div>
                                <div class="caption">
                                  <h6 class="thin"><a href="{$BASE_URL}pages/publications/publication.php?id={$eightnewpublications.$var.publicacaoid}">{$eightnewpublications.$var.titulo}</a></h6>
                                  <div class="price">
                                    {if $eightnewpublications.$var.preco != $eightnewpublications.$var.precopromocional}
                                    <small class="amount off">€{$eightnewpublications.$var.preco}</small>
                                    <span class="amount text-primary">€{$eightnewpublications.$var.precopromocional}</span>
                                    {else}
                                    <span class="amount text-primary">€{$eightnewpublications.$var.preco}</span>
                                    {/if}
                                  </div>
                                </div><!-- end caption -->
                              </div><!-- end thumbnail -->
                            </div><!-- end col -->
                            {/for}
                          </div><!-- end row -->
                        </div><!-- end yamm-content -->
                      </li><!-- end li -->
                    </ul><!-- end dropdown-menu -->
                  </li><!-- end dropdown -->
                  <!-- promoções -->
                  <li>
                    <a href="{$BASE_URL}pages/publications/publications-promotion.php">
                      <i class="glyphicon glyphicon-piggy-bank mr-5"></i>
                      Promoções
                    </a>
                  </li>
                </ul><!-- end navbar-nav -->
              </div><!-- end navbar collapse -->
            </div><!-- end container -->
          </div><!-- end navbar -->

          {if isset($USER_DATA)}
          {literal}
          <script type="text/javascript">
            var userdata = '{$USER_DATA}';
          </script>
          {/literal}
          {/if}
          <script src="{$BASE_URL}javascript/common/header.js"></script>