flag = true;
sortByIdFlag = true;
sortByPublicationNameFlag = false;
sortByCLientNameFlag = false;
sortByClassificationFlag = false;

$(document).ready(function() {
    $('#search').on('click', function(){
    	commentAction();
	});

	$('.form-horizontal').keypress(function(e){
		if(e.keyCode==13)
			commentAction();
	});

    function commentAction(){
    	if (flag){
            flag = false;
	    	var nome_cliente = $('#nome_cliente').val();
	        var email_cliente = $('#email_cliente').val();
	        var nome_publicacao = $('#nome_publicacao').val();
	        var comments = $('#comments').val();

	        $('.comment_content').empty();

	        $.getJSON("../../api/admin/comment_search.php", {nome_cliente: nome_cliente, email_cliente: email_cliente, nome_publicacao: nome_publicacao, comments: comments}, function(data){

		        if(data.length === 0 || data == "NULL"){
		            $('.comment_content').append('<p>Sem comentários com os dados de entrada</p>');
		        
		        }else{
		            
		            $('.comment_content').append('<p>Comentários das publicações na loja</p><table class="table table-striped projects" id="myTable"><thead><tr><th style="width: 6%" id="orderById">ID <span class="glyphicon glyphicon-sort"></span></th><th style="width: 14%" id="orderByPublicationName">Nome da Publicação <span class="glyphicon glyphicon-sort"></span></th><th style="width: 14%" id="orderByCLientName">Nome do Cliente <span class="glyphicon glyphicon-sort"></span></th><th style="width: 10%" id="orderByClassification">Classificação <span class="glyphicon glyphicon-sort"></span></th><th style="width: 19%">Comentário</th><th style="width: 14%">Ações </th></tr></thead><tbody>');
		            
		            for (var i in data){
		                $('.comment_content').find('tbody').append('<tr><td>'+data[i].comentarioid+'</td><td><a>'+data[i].titulo+'</a></td><td><a>'+data[i].nome+'</a></td><td><a class="fa fa-star"> '+data[i].classificacao+'</a></td><td><a>'+data[i].texto+'</a></td><td><a href="../publications/publication.php?id='+data[i].publicacaoid+'" class="btn btn-primary btn-xs"><i class="fa fa-folder"></i> Ver </a><a href="../../actions/admin/comment_remove.php?id='+data[i].comentarioid+'" class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i> Eleminar </a></td></tr>');
					}

		            $('.comment_content').append('</tbody></table>');
		        }

		        flag = true;
	        });
        }
    }

	$('#clean').on('click', function(){
    	$('#nome_cliente').val("");
        $('#email_cliente').val("");
        $('#nome_publicacao').val("");
    });


	$(document).on('click', '#orderById', function () {
		sortTable(0, "INTEGER", sortByIdFlag);
		sortResete('sortByIdFlag');
	});

	$(document).on('click', '#orderByPublicationName', function () {
  		sortTable(1, "STRING", sortByPublicationNameFlag);
  		sortResete('sortByPublicationNameFlag');

	});

	$(document).on('click', '#orderByCLientName', function () {
  		sortTable(2, "DATE", sortByCLientNameFlag);
    	sortResete('sortByCLientNameFlag');
 
	});
	
	$(document).on('click', '#orderByClassification', function () {
    	sortTable(3, "STRING", sortByClassificationFlag); 
    	sortResete('sortByClassificationFlag');
	});

	function sortResete(sortBy){
	switch(sortBy) {
	    case 'sortByIdFlag':
			sortByIdFlag = !sortByIdFlag;
			sortByPublicationNameFlag = false;
			sortByCLientNameFlag = false;
			sortByClassificationFlag = false;
	        break;

	    case 'sortByPublicationNameFlag':
    		sortByPublicationNameFlag = !sortByPublicationNameFlag; 
	    	sortByIdFlag = false;
			sortByCLientNameFlag = false;
			sortByClassificationFlag = false;
	        break;

	    case 'sortByCLientNameFlag':
   			sortByCLientNameFlag = !sortByCLientNameFlag;
	    	sortByIdFlag = false;
			sortByPublicationNameFlag = false;
			sortByClassificationFlag = false;
	    	break;

	     case 'sortByClassificationFlag':
   			sortByClassificationFlag = !sortByClassificationFlag;
	     	sortByIdFlag = false;
			sortByPublicationNameFlag = false;
			sortByCLientNameFlag = false;
	     	break;
		}
	}

});