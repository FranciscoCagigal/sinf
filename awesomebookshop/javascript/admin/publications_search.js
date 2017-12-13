flag = true;
sortByIdFlag = true;
sortByBookNameFlag = false;
sortByAuthorNameFlag = false;
sortByPriceFlag = false;
sortByPromotionalFlag = false;

$(document).ready(function() {
    $(document).on('click', '#search', function (){
        publicationsSearch();
    });

    $('.form-horizontal').keypress(function(e){
        if(e.keyCode==13)
            publicationsSearch();
    });

    $('#categoria').on('change', function(){
        var category = $(this).find('option:selected').val();

        $('#subcategoria').empty();

        if(category != "Escolha uma opção"){
            $.getJSON("../../api/owner/updateSubCategories.php", {categoria: category}, function(data){
                $('#subcategoria').append('<option value="Escolha uma opção">Escolha uma opção</option>');
                for (var i in data){
                    $('#subcategoria').append('<option value="'+ data[i].subcategoriaid +'">'+data[i].nome+'</option>');
                }
            });
        }else
            $('#subcategoria').append('<option value="Escolha uma opção">Escolha uma opção</option>');
    });

    function publicationsSearch(){
        if (flag){
            flag = false;
            var nome_livro = $('#nome_livro').val();
            var nome_autor = $('#nome_autor').val();
            var nome_editora = $('#nome_editora').val();
            var categoria = $('#categoria').find('option:selected').val();
            var subcategoria = $('#subcategoria').find('option:selected').val();
            
            if(typeof subcategoria === 'undefined')
                subcategoria = "Escolha uma opção";

            $('.publications_content').empty(); 

            $.getJSON("../../api/owner/publications_search.php", {nome_livro: nome_livro, nome_autor: nome_autor, nome_editora: nome_editora, categoria: categoria, subcategoria: subcategoria}, function(data){
                if(data.length === 0 || data == "NULL"){
                    $('.publications_content').append('<p>Sem Publicações com os dados de entrada</p>');
                }else{
                    $('.publications_content').append('<p>Todos as publicações presentes na loja</p><table class="table table-striped projects" id="myTable"><thead><tr><th style="width: 6%" id="orderByID" >ID <span class="glyphicon glyphicon-sort"></span></th><th style="width: 30%" id="orderByBookName">Nome do livro <span class="glyphicon glyphicon-sort"></span></th><th id="orderByAuthorName">Nome do Autor <span class="glyphicon glyphicon-sort"></span></th><th id="orderByPrice">Preço <span class="glyphicon glyphicon-sort"></span></th><th style="width: 20%" id="orderByPromotionalPrice">Preço Promocional <span class="glyphicon glyphicon-sort"></span></th><th>Ações</th></tr></thead><tbody>');
                    
                    for (var i in data){
                        var nome_autor

                        if (data[i].nome_autor)
                            nome_autor = data[i].nome_autor;
                        else 
                            nome_autor = "Sem Autor";
                        
                        if(data[i].publicacaoid !== null)
                            $('.publications_content').find('tbody').append('<tr><td>'+data[i].publicacaoid+'</td><td><a>'+data[i].titulo+'</a></td><td><a>'+nome_autor+'</a></td><td><a>'+parseFloat(data[i].preco).toFixed(2)+' €</a></td><td><a>'+data[i].precopromocional+' €</a></td><td><a href="../publications/publication.php?id='+data[i].publicacaoid+'" class="btn btn-primary btn-xs"><i class="fa fa-folder"></i> Ver </a><a href="publication_edit.php?id='+data[i].publicacaoid+'" class="btn btn-info btn-xs"><i class="fa fa-pencil"></i> Editar </a></td></tr>');
                    }
                    $('.publications_content').append('</tbody></table>');
                }
                flag = true;
            });
        }
    }

    $('#clean').on('click', function(){
        $('#nome_livro').val("");
        $('#nome_autor').val("");
        $('#nome_editora').val("");
        $('#categoria').val("Escolha uma opção");
        $('#subcategoria').val("Escolha uma opção");
    });

    $(document).on('click', '#orderByID', function () {
        sortTable(0, "INTEGER", sortByIdFlag); 
        sortResete('sortByIdFlag');
    });

    $(document).on('click', '#orderByBookName', function () {
        sortTable(1, "STRING", sortByBookNameFlag);
        sortResete('sortByBookNameFlag');
    });

    $(document).on('click', '#orderByAuthorName', function () {
        sortTable(2, "STRING", sortByAuthorNameFlag); 
        sortResete('sortByAuthorNameFlag');
    });

    $(document).on('click', '#orderByPrice', function () {
        sortTable(3, "INTEGER", sortByPriceFlag);
        sortResete('sortByPriceFlag'); 
    });

    $(document).on('click', '#orderByPromotionalPrice', function () {
        sortTable(4, "INTEGER", sortByPromotionalFlag);
        sortResete('sortByPromotionalFlag');
    });

    function sortResete(sortBy){
        switch(sortBy) {
            case 'sortByIdFlag':
                sortByIdFlag = !sortByIdFlag;
                sortByBookNameFlag = false;
                sortByAuthorNameFlag = false;
                sortByPriceFlag = false;
                sortByPromotionalFlag = false;
                break;

            case 'sortByBookNameFlag':
                sortByBookNameFlag = !sortByBookNameFlag; 
                sortByIdFlag = false;
                sortByAuthorNameFlag = false;
                sortByPriceFlag = false;
                sortByPromotionalFlag = false;
                break;

            case 'sortByAuthorNameFlag':
                sortByAuthorNameFlag = !sortByAuthorNameFlag;
                sortByIdFlag = false;
                sortByBookNameFlag = false;
                sortByPriceFlag = false;
                sortByPromotionalFlag = false;
                break;

            case 'sortByPriceFlag':
                sortByPriceFlag = !sortByPriceFlag; 
                sortByIdFlag = false;
                sortByBookNameFlag = false;
                sortByAuthorNameFlag = false;
                sortByPromotionalFlag = false;
                break;

            case 'sortByPromotionalFlag':
                sortByPromotionalFlag = !sortByPromotionalFlag;
                sortByIdFlag = false;
                sortByBookNameFlag = false;
                sortByAuthorNameFlag = false;
                sortByPriceFlag = false;
                break;
        }
    }
});