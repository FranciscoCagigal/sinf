{include file='owner/common/header.tpl'}
<!-- page content -->
<div class="right_col" role="main">
  <div class="">
    <div class="page-title">
      <div class="title_left">
        <h3>Gestão de Encomendas</h3>
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
            <br />
            <form class="form-horizontal form-label-left input_mask">

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-0 col-xs-12">Nome Cliente:</label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" id="nome_cliente" placeholder="Nome do Cliente">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-0 col-xs-12">Email Cliente:</label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" id="email_cliente" placeholder="Email do Cliente">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-0 col-xs-12">ID:</label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" id="id_encomenda" placeholder="ID da encomenda">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-0 col-xs-12">Estado:</label>
                <div class="col-md-9 col-sm-9 col-xs-12">
                  <select id="estadoencomenda" class="form-control">
                    <option>Escolha uma opção</option>
                    <option value="Em processamento">Em processamento</option>
                    <option value="Processada">Processada</option>
                    <option value="Enviada">Enviada</option>
                    <option value="Cancelada">Cancelada</option>
                    <option value="Devolvida">Devolvida</option>
                  </select>
                </div>
              </div>

              <div class="clearfix"></div>
              <div class="ln_solid"></div>

              <div class="form-group">
                <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset">
                  <button type="button" id="clean" class="btn btn-primary" type="reset">Limpar</button>
                  <button type="button" id="search" class="btn btn-success">Submeter</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    <!-- end of Filters -->

    <!-- Orders -->
    <div class="row">
      <div class="col-md-12">
        <div class="x_panel">
          <div class="x_title">
            <h2>Encomendas</h2>
            <ul class="nav navbar-right panel_toolbox">
              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
              </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="order_content x_content">
            <p>Encomendas listadas da loja</p>
            <!-- start of orders list -->
            {if $allOrders}
            <table class="table table-striped projects" id="myTable">
              <thead>
                <tr>
                  <th id="orderByID" >ID <span class="glyphicon glyphicon-sort"></span></th>
                  <th id="orderByName">Nome cliente <span class="glyphicon glyphicon-sort"></span></th>
                  <th id="orderByTotalPrice">Preço Total <span class="glyphicon glyphicon-sort"></span></th>
                  <th id="orderByState">Estado <span class="glyphicon glyphicon-sort"></span></th>
                  <th id="orderByDate">Data <span class="glyphicon glyphicon-sort"></span></th>
                  <th>Ações</th>
                </tr>
              </thead>
              <tbody>
                {foreach $allOrders as $order}
                <tr>
                  <td>{$order.encomendaid}</td>
                  <td>
                    <a>{$order.nomecliente}</a>
                  </td>
                  <td>
                    <a>{$order.total|string_format:"%.2f"} €</a>
                  </td>
                  <td>
                    {if $order.estado == "Em processamento"}
                    <button class="btn btn-info btn-xs">Em processamento</button>
                    {else if $order.estado == "Processada"}
                    <button class="btn btn-primary btn-xs">Processada</button>
                    {else if $order.estado == "Enviada"}
                    <button class="btn btn-success btn-xs">Enviada</button>
                    {else if $order.estado == "Devolvida"}
                    <button class="btn btn-warning btn-xs">Devolvida</button>
                    {else}
                    <button class="btn btn-danger btn-xs">Cancelada</button>
                    {/if}
                  </td>
                  <td>
                    <a>{$order.data|date_format:$parsedata.fulldata}</a>
                  </td>
                  <td>
                    <a href="{$BASE_URL}pages/owner/order.php?id={$order.encomendaid}" class="btn btn-info btn-xs"><i class="fa fa-pencil"></i> Ver/Editar </a>
                  </td>
                </tr>
                {/foreach}
              </tbody>
            </table>
            {else}
            <span>Não existem Encomendas</span>
            {/if}
            <!-- end of orders list -->
          </div>
        </div>
      </div>
    </div>
    <!-- end of Orders -->
  </div>
</div>
<!-- /page content -->
{include file='owner/common/footer.tpl'}
<script src="{$BASE_URL}javascript/owner/orders_search.js"></script>
<script src="{$BASE_URL}javascript/utilities.js"></script>