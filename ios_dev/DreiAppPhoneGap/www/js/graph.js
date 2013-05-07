
var fakedata = [{"values":[[1363283993,2009],[1363283992,2009],[1363283991,2009],[1363283990,2009],[1363283989,2009],[1363283988,2009],[1363283987,2009],[1363283986,2009],[1363283985,2009],[1363283984,1893],[1363283983,1893],[1363283982,1893],[1363283981,1893],[1363283980,1893],[1363283979,1893],[1363283978,1893],[1363283977,1893],[1363283976,1893],[1363221478,1193],[1363221477,1193],[1363221476,1193],[1363221475,1461],[1363221474,1461],[1363221473,1461],[1363221472,1461],[1363221471,1461],[1363221470,1461],[1363221469,1461],[1363221468,1461],[1363221467,1461],[1363216902,1916],[1363216901,1916],[1363216900,1916],[1363216899,1916],[1363216898,1916],[1363216847,1033],[1363216846,1033],[1363216845,1334],[1363216844,1334],[1363216843,1334],[1363216842,1334],[1363216841,1334],[1363216840,1334],[1363216839,1334],[1363216838,1334],[1363216837,1334],[1363216836,1334],[1363216835,1980],[1363216834,1980],[1363216833,1980],[1363216832,1980],[1363216831,1980],[1363216830,1980],[1363216829,1980],[1363216828,1980],[1363216827,1980],[1363046203,1905],[1363046202,1905],[1363046201,1905],[1363046200,1905],[1363046199,1905],[1363046198,1905],[1363046197,1905],[1363046196,2037],[1363046195,2037],[1363046194,2037],[1363046193,2037],[1363046192,2037],[1363046191,2037],[1363046190,2037],[1363046189,2037],[1363046188,2037],[1363046187,2037],[1363046186,2487],[1363046185,2487],[1363046184,2487],[1363046183,2487],[1363046182,2487],[1363046181,2487],[1363046180,2487],[1363046179,2487],[1363046178,2487],[1363043916,1839],[1363043915,1839],[1363043914,1839],[1363043913,1839],[1363043912,1839],[1363043911,1839],[1363043910,1839],[1363043909,1839],[1363043908,1737],[1363043907,1737],[1363043906,1737],[1363043905,1737],[1363043904,1737],[1363043903,1737],[1363043902,1737],[1363043901,1737],[1363043900,1737],[1363043888,1444],[1363043887,1444],[1363043886,1444],[1363043885,1444],[1363043884,1444],[1363043883,1444],[1363043882,1444]],"key":"Mileage"}];

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

function makescatter(data, id, isdate) {
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
 
   d3.select('#'+id+' svg')
       .datum(randomData(1,15))
     .transition().duration(500)
       .call(chart);
 
   nv.utils.windowResize(chart.update);
 
   return chart;
 }); 
}
 


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

          //chart.xAxis
          //     .tickFormat(function(d) {
               // return d3.time.format("%Y-%m-%dT%H:%M:%S.%LZ")(d)
           //         return d3.time.format('%x')(new Date(d * 1000))
            //   }); 

          d3.select('#'+id+' svg')
               .datum(data)
               .transition().duration(500)
               .call(chart);

          //d3.select(".container").select('#'+id+' svg').selectAll("text").style("font-size","10px");

          nv.utils.windowResize(chart.update);

          return chart;
     }); 
}

//makechart(fakedata, 'grapha', true);
makescatter(fakedata, 'grapha', false);
