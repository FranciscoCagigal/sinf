$(document).ready(function() {
	updateCartNumItems();
	updateWishListNumItems();
	updateBasketNumItems();
  updateOrderNumItems();
});

function updateCartNumItems() {
  $.getJSON("../../api/users/get_cart_items.php", function(data) {
    if (data > 0) {
      $('.fa-shopping-cart').parent().append('<span class="text-primary">(' + data + ')</span>');
    }
  });
}

function updateWishListNumItems() {
  $.getJSON("../../api/users/get_wishlist_items.php", function(data) {
    if (data > 0) {
      $('.fa-heart').parent().append('<span class="text-primary">(' + data + ')</span>');
    }
  });
}

function updateBasketNumItems() {
  $.getJSON("../../api/users/get_cart_items.php", function(data) {
      $('.fa-shopping-basket').append('<span class="hidden-xs"> Carrinho<sup class="text-primary">(' + data + ')</sup><i class="fa fa-angle-down ml-5"></i></span>');
  });
}

function updateOrderNumItems() {
  $.getJSON("../../api/users/get_order_list.php", function(data) {
    if (data > 0) {
      $('.fa-bar-chart').parent().append('<span class="text-primary">(' + data + ')</span>');
    }
  });
}