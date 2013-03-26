/* The Commute App Model */

/* Should eventual abstract into different views */
$().ns('DreiApp.Models');

$(document).ready(function () {

	DreiApp.Models.Log = Backbone.Model.extend({

	        initialize: function (message) {
	            this.set('context', message.context);
	            this.set('content', message.content);
	            var date = new Date();
	            this.set('date', DreiApp.Utilities.formatDate(date));
	        },
	});


    DreiApp.Models.Logs = Backbone.Collection.extend({
        model: DreiApp.Models.Log,

        nextOrder: function() {
            if (!this.length) return 1;
            return this.last().get('order') + 1;
        },

        comparator: function(timeLapse) {
         	return -timeLapse.get('order');
        }

    });

	DreiApp.Models.CommuteApp = Backbone.Model.extend({

	        initialize: function (message) {
	            this.logs = new DreiApp.Models.Logs();
	            this.lastCarData = {
					fuel_level: 10,
					fuel_range: 3,
					fuel_reserve: 8,
					headlights: "on",
					odometer: 3456,
					speed: 100
				};
	        },

	        defaults: {
	            logLevel: 0,
	            isTrackingCommute: false,
	            isConnectedToCar: false
	        },

	        log: function(message) {
	        	this.logs.add(new DreiApp.Models.Log(message));
	        }
	});

});


