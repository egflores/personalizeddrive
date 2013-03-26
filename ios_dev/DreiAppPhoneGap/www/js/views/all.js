/* Should eventual abstract into different views */
$().ns('DreiApp.Views');

$(document).ready(function () {



	DreiApp.Views.Home = Backbone.View.extend({
		template: _.template($('#home_template').html()),
		events: {
			"click #linkTracking": "toggleTracking",
			"click #linkUpload": "upload",
		},

		toggleTracking: function(e) {
			var isTracking = DreiApp.app.get("isTrackingCommute");

			if(isTracking) {
				DreiApp.Callbacks.drei_stop(function() {	
					DreiApp.app.set("isTrackingCommute", !isTracking);
					console.log("finished logging");
					$("#nextCommute").removeClass('hidden');
				}, function() {
					console.log("Something went wrong trying to stop the log");
				});
			} else {
				DreiApp.Callbacks.drei_start(function() {	
					DreiApp.app.set("isTrackingCommute", !isTracking);
				}, function() {
					alert("Currently not connected");
				});
			}

			e.stopImmediatePropagation();
            e.preventDefault();
		},
		upload: function(e) {
	        if(!this.uploading) {
		        this.uploading = true;
		        $("#linkUpload").addClass('btn-success');
		        $("#linkUpload").html("Uploading....");
		        //window.drei_subscribe(function(echoValue) {  });
		        var that = this;
		        setTimeout(function() {
		            that.uploading = false;
		            $("#linkUpload").removeClass('btn-success');
		            $("#linkUpload").html("Upload Data to Server");
		        }, 1000);
	        	e.stopImmediatePropagation();
	            e.preventDefault();
        	}
		},

		changeInTracking: function() {
			if(!DreiApp.app.get("isTrackingCommute")) {
	          $("#linkTracking").addClass('btn-primary');
	          $("#linkTracking").removeClass('btn-warning');
	          $("#linkTracking").html("Start Tracking Commute");
	        } else {
	          $("#linkTracking").removeClass('btn-primary');
	          $("#linkTracking").addClass('btn-warning');
	          $("#linkTracking").html("Stop Tracking Commute");
	        }
		},
		initialize: function() {
			this.uploading = false;
			this.setElement($("#container"));
			this.listenTo(DreiApp.app, 'change', this.changeInTracking);
		},
		render: function () {
			this.$el.html(this.template());
			this.changeInTracking();
		},
		destroy: function() {
		}
	});

	DreiApp.Views.TrackingBox = Backbone.View.extend({
		template: _.template($('#trackingBox_template').html()),
		initialize: function() {
			this.setElement($("#trackingBox"));
			var that = this;
			DreiApp.Callbacks.proxy.on("dataEntry", function(data) {
			  that.setElement($("#trackingBox"));
			  that.render();
			});
		},
		render: function () {
			this.setElement($("#trackingBox"));
			$("#trackingBox").html(this.template(DreiApp.app.lastCarData));
			return this;
		},
		destroy: function() {
		}
	})

	DreiApp.Views.Tracking = Backbone.View.extend({
		template: _.template($('#tracking_template').html()),
		initialize: function() {
			this.setElement($("#container"));
		},
		events: {
			"click #back": "back",
		},
		changeInTracking: function() {
			if(DreiApp.app.get("isTrackingCommute")) {
	          $("#blurOverlay").addClass("blur");
	        } else {
	          $("#blurOverlay").removeClass("blur");
	        }
		},
		back: function() {
			window.location.hash = "home";
		},
		render: function () {
			this.$el.empty().html(this.template({
				isTracking: DreiApp.app.get("isTrackingCommute")
			}));
			var dataBox = new DreiApp.Views.TrackingBox();
			dataBox.render();
			return this;
		},
		destroy: function() {
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
		initialize: function() {
			this.setElement($("#container"));
		},
		events: {
			"click #back": "back"
		},

		initialize: function() {
			var that = this;
			this.listenTo(DreiApp.app.logs, 'add', that.addLog);
		},

		destroy: function() {
			this.stopListening(DreiApp.app.logs);
			//DreiApp.app.logs.unbind('add', this.addLog); 
		},

		addLog: function(newLog) {
			var logView = new DreiApp.Views.LogView({model: newLog});
			this.$('.logging').prepend(logView.render().el);
			$('.logging').prepend(logView.render().el);
		},

		back: function() {
			window.location.hash = "home";
		},
		render: function () {
			this.$el.html(this.template());
			$("#container").html(this.$el);
			var that = this;
			DreiApp.app.logs.each(function(log) {
				that.addLog(log);
			});
			return this;
		}
	});
});