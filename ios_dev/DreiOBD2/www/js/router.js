$().ns('DreiApp.Router');

$(document).ready(function() {
	var ns = DreiApp.Router;

	

	ns.Router = Backbone.Router.extend({
		routes: {
			'vikas': 'vikasTest'
		},

		vikasTest: function() {
			alert('foo!');
		}
	});

	ns.router = new ns.Router();
});