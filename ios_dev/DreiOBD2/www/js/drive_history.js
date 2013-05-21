$().ns("DreiApp.Views");

$(document).ready(function() {

	var DriveHistoryEntry = Backbone.Model.extend({
		initialize: function() {
			this.set('datestring', this.get('start_date_yymmdd'));
		}
	});
	var DriveHistoryCollection = Backbone.Collection.extend({
		model: DriveHistoryEntry,
		getValidLogs: function() {
			return _(this.filter(function(driveLog) {
				var startTime = driveLog.get('start_time');
				return (startTime !== null && startTime > 0);
			}));
		}
	});

	var DriveHistoryEntryView = Backbone.View.extend({
		tagName: 'li',
		template: _.template($('#drive-history-entry-view').html()),
		render: function() {
			var jsonInfo = this.model.toJSON();
			var compiled = this.template(jsonInfo);
			$(this.el).html(compiled);
			return this;
		}
	});

	DreiApp.Views.DriveHistory = DreiApp.Views.MainView.extend({

		template: _.template($("#DriveHistoryTemplate").html()),

		render: function() {
			this.$el.html(this.template());
			var that = this;

			DreiApp.Callbacks.drei_get_drive_logs(function(results) {
				jsonResults = JSON.parse(results);
				that.driveLogs = new DriveHistoryCollection(jsonResults);
				that.driveLogs.comparator = function(driveLog) {
					// sort in descending order, so multiply by -1
					return (-1 * driveLog.get('start_time'));
				}
				that.driveLogs.sort();
				that.driveLogs.getValidLogs().each(function(log) {
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