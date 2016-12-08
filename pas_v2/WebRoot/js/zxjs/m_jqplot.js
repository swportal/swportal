
var j = {jqplot :{}};
j.jqplot.diagram = {
	/**
	
	 */
	base : function(document, s, xtitle, title, ticks, x_label, y_label, max, t){
		var renderer;
		if(t == 1) renderer = $.jqplot.BlockRenderer ;
		else if(t == 2) renderer = $.jqplot.BarRenderer ;
        var plot3 = $.jqplot(document, s, {
        	title: title,
			legend:{show:true,labels: xtitle},
			animate:true,
			seriesDefaults: {  
               renderer: renderer, // 
               pointLabels: { show: true }  
            },
			axes:{
				yaxis:{
            		label: y_label==null?"":y_label,
            		max:max,
            		min:0
				},
				xaxis:{
					renderer: $.jqplot.CategoryAxisRenderer, // 
					ticks: ticks,
                	label: x_label==null?"":x_label
				}
			}, 
			series:[{color:'#5FAB78'}] 
        });
	}
};