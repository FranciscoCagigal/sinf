{include file='common/header.tpl'}

<div class="breadcrumbs">
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<ul>
					<li><a href="{$BASE_URL}">Página inicial</a></li>
					<li class="active">Mudar password</li>
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
			<div class="col-sm-3">
				<div class="widget">
					<h6 class="subtitle">Novidades</h6>
					<figure>
						<a href="javascript:void(0);">
							<img src="{$BASE_URL}images/publications/books/books_5.jpg" alt="collection">
						</a>
					</figure>
				</div><!-- end widget -->
			</div><!-- end col -->
			<!-- end sidebar -->
			<div class="col-sm-9">
				<div class="row">
					<div class="col-sm-12 text-left">
						<h2 class="title">Mudar Password</h2>
					</div><!-- end col -->
				</div><!-- end row -->

				<hr class="spacer-5"><hr class="spacer-20 no-border">

				<div class="row">
					<div class="col-sm-12 col-md-10 col-lg-8">
						<p>Esqueceu-se da sua passaword? Por favor introduza o seu endereço de email. Receberá um link para criar uma nova password no seu email.</p>
						<form action="{$BASE_URL}actions/users/forgot-password.php" method="post">
							<div class="form-group">
								<label for="email">E-mail </label>
								<input type="email" class="form-control input-md" name="email" placeholder="E-mail">
							</div><!-- end form-group -->
							<div class="form-group">
								<input type="submit" value="Mudar Password" class="btn btn-default round btn-md">
							</div><!-- end form-group -->
						</form><!-- end form -->
					</div><!-- end col -->
				</div><!-- end row -->
			</div><!-- end col -->
		</div><!-- end row -->                
	</div><!-- end container -->
</section>
<!-- end section -->

{include file='common/footer.tpl'}