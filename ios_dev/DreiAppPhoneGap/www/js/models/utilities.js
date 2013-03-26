/* The Commute App Model */

/* Should eventual abstract into different views */
$().ns('DreiApp.Models');

$(document).ready(function () {

	DreiApp.Models.Log = Backbone.Model.extend({

	        initialize: function (context, message) {
	            this.set('context', context);
	            this.set('message', message);
	        },
	});


    DreiApp.Models.Logs = Backbone.Collection.extend({
        model: DreiApp.Models.Log,

        nextOrder: function() {
            if (!this.length) return 1;
            return this.last().get('order') + 1;
        },

        comparator: function(timeLapse) {
         return timeLapse.get('order');
        }

    });

	//isTrackingCommute
	//logs
	DreiApp.Models.CommuteApp = Backbone.Model.extend({

	        initialize: function () {
	        	this.set('logs', new DreiApp.Models.Logs());
	        },

	        defaults: {
	            isTrackingCommute: false,
	        },

	        uploadData: function() {
	        	DreiApp.log
	        }
	});

});


