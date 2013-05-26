 $().ns('DreiApp.Views');


$(document).ready(function () {

    DreiApp.Views.MainView = Backbone.View.extend({
        // transition: "none" // I kind of like the transition - Vikas
    });

    DreiApp.Views.NonScrollingView = DreiApp.Views.MainView.extend({ /*
                                                                   
        events: {
            'touchmove': 'disableVerticalScroll'
        },

        disableVerticalScroll: function(e) {
            e.preventDefault();
        }
*/
    });

/*
    DreiApp.Views.NonScrollingView.extend = function(child){
        /*
         * Code for subclasses of NonScrollingView to add their own events
         * without 4overriding events in the base view.
         * courtesy of http://stackoverflow.com/questions/6968487/sub-class-a-backbone-view-sub-class-retain-events 

        var view = Backbone.View.extend.apply(this, arguments);
        view.prototype.events = _.extend({}, this.prototype.events, child.events);
        return view;
    };                                                                     */

    DreiApp.Views.Track = DreiApp.Views.NonScrollingView.extend({
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
            this.showLoading();
            DreiApp.Callbacks.drei_start(function(){}, function(){});
            var that = this;
            setTimeout(function() {
                if (that.$el.hasClass('ui-page-active')) {
                    DreiApp.Callbacks.drei_stop(function(){}, function(){});
                    that.hideLoading();
                    window.location.href = "#connectionfailure"
                }
            }, 1000); 
        },

        showLoading: function() {
            this.$el.append('<div class="modal-overlay"/>');
            this.$(".modal-overlay").animate({opacity: .7}, 500, function(){})
            $.mobile.showPageLoadingMsg("a", "Connecting to ODB Device");
        },

        hideLoading: function() {
            this.$(".modal-overlay").remove();
            $.mobile.hidePageLoadingMsg();
        }
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

    DreiApp.Views.ConnectionFailure = DreiApp.Views.MainView.extend({
        transition: "slideup",

        template: _.template($('#ConnectionFailure').html()),

        render: function(eventName) {
            $(this.el).html(this.template());
            mixpanel.track("Navigated to Connection Failure Page");
            return this;   
        }
    });

    DreiApp.Views.Settings = DreiApp.Views.NonScrollingView.extend({

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
