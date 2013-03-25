function makechart(data, id, focus) {
	nv.addGraph(function() {
		var data = dashboard_data.car_data.data;

		var chart;
		if (focus === true) { 
			chart = nv.models.lineWithFocusChart(); 
		} else {
			chart = nv.models.lineChart(); 
		}
		chart.x(function(d) { return d[0] })
			 .y(function(d) { return d[1] }) //adjusting, 100% is 1.00, not 100 as it is in the data
			 .color(d3.scale.category10().range());

		chart.xAxis
			.tickFormat(function(d) {
			// return d3.time.format("%Y-%m-%dT%H:%M:%S.%LZ")(d)
				return d3.time.format('%x')(new Date(d * 1000))
			});

		d3.select(".container").select('#'+id+' svg')
			.datum(data)
			.transition().duration(500)
			.call(chart);

		//d3.select(".container").select('#'+id+' svg').selectAll("text").style("font-size","10px");

		nv.utils.windowResize(chart.update);

		return chart;
	});
}


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

function makegaugedata(num, max, name) {
  return [
  {
    key: "data",
    values: [
      { 
        "label" : name ,
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

function getcolors(value, max) {
	var colors = [colorbrewer.Reds[3].reverse(), colorbrewer.Blues[3].reverse(), colorbrewer.Greens[3].reverse()];

	return colors[Math.floor(value / (max / 3))];
}


function makegauge(data, id, name, side) {

	var value = data[0].values[0].value;

	var colorz = getcolors(value, data[0].values[1].value + value);

	nv.addGraph(function() {
	   var donut = nv.models.pieChart()
		  .x(function(d) { return d.label })
		  .y(function(d) { return d.value })
		  .showLabels(false)
		  .showLegend(false)
		  .donut(true)
		  .color(colorz);

		var svg = d3.select("#"+id+" svg");

		svg
		    .datum(data)
		    .transition().duration(1200)
		    .call(donut);

		svg.append('text')
			.text(value)
			.attr('x', function() { return value > 100 ? 85: 91; })
			.attr('y', function() { return value > 100 ? 163: 167; })
			.attr('fill', colorz[0])
			.style("font-family", "\"Helvetica Neue\",Helvetica,Arial,sans-serif")
			.style("font-weight", "bold")
			.style('font-size', function() { return value > 100 ? "60px" : "80px"; })
			.style('text-shadow', "0px 1px 0px rgba(255, 255, 255, 0.5)");

		if (name != null) {
			svg.append('text')
				.text(name)
				.attr('x', 140 - name.length*16/2)
				.attr('y', 40)
				.attr('fill', colorz[0])
				.style("font-family", "\"Helvetica Neue\",Helvetica,Arial,sans-serif")
				.style("font-weight", "bold")
				.style('font-size', "35px")
				.style('text-shadow', "0px 1px 0px rgba(0, 0, 0, 0.5)");
		}

		nv.utils.windowResize(donut.update);

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
			.attr('x', 130 - name.length*18/2)
			.attr('y', 40)
			.attr('fill', color(data))
			.style("font-family", "\"Helvetica Neue\",Helvetica,Arial,sans-serif")
			.style("font-weight", "bold")
			.style('font-size', "35px")
			.style('text-shadow', "0px 1px 0px rgba(255, 255, 255, 0.5)");
	}

	svg.append('text').text(data.toString())
		.attr('x', function() { return data > 100 ? 20 : 50; })
		.attr('y', 190)
		.attr('fill', color(data))
		.style("font-family", "\"Helvetica Neue\",Helvetica,Arial,sans-serif")
		.style("font-weight", "bold")
		.style('font-size', function() { return data > 100 ? "130px" : "150px"; })
		.style('text-shadow', "0px 1px 0px rgba(255, 255, 255, 0.5)");
}

makechart(dashboard_data.car_data.data, "mileage-chart", true);
makegauge(makegaugedata(dashboard_data.tank_level,100, "Percent"), "donut", "Fuel Level");
makegauge(makegaugedata(507, 1000, "Miles"), "donut2", "Oil Life");
makegauge(makegaugedata(dashboard_data.tank_level,100, "Percent"), "donut4 svg g", "Fuel Level");
makegauge(makegaugedata(dashboard_data.fuel_range, 1000, "Miles"), "donut5 svg g", "Fuel Range");
makegauge(makegaugedata(13,54, "Columbs"), "donut3", "Battery");
makenumber(dashboard_data.fuel_range, 400, "text0", "Fuel Range");
