/* Should eventual abstract into different views */
$().ns('DreiApp.Views');

$(document).ready(function () {
	DreiApp.Views.Home = Backbone.View.extend({
		className: 'my-container',
		render: function () {
			this.$el.html('<p>HOME</p><a href="#foobar">Go to new page!</a>');
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

	DreiApp.Views.Logging = Backbone.View.extend({
		template: _.template($('#logging_template').html()),
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
});