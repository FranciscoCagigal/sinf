$(document).ready(function() {
	addAtiveClass();
});

function addAtiveClass() {
	$('a').each(function(){
		if ($(this).prop('href') == window.location.href) {
			$(this).parent().addClass('active');
		}
	});
}