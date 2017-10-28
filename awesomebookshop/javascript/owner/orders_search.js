flag = true;
sortByIdFlag = true;
sortByNameFlag = false;
sortByTotalPriceFlag = false;
sortByStatusFlag = false;
sortByDateFlag = false;

$(document).ready(function() {
    $(document).on('click', '#search', function (){
        ordersSearch();
    });

    $('.form-horizontal').keypress(function(e){
        if(e.keyCode==13)
            ordersSearch();
    });

    function ordersSearch(){
        if (flag){
            flag = false;
            var nome_cliente = $('#nome_cliente').val();
            var email_cliente = $('#email_cliente').val();
            var id_encomenda = $('#id_encomenda').val();
            var estadoencomenda = $('#estadoencomenda').find('option:selected').val();

            $('.order_content').empty();

            $.getJSON("../../api/owner/orders_search.php", {nome_cliente: nome_cliente, email_cliente: email_cliente, id_encomenda: id_encomenda, estadoencomenda: estadoencomenda}, function(data){
                if(data.length === 0 || data == "NULL"){
                    $('.order_content').append('<p>Sem encomendas com os dados de entrada</p>');

                }else{
                    $('.order_content').append('<p>Encomendas listadas da loja</p><table class="table table-striped projects" id="myTable"><thead><tr><th id="orderByID" >ID <span class="glyphicon glyphicon-sort"></span></th><th id="orderByName">Nome cliente <span class="glyphicon glyphicon-sort"></span></th><th id="orderByTotalPrice">Preço Total <span class="glyphicon glyphicon-sort"></span></th><th id="orderByState">Estado <span class="glyphicon glyphicon-sort"></span></th><th id="orderByDate">Data <span class="glyphicon glyphicon-sort"></span></th><th>Ações</th></tr></thead><tbody>');
                    
                    for (var i in data){
                        var estado_encomenda;

                        if (data[i].estado == "Em processamento")
                            estado_encomenda = '<button class="btn btn-info btn-xs">Em processamento</button>';

                        else if (data[i].estado == "Processada")
                            estado_encomenda = '<button class="btn btn-primary btn-xs">Processada</button>';

                        else if (data[i].estado == "Enviada")
                            estado_encomenda = '<button class="btn btn-success btn-xs">Enviada</button>';
                        
                        else if (data[i].estado == "Devolvida")
                            estado_encomenda = '<button class="btn btn-warning btn-xs">Devolvida</button>';
                        
                        else
                            estado_encomenda = '<button class="btn btn-danger btn-xs">Cancelada</button>';

                        var dataRes = data[i].data;
                        var arr = dataRes.split(' ');
                        var arr1 = arr[1].split('.');
                        dataRes = arr[0] + " " + arr1[0];

                        $('.order_content').find('tbody').append('<tr><td>'+parseFloat(data[i].encomendaid)+'</td><td><a>'+data[i].nomecliente+'</a></td><td><a>'+parseFloat(data[i].total).toFixed(2)+' €</a></td><td>'+estado_encomenda+'</td><td><a>'+dataRes+'</a></td><td><a href="order.php?id='+data[i].encomendaid+'" class="btn btn-info btn-xs"><i class="fa fa-pencil"></i> Ver/Editar </a></td></tr>');
                    }

                $('.order_content').append('</tbody></table>');
                }

                flag = true;
            });
        }
    }

    $('#clean').on('click', function(){
        $('#nome_cliente').val("");
        $('#email_cliente').val("");
        $('#id_encomenda').val("");
        $('#estadoencomenda').val("Escolha uma opção");
    });

    $(document).on('click', '#orderByID', function () {
        sortTable(0, "INTEGER", sortByIdFlag); 
        sortResete('sortByIdFlag');
    });

    $(document).on('click', '#orderByName', function () {
        sortTable(1, "STRING", sortByNameFlag);
        sortResete('sortByNameFlag');
    });

    $(document).on('click', '#orderByTotalPrice', function () {
        sortTable(2, "INTEGER", sortByTotalPriceFlag); 
        sortResete('sortByTotalPriceFlag');
    });

    $(document).on('click', '#orderByState', function () {
        sortTable(3, "STRING", sortByStatusFlag);
        sortResete('sortByStatusFlag');
    });

    $(document).on('click', '#orderByDate', function () {
        sortTableDateAll(4, sortByDateFlag);
        sortResete('sortByDateFlag');
    });

    function sortResete(sortBy){
        switch(sortBy) {
            case 'sortByIdFlag':
                sortByIdFlag = !sortByIdFlag;
                sortByNameFlag = false;
                sortByTotalPriceFlag = false;
                sortByStatusFlag = false;
                sortByDateFlag = false;
                break;

            case 'sortByNameFlag':
                sortByNameFlag = !sortByNameFlag; 
                sortByIdFlag = false;
                sortByTotalPriceFlag = false;
                sortByStatusFlag = false;
                sortByDateFlag = false;
                break;

            case 'sortByTotalPriceFlag':
                sortByTotalPriceFlag = !sortByTotalPriceFlag;
                sortByIdFlag = false;
                sortByNameFlag = false;
                sortByStatusFlag = false;
                sortByDateFlag = false;
                break;

            case 'sortByStatusFlag':
                sortByStatusFlag = !sortByStatusFlag; 
                sortByIdFlag = false;
                sortByNameFlag = false;
                sortByTotalPriceFlag = false;
                sortByDateFlag = false;
                break;

            case 'sortByDateFlag':
                sortByDateFlag = !sortByDateFlag; 
                sortByIdFlag = false;
                sortByNameFlag = false;
                sortByTotalPriceFlag = false;
                sortByStatusFlag = false;
                break;
        }
    }

});