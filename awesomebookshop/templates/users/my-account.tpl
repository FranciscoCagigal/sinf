{include file='common/header.tpl'}

<div class="breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <ul>
                    <li><a href="{$BASE_URL}">Página inicial</a></li>
                    <li class="active">Minha conta</li>
                </ul><!-- end breadcrumb -->
            </div><!-- end col -->    
        </div><!-- end row -->
    </div><!-- end container -->
</div><!-- end breadcrumbs -->

<!-- start section -->
<section class="section white-backgorund">
    <div class="container">
        <div class="row">

            {include file='common/sidebar.tpl'}

            <div class="col-sm-9">
                <div class="row">
                    <div class="col-sm-12 text-left">
                        <h2 class="title"><i class="fa fa-user"></i> Minha conta</h2>
                    </div><!-- end col -->
                </div><!-- end row -->

                <hr class="spacer-5"><hr class="spacer-20 no-border">

                <div class="row">
                    <div class="col-sm-12">
                        <p>Olá <strong>{$USERNAME}</strong>! pode mudar a tua informação <a href="{$BASE_URL}pages/users/user-information.php">aqui</a></p>
						<hr class="spacer-30 no-border">
                    </div><!-- end owl carousel -->

                </div><!-- end col -->
				
				<div class="row">
                    <div class="col-sm-12 text-left">
                        <h4 class="title"><i class="fa fa-credit-card"></i> Conta cartão AwesomeBookShop</h4>
						<hr class="spacer-5"><hr class="spacer-20 no-border">
						<p><i class="fa fa-star"></i><i class="fa fa-star"></i> Saldo disponível: <strong>{$pontos_cliente} {if $pontos_cliente == 1}ponto {else} pontos </strong>{/if}<i class="fa fa-star"></i><i class="fa fa-star"></i></p>
						<p><h5 class="text-xs">Troque os pontos da sua conta cartão por descontos: </h5></p>
						<p><h5 class="text-xs">(Desconto de 10€ por cada 10 pontos, em compras superiores a 10€)</h5></p>
						<hr class="spacer-30 no-border">
                    </div><!-- end col -->
                </div><!-- end row -->
				
				<div class="row">
                    <div class="col-sm-12 text-left">
                        <h4 class="title"><i class="fa fa-truck"></i> Últimas encomendas </h4>
                    </div><!-- end col -->
                </div><!-- end row -->

                <hr class="spacer-5"><hr class="spacer-10 no-border">
				
				<div class="row">
					<div class="col-sm-12">
						<div  >
							{if $orders}    
							<table id="tabela-encomendas">
								<thead>
									<tr>
										<th>ID</th>
										<th>Data</th>
										<th style="max-width:200px">Morada de Envio</th>
										<th>Código-Postal</th>
										<th>Localidade</th>
										<th>Portes</th>
										<th>IVA</th>
										<th style="max-width:70px">Total (IVA incluído)</th>
										<th>Método de Pagamento</th>
										<th>Estado</th>
									</tr>
								</thead>
								<tbody>
									{assign var=val value=0}
									{foreach $orders as $order}
									<tr>
										<td><a href="{$BASE_URL}pages/users/order-publications.php?id={$order.encomendaid}">#{$order.encomendaid}</a>
										</td>
										<td>{$days.$val}{if $months.$val eq '01'}JAN{elseif $months.$val eq '02'}FEV{elseif $months.$val eq '03'}MAR{elseif $months.$val eq '04'}ABR{elseif $months.$val eq '05'}MAI{elseif $months.$val eq '06'}JUN{elseif $months.$val eq '07'}JUL{elseif $months.$val eq '08'}AGO{elseif $months.$val eq '09'}SET{elseif $months.$val eq '10'}OUT{elseif $months.$val eq '11'}NOV{elseif $months.$val eq '12'}DEZ{/if}{$years.$val}</td>
										<td style="max-width:200px">{$order.rua}</td>
										<td>{$order.cod1}-{$order.cod2}</td>
										<td>{$order.nome}</td>
										<td>{if $order.portes eq '0'}Grátis{else}{$order.valorportes}{/if}</td>
										<td>{$order.iva}</td>
										<td>{$order.total}</td>
										<td>{$order.tipo}</td>
										<td>{if isset($order.estado)}{if $order.estado eq 'Paga'}<span class="label label-success">{elseif $order.estado eq 'Processada'}<span class="label label-info">{elseif $order.estado eq 'Cancelada'}<span class="label label-default">{elseif $order.estado eq 'Em processamento'}<span class="label label-warning">{elseif $order.estado eq 'Devolvida'}<span class="label label-danger">{/if}{$order.estado}</span>{/if}</td>
														</tr>
														{assign var=val value=$val+1}
														{/foreach}
													</tbody>
												</table><!-- end table -->
												{else}
												<div>
													<p>Ainda não efetuou qualquer encomenda</p>
												</div>
												{/if}
											</div><!-- end table-responsive -->

											<hr class="spacer-10 no-border">
										</div><!-- end col -->
									</div><!-- end row -->
                </div><!-- end row -->
            </div><!-- end col -->
        </div><!-- end row -->                
    </div><!-- end container -->
</section>
<!-- end section -->

{include file='common/footer.tpl'}