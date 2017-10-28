{include file='common/header.tpl'}

<div class="breadcrumbs">
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<ul>
					<li><a href="?page=home">Página incial</a></li>
					<li class="active">Wishlist</li>
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
						<h2 class="title">A minha lista de desejos</h2>
					</div><!-- end col -->
				</div><!-- end row -->
				
				<hr class="spacer-5"><hr class="spacer-20 no-border">
				
				<div class="row">
					<div class="col-sm-12">
						<div class="table-responsive">
						{if $publicationswishlist}    
							<table class="table">
								<tbody>
									{foreach $publicationswishlist as $publication}
									<tr data-id="{$publication.publicacaoid}" data-price="{$publication.preco}">
										<td>
											<a href="{$BASE_URL}pages/publications/publication.php?id={$publication.publicacaoid}">
												<img width="60px" src="{$BASE_URL}{$publication.url}" alt="product">
											</a>
										</td>
										<td>
											<h6 class="regular"><a href="{$BASE_URL}pages/publications/publication.php?id={$publication.publicacaoid}">{$publication.titulo}</a></h6>
											<small>{$publication.nome_categoria} | {$publication.nome_subcategoria}</small>
										</td>
										<td>
											<span class="text-primary">€{$publication.preco}</span>
										</td>
										<td>
											<button type="button" class="btn btn-default round btn-sm"><i class="fa fa-cart-plus mr-5"></i> Adicionar ao carrinho</button>
										</td>
										<td>
											<button type="button" class="close">×</button>
										</td>
									</tr>
									{/foreach}
									{else}
									<tr>
										<span>Não existem produtos na sua lista de desejos</span>
									</tr>
									{/if}
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

<script src="{$BASE_URL}javascript/users/wishlist.js"></script>