{include file='owner/common/header.tpl'}
<!-- page content -->
<div class="right_col" role="main">
  <div class="row top_tiles" style="margin: 10px 0;">
    <div class="col-md-3 col-sm-3 col-xs-6 tile">
      <span>Número de Publicações</span>
      <h2>{$infoHome.publicationsNumber}</h2>
      <span class="sparkline_one" style="height: 160px;">
        <canvas width="200" height="60" style="display: inline-block; vertical-align: top; width: 94px; height: 30px;"></canvas>
      </span>
    </div>
    <div class="col-md-3 col-sm-3 col-xs-6 tile">
      <span>Total de Vendas</span>
      <h2>{$infoHome.totalValueOfOrders}€</h2>
      <span class="sparkline_one" style="height: 160px;">
        <canvas width="200" height="60" style="display: inline-block; vertical-align: top; width: 94px; height: 30px;"></canvas>
      </span>
    </div>
    <div class="col-md-3 col-sm-3 col-xs-6 tile">
      <span>Número de Clientes</span>
      <h2>{$infoHome.totalNumberOfClients}</h2>
      <span class="sparkline_three" style="height: 160px;">
        <canvas width="200" height="60" style="display: inline-block; vertical-align: top; width: 94px; height: 30px;"></canvas>
      </span>
    </div>
    <div class="col-md-3 col-sm-3 col-xs-6 tile">
      <span>Número de Encomendas</span>
      <h2>{$infoHome.totalNumberOfOrders}</h2>
      <span class="sparkline_one" style="height: 160px;">
        <canvas width="200" height="60" style="display: inline-block; vertical-align: top; width: 94px; height: 30px;"></canvas>
      </span>
    </div>
  </div>
  <br />
  <!-- /top tiles -->

  <!-- 2nd -->
  <div class="row">
    <div class="col-md-12">
      <div class="x_panel">
        <div class="x_title">
          <h2>Estatísticas de vendas</h2>
          <div class="filter">
            <div id="reportrange" class="pull-right" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
              <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
              <span></span> <b class="caret"></b>
            </div>
          </div>
          
          <div class="clearfix"></div>
        </div>
        <div class="x_content">
          <!-- <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_title">
              <h2>Encomendas nos últimos 7 dias</h2>
              <div class="clearfix"></div>
            </div>
            <div class="demo-container" style="height:280px">
              <div id="chart_plot_02" class="demo-placeholder"></div>
            </div>
            <div class="tiles">
              <div class="clearfix"></div>
            </div>
          </div> -->

          <div class="col-md-6 col-sm-12 col-xs-12">
            <div>
              <div class="x_title">
                <h2 >Top 5 Encomendas <small class="top5ordersTitle">Últimos 7 dias</small></h2>
                <div class="clearfix"></div>
              </div>
              <ul class="list-unstyled top_profiles scroll-view">
                <div class="top5orders">
                  {if $infoHome.best5Orders}
                  {foreach $infoHome.best5Orders as $bestOrder}
                  <li class="media event">
                    <a class="pull-left border-aero profile_thumb">
                      <i class="fa fa-user aero"></i>
                    </a>
                    <div class="media-body">
                      <a class="title">{$bestOrder.nomecliente}</a>
                      <p><strong>{$bestOrder.total}€. </strong> Pagos na encomenda </p>
                      <p> <small>{$bestOrder.nrEncomendasHoje} Encomenda(s) hoje</small>
                      </p>
                    </div>
                  </li>
                  {/foreach}
                  {else}
                  <li class="media event">
                    <div class="media-body">
                      <a class="title">Sem encomendas entre as datas selecionadas</a>
                    </div>
                  </li>
                  {/if}
                </div>
              </ul>
            </div>
          </div>

          <div class="col-md-6 col-sm-12 col-xs-12">
            <div>
              <div class="x_title">
                <h2 >Últimas 5 Publicações vendidas <small class="last5ordersTitle">Últimos 7 dias</small></h2>
                <div class="clearfix"></div>
              </div>
              <ul class="list-unstyled top_profiles scroll-view">
                <div class="last5orders">
                  {if $infoHome.getLast5Orders}
                  {foreach $infoHome.getLast5Orders as $lastOrder}
                  <li class="media event">
                    <a class="pull-left border-aero profile_thumb">
                      <i class="fa fa-book aero"></i>
                    </a>
                    <div class="media-body">
                      <a class="title"><h5>{$lastOrder.titulopublicacao}</h5></a>
                      <p>Preço publicação <strong>{$lastOrder.total} €</strong> </p>
                    </p>
                  </div>
                </li>
                {/foreach}
                {else}
                <li class="media event">
                  <div class="media-body">
                    <a class="title">Sem publicações vendidas entre as datas selecionadas</a>
                  </div>
                </li>
                {/if}
              </div>
            </ul>
          </div>
        </div>

      </div>
    </div>
  </div>
</div>
</div>
<!-- /page content -->
{include file='owner/common/footer.tpl'}
<script src="{$BASE_URL}javascript/owner/home.js"></script>