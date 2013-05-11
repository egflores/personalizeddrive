$().ns('DreiApp.Router');

$(document).ready(function() {
    var dv = DreiApp.Views;

	DreiApp.Router = Backbone.Router.extend({
 
	    routes:{
	    	"": "track",
	        "track":"track",
	        "drivehistory":"driveHistory",
	        "onboarding":"onboarding",
	        "activetracking":"activeTracking",
	        "settings":"settings"
	    },
	 
	    driveHistory:function () {
	        this.changePage(new dv.DriveHistory());
	    },
	 
	    track:function () {
	        this.changePage(new dv.Track());
	    },

	    activeTracking:function () {
	        this.changePage(new dv.ActiveTracking());
	    },

	   	onboarding:function () {
	        this.changePage(new dv.Onboarding());
	    },
	 
	    settings:function () {
	        this.changePage(new dv.Settings());
	    },
	 
	    changePage:function (page) {
	        $(page.el).attr('data-role', 'page');
	        page.render();
	        $('body').append($(page.el));
	        $.mobile.changePage($(page.el), {
	        	changeHash:false,
	        	transition: page.transition,
	        });
	    }
 
	});

	DreiApp.router = new DreiApp.Router();
	Backbone.history.start();
});