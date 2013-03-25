/* Utilities */

$().ns('DreiApp.Utilities');

$(document).ready(function () {

	DreiApp.Utilities.Log = function (message) {
		console.log(message);
	}

	DreiApp.Utilities.formatDate = function(d) {
	    var date = d.getDate();
	    date = date < 10 ? "0"+date : date;
	    var mon = d.getMonth()+1;
	    mon = mon < 10 ? "0"+mon : mon;
	    var year = d.getFullYear();
	    var hour = d.getHours()%12;
	    if(hour === 0) hour = 12;
	    var minutes = d.getMinutes();
	    if(minutes < 10) minutes = '0' + minutes;
	    var ampm = d.getHours()/12 > 1 ? "PM" : "AM";
	    var seconds = d.getSeconds();
    	return (mon+"/"+date+"/"+year+" "+hour+":"+minutes+":"+seconds+" "+ampm);
	};

});


