{include file='common/header.tpl'}

<div class="breadcrumbs">
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<ul>
					<li><a href="{$BASE_URL}">Página inicial</a></li>
					<li class="active">Carrinho</li>
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
						<h2 class="title">Carrinho</h2>
					</div><!-- end col -->
				</div><!-- end row -->
				
				<hr class="spacer-5"><hr class="spacer-20 no-border">
				
				<div class="row">
					<div class="col-sm-12">
						<div class="table-responsive">  
							{if $publicationscart}  
							<table class="table table-striped">
								<thead>
									<tr>
										<th colspan="2">Produtos</th>
										<th>Preço</th>
										<th>Quantidade</th>
										<th colspan="2">Total</th>
									</tr>
								</thead>
								<tbody>
									{foreach $publicationscart as $publication}

									<tr data-id="{$publication.publicacaoid}" data-price="{$publication.preco}">
										<td>
											<a href="{$BASE_URL}pages/publications/publication.php?id={$publication.publicacaoid}">
												<img width="60px" src="{$BASE_URL}{$publication.url}" alt="product">
											</a>
										</td>
										<td>
											<h6 class="regular"><a href="{$BASE_URL}pages/publications/publication.php?id={$publication.publicacaoid}">{$publication.titulo}</a></h6>
											<p>{$publication.nome_categoria} | {$publication.nome_subcategoria}</p>
										</td>
										<td>
											<span>€{$publication.preco}</span>
										</td>
										<td>
											<select class="form-control" name="select">
												{html_options options=$qtOptions selected=$publication.quantidade}
											</select>
										</td>
										<td data-column="total">
											<span class="text-primary">€{$publication.preco * $publication.quantidade}</span>
										</td>
										<td>
											<button type="button" class="close">×</button>
										</td>
									</tr>
									{/foreach}
									{else}
									<tr>
										<span>Não existem produtos no carrinho</span>
									</tr>
									{/if}
								</tbody>
							</table><!-- end table -->
						</div><!-- end table-responsive -->
						
						<hr class="spacer-10 no-border">
						
						<a href="{$BASE_URL}" class="btn btn-light semi-circle btn-sm pull-left">
							<i class="fa fa-arrow-left mr-5"></i> Continuar a comprar
						</a>
						{if $publicationscart}
						<a href="{$BASE_URL}pages/users/checkout.php" class="btn btn-default semi-circle btn-sm pull-right" data-type="checkoutbutton">
							Checkout <i class="fa fa-arrow-right ml-5"></i>
						</a>
						{/if}
					</div><!-- end col -->
				</div><!-- end row -->
			</div><!-- end col -->
		</div><!-- end row -->                
	</div><!-- end container -->
</section>
<!-- end section -->

{include file='common/footer.tpl'}

<script src="{$BASE_URL}javascript/users/cart.js"></script>