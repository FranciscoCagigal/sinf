$(document).ready(function() {
  checkNomeLength();
  checkEmailLength();
  checkMessageLength();
});

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

function checkMessageLength() {

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