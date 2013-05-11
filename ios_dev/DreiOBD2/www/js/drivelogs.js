$().ns('DreiApp.DriveLogs');

$(document).ready(function() {
	var namespace = DreiApp.DriveLogs;

	var data={ "drive_logs": [ { "duration": 4, "timestamp": "2013-04-10T14:44:06", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 0, "timestamp": "2013-04-10T14:44:06", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 0, "timestamp": "2013-04-10T14:44:06", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 0, "timestamp": "2013-04-10T14:44:06", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 0, "timestamp": "2013-04-10T14:44:06", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 0, "timestamp": "2013-04-10T14:44:06", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 0, "timestamp": "2013-04-10T14:44:06", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 0, "timestamp": "2013-04-10T14:44:06", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 0, "timestamp": "2013-04-10T14:44:06", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 0, "timestamp": "2013-04-10T14:44:06", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 0, "timestamp": "2013-04-10T14:44:06", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 4, "timestamp": "2013-04-10T14:44:06", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 0, "timestamp": "2013-04-10T14:44:06", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 0, "timestamp": "2013-04-10T14:44:06", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 0, "timestamp": "2013-04-10T14:44:06", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 0, "timestamp": "2013-04-10T14:44:06", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 0, "timestamp": "2013-04-10T14:44:06", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 0, "timestamp": "2013-04-10T14:44:06", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 0, "timestamp": "2013-04-10T14:44:06", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 0, "timestamp": "2013-04-10T14:44:06", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 0, "timestamp": "2013-04-10T14:44:06", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 0, "timestamp": "2013-04-10T14:44:06", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 0, "timestamp": "2013-04-10T14:27:32", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 50, "timestamp": "2013-03-25T00:00:00", "ave_speed": 64.0, "ave_mpg": 33.0, "tank_used": 1.5 }, { "duration": 43, "timestamp": "2013-03-24T00:00:00", "ave_speed": 70.0, "ave_mpg": 28.0, "tank_used": 1.8 }, { "duration": 0, "timestamp": "2013-03-23T00:00:00", "ave_speed": 68.0, "ave_mpg": 29.0, "tank_used": 1.3 }, { "duration": 0, "timestamp": "2013-03-10T16:59:53", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 0, "timestamp": "2013-03-10T16:59:53", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 }, { "duration": 0, "timestamp": "2013-03-10T16:59:53", "ave_speed": 0.0, "ave_mpg": 0.0, "tank_used": 0.0 } ] };

	namespace.DriveLog = Backbone.Model.extend();
	
	namespace.DriveLogCollection = Backbone.Collection.extend({
		model: namespace.DriveLog
	});
	
	namespace.DriveLogView = Backbone.View.extend({
		template: $('#drive-log-template').html(),
		render: function() {
			var compiled = _.template(this.template);
			this.$el.html(compiled(this.model.toJSON()));
			return this;
		}
	});

	namespace.DriveLogCollectionView = Backbone.View.extend({
		initialize: function() {
			this.setElement($('#drive-logs'));
		},
		render: function() {
			this.$el.html('');
			var that = this;
			
			_.each(this.model.models, function(driveLog) {
				$(this.el).append(new namespace.DriveLogView({
					model: driveLog
				}).render().el);
			}, this);
			this.$el.trigger("create");
			return this;
		}
	});

	namespace.driveLogCollection = new namespace.DriveLogCollection(data.drive_logs);
	namespace.driveLogCollectionView = new namespace.DriveLogCollectionView({
		model: namespace.driveLogCollection
	});
	namespace.driveLogCollectionView.render();
});