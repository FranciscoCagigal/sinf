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
                        <h2 class="title">Minha conta</h2>
                    </div><!-- end col -->
                </div><!-- end row -->

                <hr class="spacer-5"><hr class="spacer-20 no-border">

                <div class="row">
                    <div class="col-sm-12">
                        <p>Olá <strong>{$USERNAME}</strong>! podes mudar a tua informação <a href="{$BASE_URL}pages/users/user-information.php">aqui</a></p>

                        <hr class="spacer-30 no-border">

                        </div><!-- end owl carousel -->

                    </div><!-- end col -->
                </div><!-- end row -->
            </div><!-- end col -->
        </div><!-- end row -->                
    </div><!-- end container -->
</section>
<!-- end section -->

{include file='common/footer.tpl'}