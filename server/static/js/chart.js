nv.addGraph(function() {
	var data = dashboard_data.car_data;
    var chart = nv.models.lineChart()
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
	var data = dashboard_data.car_data;

	var smallchart = nv.models.lineChart()
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
		.call(smallchart);

	d3.select(".container").select('#smallchart svg').selectAll("text").style("font-size","10px");

	nv.utils.windowResize(smallchart.update);

	return smallchart;
});


/*
 TO BE DELETED WHEN RENDERED OBSOLETE
*/
function exampleData(num) {
  return [
  {
    key: "data",
    values: [
      { 
        "label" : "Fuel" ,
        "value" : num
      } , 
      { 
        "label" : "" , 
        "value" : 100-num
      }
    ]
  }
  ];
}

function makegaugedata(num, max) {
  return [
  {
    key: "data",
    values: [
      { 
        "label" : "Fuel" ,
        "value" : num
      } , 
      { 
        "label" : "" , 
        "value" : max-num
      }
    ]
  }
  ];
}


function makegauge(data, id, name) {
	nv.addGraph(function() {
	   var donut = nv.models.pieChart()
		  .x(function(d) { return d.label })
		  .y(function(d) { return d.value })
		  .showLabels(false)
		  .showLegend(false)
		  .donut(true);

		var svg = d3.select("#"+id+" svg");

		svg
		    .datum(data)
		    .transition().duration(1200)
		    .call(donut);

		svg.append('text')
			.text(data[0].values[0].value)
			.attr('x', 107)
			.attr('y', 180)
			.attr('fill', "rgb(58, 135, 173)")
			.style("font-family", "\"Helvetica Neue\",Helvetica,Arial,sans-serif")
			.style("font-weight", "bold")
			.style('font-size', "80px")
			.style('text-shadow', "0px 1px 0px rgba(255, 255, 255, 0.5)");

		if (name != null) {
			svg.append('text')
				.text(name)
				.attr('x', 150 - name.length*16/2)
				.attr('y', 40)
				.attr('fill', "rgb(58, 135, 173)")
				.style("font-family", "\"Helvetica Neue\",Helvetica,Arial,sans-serif")
				.style("font-weight", "bold")
				.style('font-size', "35px")
				.style('text-shadow', "0px 1px 0px rgba(0, 0, 0, 0.5)");
		}

		return donut;
	});
}

function makenumber(data, max, id, name) {
	if (name == null) {
		return;
	}

	var color = d3.scale.linear()
		.domain([0.0, max/2.0, max])
		.range(["#CF002D","#E6CE67","#55CF75"]);

	var svg = d3.select("#"+id+" svg");

	if (name != null) {
		svg.append('text')
			.text(name)
			.attr('x', 150 - name.length*18/2)
			.attr('y', 40)
			.attr('fill', color(data))
			.style("font-family", "\"Helvetica Neue\",Helvetica,Arial,sans-serif")
			.style("font-weight", "bold")
			.style('font-size', "35px")
			.style('text-shadow', "0px 1px 0px rgba(255, 255, 255, 0.5)");
	}

	svg.append('text').text(data.toString())
		.attr('x', 75)
		.attr('y', 200)
		.attr('fill', color(data))
		.style("font-family", "\"Helvetica Neue\",Helvetica,Arial,sans-serif")
		.style("font-weight", "bold")
		.style('font-size', "150px")
		.style('text-shadow', "0px 1px 0px rgba(255, 255, 255, 0.5)");
}

makegauge(makegaugedata(dashboard_data.tank_level,100), "donut", "Fuel Level");
makegauge(makegaugedata(dashboard_data.fuel_range, 1000), "donut2", "Fuel Range");
makegauge(exampleData(28), "donut3");
makenumber(92, 100, "text0", "% Funtimes");

