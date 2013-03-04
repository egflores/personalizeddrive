var chart;
d3.json('static/data/cumulativeLineData.json', function (data) {
	nv.addGraph(function() {
		chart = nv.models.lineChart()
		    .x(function(d) { return d[0] })
		    .y(function(d) { return d[1]/100 }) //adjusting, 100% is 1.00, not 100 as it is in the data
		    .color(d3.scale.category10().range());

		chart.xAxis
		    .tickFormat(function(d) {
			    return d3.time.format('%x')(new Date(d))
				});
		
		chart.yAxis
		    .tickFormat(d3.format(',.1%'));
		
		d3.select(".container").select('#chart svg')
		    .datum(data)
		    .transition().duration(500)
		    .call(chart);
		
		nv.utils.windowResize(chart.update);
		
		return chart;
	    });
    });
