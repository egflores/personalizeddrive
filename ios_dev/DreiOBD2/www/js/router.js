$().ns('DreiApp.Router');

$(document).ready(function() {
    var dv = DreiApp.Views;

	DreiApp.Router = Backbone.Router.extend({
 
	    routes:{
	    	"": "initialScreen",
	        "track":"track",
	        "drivehistory":"driveHistory",
	        "setup/:page":"setup",
	        "activetracking":"activeTracking",
	        "settings":"settings"
	    },

	    initialScreen: function() {
	    	if (window.localStorage.getItem("AcceptedEULA") === "true") {
	    		this.track();
	    	} else {
	    		this.setup();
	    	}
	    },
	 
	    driveHistory: function() {
	        this.changePage(new dv.DriveHistory());
	    },
	 
	    track: function() {
	        this.changePage(new dv.Track());
	    },

	    activeTracking: function() {
	        this.changePage(new dv.ActiveTracking());
	    },

	   	setup: function(page) {
	   		if (page === "1" || page === undefined) {
	        	this.changePage(new dv.Setup1());
	        } else if (page === "2") {
	        	this.changePage(new dv.Setup2());
	        } else if (page === "3") {
	        	this.changePage(new dv.Setup3());
	        } else if (page === "4") {
	        	this.changePage(new dv.Setup4());
	        }
	    },
	 
	    settings: function() {
	        this.changePage(new dv.Settings());
	    },
	 
	    changePage: function(page) {
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