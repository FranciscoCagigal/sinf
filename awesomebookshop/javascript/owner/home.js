$(document).ready(function() {
    init_flot_chart();

    $("#reportrange").on("apply.daterangepicker",function(a,b){

    	var firstDate = b.startDate.format("YYYY-MM-DD");
    	var lastDate = b.endDate.format("YYYY-MM-DD");

        $('.top5orders').empty();
        $('.last5orders').empty();

        var flag = "top5orders";
    	$.getJSON("../../api/owner/home.php", {firstDate: firstDate, lastDate: lastDate, flag: flag}, function(data){
    		console.log(data);
            $('.top5ordersTitle').text(firstDate+' e '+lastDate);
            if(data.length === 0 || data == "NULL"){
                $('.top5orders').append('<li class="media event"><div class="media-body"><a class="title">Sem encomendas entre as datas selecionadas</a></div></li>');
            }else{
                for (var i in data){
                    $('.top5orders').append('<li class="media event"><a class="pull-left border-aero profile_thumb"><i class="fa fa-user aero"></i></a><div class="media-body"><a class="title">'+data[i].nomecliente+'</a><p><strong>'+data[i].total+'€. </strong> Pagos na encomenda </p><p> <small>'+data[i].nrEncomendasHoje+' Encomenda(s) hoje</small></p></div></li>');
                }
            }
        });

        flag = "last5orders";
        $.getJSON("../../api/owner/home.php", {firstDate: firstDate, lastDate: lastDate, flag: flag}, function(data){
            console.log(data);
            $('.last5ordersTitle').text(firstDate+' e '+lastDate);
            if(data.length === 0 || data == "NULL"){
                $('.last5orders').append('<li class="media event"><div class="media-body"><a class="title">Sem publicações vendidas entre as datas selecionadas</a></div></li>');
            }else{
                for (var i in data){
                    $('.last5orders').append('<li class="media event"><a class="pull-left border-aero profile_thumb"><i class="fa fa-user aero"></i></a><div class="media-body"><a class="title"><h5>'+data[i].titulopublicacao+'</h5></a><p>Preço publicação <strong>'+data[i].total+'€</strong></p></div></li>');
                }
            }
        });

    })

    function init_flot_chart(){
    
        if( typeof ($.plot) === 'undefined'){ return; }
    
        console.log('init_flot_chart');
    
        var chart_plot_02_data = [];

        for (var i = 0; i < 7; i++) {
          chart_plot_02_data.push([new Date(Date.today().add(i).days()).getTime(), randNum() + i + i + 10]);
        }
    
        var chart_plot_02_settings = {
            grid: {
                show: true,
                aboveData: true,
                color: "#3f3f3f",
                labelMargin: 10,
                axisMargin: 0,
                borderWidth: 0,
                borderColor: null,
                minBorderMargin: 5,
                clickable: true,
                hoverable: true,
                autoHighlight: true,
                mouseActiveRadius: 100
            },
            series: {
                lines: {
                    show: true,
                    fill: true,
                    lineWidth: 2,
                    steps: false
                },
                points: {
                    show: true,
                    radius: 4.5,
                    symbol: "circle",
                    lineWidth: 3.0
                }
            },
            legend: {
                position: "ne",
                margin: [0, -25],
                noColumns: 0,
                labelBoxBorderColor: null,
                labelFormatter: function(label, series) {
                    return label + '&nbsp;&nbsp;';
                },
                width: 40,
                height: 1
            },
            colors: ['#96CA59', '#3F97EB', '#72c380', '#6f7a8a', '#f7cb38', '#5a8022', '#2c7282'],
            shadowSize: 0,
            tooltip: true,
            tooltipOpts: {
                content: "%s: %y.0",
                xDateFormat: "%d/%m",
            shifts: {
                x: -30,
                y: -50
            },
            defaultTheme: false
            },
            yaxis: {
                min: 0
            },
            xaxis: {
                mode: "time",
                minTickSize: [1, "day"],
                timeformat: "%d/%m/%y",
                min: chart_plot_02_data[0][0],
                max: chart_plot_02_data[6][0]
            }
        };  
        
        if ($("#chart_plot_02").length){
            console.log('Plot2');
            
            $.plot( $("#chart_plot_02"), 
            [{ 
                label: "Número de ncomendas diárias", 
                data: chart_plot_02_data, 
                lines: { 
                    fillColor: "rgba(150, 202, 89, 0.12)" 
                }, 
                points: { 
                    fillColor: "#fff" } 
            }], chart_plot_02_settings);
            
        }
    }

});