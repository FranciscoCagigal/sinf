{include file='admin/common/header.tpl'}

<!-- page content -->
<div class="right_col" role="main">
	<div class="row top_tiles">
		<div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
			<div class="tile-stats">
				<div class="icon"><i class="fa fa-sign-in"></i></div>
				<div class="count">{$infoHome.nrOfLastClients}</div>
				<h3>Novos Registos</h3>
				<p>Número de novos clientes nos últimos 7 dias.</p>
			</div>
		</div>
		<div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
			<div class="tile-stats">
				<div class="icon"><i class="fa fa-comments-o"></i></div>
				<div class="count">{$infoHome.nrOfLastComments}</div>
				<h3>Novos comentários</h3>
				<p>Número de novos comentários nos últimos 7 dias.</p>
			</div>
		</div>
		<div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
			<div class="tile-stats">
				<div class="icon"><i class="fa fa-eye"></i></div>
				<div class="count">{$infoHome.nrOfLastLogs}</div>
				<h3>Novos visitantes</h3>
				<p>Número de novos visitantes nos últimos 7 dias.</p>
			</div>
		</div>
		<div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
			<div class="tile-stats">
				<div class="icon"><i class="fa fa-cart-plus"></i></div>
				<div class="count">{$infoHome.nrOfLastOrders}</div>
				<h3>Novas encomendas</h3>
				<p>Número de novas encomendas nos últimos 7 dias.</p>
			</div>
		</div>
	</div>
	<!-- /top tiles -->

	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="row x_title">
				<div class="col-md-6">
					<h3>Registo de atividades</h3>
				</div>
				<div class="col-md-6">
					<div id="reportrange" class="pull-right" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
						<i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
						<span></span> <b class="caret"></b>
					</div>
				</div>
			</div>

			<!-- <div class="col-md-12 col-sm-12 col-xs-12">
				<div id="chart_plot_01" class="demo-placeholder"></div>
			</div> -->
			<div class="clearfix"></div>
		</div>

		<div class="col-md-4">
			<div class="x_panel top_encomendas">
				<div class="x_title">
					<h2>Top Encomendas <small>Últimos 7 dias</small></h2>
					<ul class="nav navbar-right panel_toolbox">
						<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
						</li>
					</ul>
					<div class="clearfix"></div>
				</div>
				<div class="x_content">
					{if $infoHome.getBest5UsersOrdersCountByDate}
					{foreach $infoHome.getBest5UsersOrdersCountByDate as $order}
					<article class="media event">
						<a class="pull-left border-aero profile_thumb">
							<i class="fa fa-user aero"></i>
						</a>
						<div class="media-body">
							<a class="title">{$order.nomecliente}</a>
							<p>Efetuou <strong>{$order.total}</strong> encomendas(s).</p>
						</div>
					</article>
					{/foreach}
					{else}
					<article class="media event">
						<div class="media-body">
                    		<a class="title">Sem encomendas na data selecionada</a>
                  		</div>
					</article>
					{/if}
				</div>
			</div>
		</div>

		<div class="col-md-4">
			<div class="x_panel top_usuarios">
				<div class="x_title">
					<h2>Top Encomendas <small>Últimos 7 dias</small></h2>
					<ul class="nav navbar-right panel_toolbox">
						<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
						</li>
					</ul>
					<div class="clearfix"></div>
				</div>
				<div class="x_content">
					{if $infoHome.getBest5UsersOrdersByDate}
					{foreach $infoHome.getBest5UsersOrdersByDate as $order}
					<article class="media event">
						<a class="pull-left border-aero profile_thumb">
							<i class="fa fa-user aero"></i>
						</a>
						<div class="media-body">
							<a class="title">{$order.nomecliente}</a>
							<p>Valor total gasto <strong>{$order.total}€</strong> em publicações.</p>
						</div>
					</article>
					{/foreach}
					{else}
					<article class="media event">
						<div class="media-body">
                    		<a class="title">Sem encomendas na data selecionada</a>
                  		</div>
					</article>
					{/if}
				</div>
			</div>
		</div>

		<div class="col-md-4">
			<div class="x_panel top_livros">
				<div class="x_title">
					<h2>Top Publicações <small>Últimos 7 dias</small></h2>
					<ul class="nav navbar-right panel_toolbox">
						<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
						</li>
					</ul>
					<div class="clearfix"></div>
				</div>
				<div class="x_content">
					{if $infoHome.getBest5PublicationsOrdersByDate}
					{foreach $infoHome.getBest5PublicationsOrdersByDate as $publication}
					<article class="media event">
						<a class="pull-left border-aero profile_thumb">
							<i class="fa fa-book aero"></i>
						</a>
						<div class="media-body">
							<a class="title">{$publication.titulo}</a>
							<p>Foram vendidos <strong>{$publication.quantidade}</strong> exemplares.</p>
						</div>
					</article>
					{/foreach}
					{else}
					<article class="media event">
						<div class="media-body">
                    		<a class="title">Sem Publicações entre as datas selecionadas</a>
                  		</div>
					</article>
					{/if}
				</div>
			</div>
		</div>

	</div>

	<div class="row">

		<div class="col-md-4">
			<div class="x_panel top_visitas">
				<div class="x_title">
					<h2>Top Visitas <small>Últimos 7 dias</small></h2>
					<ul class="nav navbar-right panel_toolbox">
						<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
						</li>
					</ul>
					<div class="clearfix"></div>
				</div>
				<div class="x_content">
					{if $infoHome.getViews5Publications}
					{foreach $infoHome.getViews5Publications as $publication_views}
					<article class="media event">
						<a class="pull-left border-aero profile_thumb">
							<i class="fa fa-book aero"></i>
						</a>
						<div class="media-body">
							<a class="title">{$publication_views.titulo}</a>
							<p>Foram visitadas <strong>{$publication_views.conta}</strong> veze(s).</p>
						</div>
					</article>
					{/foreach}
					{else}
					<article class="media event">
						<div class="media-body">
												<a class="title">Sem Publicações entre as datas selecionadas</a>
											</div>
					</article>
					{/if}
				</div>
			</div>
		</div>


		<div class="col-md-4">
			<div class="x_panel top_comentarios">
				<div class="x_title">
					<h2>Últimos 5 Comentários </h2>
					<ul class="nav navbar-right panel_toolbox">
						<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
						</li>
					</ul>
					<div class="clearfix"></div>
				</div>
				<div class="x_content">
					{if $infoHome.getLast5CommentsByDate}
					{foreach $infoHome.getLast5CommentsByDate as $comment}
					<article class="media event">
						<a class="pull-left border-aero profile_thumb">
							<i class="fa fa-comments-o aero"></i>
						</a>
						<div class="media-body">
							<a class="title">{$comment.nome}</a>
							<p>{$comment.texto}</p>
						</div>
					</article>
					{/foreach}
					{else}
					<article class="media event">
						<div class="media-body">
                    		<a class="title">Sem comentários na data selecionada</a>
                  		</div>
					</article>
					{/if}
				</div>
			</div>
		</div>
	</div>
</div>
<!-- /page content -->

{include file='admin/common/footer.tpl'}
<script src="{$BASE_URL}javascript/admin/home.js"></script>