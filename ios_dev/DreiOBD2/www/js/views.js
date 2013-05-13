$().ns('DreiApp.Views');


$(document).ready(function () {

    DreiApp.Views.MainView = Backbone.View.extend({
        transition: "none"
    });

    DreiApp.Views.Track = DreiApp.Views.MainView.extend({

        template:_.template($('#TrackTemplate').html()),

        render:function (eventName) {
            $(this.el).html(this.template());
            mixpanel.track("Navigated to Track Page"); 
            return this;
        }
    });

    DreiApp.Views.ActiveTracking = DreiApp.Views.MainView.extend({

        transition: "slideup",

        template:_.template($('#ActiveTrackingTemplate').html()),

        render:function (eventName) {
            $(this.el).html(this.template());
            mixpanel.track("Navigated to Active Tracking Page");
            return this;
        }
    });

    DreiApp.Views.Onboarding = DreiApp.Views.MainView.extend({

        transition: "slideup",

        template:_.template($('#OnboardingTemplate').html()),

        render:function (eventName) {
            $(this.el).html(this.template());
            mixpanel.track("Viewed Onboarding");
            return this;
        }
    });

    DreiApp.Views.Settings = DreiApp.Views.MainView.extend({

        template:_.template($('#SettingsTemplate').html()),

        events: {
            "click .logout": "logout"
        },

        logout: function(e) {
            DreiApp.Callbacks.drei_logout(function() {
                window.location.hash = "track";
            }, function() {});
            e.stopPropagation();
            e.preventDefault();
        },
        
        render:function (eventName) {
            $(this.el).html(this.template());
            mixpanel.track("Viewed Settings");
            return this;
        }
    });
});
