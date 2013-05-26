 $().ns('DreiApp.Views');


$(document).ready(function () {

    DreiApp.Views.MainView = Backbone.View.extend({});

    DreiApp.Views.Track = DreiApp.Views.MainView.extend({
        events: {
            "click .start-tracking-button": "startTracking"
        },

        trackingStarted: null,
                                                        
        template: _.template($('#TrackTemplate').html()),

        render: function (eventName) {
            $(this.el).html(this.template());
            mixpanel.track("Navigated to Track Page"); 
            return this;
        },

        startTracking: function(e) {
            window.location.href="#connecting"
        },
    });

    DreiApp.Views.ActiveTracking = DreiApp.Views.MainView.extend({

        transition: "slideup",

        template: _.template($('#ActiveTrackingTemplate').html()),

        render:function (eventName) {
            $(this.el).html(this.template());
            mixpanel.track("Navigated to Active Tracking Page");
            return this;
        }
    });

    DreiApp.Views.ConnectingScreen = DreiApp.Views.MainView.extend({
        events: {
            'pageshow': 'foo'
        },

        transition: "pop",

        render: function(eventName) {
            DreiApp.Callbacks.drei_start(function(){}, function(){});
            var that = this;
            setTimeout(function() {
                if (that.$el.hasClass('ui-page-active')) {
                    DreiApp.Callbacks.drei_stop(function(){}, function(){});
                    $.mobile.hidePageLoadingMsg();
                    window.location.href = "#connectionfailure"
                }
            }, 7000); // waits 7 seconds to make a connection, otherwise alerts failure
            return this;
        },

        foo: function() {
            $.mobile.showPageLoadingMsg("b", "Connecting to ODB Device");
        }
    });

    DreiApp.Views.ConnectionFailure = DreiApp.Views.MainView.extend({
        transition: "pop",

        template: _.template($('#ConnectionFailure').html()),

        render: function(eventName) {
            $(this.el).html(this.template());
            mixpanel.track("Navigated to Connection Failure Page");
            return this;   
        }
    });

    DreiApp.Views.Settings = DreiApp.Views.MainView.extend({

        template:_.template($('#SettingsTemplate').html()),

        events: {
            "click .logout": "logout",
            "focus .feedback-text": "clearFeedback",
            "click .submit-feedback": "submitFeedback"
        },

        logout: function(e) {
            DreiApp.Callbacks.drei_logout(function() {
                window.location.hash = "track";
            }, function() {});
            e.stopPropagation();
            e.preventDefault();
        },

        clearFeedback: function() {
            $(".feedback-text").val('');
        },

        submitFeedback: function() {
            var feedbackText = $(".feedback-text").val();
            DreiApp.Callbacks.drei_send_feedback(function() {}, function() {}, 
                    feedbackText);
            $(".feedback-text").val('');
        },
        
        render:function (eventName) {
            $(this.el).html(this.template());
            mixpanel.track("Viewed Settings");
            return this;
        }
    });
});
