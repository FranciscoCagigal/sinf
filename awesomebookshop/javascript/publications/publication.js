$(document).ready(function() {
	addEventButton();
	checkNomeLength();
	checkEmailLength();
	checkCommentLength();
});

function addEventButton() {

	$('a[data-type="Adicionar ao cart"]').on('click', function (event){
		
		if(typeof userdata !== 'undefined'){
			
			var idSelected = $(this).attr('data-id');
			var itemLinkSelected = $(this).attr('data-url');
			var itemImageSelected = $(this).attr('data-img');
			var itemTitle = $(this).attr('data-titulo');
			var itemPrice = $(this).attr('data-price');
			var quantity = $(this).parent().parent().parent().find('select').val();
			console.log(quantity);
			$.getJSON("../../api/users/add_cart_item.php", {id: idSelected, value: quantity}, function(data) {
				if(data.Success){   	  	

					$.confirm({
						title: 'Sucesso!',
						content: data.Success,
						type: 'green',
						typeAnimated: true,
						autoClose: 'success|3000',
						buttons: {
							success: {
								text: 'ok',
								btnClass: 'btn-success',
							}
						}
					});

					$.getJSON("../../api/users/get_cart_items.php", function(data) {
						if (data > 0) {
							$('.fa-shopping-cart').parent().find('.text-primary').text("(" + data + ")");
							$('.fa-shopping-basket').parent().find('span .text-primary').text("(" + data + ")");
							$('.cart-items').find('.items').append('<li data-id="' + idSelected + '"><a href="' + itemLinkSelected + '" class="product-image"><img src="' + itemImageSelected + '" alt="Sample Product "></a><div class="product-details"><div class="close-icon"> <a href="javascript:void(0);"><i class="fa fa-close"></i></a></div><p class="product-name"> <a href="' + itemLinkSelected + '">' + itemTitle + '</a></p><strong data-type="quantidade">' + quantity + '</strong> x <span class="price text-primary">€' + itemPrice + '</span></div><!-- end product-details --></li><!-- end item -->');
						}
					});
				}
				else{
					$.confirm({
						title: 'Erro!',
						content: data.Error,
						type: 'red',
						typeAnimated: true,
						buttons: {
							error: {
								text: 'ok',
								btnClass: 'btn-red',
							}
						}
					});
				}
			});
		}
		else{
			$.confirm({
				title: 'Erro!',
				content: 'Deverá efetuar login para poder adicionar a publicação ao carrinho',
				type: 'red',
				typeAnimated: true,
				buttons: {
					error: {
						text: 'ok',
						btnClass: 'btn-red',
					}
				}
			});
		}
	});

	$('a[data-type="Adicionar à wish"]').on('click', function (){

		if(typeof userdata !== 'undefined'){

			var idSelected = $(this).attr('data-id');
			var itemLinkSelected = $(this).attr('data-url');
			var itemImageSelected = $(this).attr('data-img');
			var itemTitle = $(this).attr('data-titulo');
			var itemPrice = $(this).attr('data-price');
			var quantity = 1;

			$.getJSON("../../api/users/add_wishlist_item.php", {id: idSelected}, function(data) {
				if(data.Success){   	  	

					$.confirm({
						title: 'Sucesso!',
						content: data.Success,
						type: 'green',
						typeAnimated: true,
						autoClose: 'success|3000',
						buttons: {
							success: {
								text: 'ok',
								btnClass: 'btn-success',
							}
						}
					});

					$.getJSON("../../api/users/get_wishlist_items.php", function(data) {
						if (data > 0) {
							$('.fa-heart').parent().find('span').text("(" + data + ")");
							$(".middleBar a[data-original-title='Wishlist'] sub").text(data);
						}
						else if(data == 0){
							$('.fa-heart').parent().find('span').remove();
							$(".middleBar a[data-original-title='Wishlist'] sub").text(data);
						}
					});
				}
				else{
					$.confirm({
						title: 'Erro!',
						content: data.Error,
						type: 'red',
						typeAnimated: true,
						buttons: {
							error: {
								text: 'ok',
								btnClass: 'btn-red',
							}
						}
					});
				}
			});
		}
		else{
			$.confirm({
				title: 'Erro!',
				content: 'Deverá efetuar login para poder adicionar a publicação à wishlist',
				type: 'red',
				typeAnimated: true,
				buttons: {
					error: {
						text: 'ok',
						btnClass: 'btn-red',
					}
				}
			});
		}
	});
}

function checkNomeLength() {

	$(':text').on('blur', function(){
		if(this.value.length <= 0){
			$(this).closest('div .form-group').addClass('has-error');
			$(this).next().remove();
			$(this).after('<span id="helpBlock" class="help-block">O campo nome é de preenchimento obrigatório</span>');
		}
		else{
			$(this).closest('div .form-group').removeClass('has-error');
			$(this).next().remove();
		}
	});
}

function checkEmailLength() {

	$('input[type=email]').on('blur', function(){
		if(this.value.length <= 0){
			$(this).closest('div .form-group').addClass('has-error');
			$(this).next().remove();
			$(this).after('<span id="helpBlock" class="help-block">O campo email é de preenchimento obrigatório</span>');
		}
		else{
			$(this).closest('div .form-group').removeClass('has-error');
			$(this).next().remove();
		}
	});  
}

function checkCommentLength() {

	$('textarea').on('blur', function(){
		if(this.value.length <= 0){
			$(this).closest('div .form-group').addClass('has-error');
			$(this).next().remove();
			$(this).after('<span id="helpBlock" class="help-block">O campo mensagem é de preenchimento obrigatório</span>');
		}
		else{
			$(this).closest('div .form-group').removeClass('has-error');
			$(this).next().remove();
		}
	});
}