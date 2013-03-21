/* Should eventual abstract into different views */
$().ns('DreiApp.Views');

$(document).ready(function () {
	DreiApp.Views.Home = Backbone.View.extend({
		className: 'my-container',
		render: function () {
			this.$el.html('<div style="">HOME</div><a href="#">Go home</a>');
		}
	});

	DreiApp.Views.Tracking = Backbone.View.extend({
		className: 'my-container',
		render: function () {
			this.$el.html('<p>TRACKING</p><a href="#foobar">Go to new page!</a>');
		}
	});

	DreiApp.Views.Logging = Backbone.View.extend({
		className: 'my-container',
		render: function () {
			this.$el.html('<p>LOGGING</p><a href="#foobar">Go to new page!</a>');
		}
	});
});