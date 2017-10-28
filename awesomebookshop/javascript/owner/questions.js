flag = true;
sortByUserNameFlag = false;
sortByDateFlag = true;
sortByStatusFlag = false;

$(document).ready(function() {

	$(document).on('click', '#search', function () {
    	questionsSearch();
	});

	$('.form-horizontal').keypress(function(e){
		if(e.keyCode==13)
			questionsSearch();
	});

	function questionsSearch(){
		if (flag){
          	flag = false;
	    	var nome_utilizador = $('#nome_utilizador').val();
	        var email_utilizador = $('#email_utilizador').val();
	        var estadoPergunta = $('#estadoPergunta').val();

	        $('.question_content').empty();

	        $.getJSON("../../api/owner/questions.php", {nome_utilizador: nome_utilizador, email_utilizador: email_utilizador, estadoPergunta: estadoPergunta}, function(data){

		        if(data.length === 0 || data == "NULL"){
		            $('.question_content').append('<p>Sem perguntas com os dados de entrada</p>');
		        
		        }else{
		        	
		            $('.question_content').append('<p>Perguntas listadas da loja</p><table class="table table-striped projects" id="myTable"><thead><tr><th id="questionByName">Nome Utilizador <span class="glyphicon glyphicon-sort"></span></th><th id="questionByDate">Data <span class="glyphicon glyphicon-sort"></span></th><th id="questionByStatus">Estado <span class="glyphicon glyphicon-sort"></span></th><th>Mensagem</th><th>Ações</th></tr></thead><tbody>');
		            
		            for (var i in data){

		            	var estado_utilizador;
		            	
		            	if(data[i].respondido){
		            		estado_utilizador = '<button class="btn btn-success btn-xs">Respondido</button>';
		            	}
		            	else{
		            		estado_utilizador = '<button class="btn btn-warning btn-xs">Não respondido</button>';
		            	}

		            	var dataRes = data[i].data;

                        var arr = dataRes.split(' ');
                        
                        var arr1 = arr[1].split('.');
                        split = arr[0].split('-');
			            arr = (split[2] + "-" + split[1] + "-" + split[0]);
                        dataRes = arr + " " + arr1[0];
		                $('.question_content').find('tbody').append('<tr><td>'+data[i].nome+'</td><td>'+dataRes+'</td><td>'+estado_utilizador+'</td><td>'+data[i].mensagem+'</td> <td><a href="../../actions/owner/question_status.php?id='+data[i].perguntautilizadorid+'" class="btn btn-info btn-xs"><i class="fa fa-pencil"></i> Mudar Estado </a></td></tr>');

					}
		 
		            $('.question_content').append('</tbody></table>');
		        }

		        flag = true;
	        });
        }
	}

	//TESTE
	$(document).on('click', '#updateStatus', function () {
		var idQuestion = $(this).attr('value');
		var parent = $(this).parent().parent()[0].innerHTML;
	});


	$('#clean').on('click', function(){
    	$('#nome_utilizador').val("");
        $('#email_utilizador').val("");
        $('#estadoPergunta').val("Escolha uma opção");
    });


  $(document).on('click', '#questionByName', function () {
		sortTable(0, "STRING", sortByUserNameFlag); 
		sortResete('sortByUserNameFlag');
	});


  $(document).on('click', '#questionByDate', function () {
	  	sortTableDateAll(1, sortByDateFlag);
	  	sortResete('sortByDateFlag');
	});


	$(document).on('click', '#questionByStatus', function () {
	    sortTable(2, "STRING", sortByStatusFlag); 
	    sortResete('sortByStatusFlag');
	});


	function sortResete(sortBy){
		switch(sortBy) {
		    case 'sortByUserNameFlag':
		    	sortByUserNameFlag = !sortByUserNameFlag;
				sortByDateFlag = false;
				sortByStatusFlag = false;
		        break;
		    case 'sortByDateFlag':
		    	sortByDateFlag = !sortByDateFlag;
			    sortByUserNameFlag = false;
				sortByStatusFlag = false;
		        break;
		  	default:
		  		sortByStatusFlag = !sortByStatusFlag;
				sortByUserNameFlag = false;
				sortByDateFlag = false;
		}
	}

});