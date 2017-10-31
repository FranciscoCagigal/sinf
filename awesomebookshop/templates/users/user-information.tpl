{include file='common/header.tpl'}

<div class="breadcrumbs">
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<ul>
					<li><a href="?page=home">Página inicial</a></li>
					<li class="active">Informação pessoal</li>
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
						<h2 class="title">Meus dados pessoais</h2>
					</div><!-- end col -->
				</div><!-- end row -->
				
				<hr class="spacer-5"><hr class="spacer-20 no-border">
				
				<div class="row">
					<div class="col-sm-12 col-md-10 col-lg-12">
						<form action="{$BASE_URL}actions/users/user-information.php" method="post" class="form-horizontal">
							<div class="form-group">
								<label for="nome" class="col-sm-2 control-label">Nome<span class="text-danger">*</span></label>
								<div class="col-sm-10">
									<input type="text" class="form-control input-md" name="nome" value="{$USER_DATA.nome}" placeholder="Nome">
								</div>
							</div><!-- end form-group -->
							<div class="form-group">
								<label for="Username" class="col-sm-2 control-label">Username<span class="text-danger">*</span></label>
								<div class="col-sm-10">
									<input type="text" class="form-control input-md" name="Username" value="{$USER_DATA.username}" placeholder="Nome">
								</div>
							</div><!-- end form-group -->
							<div class="form-group">
								<label for="genero" class="col-sm-2 control-label">Género<span class="text-danger">*</span></label>
								<div class="checkbox-input mb-10">
									{html_radios name='genero' options=$GENDER_ARRAY selected=$USER_DATA.genero class="row-gender-edit"}
								</div>
							</div><!-- end form-group -->
							<div class="form-group">
								<label for="dataNascimento" class="col-sm-2 control-label">Data de Nascimento<span class="text-danger">*</span></label>
								<div class="col-sm-2">
									<select class="form-control" name="diaNasc">
										{html_options options=$DAY_ARRAY selected=$BIRTH_DAY}
									</select>
								</div><!-- end col -->
								<div class="col-sm-2">
									<select class="form-control" name="mesNasc">
										{html_options values=$MONTH_ARRAY output=$MONTH_NAMES_ARRAY selected=$BIRTH_MONTH}
									</select>
								</div><!-- end col -->
								<div class="col-sm-2">
									<select class="form-control" name="anoNasc">
										{html_options options=$YEAR_ARRAY selected=$BIRTH_YEAR}
									</select>
								</div><!-- end col -->
							</div>
							<div class="form-group">
								<label for="morada" class="col-sm-2 control-label">Morada<span class="text-danger">*</span></label>
								<div class="col-sm-10">
									<input type="text" class="form-control input-md" name="morada" value="{$USER_DATA.rua}" placeholder="Morada">
								</div>
							</div><!-- end form-group -->
							<div class="form-group">
								<label for="localidade" class="col-sm-2 control-label">Localidade<span class="text-danger">*</span></label>
								<div class="col-sm-10">
									<input type="text" class="form-control input-md" name="localidade" value="{$USER_DATA.nomelocalidade}" placeholder="Localidade">
								</div>
							</div><!-- end form-group -->
							<div class="form-group">
								<label for="codigoPostal" class="col-sm-2 control-label">Código-Postal<span class="text-danger">*</span></label>
								<div class="col-sm-10">
									<input type="text" id="row-codpost" class="form-control input-md" name="cod1" value="{$USER_DATA.cod1}" placeholder="Cod1">
									<input type="text" id="row-codpost" class="form-control input-md" name="cod2" value="{$USER_DATA.cod2}" placeholder="Cod2">
								</div>
							</div><!-- end form-group -->
							<div class="form-group">
								<label for="pais" class="col-sm-2 control-label">País<span class="text-danger">*</span></label>
								<div class="col-sm-10">
									<input type="text" class="form-control input-md" name="pais" value="{$USER_DATA.nomepais}" placeholder="País">
								</div>
							</div><!-- end form-group -->
							<div class="form-group">
								<label for="telefone" class="col-sm-2 control-label">Telefone</label>
								<div class="col-sm-10">
									<input type="text" class="form-control input-md" name="telefone" value="{$USER_DATA.telefone}" placeholder="Telefone">
								</div>
							</div><!-- end form-group -->
							<div class="form-group">
								<label for="email" class="col-sm-2 control-label">E-mail <span class="text-danger">*</span></label>
								<div class="col-sm-10">
									<input type="email" class="form-control input-md" name="email" value="{$USER_DATA.email}" placeholder="E-mail">
								</div>
							</div><!-- end form-group -->
							<div class="form-group">
								<label for="nif" class="col-sm-2 control-label">NIF </label>
								<div class="col-sm-10">
									<input type="text" class="form-control input-md" name="nif" value="{$USER_DATA.nif}" placeholder="NIF">
								</div>
							</div><!-- end form-group -->
							<div class="form-group">
								<label for="password" class="col-sm-2 control-label">Password <span class="text-danger">*</span></label>
								<div class="col-sm-10">
									<input type="password" class="form-control input-md" name="password" placeholder="Password">
								</div>
							</div><!-- end form-group -->
							<div class="form-group">
								<label for="password" class="col-sm-2 control-label">Nova Password <span class="text-danger">*</span></label>
								<div class="col-sm-10">
									<input type="password" class="form-control input-md" name="novapassword" placeholder="Nova Password">
								</div>
							</div><!-- end form-group -->
							<div class="form-group">
								<label for="password" class="col-sm-2 control-label">Confirmar Password <span class="text-danger">*</span></label>
								<div class="col-sm-10">
									<input type="password" class="form-control input-md" name="confpassword" placeholder="Confirmar Password">
								</div>
							</div><!-- end form-group -->
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10"> 
									<button type="submit" class="btn btn-default round btn-sm">
										<i class="fa fa-save mr-5"></i>
										Guardar
									</button>
								</div>
							</div><!-- end form-group -->
						</div><!-- end col -->

					</div><!-- end row -->
				</div><!-- end col -->
			</div><!-- end row -->                
		</div><!-- end container -->
	</section>
	<!-- end section -->

	<script src="{$BASE_URL}javascript/users/edit.js"></script>

	{include file='common/footer.tpl'}