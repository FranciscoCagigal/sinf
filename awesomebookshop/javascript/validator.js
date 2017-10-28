$(document).ready(function() {

	$('#password').on('change input', function(){
		var passwordLenght = ($(this).val()).length;
		var div = ($(this).closest('div'));

		if (passwordLenght >= 6){
			div.addClass('has-success');
			div.removeClass('has-error');
			$('#submit').prop('disabled', false);
			$('span[data-valmsg-for="pass"]').text('')
		}
		else{
			div.addClass('has-error');
			$('#submit').prop('disabled', true);
			$('span[data-valmsg-for="pass"]').text('A password tem que conter mais de 6 carateres'); 
		}
		
	});

});		