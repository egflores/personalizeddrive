function makescatter(isdate) {
 nv.addGraph(function() {
   var chart = nv.models.scatterChart()
                 .showDistX(true)
                 .showDistY(true)
                 .color(d3.scale.category10().range());
 
   if (isdate) {
   	chart.xAxis.tickFormat(function(d) {
	   // return d3.time.format("%Y-%m-%dT%H:%M:%S.%LZ")(d)
	   return d3.time.format('%x')(new Date(d * 1000))
	   });
   } else {
   	chart.xAxis.tickFormat(d3.format('.02f'))
   }
 
   d3.select('#chart3 svg')
       .datum(randomData(1,15))
     .transition().duration(500)
       .call(chart);
 
   nv.utils.windowResize(chart.update);
 
   return chart;
 });
 
 
 
 
 /**************************************
  * Simple test data generator
  */
 
 function randomData(groups, points) { //# groups,# points per group
   var data = [],
       shapes = ['circle', 'cross', 'triangle-up', 'triangle-down', 'diamond', 'square'],
       random = d3.random.normal();
 
   for (i = 0; i < groups; i++) {
     data.push({
       key: 'Commutes ',
       values: []
     });
 
     for (j = 0; j < points; j++) {
       data[i].values.push({
         x: random() * 2 + i + 43 
       , y: 38 - random() * (i - points/3) 
       , size: Math.random()
       //, shape: shapes[j % 6]
       });
     }
   }
 
   return data;
 }

};



function makechart(data, id, focus) {
	nv.addGraph(function() {
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

var color1 = [colorbrewer.Reds[3].reverse(), colorbrewer.Blues[3].reverse(), colorbrewer.Greens[3].reverse()];
var colors = color1;
function getcolors(value, max) {
	return colors[Math.floor(value / (max / 3))];
}


function makegauge(data, id, name, side) {

	var value = data[0].values[0].value;

	var colorz = getcolors(value, data[0].values[1].value + value);

	nv.addGraph(function() {
	   var svg = d3.select("#"+id+" svg");
	   svg.remove();
        svg = d3.select("#"+id).append("svg:svg")
		.attr('viewBox','0 0 300 300')
		.attr('preserveAspectRatio','xMinYMax')
		.style('height', '300')
		.style('width', '300');

	   var donut = nv.models.pieChart()
		  .x(function(d) { return d.label })
		  .y(function(d) { return d.value })
		  .showLabels(false)
		  .showLegend(false)
		  .donut(true)
		  .color(colorz);


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

		svg.append('text')
			.text(data[0].values[0].label)
			.attr('x', 130 - data[0].values[0].label.length*7/2)
			.attr('y', 187)
			.attr('fill', 'rgb(200,200,200)')
			.style("font-family", "\"Helvetica Neue\",Helvetica,Arial,sans-serif")
			.style("font-weight", "bold")
			.style('font-size', (24/Math.pow(data[0].values[0].label.length,.2))+"px")
			.style('text-shadow', "0px 1px 0px rgba(0, 0, 0, 0.5)");

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
	svg.remove();
	svg = d3.select("#"+id).append("svg:svg")
		.attr('viewBox','0 0 300 300')
		.attr('preserveAspectRatio','xMinYMax')
		.style('height', '300')
		.style('width', '300');

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

var fakedata = [{"values":[[1363283993,2009],[1363283992,2009],[1363283991,2009],[1363283990,2009],[1363283989,2009],[1363283988,2009],[1363283987,2009],[1363283986,2009],[1363283985,2009],[1363283984,1893],[1363283983,1893],[1363283982,1893],[1363283981,1893],[1363283980,1893],[1363283979,1893],[1363283978,1893],[1363283977,1893],[1363283976,1893],[1363221478,1193],[1363221477,1193],[1363221476,1193],[1363221475,1461],[1363221474,1461],[1363221473,1461],[1363221472,1461],[1363221471,1461],[1363221470,1461],[1363221469,1461],[1363221468,1461],[1363221467,1461],[1363216902,1916],[1363216901,1916],[1363216900,1916],[1363216899,1916],[1363216898,1916],[1363216847,1033],[1363216846,1033],[1363216845,1334],[1363216844,1334],[1363216843,1334],[1363216842,1334],[1363216841,1334],[1363216840,1334],[1363216839,1334],[1363216838,1334],[1363216837,1334],[1363216836,1334],[1363216835,1980],[1363216834,1980],[1363216833,1980],[1363216832,1980],[1363216831,1980],[1363216830,1980],[1363216829,1980],[1363216828,1980],[1363216827,1980],[1363046203,1905],[1363046202,1905],[1363046201,1905],[1363046200,1905],[1363046199,1905],[1363046198,1905],[1363046197,1905],[1363046196,2037],[1363046195,2037],[1363046194,2037],[1363046193,2037],[1363046192,2037],[1363046191,2037],[1363046190,2037],[1363046189,2037],[1363046188,2037],[1363046187,2037],[1363046186,2487],[1363046185,2487],[1363046184,2487],[1363046183,2487],[1363046182,2487],[1363046181,2487],[1363046180,2487],[1363046179,2487],[1363046178,2487],[1363043916,1839],[1363043915,1839],[1363043914,1839],[1363043913,1839],[1363043912,1839],[1363043911,1839],[1363043910,1839],[1363043909,1839],[1363043908,1737],[1363043907,1737],[1363043906,1737],[1363043905,1737],[1363043904,1737],[1363043903,1737],[1363043902,1737],[1363043901,1737],[1363043900,1737],[1363043888,1444],[1363043887,1444],[1363043886,1444],[1363043885,1444],[1363043884,1444],[1363043883,1444],[1363043882,1444]],"key":"Mileage"}];

var arrlendf = fakedata[0].values.length;
fakedata[0].values[arrlendf-1][1] = 3.8;
for (var i=arrlendf-2; i >= 0 ; --i) {
	fakedata[0].values[i][1] = fakedata[0].values[i+1][1] - Math.random()*.037
	fakedata[0].values[i][0] = fakedata[0].values[i+1][0] + Math.floor(Math.random()*6);
}

makechart(dashboard_data.car_data.data, "mileage-chart", true);
makegauge(makegaugedata(dashboard_data.tank_level,100, "%"), "donut", "Fuel Level");
makegauge(makegaugedata(900, 1000, "Miles"), "donut2", "Oil Life");
makegauge(makegaugedata(dashboard_data.tank_level,100, "%"), "donut4 svg g", "Fuel Level");
makegauge(makegaugedata(dashboard_data.fuel_range, 1000, "Miles"), "donut5 svg g", "Fuel Range");
makegauge(makegaugedata(13,54, "%"), "donut3", "Battery");
makenumber(dashboard_data.fuel_range, 400, "text0", "Fuel Range");
