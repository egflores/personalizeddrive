var chart;
var smallchart;
var donut;
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

function exampleData() {
  return [
  {
    key: "data",
    values: [
      { 
        "label" : "" ,
        "value" : 30
      } , 
      { 
        "label" : "Fuel" , 
        "value" : 70
      }
    ]
  }
  ];
}

nv.addGraph(function() {
   var donut = nv.models.pieChart()
       .x(function(d) { return d.label })
       .y(function(d) { return d.value })
       .showLabels(false)
	  .showLegend(false)
       .donut(true);

	data = exampleData();
 
     d3.select("#donut svg")
         .datum(data)
         .transition().duration(1200)
         .call(donut);

	d3.select("#donut svg").append('text')
		.text(data[0].values[1].value.toString())
		.attr('x', 107)
		.attr('y', 180)
		.attr('fill', "rgb(58, 135, 173)")
		.style("font-family", "\"Helvetica Neue\",Helvetica,Arial,sans-serif")
		.style("font-weight", "bold")
		.style('font-size', "80px")
		.style('text-shadow', "0px 4px 0px rgba(88, 88, 88, 0.5)");
 
	return donut;
});
