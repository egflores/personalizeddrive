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
		makescatter();
	});
});
