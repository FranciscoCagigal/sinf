$(document).ready(function() {
	updateWishListNumberItems();
});

function updateWishListNumberItems() {

	$('.btn').on('click', function (){

		var tableBody = $(this).closest('tbody');
		var itemSelected = $(this).closest('tr');
		var idSelected = itemSelected.attr('data-id');
		var itemLinkSelected = itemSelected.find('a').attr('href');
		var itemImageSelected = itemSelected.find('img').attr('src');
		var itemTitle = itemSelected.find('h6 a').text();
		var itemPrice = itemSelected.attr('data-price');

		$.getJSON("../../api/users/move_item_wishlist_to_cart.php", {id: idSelected}, function(data) {

			if(data.Success){   	  	

				itemSelected.remove();

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
						$('.cart-items').find('.items').append('<li data-id="' + idSelected + '"><a href="' + itemLinkSelected + '" class="product-image"><img src="' + itemImageSelected + '" alt="Sample Product "></a><div class="product-details"><div class="close-icon"> <a href="javascript:void(0);"><i class="fa fa-close"></i></a></div><p class="product-name"> <a href="' + itemLinkSelected + '">' + itemTitle + '</a></p><strong data-type="quantidade">' + 1 + '</strong> x <span class="price text-primary">€' + itemPrice + '</span></div><!-- end product-details --></li><!-- end item -->');
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
						tableBody.append("<tr></tr>");
						tableBody.find('tr').append('<span>Não existem produtos na sua lista de desejos</span>');
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
	});

	$('.close').on('click', function (){

		var tableBody = $(this).closest('tbody');
		var itemSelected = this.closest('tr');
		var idSelected = itemSelected.getAttribute('data-id');

		$.getJSON("../../api/users/remove_wishlist_item.php", {id: idSelected}, function(data) {

			if(data.Success){   	

				itemSelected.remove();

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
						tableBody.append("<tr></tr>");
						tableBody.find('tr').append('<span>Não existem produtos na sua lista de desejos</span>');
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
	});
}