/* Should eventual abstract into different views */
$().ns('DreiApp.Views');

$(document).ready(function () {
	DreiApp.Views.Home = Backbone.View.extend({
		template: _.template($('#home_template').html()),
		className: 'my-container',
		render: function () {
			this.$el.html(this.template());
		}
	});

	DreiApp.Views.Tracking = Backbone.View.extend({
		template: _.template($('#tracking_template').html()),
		className: 'my-container',
		events: {
			"click #back": "back"
		},
		back: function() {
			window.location.hash = "home";
		},
		render: function () {
			this.$el.html(this.template());
		}
	});

	DreiApp.Views.LogView = Backbone.View.extend({
		template: _.template($('#log_template').html()),
		render: function () {
			this.$el.html(this.template(this.model.toJSON()));
			return this;
		}
	});

	DreiApp.Views.Logging = Backbone.View.extend({
		template: _.template($('#logging_template').html()),
		className: 'my-container',
		events: {
			"click #back": "back"
		},

		initialize: function() {
			var that = this;
			DreiApp.app.logs.bind('add', that.addLog, that); 
		},

		destroy: function() {
			DreiApp.app.logs.unbind('add', this.addLog); 
		},

		addLog: function(newLog) {
			var logView = new DreiApp.Views.LogView({model: newLog});
			this.$('.logging').prepend(logView.render().$el.html());
			$('.logging').prepend(logView.render().$el.html());
		},

		back: function() {
			window.location.hash = "home";
		},
		render: function () {
			this.$el.html(this.template());
			var that = this;
			DreiApp.app.logs.each(function(log) {
				that.addLog(log);
			});
			return this;
		}
	});
});