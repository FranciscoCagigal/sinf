{include file='common/header.tpl'}

<!-- start section -->
<div class="breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <ul>
                    <li><a href="{$BASE_URL}">Página inicial</a></li>
                    <li class="active">Login</li>
                </ul><!-- end breadcrumb -->
            </div><!-- end col -->    
        </div><!-- end row -->
    </div><!-- end container -->
</div><!-- end breadcrumbs -->
<section class="section white-backgorund">
    <div class="container">
        <div class="row">

            <!-- start sidebar -->
            <div class="col-sm-3">
                <div class="widget">
                    <h6 class="subtitle">Novidades</h6>
                    <figure>
                        {assign var=val value=0}
                        <a href="{$BASE_URL}pages/publications/publication.php?id={$eightnewpublications.$val.publicacaoid}">
                            <img src="{$BASE_URL}{$eightnewpublications.$val.url}" alt="collection">
                        </a>
                    </figure>
                </div><!-- end widget -->
            </div><!-- end col -->
            <!-- end sidebar -->

            <div class="col-sm-9">
                <div class="row">
                    <div class="col-sm-12 text-left">
                        <h2 class="title">Entre na sua conta</h2>
                    </div><!-- end col -->
                </div><!-- end row -->
                <hr class="spacer-5"><hr class="spacer-20 no-border">
                <div class="row">
                    <div class="col-sm-12 col-md-10 col-lg-8">
                        <form action="{$BASE_URL}actions/users/login.php" method="post" class="form-horizontal">
                            <div class="form-group">
                                <label for="username" class="col-sm-2 control-label">Username</label>
                                <div class="col-sm-10">
                                  <input type="text" class="form-control input-md" name="username" value="{$FORM_VALUES.username}">
                              </div>
                          </div><!-- end form-group -->
                          <div class="form-group">
                            <label for="password" class="col-sm-2 control-label">Password</label>
                            <div class="col-sm-10">
                              <input type="password" class="form-control input-md" name="password">
                          </div>
                      </div><!-- end form-group -->
                      <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <div class="checkbox-input mb-10">
                                <input id="remember" class="styled" type="checkbox">
                                <label for="remember">
                                    Lembrar-me
                                </label>
                            </div><!-- end checkbox-input -->
                        </div><!-- end col -->
                        <div class="col-sm-offset-2 col-sm-10">
                            <label><a href="{$BASE_URL}pages/users/forgot-password.php">Recuperar password</a></label>
                        </div>
                    </div><!-- end form-group -->
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="submit" class="btn btn-default round btn-md">
                              <i class="fa fa-lock mr-5"></i>
                              Entrar
                          </button>
                      </div>
                  </div><!-- end form-group -->
              </form>
          </div><!-- end col -->
      </div><!-- end row -->
  </div><!-- end col -->
</div><!-- end row -->                
</div><!-- end container -->
</section>
<!-- end section -->

{include file='common/footer.tpl'}