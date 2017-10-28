$(document).ready(function() {
	removeGenderLabel();

	$(':password').on('change input', function(){
    if(this.value.length < 6){ // checks the password value length
       $(this).closest('div .form-group').addClass('has-error');
       $(this).next().remove();
       $(this).after('<span id="helpBlock" class="help-block">A password deve ter pelo menos 6 caracteres</span>');
   }
   else{
   	$(this).closest('div .form-group').removeClass('has-error');
   	$(this).next().remove();
   }
});
});

function removeGenderLabel() {
	$('.row-gender-edit').parent().attr('id', 'label-gender');
}