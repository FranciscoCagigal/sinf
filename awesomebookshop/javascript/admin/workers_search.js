flag = true;
sortByIdFlag = true;
sortByNameFlag = false;
sortByDateFlag = false;
sortByStatusFlag = false;

$(document).ready(function() {
    $(document).on('click', '#search', function (){
    	workersSearch();
	});

	$('.form-horizontal').keypress(function(e){
		if(e.keyCode==13)
			workersSearch();
    });

	function workersSearch(){
		if (flag){
            flag = false;
	    	var nome_funcionario = $('#nome_funcionario').val();
	        var email_funcionario = $('#email_funcionario').val();
	        var data_admissao = $('#single_cal4').val();
	        var estado_funcionario = $('#estado_funcionario').val();

			if(data_admissao){
	            var arr = data_admissao.split('/');
	            data_admissao = arr[2] +'/'+ arr[0] +'/'+ arr[1];
			}

	        $('.workers_content').empty();

	        $.getJSON("../../api/admin/workers_search.php", {nome_funcionario: nome_funcionario, email_funcionario: email_funcionario, data_admissao: data_admissao, estado_funcionario: estado_funcionario}, function(data){

		        if(data.length === 0 || data == "NULL"){
		            $('.workers_content').append('<p>Sem funcionários com os dados de entrada</p>');
		            
		        }else{

		            $('.workers_content').append('<p>Funcionários da loja</p><table class="table table-striped projects" id="myTable"><thead><tr><th style="width: 6%" id="orderById">ID <span class="glyphicon glyphicon-sort"></span></th><th style="width: 36%" id="orderByName">Nome do Funcionário <span class="glyphicon glyphicon-sort"></span></th><th style="width: 18%" id="orderByDate">Data de Admissão <span class="glyphicon glyphicon-sort"></span></th><th style="width: 10%" id="orderByState">Estado <span class="glyphicon glyphicon-sort"></span></th><th style="width: 20%">Ações</th></tr></thead><tbody>');
		            
		            for (var i in data){

		            	var estado_funcionario;
		            	var estado;

		            	if(data[i].ativo){
		            		estado_funcionario = '<button type="button" class="btn btn-success btn-xs">Ativo</button>';
		            		estado = ' btn-danger btn-xs"><i class="fa fa-warning"></i> Banir ';
		            	}
		            	else{
		            		estado_funcionario = ' <button type="button" class="btn btn-warning btn-xs">Inativo</button>';
		            		estado = ' btn-success btn-xs"><i class="fa fa-warning"></i> Ativar ';
		            	}

		            	date = data[i].dataadmissao;

		            	split = date.split(' ');
		            	date = split[0];
		            	horas = split[1];

		            	split = date.split('-');

		            	date = (split[2] + "-" + split[1] + "-" + split[0] + " " + horas);

		                $('.workers_content').find('tbody').append('<tr><td>'+data[i].funcionarioid+'</td><td><a>'+data[i].nome+'</a></td><td><a>'+date+'</a></td><td>'+estado_funcionario+'</td><td><a href="worker_edit.php?username='+data[i].username+'" class="btn btn-info btn-xs"><i class="fa fa-pencil"></i> Ver / Editar </a><a href="../../actions/admin/worker_status.php?username='+data[i].username+'" class="btn'+estado+'</a></td></tr>');
					}
		            $('.workers_content').append('</tbody></table>');
		        }

		        flag = true;
	        });
        }
	}

	$('#clean').on('click', function(){
    	$('#nome_funcionario').val("");
        $('#email_funcionario').val("");
        $('#single_cal4').val("");
        $('#estado_funcionario').val("Escolha uma opção");
    });

    $(document).on('click', '#orderById', function () {
		sortTable(0, "INTEGER", sortByIdFlag); 
    	sortResete('sortByIdFlag');
	});


  	$(document).on('click', '#orderByName', function () {
  		sortTable(1, "STRING", sortByNameFlag);
  		sortResete('sortByNameFlag');
	});

	$(document).on('click', '#orderByDate', function () {
  		sortTableDateAll(2, sortByDateFlag);
  		sortResete('sortByDateFlag');
	});
	
	$(document).on('click', '#orderByState', function () {
    	sortTable(3, "STRING", sortByStatusFlag); 
  		sortResete('sortByStatusFlag');
	});

	function sortResete(sortBy){
	switch(sortBy) {
	    case 'sortByIdFlag':
			sortByIdFlag = !sortByIdFlag;
			sortByNameFlag = false;
			sortByDateFlag = false;
			sortByStatusFlag = false;
	        break;

	    case 'sortByNameFlag':
    		sortByNameFlag = !sortByNameFlag; 
    		sortByIdFlag = false;
			sortByDateFlag = false;
			sortByStatusFlag = false;
	        break;

	    case 'sortByDateFlag':
   			sortByDateFlag = !sortByDateFlag;
			sortByIdFlag = false;
			sortByNameFlag = false;
			sortByStatusFlag = false;
	    	break;

	     case 'sortByStatusFlag':
	     	sortByStatusFlag = !sortByStatusFlag;
			sortByIdFlag = false;
			sortByNameFlag = false;
			sortByDateFlag = false;
	     	break;
		}
	}

});