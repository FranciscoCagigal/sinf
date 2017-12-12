{include file='common/header.tpl'}

<div class="breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <ul>
                    <li><a href="{$BASE_URL}">Página inicial</a></li>
                    <li class="active">Minha conta</li>
                </ul><!-- end breadcrumb -->
            </div><!-- end col -->    
        </div><!-- end row -->
    </div><!-- end container -->
</div><!-- end breadcrumbs -->

<!-- start section -->
<section class="section white-backgorund">
    <div class="container">
        <div class="row">

            {include file='common/sidebar.tpl'}

            <div class="col-sm-9">
                <div class="row">
                    <div class="col-sm-12 text-left">
                        <h2 class="title"><i class="fa fa-user"></i> Minha conta</h2>
                    </div><!-- end col -->
                </div><!-- end row -->

                <hr class="spacer-5"><hr class="spacer-20 no-border">

                <div class="row">
                    <div class="col-sm-12">
                        <p>Olá <strong>{$USERNAME}</strong>! pode mudar a tua informação <a href="{$BASE_URL}pages/users/user-information.php">aqui</a></p>
						<hr class="spacer-30 no-border">
                    </div><!-- end owl carousel -->

                </div><!-- end col -->
				
				<div class="row">
                    <div class="col-sm-12 text-left">
                        <h4 class="title"><i class="fa fa-credit-card"></i> Conta cartão AwesomeBookShop</h4>
						<hr class="spacer-5"><hr class="spacer-20 no-border">
						<p><i class="fa fa-star"></i><i class="fa fa-star"></i> Saldo disponível: <strong>{$pontos_cliente} {if $pontos_cliente == 1}ponto {else} pontos </strong>{/if}<i class="fa fa-star"></i><i class="fa fa-star"></i></p>
						<p><h5 class="text-xs">Troque os pontos da sua conta cartão por descontos: </h5></p>
						<p><h5 class="text-xs">(Desconto de 10€ por cada 10 pontos, em compras superiores a 10€)</h5></p>
                    </div><!-- end col -->
                </div><!-- end row -->
				
                </div><!-- end row -->
            </div><!-- end col -->
        </div><!-- end row -->                
    </div><!-- end container -->
</section>
<!-- end section -->

{include file='common/footer.tpl'}