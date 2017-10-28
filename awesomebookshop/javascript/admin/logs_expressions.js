flag = true;
sortByExpressionFlag = true;
sortByTimesFlag = false;
var startDate = null;
var endDate = null;

$(document).ready(function() {

	$('#reservation').daterangepicker(null, function(start, end) {
		startDate = start.format("YYYY-MM-DD");
		endDate = end.format("YYYY-MM-DD");
	});

	$('#reservation').val("");
	
    $(document).on('click', '#search', function(){
    	logsExpressionsSearch();
	});

	$('.form-horizontal').keypress(function(e){
		if(e.keyCode==13)
			logsExpressionsSearch();
    });

	function logsExpressionsSearch(){
		if (flag){
            flag = false;
	    	var expressao = $('#expressao').val();

	        $('.logs_content').empty();

	        $.getJSON("../../api/admin/logs_expressions.php", {expressao: expressao, startDate: startDate, endDate: endDate}, function(data){

		        if(data.length === 0 || data == "NULL"){
		            $('.logs_content').append('<p>Sem dados de pesquisa</p>');

		        }else{
		        	
		            $('.logs_content').append('<table class="table table-striped projects" id="myTable"><thead><tr><th style="width: 50%" id="orderByExpression">Expressão <span class="glyphicon glyphicon-sort"></th><th style="width: 50%" id="orderByTimes">Número de pesquisas <span class="glyphicon glyphicon-sort"></th></tr></thead><tbody>');

		            for (var i in data){
		                $('.logs_content').find('tbody').append('<tr><td>'+data[i].expressao+'</td><td>'+data[i].conta+'</td></tr>');
					}
		        	$('.logs_content').append('</tbody></table>');
		        }

		        flag = true;
	        });
        }
	}


	$('#clean').on('click', function(){
    	$('#expressao').val("");
        $('#reservation').val("");
    });

   	$(document).on('click', '#orderByExpression', function () {
		sortTable(0, "STRING", sortByExpressionFlag); 
		sortResete('sortByExpressionFlag');
	});


  	$(document).on('click', '#orderByTimes', function () {
  		sortTable(1, "INTEGER", sortByTimesFlag);
  		sortResete('sortByTimesFlag'); 
	});

	function sortResete(sortBy){
	switch(sortBy) {
	    case 'sortByExpressionFlag':
    		sortByExpressionFlag = !sortByExpressionFlag;
			sortByTimesFlag = false;
	        break;

	    case 'sortByTimesFlag':
    		sortByTimesFlag = !sortByTimesFlag;
    		sortByExpressionFlag = false;
	        break;
		}
	}
	
});