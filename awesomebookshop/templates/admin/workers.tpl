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

    <!-- Filters -->
    <div class="row">
      <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="x_panel">

          <div class="x_title">
            <h2>Filtros de pesquisa</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
              </li>
            </ul>
            <div class="clearfix"></div>
          </div>

          <div class="x_content">
            <form class="form-horizontal form-label-left input_mask">

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-0 col-xs-12">Nome:</label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" id="nome_funcionario" placeholder="Nome do funcionário">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-0 col-xs-12">Email:</label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" id="email_funcionario" placeholder="Email do funcionário">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-3 col-xs-12">Data de Admissão</span>
                </label>
                <div class="col-md-9 col-sm-9 col-xs-12 xdisplay_inputx form-group has-feedback">
                  <input type="text" class="form-control has-feedback-left" id="single_cal4" placeholder="Data de Admissão" aria-describedby="inputSuccess2Status4">
                  <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                  <span id="inputSuccess2Status4" class="sr-only">(success)</span>
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-0 col-xs-12">Estado:</label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <select class="form-control" id="estado_funcionario">
                    <option>Escolha uma opção</option>
                    <option value="TRUE">Ativo</option>
                    <option value="FALSE">Inativo</option>
                  </select>
                </div>
              </div>

              <div class="ln_solid"></div>
              <div class="form-group">
                <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset">
                  <button id="clean"class="btn btn-primary" type="button">Limpar</button>
                  <button id="search" type="button" class="btn btn-success">Submeter</button>
                </div>
              </div>

            </form>
          </div>

        </div>
      </div>
    </div>
    <!-- end of Filters -->

    <!-- Content -->
    <div class="row">
      <div class="col-md-12">
        <div class="x_panel">

          <div class="x_title">
            <h2>Funcionarios</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
              </li>
              <li><div class="x_content">
                <a href="{$BASE_URL}pages/admin/worker_add.php"type="button" class="btn btn-round btn-success btn-xs">Adicionar</a>
              </div>
            </li>
          </ul>
          <div class="clearfix"></div>
        </div>

        <div class="workers_content x_content">
          <p>Funcionários da loja</p>
          <!-- start of list -->
          {if $allWorkers}
          <table class="table table-striped projects" id="myTable">
            <thead>
              <tr>
                <th style="width: 6%" id="orderById">ID <span class="glyphicon glyphicon-sort"></span></th>
                <th style="width: 36%" id="orderByName">Nome do Funcionário <span class="glyphicon glyphicon-sort"></span></th>
                <th style="width: 18%" id="orderByDate">Data de Admissão <span class="glyphicon glyphicon-sort"></span></th>
                <th style="width: 10%" id="orderByState">Estado <span class="glyphicon glyphicon-sort"></span></th>
                <th style="width: 20%">Ações</th>
              </tr>
            </thead>
            <tbody>
              {foreach $allWorkers as $worker}
              <tr>
                <td>{$worker.funcionarioid}</td>
                <td>
                  <a>{$worker.nome}</a>
                </td>
                <td>
                  <a>{$worker.dataadmissao|date_format:$parsedata.fulldata}</a>
                </td>
                <td>
                  {if $worker.ativo}
                    <button type="button" class="btn btn-success btn-xs">Ativo</button>
                  {else}
                    <button type="button" class="btn btn-warning btn-xs">Inativo</button>
                  {/if}
                </td>
                <td>
                  <a href="{$BASE_URL}pages/admin/worker_edit.php?username={$worker.username}" class="btn btn-info btn-xs"><i class="fa fa-pencil"></i> Ver / Editar </a>
                 {if $worker.ativo}
                    <a href="{$BASE_URL}actions/admin/worker_status.php?username={$worker.username}" class="btn btn-danger btn-xs"><i class="fa fa-warning"></i> Banir </a>
                  {else}
                    <a href="{$BASE_URL}actions/admin/worker_status.php?username={$worker.username}" class="btn btn-success btn-xs"><i class="fa fa-warning"></i> Ativar </a>
                  {/if}
                </td>
              </tr>
              {/foreach}
              </tbody>
            </table>
            {else}
              <span>Não existem Funcionários</span>
            {/if}
          <!-- end of list -->
        </div>

      </div>
    </div>
  </div>
  <!-- end of Content -->
</div>
</div>
<!-- /page content -->
{include file='admin/common/footer.tpl'}
<script src="{$BASE_URL}javascript/admin/workers_search.js"></script>
<script src="{$BASE_URL}javascript/utilities.js"></script>