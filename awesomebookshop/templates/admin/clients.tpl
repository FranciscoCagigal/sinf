{include file='admin/common/header.tpl'}
<!-- page content -->
<div class="right_col" role="main">
  <div class="">
    <div class="page-title">
      <div class="title_left">
        <h3>Gestão de Clientes</h3>
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
                  <input type="text" class="form-control" id="nome_cliente" placeholder="Nome do cliente">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-0 col-xs-12">Email:</label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" id="email_cliente" placeholder="Email do cliente">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-0 col-xs-12">Estado:</label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <select class="form-control" id="estado_cliente">
                    <option>Escolha uma opção</option>
                    <option value="True">Ativo</option>
                    <option value="False">Inativo</option>
                  </select>
                </div>
              </div>

              <div class="ln_solid"></div>
              <div class="form-group">
                <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset">
                  <button id="clean" type="button" class="btn btn-primary">Limpar</button>
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
            <h2>Clientes</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
              </li>
            </ul>
            <div class="clearfix"></div>
          </div>

          <div class="clients_content x_content">
            <!-- start of list -->
            {if $allUseres}
            <p>Clientes existentes na loja</p>
            <table class="table table-striped projects" id="myTable">
              <thead>
                 <tr>
                  <th style="width: 6%" id="orderById">ID <span class="glyphicon glyphicon-sort"></span></th>
                  <th style="width: 51%" id="orderByClientName">Nome do cliente <span class="glyphicon glyphicon-sort"></span></th>
                  <th style="width: 13%" id="orderByStatus">Estado <span class="glyphicon glyphicon-sort"></span></th>
                  <th style="width: 20%">Ações </th>
                </tr>
              </thead>
              <tbody>
                {foreach $allUseres as $user}
                <tr>
                  <td>{$user.clienteid}</td>
                  <td>
                    <a>{$user.nome}</a>
                  </td>
                  <td>
                    {if $user.ativo}
                      <button type="button" class="btn btn-success btn-xs">Ativo</button>
                    {else}
                      <button type="button" class="btn btn-warning btn-xs">Inativo</button>
                    {/if}
                  </td>
                  <td>
                    <a href="{$BASE_URL}pages/admin/client_edit.php?username={$user.username}" class="btn btn-info btn-xs"><i class="fa fa-pencil"></i> Ver/Editar </a>
                    {if $user.ativo}
                      <a href="{$BASE_URL}actions/admin/client_status.php?username={$user.username}" class="btn btn-danger btn-xs"><i class="fa fa-warning"></i> Banir </a>
                    {else}
                      <a href="{$BASE_URL}actions/admin/client_status.php?username={$user.username}" class="btn btn-success btn-xs"><i class="fa fa-warning"></i> Ativar </a>
                    {/if}
                  </td>
                </tr>
                {/foreach}
              </tbody>
            </table>
            {else}
              <span>Não existem clientes</span>
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
<script src="{$BASE_URL}javascript/admin/clients_search.js"></script>
<script src="{$BASE_URL}javascript/utilities.js"></script>