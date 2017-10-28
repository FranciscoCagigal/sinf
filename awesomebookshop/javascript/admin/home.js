$(document).ready(function() {
    init_flot_chart();
    
    $("#reportrange").on("apply.daterangepicker",function(a,b){

    	var firstDate = b.startDate.format("YYYY-MM-DD");
    	var lastDate = b.endDate.format("YYYY-MM-DD");

        $('.top_comentarios').empty();
    	$('.top_usuarios').empty();
        $('.top_livros').empty();

        var flag = "top_comentarios";
        $.getJSON("../../api/admin/home.php", {firstDate: firstDate, lastDate: lastDate, flag: flag}, function(data){
            $('.top_comentarios').append('<div class="x_title"><h2>Últimos 5 Comentários <small>'+firstDate+' e '+lastDate+'</small></h2><div class="clearfix"></div></div><div class="x_content">');
            if(data.length === 0 || data == "NULL"){
                $('.top_comentarios').append('<article class="media event"><div class="media-body"><a class="title">Sem comentários entre as datas selecionadas</a></div></article>');
            }else{
                for (var i in data){
                    $('.top_comentarios').append('<article class="media event"><a class="pull-left border-aero profile_thumb"><i class="fa fa-comments-o aero"></i></a><div class="media-body"><a class="title">'+data[i].nome+'</a><p>'+data[i].texto+'</p></div></article>');
                }
            }
            $('.top_comentarios').append('</div>');
        });

        flag = "top_usuarios";
    	$.getJSON("../../api/admin/home.php", {firstDate: firstDate, lastDate: lastDate, flag: flag}, function(data){
            $('.top_usuarios').append('<div class="x_title"><h2>Top Usuários <small>'+firstDate+' e '+lastDate+'</small></h2><div class="clearfix"></div></div><div class="x_content">');
            if(data.length === 0 || data == "NULL"){
                $('.top_usuarios').append('<article class="media event"><div class="media-body"><a class="title">Sem encomendas entre as datas selecionadas</a></div></article>');
            }else{
                for (var i in data){
                    $('.top_usuarios').append('<article class="media event"><a class="pull-left border-aero profile_thumb"><i class="fa fa-user aero"></i></a><div class="media-body"><a class="title">'+data[i].nomecliente+'</a><p>Valor total gasto <strong>'+data[i].total+'€</strong> em publicações.</p></div></article>');
                }
            }
            $('.top_usuarios').append('</div>');
        });

        flag = 'top_livros';
        $.getJSON("../../api/admin/home.php", {firstDate: firstDate, lastDate: lastDate, flag: flag}, function(data){
            $('.top_livros').append('<div class="x_title"><h2>Top Publicações <small>'+firstDate+' e '+lastDate+'</small></h2><div class="clearfix"></div></div><div class="x_content">');
            if(data.length === 0 || data == "NULL"){
                $('.top_livros').append('<article class="media event"><div class="media-body"><a class="title">Sem Publicações entre as datas selecionadas</a></div></article>');
            }else{
                for (var i in data){
                    $('.top_livros').append('<article class="media event"><a class="pull-left border-aero profile_thumb"><i class="fa fa-user aero"></i></a><div class="media-body"><a class="title">'+data[i].titulo+'</a><p>Foram vendidos <strong>'+data[i].quantidade+'</strong> exemplares.</p></div></article>');
                }
            }
            $('.top_livros').append('</div>');
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