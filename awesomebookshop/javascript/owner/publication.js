$(document).ready(function() {
    var conta = 0;
    $('#autor').on('change', function(){
        if(($(this).find('option:selected').val() == "novoAutor") && conta == 0){
            conta = 1;
            var aux = $(this).closest('.form-group');
            var options = null;
            $.getJSON("../../api/owner/getCountries.php", {}, function(data){
                for (var i in data){
                    options += '<option value="'+data[i].paisid+'">'+data[i].nome+'</option>';
                }
                aux.after('<div class="divNovoAutor"><div class="form-group"><label class="control-label col-md-2 col-sm-3 col-xs-12">Nome Autor <span class="required">*</span></label><div class="col-md-10 col-sm-3 col-xs-12"><input type="text" class="form-control" required="required" name="nomeAutor" {if $FORM_VALUES}value="{$FORM_VALUES.nomeAutor}"{/if} placeholder="Nome do Autor"></div></div><div class="form-group"><label class="control-label col-md-2 col-sm-3 col-xs-12">Biografia </span></label><div class="col-md-10 col-sm-9 col-xs-12"><textarea class="form-control" rows="3" name="biografia" placeholder="Biografia do Autor"></textarea></div></div><div class="form-group"><label class="col-md-2 col-sm-9 col-xs-12 control-label">Genero</span></label><div class="col-md-4 col-sm-9 col-xs-12"><div class="radio"><label><input type="radio" checked="" value="Masculino" name="genero"> Masculino</label><label><input type="radio" value="Feminino" name="genero"> Feminino</label></div></div><label class="control-label col-md-2 col-sm-3 col-xs-12">Data de Nascimento <span class="required">*</span></label><div class="col-md-4 col-sm-6 col-xs-12 has-feedback"><input type="text" class="form-control has-feedback-left" id="single_cal2" name="datanascimento" required="required" placeholder="MM/DD/YYYY" aria-describedby="inputSuccess2Status4"><span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span><span id="inputSuccess2Status4" class="sr-only">(success)</span></div></div><div class="form-group"><label class="control-label col-md-2 col-sm-3 col-xs-12">Pais <span class="required">*</span></label><div class="col-md-10 col-sm-3 col-xs-12"><select class="form-control" required="required" name="pais" id="pais">'+options+'</select></div></div></div>');
            });

        }else if(conta == 1){
            $(".divNovoAutor").remove();
            conta = 0;
     }
 });

    $('#categoria').on('change', function(){
        var category = $(this).find('option:selected').val();

        $('#subcategoria').empty();
        
        $.getJSON("../../api/owner/updateSubCategories.php", {categoria: category}, function(data){
            
            for (var i in data){
                $('#subcategoria').append('<option value="'+ data[i].subcategoriaid +'">'+data[i].nome+'</option>');
            }
        });
    });

    $('#preco_promocional').on('change input', function(){
        var price = parseFloat($('#preco').val());
        var promotionalPrice = parseFloat($('#preco_promocional').val());
        var div = ($(this).closest('div')).parent();

       if(promotionalPrice > price){
            div.addClass('has-error');
            $('#submit').prop('disabled', true);
            $('span[data-valmsg-for="preco"]').text('Preço tem que ser superior ao preço promocional!'); 
            $('span[data-valmsg-for="preco_promocional"]').text('Preço promocional tem que ser inferior ao preço!'); 
        }
        else{
            div.addClass('has-success');
            div.removeClass('has-error');
            $('#submit').prop('disabled', false);
            $('span[data-valmsg-for="preco"]').text(''); 
            $('span[data-valmsg-for="preco_promocional"]').text(''); 
        }
    });

});