var chart;
var smallchart;
data = car_data.data;
nv.addGraph(function() {
    chart = nv.models.lineChart()
        .x(function(d) { return d[0] })
        .y(function(d) { return d[1] }) //adjusting, 100% is 1.00, not 100 as it is in the data
        .color(d3.scale.category10().range());

    chart.xAxis
        .tickFormat(function(d) {
            // return d3.time.format("%Y-%m-%dT%H:%M:%S.%LZ")(d)
            return d3.time.format('%x')(new Date(d * 1000))
        });
    
    d3.select(".container").select('#chart svg')
        .datum(data)
        .transition().duration(500)
        .call(chart);
    
    nv.utils.windowResize(chart.update);
    
    return chart;
});

nv.addGraph(function() {
	smallchart = nv.models.lineChart()
		.x(function(d) { return d[0] })
		.y(function(d) { return d[1] }) //adjusting, 100% is 1.00, not 100 as it is in the data
		.color(d3.scale.category10().range());

	smallchart.xAxis
		.tickFormat(function(d) {
		// return d3.time.format("%Y-%m-%dT%H:%M:%S.%LZ")(d)
			return d3.time.format('%x')(new Date(d * 1000))
		});

	d3.select(".container").select('#smallchart svg')
		.datum(data)
		.transition().duration(500)
		.call(chart);

	d3.select(".container").select('#smallchart svg').selectAll("text").style("font-size","10px");

	

	nv.utils.windowResize(chart.update);

	return chart;
});
