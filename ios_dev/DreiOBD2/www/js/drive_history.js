$().ns("DreiApp.Views");

$(document).ready(function() {

	var data = {
	    "drive_logs": [
	        {
	            "duration": 4,
	            "timestamp": "2013-04-10T14:44:06",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-04-10T14:44:06",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-04-10T14:44:06",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-04-10T14:44:06",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-04-10T14:44:06",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-04-10T14:44:06",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-04-10T14:44:06",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-04-10T14:44:06",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-04-10T14:44:06",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-04-10T14:44:06",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-04-10T14:44:06",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 4,
	            "timestamp": "2013-04-10T14:44:06",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-04-10T14:44:06",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 4,
	            "timestamp": "2013-04-10T14:44:06",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-04-10T14:44:06",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-04-10T14:44:06",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-04-10T14:44:06",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-04-10T14:44:06",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-04-10T14:44:06",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-04-10T14:44:06",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-04-10T14:44:06",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-04-10T14:44:06",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-04-10T14:44:06",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-04-10T14:27:32",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 50,
	            "timestamp": "2013-03-25T00:00:00",
	            "ave_speed": 64,
	            "ave_mpg": 33,
	            "tank_used": 1.5
	        },
	        {
	            "duration": 43,
	            "timestamp": "2013-03-24T00:00:00",
	            "ave_speed": 70,
	            "ave_mpg": 28,
	            "tank_used": 1.8
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-03-23T00:00:00",
	            "ave_speed": 68,
	            "ave_mpg": 29,
	            "tank_used": 1.3
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-03-10T16:59:53",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-03-10T16:59:53",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        },
	        {
	            "duration": 0,
	            "timestamp": "2013-03-10T16:59:53",
	            "ave_speed": 0,
	            "ave_mpg": 0,
	            "tank_used": 0
	        }
	    ]
	};

	// TODO remove
	
	for (var i = 0; i < data.drive_logs.length; i += 1) {
		var curr = data.drive_logs[i];
		DreiApp.Storage.insertEntry(curr.timestamp, curr.duration, curr.ave_speed, curr.ave_mpg);
	}


	var DriveHistoryEntry = Backbone.Model.extend({
		initialize: function() {
			this.set('timestamp', new Date(this.get('timestamp')));
		}
	});
	var DriveHistoryCollection = Backbone.Collection.extend({
		model: DriveHistoryEntry
	});

	var DriveHistoryEntryView = Backbone.View.extend({
		tagName: 'li',
		template: _.template($('#drive-history-entry-view').html()),
		render: function() {
			var compiled = this.template(this.model.toJSON());
			$(this.el).html(compiled);
			return this;
		}
	});

	DreiApp.Views.DriveHistory = Backbone.View.extend({

		template: _.template($("#DriveHistoryTemplate").html()),


		render: function() {
			this.$el.html(this.template());
			var that = this;
			DreiApp.Storage.getEntries(function(results) {
				that.driveLogs = new DriveHistoryCollection(results);
				var i = 0;
				that.driveLogs.each(function(log) {
					console.log(i);
					i += 1;
					var view = new DriveHistoryEntryView({
						model: log
					});
					this.$("#drive-history-entries").append(view.render().el);
				}, that);
				that.$el.trigger('create');
			});

		}
	});

});