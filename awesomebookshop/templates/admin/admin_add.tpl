{include file='admin/common/header.tpl'}
<!-- page content -->
<div class="right_col" role="main">
  <div class="">
    <div class="page-title">
      <div class="title_left">
        <h3>Gestão de Administradores</h3>
      </div>
    </div>

    <div class="clearfix"></div>

    <!-- Content -->
    <div class="row">
      <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="x_panel">

          <div class="x_title">
            <h2>Adicionar novo Administrador</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
              </li>
            </ul>
            <div class="clearfix"></div>
          </div>

          <div class="x_content">
          <form action="{$BASE_URL}actions/admin/admin_add.php" method="post" class="form-horizontal form-label-left input_mask">

              <div class="col-md-12 col-sm-6 col-xs-12 form-group has-feedback">
                <input type="text" class="form-control has-feedback-left" name="nome" value="{$FORM_VALUES.nome}" required="required" placeholder="Nome Completo *">
                <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span>
              </div>

              <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                <!-- <input type="text" class="form-control has-feedback-left" name="pais" value="{$FORM_VALUES.pais}" required="required" placeholder="País *">
                <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span> -->
                <select class="form-control" required="required" name="pais" id="pais">
                    <option>Escolha um País</option>
                    {foreach $countries as $country}
                    <option value="{$country.paisid}" {if $country.nome === $FORM_VALUES.pais}selected{/if}>{$country.nome}</option>
                    {/foreach}
                </select>
              </div>

              <!-- DATA NASCIMENTO -->
                <label class="control-label col-md-2 col-sm-3 col-xs-12">Data de Nascimento</span>
                </label>
                <div class="col-md-4 col-sm-6 col-xs-12 form-group has-feedback">
                  <input type="text" class="form-control has-feedback-left" id="single_cal1" name="datanascimento" required="required" placeholder="Data Nascimento" aria-describedby="inputSuccess2Status4">
                  <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                  <span id="inputSuccess2Status4" class="sr-only">(success)</span>
                </div>

              <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                <input type="text" class="form-control has-feedback-left" name="username" value="{$FORM_VALUES.username}" required="required" placeholder="Username *">
                <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span>
              </div>

              <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                <input id="password" title="Insira password com mais de 6 caracteres" type="password" class="form-control has-feedback-left" name="password" required="required" placeholder="Password *">
                <span class="fa fa-key form-control-feedback left" aria-hidden="true"></span>
                <span class="help-block with-errors" data-valmsg-for="pass" data-valmsg-replace="true"></span>
              </div>

                <!-- Sexo -->
                <label class="col-md-1 col-sm-9 col-xs-12 control-label">Genero</span>
                </label>
                <div class="col-md-4 col-sm-9 col-xs-12">
                  <div class="radio">
                    <label>
                      <input type="radio" checked="" value="Masculino" name="genero"> Masculino
                    </label>
                    <label>
                      <input type="radio" value="Feminino" name="genero"> Feminino
                    </label>
                  </div>
                </div>

                <!-- Activity -->
                <label class="col-md-1 col-sm-9 col-xs-12  control-label">Atividade</span>
                </label>
                <div class="col-md-4 col-sm-9 col-xs-12">
                  <div class="radio">
                    <label>
                      <input type="radio" checked="" value="Ativo" name="atividade"> Ativo
                    </label>
                    <label>
                      <input type="radio" value="Inativo" name="atividade"> Inativo
                    </label>
                  </div>
                </div>

              <div class="clearfix"></div>
              <div class="ln_solid"></div>
              
                <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset">
                  <a href="{$BASE_URL}pages/admin/admins.php" type="button" class="btn btn-primary">Cancelar</a>
                  <button class="btn btn-primary" type="reset">Limpar</button>
                  <button id="submit" type="submit" class="btn btn-success" disabled>Submeter</button>
                </div>

            </form>
          </div>
        </div>
      </div>
    </div>
    <!-- end of Content -->
  </div>
</div>
<!-- /page content -->
{include file='admin/common/footer.tpl'}
<script src="{$BASE_URL}javascript/validator.js"></script>