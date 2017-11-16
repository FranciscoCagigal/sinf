{include file='common/header.tpl'}

<div class="breadcrumbs">
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<ul>
					<li><a href="{$BASE_URL}">Página inicial</a></li>
					<li class="active">Encomenda</li>
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
						<h2 class="title">Encomenda #{$orderid}</h2>
					</div><!-- end col -->
				</div><!-- end row -->
				
				<hr class="spacer-5"><hr class="spacer-20 no-border">
				
				<div class="row">
					<div class="col-sm-12">
						<div class="table-responsive">    
							<table id="tabela-encomenda-publicacoes" class="table table-striped">
								<thead>
									<tr>
										<th>ID</th>
										<th >Imagem</th>
										<th >Título</th>
										<th>Preço</th>
										<th>Quantidade</th>
										<th>IVA</th>
										<th>Total (IVA incluído)</th>
									</tr>
								</thead>
								<tbody>
									{foreach $orderpublications as $publication}
									<tr>
										<td>
											#{$publication.publicacaoid}
										</td>
										<td>
											<a href="{$BASE_URL}pages/publications/publication.php?id={$publication.publicacaoid}">
												<img width="60px" src="{$BASE_URL}{$publication.url}" alt="product">
											</a>
										</td>
										<td>
											<h6 class="regular"><a href="{$BASE_URL}pages/publications/publication.php?id={$publication.publicacaoid}">{$publication.titulo}</a></h6>
											<p>Sed aliquam tincidunt tempus</p>
										</td>
										<td>
											<span>€{$publication.preco}</span>
										</td>
										<td>
											{$publication.quantidade}
										</td>
										<td>
											€{$publication.preco * $publication.quantidade * 23/100}
										</td>
										<td>
											€{$publication.preco * $publication.quantidade}
										</td>
									</tr>
									{/foreach}
									<tr>
										<td colspan="7">
											€{$publication.total}
										</td>
									</tr>
								</tbody>
							</table><!-- end table -->
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
