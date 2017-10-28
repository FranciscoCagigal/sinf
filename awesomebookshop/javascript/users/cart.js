$(document).ready(function() {
	updateCartNumberItems();
});

function updateCartNumberItems() {
	
	$('select').on('change', function (){
		var valueSelected = this.value;
		var itemSelected = this.closest('tr');
		var idSelected = itemSelected.getAttribute('data-id');

		$.getJSON("../../api/users/update_cart_items.php", {id: idSelected, value: valueSelected}, function(data) {

			if(data.Success){   	

				var price = itemSelected.getAttribute('data-price');
				
				$(itemSelected).find('td[data-column="total"]').children().text("€" + price*valueSelected);
				
				$('.cart-items').find("li[data-id='"+idSelected+"'] strong[data-type='quantidade']").text(valueSelected);
			}
		});
	});

	$('.close').on('click', function (){
		var tableBody = $(this).closest('tbody');
		var itemSelected = this.closest('tr');
		var idSelected = itemSelected.getAttribute('data-id');

		$.getJSON("../../api/users/remove_cart_item.php", {id: idSelected}, function(data) {
			
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
						$('.fa-shopping-cart').parent().find('span').text("(" + data + ")");
						$('.fa-shopping-basket').parent().find('span .text-primary').text("(" + data + ")");
						$('.cart-items').find("li[data-id='"+idSelected+"']").remove();
					}
					else if(data == 0){
						$('.fa-shopping-cart').parent().find('span').remove();
						$('.fa-shopping-basket').parent().find('span .text-primary').remove();
						$('.cart-items').find("li[data-id='"+idSelected+"']").remove();
						tableBody.append("<tr></tr>");
						tableBody.find('tr').append('<span>Não existem produtos no seu carrinho</span>');
					}
				});
			}
		});
	});
}