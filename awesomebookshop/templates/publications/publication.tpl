{include file='common/header.tpl'}

<div class="breadcrumbs">
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<ul>
					<li><a href="{$BASE_URL}">Página inicial</a></li>
					<li><a>{$publication.nome_categoria}</a></li>
					<li><a href="{$BASE_URL}pages/publications/publication-list.php?subcat={$publication.nome_subcategoria}&cat={$publication.nome_categoria}">{$publication.nome_subcategoria}</a></li>
					<li class="active">{$publication.titulo}</li>
				</ul><!-- end breadcrumb -->
			</div><!-- end col -->    
		</div><!-- end row -->
	</div><!-- end container -->
</div><!-- end breadcrumbs -->

<!-- start section -->
<section class="section white-backgorund">
	<div class="container">
		<div class="row">
			<!-- start sidebar -->
			<div class="col-sm-4">
				<div class='carousel slide product-slider' data-ride='carousel' data-interval="false">
					<div class='carousel-inner'>
						<div class='item active'>
							<figure>
								<img src='{$BASE_URL}{$publication.url}' alt='Publicacao' />
							</figure>
						</div><!-- end item -->
					</div><!-- end carousel-inner -->
				</div><!-- end carousel -->
			</div><!-- end col -->
			<!-- end sidebar -->
			<div class="col-sm-8">
				<div class="row">
					<div class="col-sm-12">
						<h2 class="title">{$publication.titulo}</h2>
						<p class="text-gray alt-font">ID: {$publication.publicacaoid}</p>
						
						<ul class="list list-inline">
							{if $publication.preco != $publication.precopromocional}
							<li><h6 class="text-danger text-xs">€{$publication.preco}</h6></li>
							{/if}
							<li><h5 class="text-primary">€{$publication.precopromocional}</h5></li>
							<li>
								{if isset($numcomments)}
								{for $value=1 to ($numcomments.classificacao)|floor}
								<i class="fa fa-star text-warning"></i>
								{/for}
								{if $numcomments.classificacao}
								{if is_numeric($numcomments.classificacao) && (float)(int)$numcomments.classificacao===(float)$numcomments.classificacao}
								{else}
								<i class="fa fa-star-half-o text-warning"></i>
								{/if}
								{/if}
								{/if}
							</li>
							<li><a data-type="gotocomments">
								(
								{if isset($numcomments)}
								{if $numcomments.comentarios == 1} {$numcomments.comentarios} comentário
								{else}
								{$numcomments.comentarios} comentários
								{/if}
								{else}
								0 comentários
								{/if}
								)</a></li>
							</ul>
						</div><!-- end col -->
					</div><!-- end row -->

					<div class="row">
						<div class="col-sm-12">
							{if $publication.pontos > 0}
							<p><h5 class="text-xs">Acumule {$publication.pontos} {if $publication.pontos == 1}ponto {else} pontos {/if}na compra deste artigo</h5></p>
							<p><h5 class="text-xs">{if isset($pontos_cliente)}(Atualmente tem {$pontos_cliente} {if $pontos_cliente == 1}ponto {else} pontos {/if}na sua conta){/if}</h5></p>
							{/if}
						</div>
					</div>
					
					<hr class="spacer-5"><hr class="spacer-10 no-border">

					<div class="row">
						<div class="col-sm-12">
							<p>{$publication.descricao}</p>
							<hr class="spacer-15">
							<div class="row">

								<div class="col-md-4 col-sm-12">
									<select class="form-control" name="select">
										<option value="" selected>Quantidade</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
									</select>
								</div><!-- end col -->
								
								<div class="col-md-4 col-sm-12">
									<ul>
										<!-- StockOnline -->
										{if $stockOnline > 0} 
										<li class="emstock"><i class="fa fa-check"></i> Online: Em stock</li>
										{elseif $stockOnline == 0}
										<li class="semstock"><i class="fa fa-times"></i> Online: 2 a 3 dias</li>
										{/if}
										
										<!-- StockLisboa -->
										{if $stockLisboa > 0} 
										<li class="emstock"><i class="fa fa-check emstock"></i> Loja Lisboa: Em stock</li>
										{elseif $stockLisboa == 0}
										<li class="semstock"><i class="fa fa-times semstock"></i> Loja Lisboa: 2 a 3 dias</li>
										{/if}
									</ul>
								</div><!-- end col -->
								
								<div class="col-md-4 col-sm-12 stockarmazem">
									<ul>
										<!-- StockPorto -->
										{if $stockPorto > 0} 
										<li class="emstock"><i class="fa fa-check emstock"></i> Loja Porto: Em stock</li>
										{elseif $stockPorto == 0}
										<li class="semstock"><i class="fa fa-times semstock"></i> Loja Porto: 2 a 3 dias</li>
										{/if}
										
										<!-- StockCoimbra -->
										{if $stockCoimbra > 0} 
										<li class="emstock"><i class="fa fa-check"></i> Loja Coimbra: Em stock</li>
										{elseif $stockCoimbra == 0}
										<li class="semstock"><i class="fa fa-times semstock"></i> Loja Coimbra: 2 a 3 dias</li>
										{/if}
									</ul>
								</div><!-- end col -->
							</div><!-- end row -->
							<hr class="spacer-15">

							<ul class="list list-inline">
								<li><a class="btn btn-default btn-md round" data-type="Adicionar ao cart" data-id="{$publication.publicacaoid}" data-url="{$BASE_URL}pages/publications/publication.php?id={$publication.publicacaoid}" data-img="{$BASE_URL}{$publication.url}" data-titulo="{$publication.titulo}" data-price="{$publication.precopromocional}"><i class="glyphicon glyphicon-shopping-cart mr-5"></i>Adicionar ao carrinho</a></li>
								<li><a class="btn btn-gray btn-md round" data-type="Adicionar à wish" data-id="{$publication.publicacaoid}" data-url="{$BASE_URL}pages/publications/publication.php?id={$publication.publicacaoid}" data-img="{$BASE_URL}{$publication.url}" data-titulo="{$publication.titulo}" data-price="{$publication.precopromocional}"><i class="glyphicon glyphicon-heart mr-5"></i>Adicionar à lista de desejos</a></li>
								<br><br>
								<li>Partilhar este produto: </li>
								<li>
									<ul class="social-icons style1">
										<li class="facebook"><a><i class="fa fa-facebook"></i></a></li>
										<li class="twitter"><a><i class="fa fa-twitter"></i></a></li>
										<li class="pinterest"><a><i class="fa fa-pinterest"></i></a></li>
									</ul>
								</li>
							</ul>
						</div><!-- end col -->
					</div><!-- end row -->
				</div><!-- end col -->
			</div><!-- end row -->

			<hr class="spacer-60">

			<div class="row">
				<div class="col-xs-12 col-sm-3">
					<!-- Nav tabs -->
					<ul class="nav nav-tabs style2 tabs-left">
						<li class="active"><a href="#description" data-toggle="tab">Informação adicional</a></li>
						<li><a href="#reviews" data-toggle="tab">Comentários (
							{if isset($numcomments)}
							{$numcomments.comentarios}
							{else}
							0
							{/if})</a></li>
						</ul>
					</div><!-- end col -->
					<div class="col-xs-12 col-sm-9">
						<!-- Tab panes -->
						<div class="tab-content style2">
							<div class="tab-pane active" id="description">
								<h5>Informação adicional</h5>

								<hr class="spacer-15">

								<div class="row">
									<div class="col-sm-12 col-md-6">
										<dl class="dl-horizontal">
											<dt>Categoria</dt>
											<dd>{$publication.nome_categoria}</dd>
											<dt>Ano de publicação</dt>
											<dd>{$publication.datapublicacao}</dd>
											<dt>Autor</dt>
											<dd>{$publication.nome_autor}</dd>
										</dl>
									</div><!-- end col -->
									<div class="col-sm-12 col-md-6">
										<dl class="dl-horizontal">
											<dt>Sub-Categoria</dt>
											<dd>{$publication.nome_subcategoria}</dd>
											<dt>Editora</dt>
											<dd>{$publication.nome_editora}</dd>
											<dt>ISBN</dt>
											<dd>{$publication.isbn}</dd>
										</dl>
									</div><!-- end col -->
								</div><!-- end row -->
							</div><!-- end tab-pane -->
							<div class="tab-pane" id="reviews">
								<h5>
									{if isset($numcomments)}
									{if $numcomments.comentarios == 1} 
									{$numcomments.comentarios} comentário
									{else}
									{$numcomments.comentarios} comentários
									{/if} 
									{else}
									0 comentários
									{/if}
									para "{$publication.titulo}"</h5>

									<hr class="spacer-10 no-border">
									{foreach $comments as $comment}
									<div class="comments">
										<div class="comment-image">
											<figure>
												<img src='{$BASE_URL}{$publication.url}' alt="Publicacao" />
											</figure>
										</div><!-- end comments-image -->
										<div class="comment-content">
											<div class="comment-content-head">
												<h6 class="comment-title">{$publication.titulo}</h6>
												<ul class="list list-inline comment-meta">
													<li>
														{for $valor=1 to ($comment.classificacao)|floor}
														<i class="fa fa-star text-warning"></i>
														{/for}
														{if $comment.classificacao}
														{if is_numeric($comment.classificacao) && (float)(int)$comment.classificacao===(float)$comment.classificacao}
														{else}
														<i class="fa fa-star-half-o text-warning"></i>
														{/if}
														{/if}
													</li>
												</ul>
											</div><!-- end comment-content-head -->
											<p>{$comment.texto}</p>
											<cite>{$comment.nome}</cite>
										</div><!-- end comment-content -->
									</div><!-- end comments -->
									{/foreach}

									<hr class="spacer-30">
									{if $USERNAME && $bought && !$havecommented}
									<h5>Adicionar um comentário</h5>
									<p>Como classifica este produto?</p>

									<hr class="spacer-5 no-border">

									<form action="{$BASE_URL}actions/users/send_comment_item.php" method="post">
										{html_radios name='classificacao' values=$ratingvalues output=$rating_names separator='<br />'}

										<hr class="spacer-10 no-border">

										<div class="form-group">
											<label for="nome">Nome<span class="text-danger">*</span></label>
											<input type="text" name="nome" class="form-control input-md" {if $USER_DATA}
											value="{$USER_DATA.nome}"
											{else}
											value="{$FORM_VALUES.nome}"
											{/if}
											placeholder="Nome">
										</div><!-- end form-group -->
										<div class="form-group">
											<label for="email">E-mail<span class="text-danger">*</span></label>
											<input type="email" name="email" class="form-control input-md" {if $USER_DATA}
											value="{$USER_DATA.email}"
											{else}
											value="{$FORM_VALUES.email}"
											{/if}
											placeholder="E-mail">
										</div><!-- end form-group -->
										<div class="form-group">
											<label for="comentario">Comentário<span class="text-danger">*</span></label>
											<textarea name="comentario" rows="5" class="form-control" placeholder="Comentário"></textarea>
										</div><!-- end form-group -->
										<div class="form-group">
											<input type="hidden" name="publicacaoid" value="{$publication.publicacaoid}">
										</div><!-- end form-group -->
										<div class="form-group">
											<button type="submit" class="btn btn-default round btn-md">Submeter
											</button>
										</div><!-- end form-group -->
									</form>
									{/if}
								</div><!-- end tab-pane -->
							</div><!-- end tab-content -->
						</div><!-- end col -->
					</div><!-- end row -->

					<hr class="spacer-60">

					<div class="row">
						<div class="col-sm-12">
							<h4 class="mb-20">Recomendações</h4>
						</div><!-- end col -->
					</div><!-- end row -->

					<div class="row">
						<div class="col-sm-12">
							<div id="owl-demo" class="owl-carousel column-4 owl-theme">
								{foreach $recomendations as $publication}
								<div class="item">
									<div class="thumbnail store style1">
										<div class="header">
											<figure>
												<a href="{$BASE_URL}pages/publications/publication.php?id={$publication.publicacaoid}">
													<img src='{$BASE_URL}{$publication.url}' alt="Publicacao">
												</a>
											</figure>
										</div>
										<div class="caption">
											<h6 class="regular"><a href="{$BASE_URL}pages/publications/publication.php?id={$publication.publicacaoid}">{$publication.titulo}</a></h6>
											<div class="price">
												<small class="amount off">€{$publication.preco}</small>
												<span class="amount text-primary">€{$publication.precopromocional}</span>
											</div>
											<span class="product-badge bottom left text-warning">
												{for $val=1 to ($publication.classificacao)|floor}
												<i class="fa fa-star"></i>
												{/for}
												{if $publication.classificacao}
												{if is_numeric($publication.classificacao) && (float)(int)$publication.classificacao===(float)$publication.classificacao}
												{else}
												<i class="fa fa-star-half-o"></i>
												{/if}
												{/if}
											</span>
										</div><!-- end caption -->
									</div><!-- end thumbnail -->
								</div><!-- end item -->
								{/foreach}
							</div><!-- end owl carousel -->
						</div><!-- end col -->
					</div><!-- end row -->
				</div><!-- end container -->
			</section>
			<!-- end section -->

			{include file='common/footer.tpl'}
			
			<script src="{$BASE_URL}javascript/publications/publication.js"></script>