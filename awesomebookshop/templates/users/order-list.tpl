{include file='common/header.tpl'}

<div class="breadcrumbs">
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<ul>
					<li><a href="{$BASE_URL}">Página inicial</a></li>
					<li class="active">Minhas Encomendas</li>
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
						<h2 class="title">Minhas encomendas</h2>
					</div><!-- end col -->
				</div><!-- end row -->
				
				<hr class="spacer-5"><hr class="spacer-20 no-border">
				
				<div class="row">
					<div class="col-sm-13">
						<div class="table-responsive">
							{if $orders}    
							<table class="table table-striped">
								<thead>
									<tr>
										<th>ID</th>
										<th>Data</th>
										<th>Morada de Envio</th>
										<th>Código-Postal</th>
										<th>Localidade</th>
										<th>Portes</th>
										<th>Total</th>
										<th>Método de Pagamento</th>
										<th>Estado</th>
										<th>Fatura</th>
									</tr>
								</thead>
								<tbody>
									{assign var=val value=0}
									{foreach $orders as $order}
									<tr>
										<td>
											<a href="{$BASE_URL}pages/users/order-publications.php?id={$order.encomendaid}">
												#{$order.encomendaid}
											</a>
										</td>
										<td>
											{$days.$val}
											{if $months.$val eq '01'}
											JAN
											{elseif $months.$val eq '02'}
											FEV
											{elseif $months.$val eq '03'}
											MAR
											{elseif $months.$val eq '04'}
											ABR
											{elseif $months.$val eq '05'}
											MAI
											{elseif $months.$val eq '06'}
											JUN
											{elseif $months.$val eq '07'}
											JUL
											{elseif $months.$val eq '08'}
											AGO
											{elseif $months.$val eq '09'}
											SET
											{elseif $months.$val eq '10'}
											OUT
											{elseif $months.$val eq '11'}
											NOV
											{elseif $months.$val eq '12'}
											DEZ
											{/if}
											{$years.$val}
										</td>
										<td>
											{$order.rua}
										</td>
										<td>
											{$order.cod1}-{$order.cod2}
										</td>
										<td>
											{$order.nome}
										</td>
										<td>
											{if $order.portes eq '0'}
											Grátis
											{else}
											€{$order.portes}
											{/if}
										</td>
										<td>
											€{$order.total}
										</td>
										<td>
											{$order.tipo}
										</td>
										<td>
											{if isset($order.estado)}
												{if $order.estado eq 'Enviada'} 
												<span class="label label-success">
													{elseif $order.estado eq 'Processada'} 
													<span class="label label-info">
														{elseif $order.estado eq 'Devolvida'} 
														<span class="label label-default">
															{elseif $order.estado eq 'Em processamento'}
															<span class="label label-warning">
																{elseif $order.estado eq 'Cancelada'}
																<span class="label label-danger">
												{/if}
												{$order.estado}</span>
											{/if}
										</td>
										<td>
											<a href="{$BASE_URL}actions/users/get_invoice.php?id={$order.primaveraencomendaid}" class="fatura_button" download><span class="fa fa-file-pdf-o"></span></a>
										</td>
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

											<a href="{$BASE_URL}" class="btn btn-light semi-circle btn-sm">
												<i class="fa fa-arrow-left mr-5"></i> Continuar a comprar
											</a>
										</div><!-- end col -->
									</div><!-- end row -->
								</div><!-- end col -->
							</div><!-- end row -->                
						</div><!-- end container -->
					</section>
					<!-- end section -->

					{include file='common/footer.tpl'}