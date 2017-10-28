{include file='common/header.tpl'}

<!-- start section -->
<div class="breadcrumbs">
  <div class="container">
    <div class="row">
      <div class="col-sm-12">
        <ul>
          <li><a href="{$BASE_URL}">Página inicial</a></li>
          <li class="active">Registo</li>
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
            <a href="{$BASE_URL}pages/publications/publication.php?id={$newpublication.publicacaoid}">
              <img src="{$BASE_URL}{$newpublication.url}" alt="collection">
            </a>
          </figure>
        </div><!-- end widget -->
      </div><!-- end col -->
      <!-- end sidebar -->

      <div class="col-sm-9">
        <div class="row">
          <div class="col-sm-12 text-left">
            <h2 class="title">Criar uma conta nova</h2>
          </div><!-- end col -->
        </div><!-- end row -->

        <hr class="spacer-5"><hr class="spacer-20 no-border">

        <div class="row">
          <div class="col-sm-12 col-md-10 col-lg-12">
            <form action="{$BASE_URL}actions/users/register.php" method="post" class="form-horizontal">
              <div class="form-group">
                <label for="nome" class="col-sm-2 control-label">Nome<span class="text-danger">*</span></label>
                <div class="col-sm-10">
                  <input type="text" class="form-control input-md" name="nome" value="{$FORM_VALUES.nome}" placeholder="Nome" data-toggle="tooltip" data-placement="right" title="Preencha este campo com o seu nome">
                </div>
              </div><!-- end form-group -->
              <div class="form-group">
                <label for="genero" class="col-sm-2 control-label" data-toggle="tooltip" data-placement="top" title="Selecione o seu género">Género<span class="text-danger">*</span></label>
                <div class="checkbox-input mb-10">
                  {html_radios name='genero' options=$GENDER_ARRAY class="row-gender-edit"}
                </div>
              </div><!-- end form-group -->
              <div class="form-group">
               <label for="dataNascimento" class="col-sm-2 control-label" data-toggle="tooltip" data-placement="top" title="Selecione a sua data de nascimento">Data de Nascimento<span class="text-danger">*</span></label>
               <div class="col-sm-2">
                <select class="form-control" name="diaNasc">
                  {html_options options=$DAY_ARRAY}
                </select>
              </div><!-- end col -->
              <div class="col-sm-2">
                <select class="form-control" name="mesNasc">
                    {html_options values=$MONTH_ARRAY output=$MONTH_NAMES_ARRAY}
                  </select>
              </div><!-- end col -->
              <div class="col-sm-2">
                <select class="form-control" name="anoNasc">
                    {html_options options=$YEAR_ARRAY}
                  </select>
                </select>
              </div><!-- end col -->
            </div>
            <div class="form-group">
              <label for="morada" class="col-sm-2 control-label">Morada<span class="text-danger">*</span></label>
              <div class="col-sm-10">
                <input type="text" class="form-control input-md" name="morada" value="{$FORM_VALUES.morada}" placeholder="Morada" data-toggle="tooltip" data-placement="right" title="Preencha este campo com a sua morada">
              </div>
            </div><!-- end form-group -->
            <div class="form-group">
              <label for="localidade" class="col-sm-2 control-label">Localidade<span class="text-danger">*</span></label>
              <div class="col-sm-10">
                <input type="text" class="form-control input-md" name="localidade" value="{$FORM_VALUES.localidade}" placeholder="Localidade" data-toggle="tooltip" data-placement="right" title="Preencha este campo com a sua localidade">
              </div>
            </div><!-- end form-group -->
            <div class="form-group">
              <label for="codigoPostal" class="col-sm-2 control-label">Código-Postal<span class="text-danger">*</span></label>
              <div class="col-sm-10">
                <input type="text" id="row-codpost" class="form-control input-md" name="cod1" value="{$FORM_VALUES.cod1}" placeholder="Cod1" data-toggle="tooltip" data-placement="right" title="Preencha este campo com os primeiros 4 dígitos do seu código-postal">
                <input type="text" id="row-codpost" class="form-control input-md" name="cod2" value="{$FORM_VALUES.cod2}" placeholder="Cod2" data-toggle="tooltip" data-placement="right" title="Preencha este campo com os últimos 3 dígitos do seu código-postal">
              </div>
            </div><!-- end form-group -->
            <div class="form-group">
              <label for="pais" class="col-sm-2 control-label">País<span class="text-danger">*</span></label>
              <div class="col-sm-10">
                <select class="form-control" name="pais" data-toggle="tooltip" data-placement="right" title="Preencha este campo com a sua nacionalidade">
                  {foreach from=$countries item=label key=key}
                  <option value="{$key}">{$label.nome}
                  </option>
                  {/foreach}
                </select>
              </div>
            </div><!-- end form-group -->
            <div class="form-group">
              <label for="telefone" class="col-sm-2 control-label">Telefone</label>
              <div class="col-sm-10">
                <input type="text" class="form-control input-md" name="telefone" value="{$FORM_VALUES.telefone}" placeholder="Telefone" data-toggle="tooltip" data-placement="right" title="Preencha este campo com o seu número de telefone">
              </div>
            </div><!-- end form-group -->
            <div class="form-group">
              <label for="email" class="col-sm-2 control-label">E-mail <span class="text-danger">*</span></label>
              <div class="col-sm-10">
                <input type="email" class="form-control input-md" name="email" value="{$FORM_VALUES.email}" placeholder="E-mail" data-toggle="tooltip" data-placement="right" title="Preencha este campo com o seu e-mail">
              </div>
            </div><!-- end form-group -->
            <div class="form-group">
              <label for="nif" class="col-sm-2 control-label">NIF <span class="text-danger">*</span></label>
              <div class="col-sm-10">
                <input type="text" class="form-control input-md" name="nif" value="{$FORM_VALUES.nif}" placeholder="NIF" data-toggle="tooltip" data-placement="right" title="Preencha este campo com o seu número de contribuinte">
              </div>
            </div><!-- end form-group -->
            <div class="form-group">
              <label for="username" class="col-sm-2 control-label">Username <span class="text-danger">*</span></label>
              <div class="col-sm-10">
                <input type="text" class="form-control input-md" name="username" value="{$FORM_VALUES.username}" placeholder="Username" data-toggle="tooltip" data-placement="right" title="Escolha o username pretendido para se autenticar no site">
              </div>
            </div><!-- end form-group -->
            <div class="form-group">
              <label for="password" class="col-sm-2 control-label">Password <span class="text-danger">*</span></label>
              <div class="col-sm-10">
                <input type="password" class="form-control input-md" name="password" placeholder="Password" data-toggle="tooltip" data-placement="right" title="Escolha a password pretendida para se autenticar no site">
              </div>
            </div><!-- end form-group -->
            <div class="form-group">
              <div class="col-sm-offset-2 col-sm-10">
                <button type="submit" class="btn btn-default round btn-md">
                  <i class="fa fa-user-plus mr-5"></i>
                  Registar
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

<script src="{$BASE_URL}javascript/users/register.js"></script>
