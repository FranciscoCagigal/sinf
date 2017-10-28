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

    <!-- Content -->
    <div class="row">
      <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="x_panel">

          <div class="x_title">
            <h2>Gestão da encomenda: <span>{$orderData[0].encomendaid}</span></h2>
            <ul class="nav navbar-right panel_toolbox">
              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
              </li>
            </ul>
            <div class="clearfix"></div>
          </div>

          <div class="x_content">
            <form action="{$BASE_URL}actions/owner/orders_status.php" method="post" class="form-horizontal form-label-left input_mask">

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-3 col-xs-12">ID da encomenda:</label>
                <div class="col-md-10 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" readonly="readonly" placeholder="{$orderData[0].encomendaid}">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-3 col-xs-12">Nome do Cliente:</label>
                <div class="col-md-10 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" readonly="readonly" placeholder="{$orderData[0].nomecliente}">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-3 col-xs-12">Morada de Envio:</label>
                <div class="col-md-10 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" readonly="readonly" placeholder="{$orderData[0].rua}, {$orderData[0].cod1}-{$orderData[0].cod2} - {$orderData[0].nome_localidade} - {$orderData[0].nome_pais}">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-3 col-xs-12">Morada de Faturação:</label>
                <div class="col-md-10 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" readonly="readonly" placeholder="{$orderFactAddData[0].rua}, {$orderFactAddData[0].cod1}-{$orderFactAddData[0].cod2} - {$orderFactAddData[0].nome_localidade} - {$orderFactAddData[0].nome_pais}">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-3 col-xs-12">Data:</label>
                <div class="col-md-10 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" readonly="readonly" placeholder="{$orderData[0].data|date_format:$parsedata.fulldata}">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-3 col-xs-12">Meio de pagamento:</label>
                <div class="col-md-10 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" readonly="readonly" placeholder="{$orderData[0].metodopagamento}">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-3 col-xs-12">Preço IVA:</label>
                <div class="col-md-10 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" readonly="readonly" placeholder="{$orderData[0].iva|string_format:'%.2f'} € (Já incluido no Sub-Total)">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-3 col-xs-12">Preço Portes:</label>
                <div class="col-md-10 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" readonly="readonly" placeholder="{$orderData[0].portes|string_format:'%.2f'} €">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-3 col-xs-12">Preço Total:</label>
                <div class="col-md-10 col-sm-9 col-xs-12">
                  <input type="text" class="form-control" readonly="readonly" placeholder="{$orderData[0].total|string_format:'%.2f'} €">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-md-2 col-sm-3 col-xs-12">Alterar estado da encomenda: </label>
                <div class="col-md-6 col-sm-6 col-xs-12">
                  <div id="estadoencomenda" class="btn-group" data-toggle="buttons">
                    {if $orderData[0].estado == "Em processamento"}
                    <label class="btn btn-primary" data-toggle-class="btn-primary" >
                      <input type="radio" name="estadoencomenda" value="Em processamento">Em processamento
                    </label>
                    {else}
                    <label class="btn btn-default" data-toggle-class="btn-default" >
                      <input type="radio" name="estadoencomenda" value="Em processamento">Em processamento
                    </label>
                    {/if}

                    {if $orderData[0].estado == "Processada"}
                    <label class="btn btn-primary" data-toggle-class="btn-primary" >
                      <input type="radio" name="estadoencomenda" value="Processada"> Processada
                    </label>
                    {else}
                    <label class="btn btn-default" data-toggle-class="btn-default" >
                      <input type="radio" name="estadoencomenda" value="Processada"> Processada
                    </label>
                    {/if}

                    {if $orderData[0].estado == "Enviada"}
                    <label class="btn btn-primary" data-toggle-class="btn-primary" >
                      <input type="radio" name="estadoencomenda" value="Enviada"> Enviada
                    </label>
                    {else}
                    <label class="btn btn-default" data-toggle-class="btn-default" >
                      <input type="radio" name="estadoencomenda" value="Enviada"> Enviada
                    </label>
                    {/if}

                    {if $orderData[0].estado == "Devolvida"}
                    <label class="btn btn-primary" data-toggle-class="btn-primary" >
                      <input type="radio" name="estadoencomenda" value="Devolvida"> Devolvida
                    </label>
                    {else}
                    <label class="btn btn-default" data-toggle-class="btn-default" >
                      <input type="radio" name="estadoencomenda" value="Devolvida"> Devolvida
                    </label>
                    {/if}
                  </div>
                </div>
              </div>


              <div class="clearfix"></div>
              <div class="ln_solid"></div>

              <div class="x_content">
                <h4>Publicações da compra</h4>
                <!-- start of books list -->
                <table class="table table-striped projects">
                  <thead>
                    <tr>
                      <th style="width: 1%">ID</th>
                      <th style="width: 50%">Nome do livro</th>
                      <th>Preço</th>
                      <th>Quantidade</th>
                      <th style="width: 10%">Opções</th>
                    </tr>
                  </thead>
                  <tbody>
                    {foreach $orderData as $publication}
                    <tr>
                      <td>{$publication.publicacaoid}</td>
                      <td>{$publication.titulo}</td>
                      <td>{$publication.preco|string_format:"%.2f"} €</td>
                      <td>{$publication.quantidade}</td>
                      <td>
                        <a href="{$BASE_URL}pages/publications/publication.php?id={$publication.publicacaoid}" class="btn btn-primary btn-xs"><i class="fa fa-folder"></i> Ver </a>
                      </td>
                    </tr>
                    {/foreach}
                  </tbody>
                </table>
              </div>

              <div class="clearfix"></div>
              <div class="ln_solid"></div>

              <div class="form-group">
                <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset">
                  <input type="hidden" name="order_id" value="{$orderData[0].encomendaid}">
                  <a href="{$BASE_URL}pages/owner/orders.php" type="button" class="btn btn-primary">Cancelar</a>
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
{include file='owner/common/footer.tpl'}