$().ns('DreiApp.Router');

$(document).ready(function() {
    var dv = DreiApp.Views;
    var lastPageRole;
    var currentPageRole;
	DreiApp.Router = Backbone.Router.extend({
                                            currPage: null,
 
	    routes:{
	    	"": "track",
	        "track":"track",
	        "drivehistory":"driveHistory",
	        "setup/:page":"setup",
	        "activetracking":"activeTracking",
	        "settings":"settings",
	        "connecting":"connecting",
	        "connectionfailure": "connectionfailure"
	    },
	 
	    driveHistory: function() {
	    	if (!this.acceptedEula()) {
	    		this.setup();
	    		return;
	    	}
	        this.changePage(new dv.DriveHistory());
	    },
	 
	    track: function() {
	    	if (!this.acceptedEula()) {
	    		this.setup();
	    		return;
	    	}
            if(currentPageRole=='dialog') {
               // $('body').html('');
            }
	        this.changePage(new dv.Track());
	    },

	    activeTracking: function() {
	    	if (!this.acceptedEula()) {
	    		this.setup();
	    		return;
	    	}
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
	    	if (!this.acceptedEula()) {
	    		this.setup();
	    		return;
	    	}
	        this.changePage(new dv.Settings());
	    },

	    connecting: function() {
	    	var page = new dv.ConnectingScreen();
	    	this.changePage(page, 'dialog');
	    },

	    connectionfailure: function() {
	    	var page = new dv.ConnectionFailure();
	    	this.changePage(page, 'dialog');
                                            
	    },
	 
	    changePage: function(page, data_role) {
	    	var data_role = data_role || 'page';
                                            
            lastPageRole = currentPageRole;
            currentPageRole = data_role;
	        $(page.el).attr('data-role', data_role);
	        page.render();
                                           
	        $('body').append($(page.el));
	        $.mobile.changePage($(page.el), {
	        	changeHash:false,
	        	transition: page.transition,
				reloadPage: true
	        });
                                            
            
	    },

	    acceptedEula: function() {
	    	return (window.localStorage.getItem("AcceptedEULA") === "true");
	    }
 
	});
    $('body').on('pageshow',function(event, ui){
                 ui.prevPage.remove();
    });
	DreiApp.router = new DreiApp.Router();
	Backbone.history.start();
});