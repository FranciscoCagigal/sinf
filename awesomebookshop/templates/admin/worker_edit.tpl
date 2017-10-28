{include file='admin/common/header.tpl'}
<!-- page content -->
<div class="right_col" role="main">
  <div class="">
    <div class="page-title">
      <div class="title_left">
        <h3>Gestão de Funcionários</h3>
      </div>
    </div>

    <div class="clearfix"></div>

    <!-- Content -->
    <div class="row">
      <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="x_panel">

          <div class="x_title">
            <h2>Editar Funcionário: <span>{$workerdata.nome}</span></h2>
            <ul class="nav navbar-right panel_toolbox">
              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
              </li>
            </ul>
            <div class="clearfix"></div>
          </div>

          <div class="x_content">
            <form action="{$BASE_URL}actions/admin/worker_edit.php" method="post" class="form-horizontal form-label-left input_mask">

              <div class="col-md-12 col-sm-6 col-xs-12 form-group has-feedback">
                <input type="text" class="form-control has-feedback-left" name="nome" required="required" value="{$workerdata.nome}" placeholder="Nome Completo">
                <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span>
              </div>

              <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                <input type="email" class="form-control has-feedback-left" name="email" required="required" value="{$workerdata.email}" placeholder="Email">
                <span class="fa fa-envelope form-control-feedback left" aria-hidden="true"></span>
              </div>

              <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                <input type="tel" class="form-control has-feedback-left" name="telefone" required="required" value="{$workerdata.telefone}" placeholder="Telefone">
                <span class="fa fa-phone form-control-feedback left" aria-hidden="true"></span>
              </div>

              <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                <input type="text" class="form-control has-feedback-left" name="username" required="required" value="{$workerdata.username}" placeholder="Username">
                <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span>
              </div>

              <div class="form-group">
                <!-- Activity -->
                <label class="col-md-1 col-sm-9 col-xs-12 control-label">Estado</span>
                </label>
                <div class="col-md-4 col-sm-9 col-xs-12">
                  <div class="radio">
                    <label>
                      <input type="radio" {if $workerdata.ativo} checked="" {/if} value="Ativo" name="atividade"> Ativo
                    </label>
                    <label>
                      <input type="radio" {if !$workerdata.ativo} checked="" {/if} value="Inativo" name="atividade"> Inativo
                    </label>
                  </div>
                </div>
              </div>

              <div class="form-group">
                <!-- DATA NASCIMENTO -->
                <label class="control-label col-md-2 col-sm-3 col-xs-12">Data de Nascimento</span>
                </label>
                <div class="col-md-4 col-sm-6 col-xs-12 has-feedback">
                  <input type="text" class="form-control has-feedback-left" name="datanascimento" required="required" value="{$workerdata.datanascimento}" aria-describedby="inputSuccess2Status4">
                  <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                  <span id="inputSuccess2Status4" class="sr-only">(success)</span>
                </div>

                <!-- Sexo -->
                <label class="col-md-1 col-sm-9 col-xs-12 control-label">Sexo</span>
                </label>
                <div class="col-md-4 col-sm-9 col-xs-12">
                  <div class="radio">
                    <label>
                      <input type="radio" {if $workerdata.genero == 'Masculino'} checked="" {/if} value="Masculino" name="genero"> Masculino
                    </label>
                    <label>
                      <input type="radio" {if $workerdata.genero == 'Feminino'} checked="" {/if} value="Feminino" name="genero"> Feminino
                    </label>
                  </div>
                </div>
              </div>

              <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                <input type="text" class="form-control has-feedback-left" name="nif" required="required" value="{$workerdata.nif}" placeholder="NIF">
                <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span>
              </div>

              <div class="col-md-6 col-sm-6 col-xs-12 form-group has-feedback">
                <input type="text" class="form-control has-feedback-left" name="cartaocidadao" required="required" value="{$workerdata.cartaocidadao}" placeholder="Cartão de Cidadão">
                <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span>
              </div>

              <div class="col-md-12 col-sm-6 col-xs-12 form-group has-feedback">
                <input type="text" class="form-control has-feedback-left" name="morada" required="required" value="{$workerdata.rua}" placeholder="Morada">
                <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span>
              </div>

              <div class="col-md-4 col-sm-6 col-xs-12 form-group has-feedback">
                <input type="text" class="form-control has-feedback-left" name="codigopostal" required="required" value="{$workerdata.cod1}-{$workerdata.cod2}" placeholder="Código Postal">
                <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span>
              </div>

              <div class="col-md-4 col-sm-6 col-xs-12 form-group has-feedback">
                <input type="text" class="form-control has-feedback-left" name="localidade" required="required" value="{$workerdata.nomelocalidade}" placeholder="Localidade">
                <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span>
              </div>

              <div class="col-md-4 col-sm-6 col-xs-12 form-group has-feedback">
                <!-- <input type="text" class="form-control has-feedback-left" name="pais" required="required" value="{$workerdata.nomepais}" placeholder="País">
                <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span> -->
                <select class="form-control" required="required" name="pais" id="pais">
                    <option>Escolha um País</option>
                    {foreach $countries as $country}
                    <option value="{$country.paisid}" {if $country.nome === $workerdata.nomepais}selected{/if}>{$country.nome}</option>
                    {/foreach}
                </select>
              </div>


              <div class="clearfix"></div>
              <div class="ln_solid"></div>

              <div class="form-group">
                <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset">
                  <input type="hidden" name="worker_username" value="{$workerdata.username}">
                  <a href="{$BASE_URL}pages/admin/workers.php" type="button" class="btn btn-primary">Cancelar</a>
                  <button class="btn btn-primary" type="reset">Limpar</button>
                  <button type="submit" class="btn btn-success">Submeter</button>
                </div>
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