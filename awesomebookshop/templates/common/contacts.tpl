{include file='common/header.tpl'}

<div class="breadcrumbs">
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<ul>
					<li><a href="?page=home">Página inicial</a></li>
					<li class="active">Contacte-nos</li>
				</ul><!-- end breadcrumb -->
			</div><!-- end col -->    
		</div><!-- end row -->
	</div><!-- end container -->
</div><!-- end breadcrumbs -->

<!-- start section -->
<section class="section white-backgorund">
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<div class="title-wrap">
					<h2 class="title lines">Contacte-nos</h2>
				</div>
			</div><!-- end col -->    
		</div><!-- end row -->

		<div class="row column-3">
			<div class="col-sm-6 col-md-4">
				<div class="icon-boxes style1">
					<div class="icon">
						<i class="fa fa-commenting-o text-warning"></i>
					</div><!-- end icon -->
					<div class="box-content">
						<h6 class="thin">Precisa de ajuda?</h6>
						<h5 class="text-warning">Deixe aqui a sua mensagem!</h5>
					</div>
				</div><!-- icon-box -->
			</div><!-- end col -->   
			<div class="col-sm-6 col-md-4">
				<div class="icon-boxes style1">
					<div class="icon">
						<i class="fa fa-phone text-info"></i>
					</div><!-- end icon -->
					<div class="box-content">
						<h6 class="thin">Pergunta rápida?</h6>
						<h5 class="text-info">Contacte-nos: 213 456 789!</h5>
					</div>
				</div><!-- icon-box -->
			</div><!-- end col -->   
			<div class="col-sm-6 col-md-4">
				<div class="icon-boxes style1">
					<div class="icon">
						<i class="fa fa-envelope-o text-success"></i>
					</div><!-- end icon -->
					<div class="box-content">
						<h6 class="thin">Ou envie-nos um email</h6>
						<h5 class="text-success">apoio@awesomebookshop.pt</h5>
					</div>
				</div><!-- icon-box -->
			</div><!-- end col --> 
		</div><!-- end row -->

		<hr class="spacer-40 no-border">

		<div class="row">
			<div class="col-sm-10 col-sm-offset-1">
				<form action="{$BASE_URL}actions/common/send_message.php" method="post" class="form-horizontal">
					<div class="form-group">
						<label for="nome" class="control-label">
						Nome <span class="text-danger">*</span>
						</label>
						<input type="text" name="nome" class="form-control input-lg" 
						{if $USER_DATA}
						value="{$USER_DATA.nome}"
						{else}
						value="{$FORM_VALUES.nome}"
						{/if}
						placeholder="Name">
					</div>
					<div class="form-group">
						<label for="email" class="control-label">E-mail <span class="text-danger">*</span></label>
						<input type="email" name="email" class="form-control input-lg" 
						{if $USER_DATA}
						value="{$USER_DATA.email}"
						{else}
						value="{$FORM_VALUES.email}"
						{/if}
						placeholder="E-mail">
					</div>
					<div class="form-group">
						<label class="control-label" for="message">Mensagem <span class="text-danger">*</span></label>
						<textarea name="mensagem" rows="6" class="form-control input-lg" placeholder="Messagem"></textarea>
					</div>
					<div class="form-group">
						<button type="submit" class="btn btn-default round btn-lg">
						Submeter
						</button>
					</div>
				</form>
			</div><!-- end col -->
		</div><!-- end row -->

	</div><!-- end container -->
</section>
<!-- end section -->

{include file='common/footer.tpl'}

<script src="{$BASE_URL}javascript/common/contacts.js"></script>