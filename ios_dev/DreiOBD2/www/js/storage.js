$().ns('DreiApp.Storage');

$(document).ready(function() {

	window.db = window.openDatabase("Database", "1.0", "Cordova Demo", 200000);

	function createDB(tx) {
		tx.executeSql('DROP TABLE IF EXISTS DRIVEHISTORY'); // TODO remove this line
		tx.executeSql('CREATE TABLE IF NOT EXISTS DRIVEHISTORY (id INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT, timestamp TEXT, minutes INTEGER, mpg INTEGER, mph INTEGER)');
	}

	function errorCB(err) {
	    alert("Error processing SQL: "+err);
	}

	function successCB() {
	    // alert("success!");
	}

	function queryDB(tx) {
		tx.executeSql('SELECT * FROM DRIVEHISTORY', [], querySuccess, errorCB);	
	}

	function querySuccess(tx, results) {
		for (var i = 0; i < results.rows.length; i += 1) {
			var row = results.rows.item(i);
			alert(row.id);
			alert(row.minutes)
		}
	};

	DreiApp.Storage.foo = function() {
		db.transaction(queryDB, errorCB);
	}

	DreiApp.Storage.getEntries = function(callbackFn) {

		function success(tx, results) {
			resultSet = [];
			for (var i = 0; i < results.rows.length; i += 1) {
				var curr = results.rows.item(i);
				resultSet.push({
					timestamp: curr.timestamp,
					duration: curr.minutes,
					ave_mpg: curr.mpg,
					ave_mph: curr.mph
				});
			}
			callbackFn(resultSet);
		}

		db.transaction(function(tx) {
			tx.executeSql('SELECT * FROM DRIVEHISTORY', [], success);	
		});
	}

	DreiApp.Storage.insertEntry = function(timestamp, minutes, mpg, mph) {
		db.transaction(function(tx) {
			tx.executeSql('INSERT INTO DRIVEHISTORY (timestamp, minutes, mpg, mph) values (?, ?, ?, ?)', [timestamp, minutes, mpg, mph]);
		});
	}

	db.transaction(createDB, errorCB, successCB);
	
});