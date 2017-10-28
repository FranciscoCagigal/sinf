<!-- start sidebar -->
<div class="col-sm-3">
	<div class="widget">
		<h6 class="subtitle">Menu de navegação</h6>

		<ul class="list list-unstyled">
			<li>
				<a href="{$BASE_URL}pages/users/my-account.php">
					<i class="fa fa-user mr-5"></i>
					Minha conta
				</a>
			</li>
			<li>
				<a href="{$BASE_URL}pages/users/user-information.php">
					<i class="fa fa-edit mr-5"></i>
					Meus dados pessoais
				</a>
			</li>
			<li>
				<a href="{$BASE_URL}pages/users/wishlist.php">
					<i class="fa fa-heart mr-5"></i>
					Lista de desejos 
				</a>
			</li>
			<li>
				<a href="{$BASE_URL}pages/users/cart.php">
					<i class="fa fa-shopping-cart mr-5"></i>
					Meu carrinho 
				</a>
			</li>
			<li>
				<a href="{$BASE_URL}pages/users/order-list.php">
					<i class="fa fa fa-bar-chart mr-5"></i>
					Minhas encomendas 
				</a>
			</li>
		</ul>
	</div><!-- end widget -->
	{assign var=val value=0}
	<div class="widget">
		<h6 class="subtitle">Novidades</h6>
		<figure>
			<a href="{$BASE_URL}pages/publications/publication.php?id={$eightnewpublications.$val.publicacaoid}">
				<img src="{$BASE_URL}{$eightnewpublications.$val.url}" alt="collection">
			</a>
		</figure>
	</div><!-- end widget -->
	{assign var=val value=$val+1}
	<div class="widget">

		<ul class="items">
			<li> 
				<a href="{$BASE_URL}pages/publications/publication.php?id={$eightnewpublications.$val.publicacaoid}" class="product-image">
					<img src="{$BASE_URL}{$eightnewpublications.$val.url}" alt="Sample Product ">
				</a>
				<div class="product-details">
					<p class="product-name"> 
						<a href="{$BASE_URL}pages/publications/publication.php?id={$eightnewpublications.$val.publicacaoid}">{$eightnewpublications.$val.titulo}</a> 
					</p>
					<span class="Preço text-primary">€{$eightnewpublications.$val.precopromocional}</span>
					<div class="rate text-warning">
						{for $valor=1 to ($eightnewpublications.$val.classificacao)|floor}
						<i class="fa fa-star"></i>
						{/for}
						{if $eightnewpublications.$val.classificacao}
						{if is_numeric($eightnewpublications.$val.classificacao) && (float)(int)$eightnewpublications.$val.classificacao===(float)$eightnewpublications.$val.classificacao}
						{else}
						<i class="fa fa-star-half-o"></i>
						{/if}
						{/if}
					</div>
				</div>
			</li><!-- end item -->
			{assign var=val value=$val+1}
			<li> 
				<a href="{$BASE_URL}pages/publications/publication.php?id={$eightnewpublications.$val.publicacaoid}" class="product-image">
					<img src="{$BASE_URL}{$eightnewpublications.$val.url}" alt="Sample Product ">
				</a>
				<div class="product-details">
					<p class="product-name"> 
						<a href="?page=single-product">{$eightnewpublications.$val.titulo}</a> 
					</p>
					<span class="Preço text-primary">€{$eightnewpublications.$val.precopromocional}</span>
					<div class="rate text-warning">
						{for $valor=1 to ($eightnewpublications.$val.classificacao)|floor}
						<i class="fa fa-star"></i>
						{/for}
						{if $eightnewpublications.$val.classificacao}
						{if is_numeric($eightnewpublications.$val.classificacao) && (float)(int)$eightnewpublications.$val.classificacao===(float)$eightnewpublications.$val.classificacao}
						{else}
						<i class="fa fa-star-half-o"></i>
						{/if}
						{/if}
					</div>
				</div>
			</li><!-- end item -->
		</ul>

		<hr class="spacer-10 no-border">
		<a href="{$BASE_URL}" class="btn btn-default btn-block semi-circle btn-sm">Todos os produtos</a>
	</div><!-- end widget -->
</div><!-- end col -->
<!-- end sidebar -->

<script src="{$BASE_URL}javascript/users/sidebar.js"></script>
