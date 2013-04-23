$(document).ready(function () {
	$('#right-pane').children().hide();
	$("#mileage-pane").show();

	$("#oillife-toggle").click(function() {
		$('#right-pane').children().hide();
		$("#oillife-pane").show();
		makechart(fakedata, "oillife-chart");
	});

	$("#oillife-chart").click(function() {
		/* XXX TODO: remove temp stuff */
		fakedata[0].values.unshift([fakedata[0].values[0][0]+6, fakedata[0].values[0][1] - .1]);
		makechart(fakedata, "oillife-chart");
	});

	$("#mileage-toggle").click(function() {
		$('#right-pane').children().hide();
		$("#mileage-pane").show();
		makechart(dashboard_data.car_data.data, "mileage-chart", true);
	});

	$("#fuel-toggle").click(function() {
		$('#right-pane').children().hide();
		$("#fuel-pane").show();
		makechart(dashboard_data.car_data.data, "fuel-chart");
	});

	$("#chart3").click(function() {
		$("#commute-listing-0").collapse();
		$("#commute-listing-1").collapse();
	});

	$('#commuteTog').click(function () {
		makescatter();
	});

	$('#export').click(function () {
		alert('It\'s exported, ok? Just Believe me.');
	});

	$('#yaxis').change(function () {
		$('#ylabel').html($('#yaxis').val());
		makescatter();
	});

	$('#xaxis').change(function () {
		$('#xlabel').html($('#xaxis').val());
		makescatter(($('#xaxis').val())==='Date');
	});

	$('#skin').click(function () {
		colors = [colorbrewer.Dark2[3], colorbrewer.Dark2[3], colorbrewer.Dark2[3]];
		makegauge(makegaugedata(dashboard_data.tank_level,100, "%"), "donut", "Fuel Level");
		makegauge(makegaugedata(900, 1000, "Miles"), "donut2", "Oil Life");
		makegauge(makegaugedata(dashboard_data.tank_level,100, "%"), "donut4 svg g", "Fuel Level");
		makegauge(makegaugedata(dashboard_data.fuel_range, 1000, "Miles"), "donut5 svg g", "Fuel Range");
		makegauge(makegaugedata(13,54, "%"), "donut3", "Battery");
		makenumber(dashboard_data.fuel_range, 400, "text0", "Fuel Range");
	});

	$('#skin1').click(function () {
		var oranges = colorbrewer.Oranges[3].slice(0).reverse();
		colors = [oranges, oranges, oranges];
		makegauge(makegaugedata(dashboard_data.tank_level,100, "%"), "donut", "Fuel Level");
		makegauge(makegaugedata(900, 1000, "Miles"), "donut2", "Oil Life");
		makegauge(makegaugedata(dashboard_data.tank_level,100, "%"), "donut4 svg g", "Fuel Level");
		makegauge(makegaugedata(dashboard_data.fuel_range, 1000, "Miles"), "donut5 svg g", "Fuel Range");
		makegauge(makegaugedata(13,54, "%"), "donut3", "Battery");
		makenumber(dashboard_data.fuel_range, 400, "text0", "Fuel Range");
	});

	$('#skin2').click(function () {
		colors = [colorbrewer.RdYlGn[3], colorbrewer.RdYlGn[3], colorbrewer.RdYlGn[3]];
		makegauge(makegaugedata(dashboard_data.tank_level,100, "%"), "donut", "Fuel Level");
		makegauge(makegaugedata(900, 1000, "Miles"), "donut2", "Oil Life");
		makegauge(makegaugedata(dashboard_data.tank_level,100, "%"), "donut4 svg g", "Fuel Level");
		makegauge(makegaugedata(dashboard_data.fuel_range, 1000, "Miles"), "donut5 svg g", "Fuel Range");
		makegauge(makegaugedata(13,54, "%"), "donut3", "Battery");
		makenumber(dashboard_data.fuel_range, 400, "text0", "Fuel Range");
	});

	$('#skin3').click(function () {
		var kuler = colorbrewer.YlGnBu[3].slice(0).reverse();
		colors = [kuler, kuler, kuler]; 
		makegauge(makegaugedata(dashboard_data.tank_level,100, "%"), "donut", "Fuel Level");
		makegauge(makegaugedata(900, 1000, "Miles"), "donut2", "Oil Life");
		makegauge(makegaugedata(dashboard_data.tank_level,100, "%"), "donut4 svg g", "Fuel Level");
		makegauge(makegaugedata(dashboard_data.fuel_range, 1000, "Miles"), "donut5 svg g", "Fuel Range");
		makegauge(makegaugedata(13,54, "%"), "donut3", "Battery");
		makenumber(dashboard_data.fuel_range, 400, "text0", "Fuel Range");
	});
});
