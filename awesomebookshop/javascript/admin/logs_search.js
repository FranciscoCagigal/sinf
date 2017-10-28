flag = true;
sortByIdFlag = true;
sortByNameFlag = false;
sortByDateFlag = false;
var startDate = null;
var endDate = null;

$(document).ready(function() {

	$('#reservation').daterangepicker(null, function(start, end) {
		startDate = start.format("YYYY-MM-DD");
		endDate = end.format("YYYY-MM-DD");
	});

	$('#reservation').val("");
	
    $(document).on('click', '#search', function (){
    	logsSearch();
	});

	$('.form-horizontal').keypress(function(e){
		if(e.keyCode==13)
			logsSearch();
    });

	function logsSearch(){
		if (flag){
            flag = false;
	    	var nome_utilizador = $('#nome_utilizador').val();
	        var username_utilizador = $('#username_utilizador').val();

	        $('.logs_content').empty();

	        $.getJSON("../../api/admin/logs_search.php", {nome_utilizador: nome_utilizador, username_utilizador: username_utilizador, startDate: startDate, endDate: endDate}, function(data){

		        if(data.length === 0 || data == "NULL"){
		            $('.logs_content').append('<p>Sem logins com os dados de entrada</p>');

		        }else{
		        	
		            $('.logs_content').append('<table class="table table-striped projects" id="myTable"><thead><tr><th style="width: 6%" id="orderById">ID <span class="glyphicon glyphicon-sort"></th><th style="width: 48%" id="orderByName">Nome do Utilizador <span class="glyphicon glyphicon-sort"></th><th style="width: 46%" id="orderByDate">Data <span class="glyphicon glyphicon-sort"></th></tr></thead><tbody>');

		            for (var i in data){

		            	var dataRes = data[i].data;

                        var arr = dataRes.split(' ');
                        
                        var arr1 = arr[1].split('.');
                        split = arr[0].split('-');
			            arr = (split[2] + "-" + split[1] + "-" + split[0]);
                        dataRes = arr + " " + arr1[0];

                        nome = data[i].nome.replace(/[^a-zA-Z 0-9]+/g,'');
                        
		                $('.logs_content').find('tbody').append('<tr><td>'+data[i].loginid+'</td><td><a>'+nome+'</a></td><td><a>'+dataRes+'</a></td></tr>');
					}
 
		        	$('.logs_content').append('</tbody></table>');
		        }

		        flag = true;
	        });
        }
	}


	$('#clean').on('click', function(){
    	$('#nome_utilizador').val("");
    	$('#username_utilizador').val("");
        $('#reservation').val("");
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

	function sortResete(sortBy){
	switch(sortBy) {
	    case 'sortByIdFlag':
    		sortByIdFlag = !sortByIdFlag;
			sortByNameFlag = false;
			sortByDateFlag = false;
	        break;

	    case 'sortByNameFlag':
    		sortByNameFlag = !sortByNameFlag;
    		sortByIdFlag = false;
			sortByDateFlag = false;
	        break;

	    case 'sortByDateFlag':
	    	sortByDateFlag = !sortByDateFlag; 
   			sortByIdFlag = false;
			sortByNameFlag = false;
	    	break;
		}
	}
	
});