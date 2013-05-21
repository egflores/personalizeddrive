$().ns("DreiApp.Views");

$(document).ready(function() {

	var DriveHistoryEntry = Backbone.Model.extend({
		initialize: function() {
			this.set('start_time', new Date(this.get('start_time')));
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
			/*
			jsonResults = [
				{
					start_time: 0,
					total_time: 0,
					average_mpg: 0,
					average_speed: 0
				}
			]
			that.driveLogs = new DriveHistoryCollection(jsonResults);
			that.driveLogs.each(function(log) {
				var view = new DriveHistoryEntryView({
						model: log
					});
				that.$("#drive-history-entries").append(view.render().el);
			}); */
                                                      

			DreiApp.Callbacks.drei_get_drive_logs(function(results) {
				jsonResults = JSON.parse(results);
				that.driveLogs = new DriveHistoryCollection(jsonResults);
				that.driveLogs.each(function(log) {
					var view = new DriveHistoryEntryView({
						model: log
					});
					that.$("#drive-history-entries").append(view.render().el);
				});
				that.$("#drive-history-entries").listview("refresh");
			}, function() {}); 
			
			return this;

		}
	});

});